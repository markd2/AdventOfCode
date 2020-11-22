program dowhile
  integer :: i

  real, parameter :: pi = 3.14159
  integer, parameter :: n = 10
  real :: result_sin(n)

  i = 1
  do while (i < 11)
     print *, i
     i = i + 1
  end do

  print *, "-----"

  do i = 1, 10
     if (mod(i, 2) == 0) then
        cycle
     end if
     print *, i
  end do

  print *, "-----"

  outer_loop: do i = 1, 10
     inner_loop: do j = 1, 10
        if ((j + i) > 10) then  ! print only pairs of i and j that sum to 10
           cycle outer_loop  ! go to the next iteration of the outer loop
        end if
        print *, "I=", i, ' J=', j, " Sum=", j + i
     end do inner_loop
  end do outer_loop

  print *, "-----"

  do concurrent (i = 1 : n)  ! syntax is slightly different
     result_sin(i) = sin(i * pi / 4.)
  end do

  print *, result_sin

end program dowhile

