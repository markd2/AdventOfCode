subroutine printMatrix(n, m, A)
  implicit none
  integer, intent(in) :: n
  integer, intent(in) :: m
  real, intent(in) :: A(n, m)
  
  integer :: i
  do i = 1, n
     print *, A(i, 1:m)
  end do
end subroutine printMatrix

function vectorNorm(n, vec) result(norm)
  implicit none
  integer, intent(in) :: n
  real, intent(in) :: vec(n)
  real :: norm

  norm = sqrt(sum(vec ** 2))
end function vectorNorm

program subby
  implicit none

  real :: mat(10, 20)
  real :: v(9)  ! coulda had a v8
  real :: vectorNorm   ! declaring the function type?

  mat(:,:) = 0.0

  call printMatrix(10, 20, mat)

  v(:) = 9
  print *, "vector norm = ", vectorNorm(9, v)
  
end program subby
