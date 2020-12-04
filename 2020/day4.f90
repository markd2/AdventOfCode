! Day 4 - Passport Processing
! https://adventofcode.com/2020/day/4

program passportProcessing
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-4-test-input.txt"
  character(len=256) :: line
  integer :: readStatus

  open(unit=23, file=filename, status='old', action='read')

  do
     read(23, '(A)', iostat=readStatus) line
     if (readStatus .eq. iostat_end) then
        exit
     end if
     print *, trim(line)
  end do
  close(23)

end program
