# Instructions for running

Run with `ruby make_trip_report.rb <name of file>.txt`.  

Tests require rake `gem install rake`.

Run tests with `rake test`.

Tests are located in the spec folder.

Implementation classes are located in the src folder.

`make_trip_report.rb` is main index file into application.

# Language choice

I decided I would do this in either Python or Ruby for the following reasons
- less dependencies - node stdlib can be quite weak at times an I would probably have had to include some extra packages
- Testing - similar to the first point, both python and ruby have built in test frameworks
- simplicity to run - compared to something like PHP, you certainly can write php command line apps but its a bit unusual and clunky

Ultimately I decided to use Ruby since it is a Ruby job posting and now is as good a time as any to get comfortable with it.

# Application Architecture 

Program is modeled in 3 classes Driver, Trip, and TripCalculator.

Sample object graph

TripCalculator
- Driver: 'Ted'
	- Trip
	- Trip
	- Trip
- Driver: 'Bob'
	- Trip
	- Trip

Trip will take all trip data and be able to calculate the time the trip took, as well as the mph of the trip.

Driver will hold all driver data and be able to calculate totals of all trips.

TripCalculator will handle all IO for the application. It will read the input file one line at a time and determine which command is being run. It will also hold a hash of registered drivers. 

For performance I want everything to happen in one pass through the file vs transforming the file data several times.

If the scope increased I would probably further break up the trip_calculator class and possible split the hash of drivers into its own class, but I think its okay to use 3 classes for this.


