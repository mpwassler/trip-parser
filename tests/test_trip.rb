require 'minitest/autorun'
require "minitest/spec"

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
 
