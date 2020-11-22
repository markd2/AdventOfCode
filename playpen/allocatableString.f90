program allocatableString
  implicit none

  character(:), allocatable :: first_name
  character(:), allocatable :: last_name

  ! explicit allocation statement
  allocate(character(4) :: first_name)
  first_name = 'John'
  
  ! allocation on assignment
  last_name = 'Smith'

  print *, first_name // ' ' // last_name
end program allocatableString
