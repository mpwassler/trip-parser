require 'minitest/autorun'
require "minitest/spec"
require "./src/driver"
require "./src/trip"


describe TripCalculator do 
	before do
    	@trip_calculator = TripCalculator.new
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