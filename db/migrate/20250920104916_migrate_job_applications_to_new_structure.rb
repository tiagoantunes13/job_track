class MigrateJobApplicationsToNewStructure < ActiveRecord::Migration[8.0]
  def up
    # Add job_id to job_applications temporarily
    add_reference :job_applications, :job, foreign_key: true

    # Migrate existing job_applications to jobs table
    JobApplication.find_each do |application|
      # Create or find job record
      job = Job.find_or_create_by(
        title: application.position&.strip,
        company: application.company&.strip,
        source: 'internal'
      ) do |j|
        j.location = application.location
        j.job_posting_url = application.job_posting_url
        j.description = application.post # assuming 'post' contains job description
        j.external_job_id = "internal_#{SecureRandom.hex(8)}" # Generate unique internal ID
        j.job_data = {
          migrated_from_application: true,
          original_application_id: application.id
        }
      end

      # Link application to job
      application.update!(job_id: job.id)
    end

    # Clean up job_applications table - remove redundant columns
    remove_column :job_applications, :company, :text
    remove_column :job_applications, :position, :text
    remove_column :job_applications, :job_posting_url, :text
    remove_column :job_applications, :post, :text
    remove_column :job_applications, :location, :string

    # Make job_id required
    change_column_null :job_applications, :job_id, false
  end

  def down
    # Add back removed columns
    add_column :job_applications, :company, :text
    add_column :job_applications, :position, :text
    add_column :job_applications, :job_posting_url, :text
    add_column :job_applications, :post, :text
    add_column :job_applications, :location, :string, default: "Remote"

    # Restore data from jobs table
    JobApplication.includes(:job).find_each do |application|
      if application.job
        application.update!(
          company: application.job.company,
          position: application.job.title,
          job_posting_url: application.job.job_posting_url,
          post: application.job.description,
          location: application.job.location || "Remote"
        )
      end
    end

    # Remove job reference
    remove_reference :job_applications, :job, foreign_key: true
  end
end