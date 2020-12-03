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

  character(*), parameter :: filename = "day-3-input.txt"
  integer :: lineCount
  integer :: width
  integer :: lines
  integer :: readStatus
  character(80) :: line
  integer :: row, column

  character, dimension(:, :), allocatable :: forest

  ! how tall of an array?
  lines = lineCount(filename)

  ! how wide?
  open(unit=23, file=filename, status='old', action='read')
  read(23, *) line
  width = len(trim(line))

  allocate(forest(width, lines))  ! columns, rows

  close(23)
  open(unit=23, file=filename, status='old', action='read')

!  rewind(23)
  do row = 1, lines
     read(23, *) line

     do column = 1, width
        forest(column, row) = line(column:column)
     end do

     if (readStatus .eq. iostat_end) then
        print *, "eof"
        exit
     end if
  end do
  close(23)

  

  deallocate(forest)


end program

