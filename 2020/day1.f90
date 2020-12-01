! Day 1 - Preflight

function findMatch(inArray, inSize, outThing1, outThing2) result(foundMatch)
  implicit none

  integer, intent(in) :: inSize
  integer, dimension(inSize), intent(in) :: inArray
  integer, intent(out) :: outThing1
  integer, intent(out) :: outThing2
  logical :: foundMatch
  integer :: i
  integer :: j

  foundMatch = .false.

  do i = 1, inSize
     do j = i + 1, inSize
        if (inArray(i) + inArray(j) == 2020) then
           foundMatch = .true.
           outThing1 = inArray(i)
           outThing2 = inArray(j)
           exit
        end if
     end do
  end do

end function

! Doesn't seem to be an easy way to "read this file into an array" given my
! current caveman familiarity with the language.  So first scan through the file
! and count the number of elements, and then someone can allocate a properly
! sized array and then read in to that.
function fileCount(filename) result(lineCount)
  use :: iso_fortran_env

  implicit none
  
  character(*), intent(in) :: filename
  integer :: lineCount
  integer :: readStatus

  lineCount = 0

  open (unit=23, file=filename, status='old', action='read')
  do
     read(23, *, iostat=readStatus)

     if (readStatus .eq. iostat_end) then
        exit
     end if
     lineCount = lineCount + 1
  end do
  close(23)

end function


program preflight
  implicit none

  character(*), parameter :: filename = "day-1-input.txt"
  integer :: thing1
  integer :: thing2
  integer :: product
  logical :: found
  integer, allocatable, dimension(:) :: data
  logical :: findMatch
  integer :: fileCount
  integer :: lineCount
  integer :: i

  print *, "filecount ", fileCount(filename)
  lineCount = fileCount(filename)

  allocate(data(lineCount))
  open(unit=23, file=filename, status='old', action='read')
  read(23, *) (data(i), i=1, lineCount)
  close(23)

  found = findMatch(data, lineCount, thing1, thing2)

  if (found) then
     product = thing1 * thing2
     print *, "found ", thing1, " and ", thing2, " => ", product
  else
     print *, "not found"
  end if

end program


