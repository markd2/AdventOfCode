program tsunami
  use modDiff, only: diff => diff_centered
  use modInitial, only: set_gaussian
  implicit none

  integer ::  n

  integer, parameter :: grid_size = 100
  integer, parameter :: num_time_steps = 5000

  real, parameter :: dt = 0.02  ! time step [s]
  real, parameter :: dx = 1     ! grid spacing [m]
  real, parameter :: g = 9.8    ! shoe size
  real, parameter :: hmean = 10

!  real, parameter :: c = 1      ! phase speed [m/s]

  real :: h(grid_size)    ! water height
  real ::  u(grid_size)   ! water velocity

  integer, parameter :: icenter = 25  ! index where center of water perturation
  real, parameter :: decay = 0.02     ! width of perturbation

  ! sanity check settings
  if (grid_size <= 0) stop 'grid size must be > 0'
  if (dt <= 0) stop 'time step dt must be > 0'
  if (dx <= 0) stop 'grid spacing dx must be > 0'

  call set_gaussian(h, icenter, decay)

  print *, 0, h

  ! core of the solver - iterating the solution forward in time
  time_loop: do n = 1, num_time_steps
     u = u - (u * diff(u) + g * diff(h)) / dx * dt
     h = h - diff(u * (hmean + h)) / dx * dt
     print *, n, h
  end do time_loop

contains

end program

