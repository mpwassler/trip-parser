require "./src/driver"
require "./src/trip"

class TripCalculator
	attr_reader :drivers
	def initialize
	    @drivers = {}
	end
	
	# Read input file line by line
	def read_file filename
		begin	    
			file = File.new(filename, "r")
			line_number = 1
		    file.each do |line|		    	
		    	self.read_input_line line, line_number
		    	line_number += 1
		    end	    
		rescue => err
		    puts "File not loaded: #{err}"
		    err
		ensure file.close if file end
	end

	# Outputs the report from the file will write to file if passed
	def write_report filename=nil
		output_string = ''
		drivers = @drivers.sort_by { |key,driver| -driver.trip_total_miles }
		drivers.each do |key,driver|
			output_string += "#{driver.trip_report_str} \n"
		end
		unless filename.nil?
			File.write(filename, output_string)
		end
		output_string
	end

	# Add a new driver to the hash if thye dont exist already
	def create_driver name
		unless @drivers.has_key? name
			driver = Driver.new name
			@drivers[driver.name] = driver
			driver
		end
	end

	# Adds a trip to its specified driver, will create a new driver 
	# if trip is for a driver that isn't in the hash
	def create_trip trip, driver_name
		if @drivers.has_key? driver_name			
			@drivers[driver_name].add_trip trip
		else
			puts "No driver #{driver_name} registered, created a new driver"
			driver = self.create_driver driver_name
			driver.add_trip trip
		end	
	end

	# Validates input to driver command
	def handle_driver_command input_params
		unless input_params[1].nil?
			driver_name = input_params[1]
			self.create_driver driver_name			
		else raise ArgumentError, "Driver command requires a driver name" end
	end

	# Validates input to trip command
	def handle_trip_command input_params
		if input_params.count == 5
			trip =  Trip.new input_params[2].to_s, input_params[3].to_s, input_params[4].to_f
			driver_name = input_params[1]			
			self.create_trip trip, driver_name	
		else raise ArgumentError, "Trip command requires a driver name, start time, end time, and distance" end
	end

	# Determines which command is being run per line
	def read_input_line line_in, line_number
		input_params = line_in.split(" ")
		unless input_params.empty? 
			begin	    
				case input_params[0]
				when "Driver"
					self.handle_driver_command input_params		
				when "Trip"
					self.handle_trip_command input_params		
				else
					puts "#{input_params[0]} id not a supported command"
				end
			rescue => err
			    puts "line #{line_number} not parsed, Incorrect input format  #{line_in} - #{err}"
			    err
			end			
		end
	end
end
