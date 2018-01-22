
require 'minitest/autorun'
require "minitest/spec"
require "./src/trip"

# Driver and Trip are definite classes. 
# Drivers will be stored in a hash
# Each driver will have an array of Trips
class Driver
	attr_reader :name, :trips
	def initialize(name)
	    @name = name
	    @trips = []
	end

	def add_trip trip 		
		if trip.mph >= 5.0 && trip.mph <= 100.0
			@trips << trip 
		end
	end

	def trip_total_miles
		@trips.reduce(0) do |carry, trip|
			carry += trip.miles
		end
	end

	def trips_total_time
		@trips.reduce(0) do |carry, trip|
			carry += trip.total_trip_time
		end
	end

	def trips_total_mph
		total_miles = self.trip_total_miles
		if total_miles > 0
			(total_miles / self.trips_total_time).round
		else 
			nil
		end
	end

	def trip_report_str
		total_mph = self.trips_total_mph
		total_miles = self.trip_total_miles.round
		if total_mph.nil?
			"#{total_miles} miles"	
		else
			"#{total_miles} miles @ #{total_mph} mph"	
		end
	end
end


describe Driver do 
	before do
    	@driver = Driver.new('Mitchel')
    	@driver.add_trip Trip.new('07:00', '08:00', 5.5)
    	@driver.add_trip Trip.new('12:00', '13:00', 5)
    	@driver.add_trip Trip.new('06:00', '07:00', 10)    	
  	end

  	it "has a name?" do		
		assert @driver.name == 'Mitchel'
	end

	it "Can add a trip" do		
		trip = Trip.new('07:00', '08:00', 17.3)
		driver = Driver.new('Mitchel')
		driver.add_trip trip
		assert driver.trips.count == 1
	end

	it "ignores trips under 5 mph" do
		trip = Trip.new('07:00', '08:00', 1)	
		@driver.add_trip trip
		assert @driver.trips.count == 3
	end

	it "ignores trips over than 100 mph" do
		trip = Trip.new('07:00', '08:00', 150)		
		@driver.add_trip trip		
		assert @driver.trips.count == 3
	end

	it "Can calculate total miles of all trips" do
		assert @driver.trip_total_miles == 20.5
	end

	it "Can calculate the total time of all trips" do
		assert @driver.trips_total_time == 3
	end

	it "Can calculate mph of all trips" do
		assert @driver.trips_total_mph == 7
	end

	it "Will return 0 miles for total distance if no trips have been added" do
		driver = Driver.new('Mitchel')
		assert driver.trip_total_miles == 0
	end

	it "Will print out a string to represent the trip report" do
		driver = Driver.new('Dan')
		driver.add_trip Trip.new('07:15', '07:45', 17.3)
		driver.add_trip Trip.new('06:12', '06:32', 21.8)
		assert driver.trip_report_str == '39 miles @ 47 mph'
	end

	it "Will print out 0 miles with no mph if there are no trips added" do
		driver = Driver.new('Dan')
		assert driver.trip_report_str == '0 miles'
	end

	
end
 
