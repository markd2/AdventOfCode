program arrays
  implicit none
  
  ! 1D integer array
  integer, dimension(10) :: array1

  ! equivalent
  integer :: array2(10)

  ! 2D real array
  real, dimension(10, 10) :: array3

  ! custom lower and upper index bounds
  real :: array4(0:9)
  real :: array5(-5:5)

end program arrays
