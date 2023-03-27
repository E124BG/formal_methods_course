//Eliott Bonte
//a Model

abstract sig Station {nextStation, prevStation : set Station}{ nextStation & prevStation = none}
//A station is defined by its next and previous stations - there can be multiple of them so use sets

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
//I think it makes more sense in our context, even though not asked in the problem

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



