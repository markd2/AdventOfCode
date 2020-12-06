! Day 6 - Custom Customs
! https://adventofcode.com/2020/day/5

program customCustoms
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-6-test-input.txt"
  character(len=10) :: line
  integer :: readStatus

  open(unit=23, file=filename, status='old', action='read')
  do
     read(23, '(a)', iostat=readStatus) line

     if (readStatus .eq. iostat_end) then
        print *, "EOF"
        exit
     end if
     if (readStatus .ne. 0) then
        exit
     end if


     if (len(trim(line)) == 0) then
        print *, "END OF RECORD"
        cycle
     end if
     
  end do
  
contains
  
end program
