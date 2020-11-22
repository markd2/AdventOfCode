program arraySlice

  implicit none
  
  integer :: i
  integer :: array1(10)      ! 1D integer array of 10 elementals
  integer :: array2(10, 10)  ! 2D integer array of 100 elements

  array1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]  ! array constructor
  array1 = [(i, i = 1, 10)]                 ! implied DO loop constructor
  array1(:) = 0       ! set all elements to zero
  array1(1:5) = 1      ! set first five elements to 1
  array1(6:) = 2       ! set all elements after five to 2

  print *, array1(1:10:2)   ! print out elements at odd indices
  print *, array2(:, 1)     ! print out first column in a 2D array
  print *, array1(10:1:-1)  ! print array in reverse

end program arraySlice
