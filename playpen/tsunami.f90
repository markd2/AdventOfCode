program tsunami
  implicit none

  integer :: i, n

  integer, parameter :: grid_size = 100
  integer, parameter :: num_time_steps = 100

  real, parameter :: dt = 1  ! time step [s]
  real, parameter :: dx = 1  ! grid spacing [m]
  real, parameter :: c = 1  ! phase speed [m/s]

  real :: h(grid_size), dh(grid_size)

end program

