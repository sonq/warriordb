# app/helpers/events_helper.rb
module EventsHelper
  def event_status_color(status)
    case status
    when 'Taslak'
      'gray'
    when 'Yayında'
      'green'
    when 'Devam Ediyor'
      'blue'
    when 'Tamamlandı'
      'indigo'
    when 'İptal Edildi'
      'red'
    else
      'gray'
    end
  end
end