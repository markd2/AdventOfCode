program tsunami
  implicit none

  integer :: i, n

  integer, parameter :: grid_size = 100
  integer, parameter :: num_time_steps = 100

  real, parameter :: dt = 1  ! time step [s]
  real, parameter :: dx = 1  ! grid spacing [m]
  real, parameter :: c = 1  ! phase speed [m/s]

  real :: h(grid_size), dh(grid_size)

  integer, parameter :: icenter = 25  ! index where center of water perturation
  real, parameter :: decay = 0.02     ! width of perturbation

  ! sanity check settings
  if (grid_size <= 0) stop 'grid size must be > 0'
  if (dt <= 0) stop 'time step dt must be > 0'
  if (dx <= 0) stop 'grid spacing dx must be > 0'
  if (c <= 0) stop 'background flow speed c must be > 0'


  call set_gaussian(h, icenter, decay)

  ! core of the solver - iterating the solution forward in time
  time_loop: do n = 1, num_time_steps
     h = h - c * diff(h) / dx * dt
     print *, n, h
  end do time_loop

contains

  subroutine set_gaussian(x, icenter, decay)
    real, intent(in out) :: x(:)

    integer, intent(in) :: icenter
    real, intent(in) :: decay
    integer :: i

    do concurrent (i = 1:size(x))
       h(i) = exp(-decay * (i - icenter) ** 2 )
    end do
  end subroutine

  pure function diff(x) result(dx)
    real, intent(in) :: x(:)
    real :: dx(size(x))
    integer :: im

    im = size(x)
    dx(1) = x(1) - x(im)
    dx(2 : im) = x(2 : im) - x(1 : im - 1)
  end function

end program

