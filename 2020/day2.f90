! Day 2 - Password Philosophy
! https://adventofcode.com/2020/day/2

module blah
  implicit none
  
contains
  
  function isValid(password, required, upperBound, lowerBound) result(valid)
    implicit none
    character(len=*) :: password
    character, intent(in) :: required
    integer, intent(in) :: upperBound, lowerBound
    logical :: valid
    
    integer :: count
    integer :: i
    character :: scan
    integer :: length
    
    count = 0
    length = len(password)


    do i = 1, length
       scan = password(i:i)
       if (scan .eq. required) then 
          count = count + 1 
       end if
    end do
    
    valid = count .ge. upperBound .and. count .le. lowerBound
    ! print *, "pw ", password, "valid ", valid

  end function
end module


program passwordPhilosophy
  use :: iso_fortran_env
  use blah
  implicit none
  logical :: isGood
  integer :: goodCount

  integer :: i
  integer :: thing1, thing2
  character :: dummy, dummy2
  integer :: readStatus
  character(len=80) :: range, required, password

  character(*), parameter :: filename = "day-2-input.txt"

  open(unit=23, file=filename, status='old', action='read')

  goodCount = 0

  do
     read(23, *, iostat=readStatus) range, required, password
     if (readStatus .eq. iostat_end) then
        exit
     end if

     ! --- get the range
     ! replace "-" with a space in the "10-30" range
     do i = 1, len(range)
        select case(range(i:i))
           case('-'); range(i:i) = ' '
        end select
     end do
     ! extract start and end from the string
     read(range, *) thing1, thing2

     ! --- get the required letter
     required(2:2) = ''

     isGood = isValid(trim(password), required, thing1, thing2)
     if (isGood) then
        goodCount = goodCount + 1
     end if

  end do

  print *, "good count is ", goodCount

  close(23)


end program



