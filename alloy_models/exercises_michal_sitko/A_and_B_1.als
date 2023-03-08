// here we create instances B with each a parent A

//Signatures

sig A {}

//sig B {
//	parent: A
//}

// Predicates and facts

pred atLeastOne {
	#A > 0 //numbers of elems in a set
}

pred atLeastOneAndAtMostFive {
	atLeastOne && #A < 6
}

pred atLeastOneAndAtMostFiveAlternative {
	atLeastOne
	#A < 6
}

//facts are predicates that are always applied (no need to invoke them)
//use to model global invariants

fact notThree {
	#A != 3
}


pred show {}

//Assertions

//Commands

run atLeastOneAndAtMostFive for 6
