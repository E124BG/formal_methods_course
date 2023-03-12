// Solutions for Homework 2

module formalMethods/curriculum

// non-empty set of courses
some sig Course {
	specializations: some Specialization // each course belongs to at least one specialization
} 

// some courses are core courses
some sig CoreCourse in Course {} 

sig Specialization {}

sig Student {
	specialization: Specialization,
 	courses: set Course
}

pred valid(s:Student){
	let p=s.specialization|{
		all c: CoreCourse| p in c.specializations => c in s.courses
		some disj c1,c2: Course |  not p in c1.specializations && not p in c2.specializations && c1+c2 in s.courses
	}
}
run valid 

