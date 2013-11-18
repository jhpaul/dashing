i=1
SCHEDULER.every '5s' do
	
	if i == 1
		send_event('welcome', { text: "Hello"})
		i=2
		break
	end
	if i == 2
		send_event('welcome', { text: "Goodbye"})
		i=1
		break
	end
end
