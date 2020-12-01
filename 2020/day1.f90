! Day 1 - Preflight

function findMatch2(inArray, inSize, outThing1, outThing2) result(foundMatch)
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

function findMatch3(inArray, inSize, outThing1, outThing2, outThing3) result(foundMatch)
  implicit none

  integer, intent(in) :: inSize
  integer, dimension(inSize), intent(in) :: inArray
  integer, intent(out) :: outThing1
  integer, intent(out) :: outThing2
  integer, intent(out) :: outThing3
  logical :: foundMatch
  integer :: i
  integer :: j
  integer :: k

  foundMatch = .false.

  do i = 1, inSize
     do j = i + 1, inSize
        do k = j + 1, inSize
           if (inArray(i) + inArray(j) + inArray(k) == 2020) then
              foundMatch = .true.
              outThing1 = inArray(i)
              outThing2 = inArray(j)
              outThing3 = inArray(k)
              exit
           end if
        end do
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
  integer, allocatable, dimension(:) :: data
  integer :: lineCount

  integer :: thing1, thing2, thing3
  integer :: product
  logical :: found
  integer :: i

  ! functions
  logical :: findMatch2, findMatch3
  integer :: fileCount

  ! read in the file contents. Assuming it's well-formed
  lineCount = fileCount(filename)
  print *, lineCount, "lines in ", filename

  allocate(data(lineCount))
  open(unit=23, file=filename, status='old', action='read')
  read(23, *) (data(i), i=1, lineCount)
  close(23)

  ! pair-wise work (part 1)
  found = findMatch2(data, lineCount, thing1, thing2)

  if (found) then
     product = thing1 * thing2
     print *, "found match-2", thing1, " and ", thing2, " => ", product
  else
     print *, "match-2 not found"
  end if

  ! triplet-wise work (part 2)
  found = findMatch3(data, lineCount, thing1, thing2, thing3)

  if (found) then
     product = thing1 * thing2 * thing3
     print *, "found match-3", thing1, " and ", thing2, " and ", thing3, " => ", product
  else
     print *, "match-3 not found"
  end if

end program


