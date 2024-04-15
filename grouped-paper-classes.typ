#set page(paper: "us-letter", margin: (y: 24pt)) 
#show heading: it => [
#set align(center)

  #block(smallcaps(it.body))
]

#show heading.where(level:1): it=>[
  #set text(20pt)
  #set align(center)
  #block(smallcaps(it.body))
] 

#show heading.where(level:2): it=>[
  #set text(15pt)
  #set align(center)
  #block(upper(it.body))
] 

#let results = csv("input.tmp.csv")
#let results_noheader = results.slice(1)
#let results_noheader = results_noheader.map(x=>{x.map(y=>{y.trim(" ")})})

#let groupClasses(classes) = {
  let classDict = (:)

  for class in classes{
    let credit_hours = class.remove(3)
    let course = class.remove(1)
    let name = class.remove(0)
    let classInfo = class
    

    if classDict.at(course, default:false) == false{
      classDict.insert(course, (name: name, credit_hours:credit_hours, classOptions: (classInfo,)))
    }
    else{
      classDict.at(course).classOptions.push(classInfo)
      
    }
  }
  return classDict
}

#let groupByProfs(classes) = {
  let profDict = (:)

  for class in classes{
    if class.at(4) != "N/A" {
      let profEmail = class.remove(5)
      let profName = class.remove(4)
      let classInfo = class
      if profDict.at(profName, default: false) == false{
        profDict.insert(
          profName, (
            email: profEmail,
            classes: (classInfo,)
          )
          
        )
      }
      else{
        profDict.at(profName).classes.push((classInfo))
      }
    }
  }
  for key in profDict.keys(){
    profDict.at(key).classes = groupClasses(profDict.at(key).classes)
  }
  return profDict
}

#let profDict = groupByProfs(results_noheader)

#let checkIfSingleCourse(profDict) = {
  let courses = ()
  let course_name = ""
  for key in profDict.keys(){
    for course in profDict.at(key).classes.keys(){
      courses.push(course)
      course_name = profDict.at(key).classes.at(course).name
    }

  }

  courses = courses.flatten()

  let previous_course = ""

  for course in courses {
    if previous_course == ""{
      previous_course = course
      continue
    }
    if previous_course != course{
      return (false, previous_course, course_name)
    }
    else{
      previous_course = course
    }
  }

  return (true, previous_course, course_name)
}

#let (is_single_course, single_course, single_course_name) = checkIfSingleCourse(profDict)


#if is_single_course{
  
  align(
    center, block(
    below: 40pt
  )[

    = #text(25pt)[#single_course_name (#single_course)]]
)
}

#align(center, 

for key in profDict.keys(){
  let classes = (profDict.at(key).classes)
  block(breakable: false, below: 32pt)[
    = #key
    #text(16pt)[
    #profDict.at(key).email
  ]
  
    #for course in classes.keys(){
      let classOptions = classes.at(course).classOptions
      if is_single_course == false{
        [

          == #classes.at(course).name (#course)]
      }
      [credit hours: #classes.at(course).credit_hours]
      for option in classOptions{
        align(start)[
        #table(
          columns: (auto, 1fr),
          stroke: (x, y) => (
  left: if x > 0 { 1pt },
  top: if y > 0 { 1pt },
),
          [*CRN*], [#option.at(0)],
          [*Delivery Method*], [#option.at(1)],
          [*Times*], [#option.at(2)],
          [*Location*], [#option.at(3)],
          [*Start-End*], [#option.at(4)],
          [*Seats Open*], [#option.at(5)],
          [*Waitlist Slots*], [#option.at(6)],
          [*Attributes*], [#option.at(7)],
  
        )
      ]
      }
    }
  ]
  
}
)