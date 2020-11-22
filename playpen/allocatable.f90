program allocatable
  implicit none

  integer :: i
  integer, allocatable :: array1(:)
  integer, allocatable :: array2(:,:)

  allocate(array1(10))
  allocate(array2(10,20))

  array1 = [(i, i = 1, 10)]
  print *,array1

  deallocate(array1)
  deallocate(array2)

end program allocatable
