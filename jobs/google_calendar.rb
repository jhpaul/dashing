require 'net/http'
require 'icalendar'
require 'open-uri'

# List of calendars
#
# Format:
#   <name> => <uri>
# Example:
#   hangouts: "https://www.google.com/calendar/ical/<hash>.calendar.google.com/private-<hash>/hangouts.ics"
calendars = {phil: "https://www.google.com/calendar/ical/rv7ogc265e178h3ess6f1lgqpk%40group.calendar.google.com/private-7ec68c732f6633e97ab11f720e843f23/basic.ics"}

SCHEDULER.every '5m', :first_in => 0 do |job|

  calendars.each do |cal_name, cal_uri|

    ics  = open(cal_uri) { |f| f.read }
    cal = Icalendar.parse(ics).first
    events = cal.events

    # select only current and upcoming events
    now = Time.now.utc
    events = events.select{ |e| e.dtend.to_time.utc > now }

    # sort by start time
    events = events.sort{ |a, b| a.dtstart.to_time.utc <=> b.dtstart.to_time.utc }[0..1]

    events = events.map do |e|
      {
        title: e.summary,
        start: e.dtstart.to_time.to_i,
        end: e.dtend.to_time.to_i
      }
    end

    send_event("google_calendar_#{cal_name}", {events: events})
  end

end
