module EventApplicationsHelper
  def application_status_class(status_name)
    case status_name
    when '"Onay Bekliyor"'
      'bg-yellow-50 text-yellow-800 ring-1 ring-inset ring-yellow-600/20'
    when '"Onaylandı"'
      'bg-green-50 text-green-800 ring-1 ring-inset ring-green-600/20'
    when '"Reddedildi"'
      'bg-red-50 text-red-800 ring-1 ring-inset ring-red-600/20'
    else
      'bg-gray-50 text-gray-800 ring-1 ring-inset ring-gray-600/20'
    end
  end
end