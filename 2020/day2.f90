! Day 2 - Password Philosophy
! https://adventofcode.com/2020/day/2

function isValid(password, letter, upperBound, lowerBound) result(valid)
  implicit none
  character, intent(in) :: password(*)
  character, intent(in) :: letter
  integer, intent(in) :: upperBound, lowerBound
  logical :: valid

  valid = .false.

end function


program passwordPhilosophy
  implicit none
  logical :: isValid

  print *, "1-3 a abcde", isValid("abcde", "a", 1, 3)
!  print *, "1-3 a abcde", isValid("cdefg", "b", 1, 3)
!  print *, "1-3 a abcde", isValid("ccccccccc", "a", 2, 9)

end program



