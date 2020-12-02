! Day 2 - Password Philosophy
! https://adventofcode.com/2020/day/2

module blah
  implicit none
  
contains
  
  function isValid(password, letter, upperBound, lowerBound) result(valid)
    implicit none
    character(len=*) :: password
    character, intent(in) :: letter
    integer, intent(in) :: upperBound, lowerBound
    logical :: valid
    
    integer :: count
    integer :: i
    character :: scan
    integer :: length
    
    count = 0
    length = len(password)

    print *, "length ", length

    do i = 1, length
       scan = password(i:i)
       print *, "  scan ", scan, " letter ", letter
       if (scan .eq. letter) then 
          count = count + 1 
       end if
    end do
    
    valid = count .ge. upperBound .and. count .le. lowerBound
    print *, "    valid? ", valid

  end function
end module


program passwordPhilosophy
  use blah
  implicit none
  logical :: isGood

  isGood = isValid("abcde", "a", 1, 3)
  isGood = isValid("cdefg", "b", 1, 3)
  isGood = isValid("ccccccccc", "c", 2, 9)

end program



