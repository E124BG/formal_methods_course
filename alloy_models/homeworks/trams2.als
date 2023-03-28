//Eliott Bonte
//a Model

//Station is the general term
//Stop is a Station that is not at an extremity of a line
//Terminus is at an extremity of a line (beginning or end of a line)

abstract sig Station {nextStation, prevStation : set Station}{ nextStation & prevStation = none}
//A station is defined by its next and previous stations - there can be multiple of them so I use sets

sig Stop extends Station {} {some nextStation && some prevStation}
//A tram stop has at least a previous station and a next station, as it is not at one end of the line

sig Terminus extends Station {} {(no nextStation or no prevStation) && !(no nextStation && no prevStation)}
//A terminus has no next station or no previous station, as it is at the end of the line
//note : there is no exclusive or in alloy, so we'll have to create a fact to avoid a terminus being alone (no selfloop fact)

sig Line {origin, destination : one Terminus, route : set Stop}{origin != destination}
//A line is defined by an origin and a destination that are both at the end of the line, and a set of Stops in between those
//two terminuses. Every Stop and the destination has to be in the set of nextStations of either the origin or the route.

//fact noSelfLoop {all s:Station | s not in s.nextStation && s not in s.prevStation}
//no Station is its own previous station nor next station

fact noLoop {all s : Station | s not in s.^nextStation && s not in s.^prevStation}
//a stronger fact that prevents paths from looping (i.e. coming back to the same station by always taking the next station or always the previous station)

fact nextPreviousCoherence {all s1,s2 : Station | (s1 in prevStation.s2 => s2 in nextStation.s1) && (s1 in nextStation.s2 => s2 in prevStation.s1)}
//if a station s2 is in the next stations of s1, s1 has to be in the previous stations of s2
//and if a station s1 is in the previous stations of s2, then s2 is in the next stations of s1

fact stationsOfLineAreReachableFromOrigin{all l : Line | l.route + l.destination = l.origin.^nextStation}
//destination and stops in the route of a line are reachable from the origin of the line


//b Predicates

pred differentStopsForLines() {all disj l,l1:Line | l.origin + l.route + l.destination != l1.origin + l1.route + l1.destination}
//no two tram lines have the same stops

pred allStopOnALine() {Station - (Line.origin + Line.route + Line.destination) = none}
//every stop is served by some line

pred differentLineDifferentTerminus() {all disj l,l1:Line | l.origin != l1.origin && l.destination != l1.destination}
//No two lines share the same terminus, I interpreted terminus here to be at the same time origin and destination


pred allThreePred() {differentStopsForLines and allStopOnALine and differentLineDifferentTerminus}



pred show(){}
//run differentStopsForLines for 4 Terminus, exactly 2 Line, 6 Stop

//run allStopOnALine for exactly 2 Line, 4 Terminus, 6 Stop

//run differentLineDifferentTerminus for exactly 2 Line, 4 Terminus, 6 Stop

run allThreePred for exactly 2 Line, 4 Terminus, 6 Stop


//c

//fun Station::servedBy():set Line{}

fun findLine[s : Station]: set Line{
	{l: Line | s in l.origin + l.route + l.destination}
}

pred Station::allStationHasALine(){
	this.findLine[] != none}

//run allStationHasALine
//A function that returns all of the tram lines serving a given stop (Station)


fun findCommonLine[s,s1 : Station]: set Line{
	{l : Line | (s in l.origin + l.route + l.destination) && (s1 in l.origin + l.route + l.destination)}
}

//A function that returns for two stops the set of tram lines serving both stops


fun findCommonStops[l, l1 : Line]: set Station{
	{s : Station | (l.origin + l.route + l.destination - s != l.origin + l.route + l.destination) &&  (l1.origin + l1.route + l1.destination - s !=  l1.origin + l1.route + l1.destination)}
}
//A function that returns, for two given tram lines, the set of stops that are served by both tram lines

//sig Route {stations : set Station}{Station = {l : Line | l.origin.*nextStation}}
//d
//add the notion of route in the above model, a route is defined for a tram line and consists of the ordered sequence of stops that are visited


//fun reachable[s : Station, r: Route]: set Station{
//	{s.^nextStation in r | s.^nextStation}
//}
//e
//Define a function that returns for a bus stop and a route the set of stops reachable on this route from this stop

//a station that is both in the ordered set (route) and reachable by nextStation transitions is reachable and on the same route

//2 problems I would improve on in this model :

//problem 1 : I did not manage to enforce a "no shortcut" property where the is only one route from origin to destination

//problem 2 : I interpreted "Terminus" as being an extremity of the line, meaning that every line goes from a Terminus to another Terminus
// It could be that a terminus is only the end of the line if we ignore the part where the tram goes back to the beginning of the line



