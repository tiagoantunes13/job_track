class AddCompanyDetailsToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :company_details, :text
  end
end
