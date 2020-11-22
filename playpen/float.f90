program float
!  use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
  use, intrinsic :: iso_c_binding, only: sp=>c_float, dp=>c_double
  implicit none

  real(sp) :: float32
  real(dp) :: float64

  float32 = 1.0_sp  ! explicit suffix for litearal contants
  float64 = 1.0_dp

end program float
