// A file system obj in file system
sig FSObject {parent: lone Dir}

//A directory in the file system
sig Dir extends FSObject {contents: set FSObject}

// A file in the file system

sig File extends FSObject {}

// A directory is the parent of its contents

fact {all d: Dir, o: d.contents | o.parent = d}
//Given any directory d and any object o in its content,
//d must be the parent of o.
//equivalences:

//fact { all d: Dir | all o: d.contents | o.parent = d }

//fact { all d: Dir, o: FSObject | o in d.contents => o.parent = d }

//fact { all d: Dir | all o: FSObject | o in d.contents => o.parent = d }


// All file system objects are either files or directori
fact {File + Dir = FSObject}

// There exists a root

one sig Root extends Dir {} {no parent}

// File system is connected

fact {
	FSObject in Root.*contents
}

//* is the reflexive transitive closure = identity + non reflexive transitivie closure
//*contents = content + content.content + content.content.content...

// The contents path is acyclic
assert acyclic {
	no d : Dir | d in d.^content
}
//^ is the non reflexive transitive closure
//^content = content.content + .... (no identity though)

// Now check it for a scope of 5

// File system has one root
