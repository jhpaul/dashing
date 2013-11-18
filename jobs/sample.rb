current_valuation = 0
current_karma = 0

SCHEDULER.every '2s' do
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = rand(100)
  current_karma     = rand(200000)

  send_event('valuation', { current: current_valuation, last: last_valuation })
  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: rand(100) })
end
# i=1
# SCHEDULER.every '5s' do
	
# 	if i == 1
# 		send_event('welcome', { text: "Hello"})
# 		i=2
# 		break
# 	end
# 	if i == 2
# 		send_event('welcome', { text: "Goodbye"})
# 		i=1
# 		break
# 	end
# end
