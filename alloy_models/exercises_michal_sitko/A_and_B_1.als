// here we create instances B with each a parent A

//Signatures

sig A {}

sig B {
	parent: A
}

// Predicates and facts

pred show {}

//Assertions

//Commands

run {} for exactly 2 A, 1 B
