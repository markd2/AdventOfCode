program hondaElemental
  implicit none

  print *, sum(3, 5)
  print *, sum([1,2], 3, .true.)
  print *, sum(1, [2,3,4])
  print *, sum([1,2,3], [2,3,4])
  ! print *, sum([1,2], [2,3,4])  ! error - different shapes

  print *, coldFrontTemp(1, 2, 3, 4, [5, 6, 7, 8, 9])

contains
  elemental integer function sum(a, b, degub)
    integer, intent(in) :: a, b
    logical, intent(in), optional :: degub
    if (present(degub)) then
       ! can use `degub` for ifs &c
       sum = 666
    else 
       sum = a + b
    end if
  end function

  elemental integer function coldFrontTemp(c1, c2, c3, c4, c5)
    integer, intent(in) :: c1
    integer, intent(in) :: c2
    integer, intent(in) :: c3
    integer, intent(in) :: c4
    integer, intent(in) :: c5

    coldFrontTemp = c1 + c2 + c3 + c4 + c5
  end function
end program
