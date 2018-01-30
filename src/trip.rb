
# Trips will be able to calculate their duration
class Trip
	attr_reader :driver_name, :miles, :total_trip_time
	def initialize start_time, end_time, miles
	    @start_time = start_time
	    @end_time = end_time
	    @miles = miles
	    @total_trip_time = self.calculat_total_trip_time
	end

	def calculat_total_trip_time
		end_time = self.time_to_f(@end_time)
		start_time = self.time_to_f(@start_time)						
		if end_time > start_time
			end_time - start_time
		elsif start_time > end_time 
			raise ArgumentError, "End time cannot be before the start time"
		end		
	end
	
	def mph 
		@miles / @total_trip_time 
	end

	def time_to_f timestamp		
		hours_mins_arr = timestamp.to_s.split(':')	
		case hours_mins_arr.count		
		when 2
			minuets = hours_mins_arr[0].to_i * 60
			minuets += hours_mins_arr[1].to_i			
			minuets.to_f / 60
		else 
			raise ArgumentError, "Timestamp #{timestamp} must be delimited by a colon ':'"	
		end
	end
end
