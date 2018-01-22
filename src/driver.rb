# Driver and Trip are definite classes. 
# Drivers will be stored in a hash
# Each driver will have an array of Trips
class Driver
	attr_reader :trips
	def initialize(name)
	    @name = name.downcase
	    @trips = []
	end

	def name
		@name.capitalize
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
		else nil end
	end

	def trip_report_str
		total_mph = self.trips_total_mph
		total_miles = self.trip_total_miles.round
		if total_mph.nil?
			"#{@name.capitalize} #{total_miles} miles"	
		else "#{@name.capitalize} #{total_miles} miles @ #{total_mph} mph"	end
	end
end

