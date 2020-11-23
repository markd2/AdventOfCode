! * amount needed to launch a _module_ is based on its _mass_
! * take its mass, divide by 3, round down, subtract 2.  e.g.
!     - mass of 12:  12 / 3 == 4, -2 == 2
!     - mass of 14:  12 / 3 == 4.6666 == 4, -2 == 2
!     - mass of 100756:  100756 / 3 = 33,585.33 == 33585, -2 == 33583
! * the fuel counter-upper&trade; needs to know the total, so calculate
!   mass for each module (puzzle input) and sum all the values

function calculateFuelNeededForMass(mass) result(fuelNeeded)
  implicit none

  real, intent(in) :: mass
  integer :: fuelNeeded

  integer :: divThree

  divThree = mass / 3.0
  fuelNeeded = divThree - 2
end function


program day1
  use :: iso_fortran_env

  implicit none

  integer :: status
  integer, parameter :: EOF = -1
  character(*), parameter :: filename = "day-1-input.txt"
  real :: mass
  integer :: calculateFuelNeededForMass
  integer :: totalFuel = 0

  open (unit=23, file=filename, status='old', action='read')

  do
     read(23, *, iostat=status) mass

     if (status .eq. iostat_end) then
        exit
     end if
     totalFuel = totalFuel + calculateFuelNeededForMass(mass)
  end do

  print *, totalFuel
  
  close(23)

end program day1
