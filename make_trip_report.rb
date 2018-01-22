#!/usr/bin/env ruby 
require "./src/trip_calculator"

if ARGV[0].nil? 
	puts "please pass a txt file to read"
elsif ARGV[0].split(".")[1] != "txt"
	puts "File must by of type .txt"		
else
	input_file = ARGV[0]
	calculator = TripCalculator.new
	calculator.read_file input_file
	calculator.write_report "output.txt"
	puts "File 'output.txt' written successfully"
end
