require "./src/driver"
require "./src/trip"

class TripCalculator

	attr_reader :drivers

	def initialize
	    @drivers = {}
	end
	
	def read_file filename
		begin	    
			file = File.new(filename, "r")
		    file.each do |line|
		    	self.read_input_line line
		    end	    
		rescue => err
		    puts "File not loaded: #{err}"
		    err
		ensure
			file.close if file
		end
	end

	def write_report filename
		output_string = ''
		@drivers.each do |key,driver|
			output_string += "#{driver.name} #{driver.trip_report_str} \n"
		end
		File.write(filename, output_string)
	end

	def create_driver name
		unless @drivers.has_key? name
			driver = Driver.new name
			@drivers[name] = driver
			driver
		end
	end

	def create_trip trip, driver_name
		if @drivers.has_key? driver_name			
			@drivers[driver_name].add_trip trip
		else
			puts "No driver #{driver_name} registered, created a new driver"
			driver = self.create_driver driver_name
			driver.add_trip trip
		end	
	end

	def handle_driver_command input_params
		unless input_params[1].nil?
			driver_name = input_params[1]
			self.create_driver driver_name			
		else
			raise ArgumentError, "Driver command requires a driver name"		
		end
	end

	def handle_trip_command input_params
		if input_params.count == 5
			trip =  Trip.new input_params[2].to_s, input_params[3].to_s, input_params[4].to_f
			driver_name = input_params[1]			
			self.create_trip trip, driver_name	
		else
			raise ArgumentError, "Trip command requires a driver name, start time, end time, and distance"		
		end
	end

	def read_input_line line_in
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
			    puts "line not parsed  #{line_in} - #{err}"
			    err
			end			
		end
	end
end
