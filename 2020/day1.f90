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
           outThing2 = inArraY(j)
           exit
        end if
     end do
  end do

end function


program preflight
  implicit none

  integer :: thing1
  integer :: thing2
  integer :: product
  logical :: found
  integer, dimension(6) :: data
  logical :: findMatch

  data = [1721, 979, 366, 299, 675, 1456]

  found = findMatch(data, 6, thing1, thing2)

  if (found) then
     product = thing1 * thing2
     print *, "found ", thing1, " and ", thing2, " => ", product
  else
     print *, "not found"
  end if
  

end program


