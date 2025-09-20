module JobApplicationsHelper
  def status_badge_class(status)
    case status
    when "applied"
      "bg-blue-100 text-blue-800"
    when "interviewing"
      "bg-yellow-100 text-yellow-800"
    when "offered"
      "bg-green-100 text-green-800"
    when "rejected"
      "bg-red-100 text-red-800"
    when "accepted"
      "bg-purple-100 text-purple-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end

  def expectations_badge_class(expectations)
    case expectations
    when "low"
      "bg-red-100 text-red-800"
    when "medium"
      "bg-yellow-100 text-yellow-800"
    when "high"
      "bg-green-100 text-green-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end
end
