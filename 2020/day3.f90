! Day 2 - Toboggan Trajectory
! https://adventofcode.com/2020/day/3

! Doesn't seem to be an easy way to "read this file into an array" given my
! current caveman familiarity with the language.  So first scan through the file
! and count the number of elements, and then someone can allocate a properly
! sized array and then read in to that.
!
! USED TWICE - MAKE A UTILITY MODULE PLZ KTHX
function lineCount(filename) result(count)
  use :: iso_fortran_env

  implicit none
  
  character(*), intent(in) :: filename
  integer :: count
  integer :: readStatus

  count = 0

  open (unit=23, file=filename, status='old', action='read')
  do
     read(23, *, iostat=readStatus)

     if (readStatus .eq. iostat_end) then
        exit
     end if
     count = count + 1
  end do
  close(23)
end function


program togogganTrajector
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-3-test-input.txt"
  integer :: lineCount
  integer :: width
  integer :: lines
  character(80) :: line

  character, dimension(:, :), allocatable :: forest

  ! how tall of an array?
  lines = lineCount(filename)

  ! how wide?
  open(unit=23, file=filename, status='old', action='read')
  read(23, *) line
  close(23)
  width = len(trim(line))

  print *, width, lines



end program

