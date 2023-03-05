// Solutions to Homework 1

module formalMethods/curriculum

// non-empty set of courses
some sig Course {
	specializations: some Specialization // each course belongs to at least one specialization
} 

// some courses are core courses
some sig CoreCourse extends Course {} 

sig Specialization {}

//A student must take at least one core course and at most one non-core course

sig Student {
 	coreCourses: some CoreCourse,
	nonCoreCourses: lone Course-CoreCourse
}

pred show(){}
run show 
