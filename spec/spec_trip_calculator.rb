require 'minitest/autorun'
require 'minitest/spec'
require "./src/trip_calculator"
require "./src/driver"
require "./src/trip"

describe TripCalculator do 
	before do
    	@trip_calculator = TripCalculator.new
  	end
  	
  	it "Doesnt add the same driver more than once" do
	  	@trip_calculator.create_driver "Bob"
	  	@trip_calculator.create_driver "Bob"
	  	assert @trip_calculator.drivers.count == 1
  	end


  	it "Parses the sample input correctly" do
  		@trip_calculator.read_input_line "Driver Dan", 1
		@trip_calculator.read_input_line "Driver Alex", 2
		@trip_calculator.read_input_line "Driver Bob", 3
		@trip_calculator.read_input_line "Trip Dan 07:15 07:45 17.3", 4
		@trip_calculator.read_input_line "Trip Dan 06:12 06:32 21.8", 5
		@trip_calculator.read_input_line "Trip Alex 12:01 13:16 42.0", 6
 		assert @trip_calculator.write_report == "Alex 42 miles @ 34 mph \nDan 39 miles @ 47 mph \nBob 0 miles \n"
  	end

  	it "Will create a new driver if it parses a trip that does not already have a driver" do
		@trip_calculator.read_input_line "Trip Frank 12:01 13:16 42.0", 1
		@trip_calculator.read_input_line "Trip Ted 12:01 13:16 42.0", 1
		assert @trip_calculator.drivers.count == 2
  	end

  	it "Will only create one driver for name regardless of lettter case" do
  		@trip_calculator.read_input_line "Driver Ted", 1
		@trip_calculator.read_input_line "Driver ted", 2
  		assert @trip_calculator.drivers.count == 1
  	end


  	it "Throws exception if trip arguments not formatted corectly" do
  		assert_raises ArgumentError do 
			 @trip_calculator.handle_trip_command "Trip Dan 07:15".split(" ")
		end	
  	end 

  	it "Throws exception if driver arguments not formatted corectly" do
  		assert_raises ArgumentError do 
			@trip_calculator.handle_driver_command "Driver".split(" ")
		end	
  	end 

end