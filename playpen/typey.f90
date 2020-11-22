module fToC
  use iso_c_binding, only: c_int
  implicit none

  type, bind(c) :: f_type
     integer(c_int) :: i
  end type
  
end module fToC


module mMatrix
  implicit none
  private

  type, public :: tMatrix(rows, cols, k)
     integer, len :: rows, cols
     integer, kind :: k = kind(0.0)   ! k already been assigned default value
     real(kind = k), dimension(rows, cols) :: values
  end type
end module


program typey
  use mMatrix
  implicit none

  type :: t_pair
     integer :: i = 1
     real :: x = 0.5
  end type t_pair

  type :: tPair2
     sequence
     integer :: i
     real :: x
  end type tPair2

  type(t_pair) :: pair
  type(tPair2) :: pair2

  type(tMatrix(rows=5, cols=5)) :: m

  pair%i = 1
  pair%x = 0.5

  print *, pair

  pair = t_pair(1, 0.5)  ! positional arguments
  pair = t_pair(i = 1, x = 0.5)  ! keyword arguments
  pair = t_pair(x = 0.5, i = 1)   ! can go in any order

  pair = t_pair()
  pair = t_pair(i = 2)
  pair = t_pair(x = 2.7)

  pair2 = tPair2(1, 0.5)


end program typey
