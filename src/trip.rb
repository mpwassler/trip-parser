require 'minitest/autorun'
require "minitest/spec"

# Trips will be able to calculate their duration
class Trip
	attr_reader :driver_name, :miles
	def initialize start_time, end_time, miles
	    @start_time = start_time
	    @end_time = end_time
	    @miles = miles
	end

	def total_trip_time
		end_time = self.time_to_f(@end_time)
		start_time = self.time_to_f(@start_time)						
		if end_time > start_time
			end_time - start_time
		elsif start_time > end_time 
			raise ArgumentError, "End time cannot be before the start time"
		end		
	end
	
	def mph 
		@miles / self.total_trip_time 
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

describe Trip do 
	before do
    	@trip = Trip.new('07:15', '07:45', 17.3)
  	end

	it "has distance traveled" do
		assert @trip.miles == 17.3
	end

	it "can convert timestamps to float" do
		time = @trip.time_to_f '07:15'		
		assert time == 7.25
	end

	it "can calculate time spent traveling in hours" do
		assert @trip.total_trip_time == 0.5
	end
	
	it "Can calculate mph for the trip" do
		trip = Trip.new('07:00', '08:00', 5)
		trip2 = Trip.new('03:00', '04:30', 1.5)
		assert (trip.mph == 5 && trip2.mph == 1)
	end

	it "Throws an exeption if startime is before endtime" do
		assert_raises ArgumentError do 
			trip = Trip.new('07:15', '07:00', 17.3)
			trip.total_trip_time
		end		
	end

	it "Throws an exeption if hours and minutes are not delimited by a colon" do
		assert_raises ArgumentError do 
			trip = Trip.new('07:00', '0715', 17.3)
			trip.total_trip_time
		end		
	end
end
 
