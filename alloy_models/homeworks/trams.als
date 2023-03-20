//Eliott Bonte

//a model

sig Stop {nextStop, prevStop : lone  Stop}
//A stop is defined by a next stop and a previous stop.
//They can be empty

sig Terminus extends Stop {} {no nextStop or no prevStop}
//A terminus is a Stop which does not have either a previous or a next stop (inclusive or)

fact {all s,s1: Stop | s in s1.nextStop =>  s.prevStop = s1}
//if s is the nextStop of s1, then s1 is the previous stop of s

fact {all s,s1: Stop | s in s1.prevStop =>  s.nextStop = s1}
//if s is the previousStop of s1, then s1 is the nextStop of s

fact {all s : Stop | s.nextStop != s}
//a stop's next stop cannot be itself


fact {all s: Stop-Terminus | some s.nextStop && some s.prevStop}
//All stops that are not terminuses have a next and previous stop


fact {all t : Terminus | t.nextStop + t.prevStop != none}
//Terminuses cannot have no previous and no next stops

//I want to not have cyclical lines

//I want to have a representation of a line (a set of stops that are linked)

//I need to modify it to have multiple possible next and previous stops for the normal stops


pred show(){}
run show for 9 Stop
