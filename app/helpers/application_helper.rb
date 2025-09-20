module ApplicationHelper
  def dom_id_for_json(id, prefix = 'job')
    "#{prefix}_#{id}"
  end
end
