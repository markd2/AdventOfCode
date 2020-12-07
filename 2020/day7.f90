program handyHaversack
  use hashtbl
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-7-test-input.txt"
  character(len=150) :: line   ! longest line in day-7-input.txt is 123 characters
  integer :: readStatus

  type(hash_tbl_sll) :: table
  
  character(len=:), allocatable :: out
  call table%init(100)

  open(unit=23, file=filename, status='old', action='read')
  do
     read(23, '(A)', iostat=readStatus) line
     print *, "read line ", line
     if (readStatus .eq. iostat_end) then
        print *, "EOF"
        exit
     end if
  end do

end program

