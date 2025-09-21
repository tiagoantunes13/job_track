module ApplicationHelper
  def dom_id_for_json(id, prefix = 'job')
    "#{prefix}_#{id}"
  end

  # Add this to your app/helpers/application_helper.rb
  def flash_class(type)
    case type.to_s
    when 'notice', 'success'
      'bg-green-900/20 border border-green-500/30 text-green-300'
    when 'alert', 'error'  
      'bg-red-900/20 border border-red-500/30 text-red-300'
    else
      'bg-blue-900/20 border border-blue-500/30 text-blue-300'
    end
  end
end
