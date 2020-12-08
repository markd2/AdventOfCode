! Handheld Halting
! https://adventofcode.com/2020/day/8

program handheldHalting
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-8-test-input.txt"
  character(len=50) :: line
  integer :: readStatus, sum
  integer :: lineCount

  lineCount = fileCount(filename)
  print *, lineCount


contains
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

end program
