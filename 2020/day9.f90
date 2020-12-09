! https://adventofcode.com/2020/day/9

program encodingError
  implicit none

  ! I/O
  character(*), parameter :: filename = "day-9-test-input.txt"
  integer :: preamble = 5
!  character(*), parameter :: filename = "day-9-input.txt"
!  integer :: preamble = 25
  character(len=50) :: line
  integer :: readStatus, sum
  integer :: lineCount

  ! number stream
  integer, allocatable :: stream(:)
  integer :: i, number, index
  logical :: valid

  lineCount = fileCount(filename)
  print *, lineCount
  allocate(stream(lineCount))

  open(unit=23, file=filename, status='old', action='read')
  do i = 1, lineCount
     read (23, *) number
     stream(i) = number
  end do
  close(23)

  index = 6
  valid = verify(stream, lineCount, preamble, index)
  print *, "index ", index, " is valid? ", valid

contains
  logical function verify(stream, lineCount, preamble, index)
    integer, intent(in) :: lineCount
    integer, intent(in) :: stream(lineCount)
    integer, intent(in) :: preamble
    integer, intent(in) :: index

    verify = .false.
  end function

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
