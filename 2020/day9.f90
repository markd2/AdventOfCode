! https://adventofcode.com/2020/day/9

program encodingError
  use iso_fortran_env, only: int64
  implicit none

  ! I/O
!  character(*), parameter :: filename = "day-9-test-input.txt"
!  integer :: preamble = 5
  character(*), parameter :: filename = "day-9-input.txt"
  integer :: preamble = 25
  character(len=50) :: line
  integer :: readStatus, sum
  integer :: lineCount

  ! number stream
  integer(int64), allocatable :: stream(:)
  integer(int64) number
  integer :: i, index
  logical :: valid

  lineCount = fileCount(filename)
  print *, lineCount
  allocate(stream(lineCount))

  open(unit=23, file=filename, status='old', action='read')
  do i = 1, lineCount
     read (23, *) number
     print *, "READ ", number
     stream(i) = number
  end do
  close(23)

  do i = preamble + 1, lineCount
     valid = verify(stream, lineCount, preamble, i)
     if (.not. valid) then
        print *, "index ", i, " value ", stream(i), "is valid? ", valid
     end if
  end do

contains
  logical function verify(stream, lineCount, preamble, index)
    integer, intent(in) :: lineCount
    integer(int64), intent(in) :: stream(lineCount)
    integer, intent(in) :: preamble
    integer, intent(in) :: index

    integer :: baseValue, lowIndex, highIndex
    integer :: i, j
    integer(int64) :: iValue, jValue
    logical :: seen

    baseValue = stream(index)
    lowIndex = index - preamble
    highIndex = index - 1

    if (lowIndex .le. 0) stop "too low"
    if (highIndex .le. 0) stop "still too low"

    ! starting from index, go from index-1 to index-1-preamble N^2 times
    ! see if any pairs equal the value at index
    
    verify = .false.
    seen = .false.

    outer: do i = lowIndex, highIndex
       do j = i, highIndex - 1   ! don't need to check highIndex == highIndex
          iValue = stream(i)
          jValue = stream(j)
          if (iValue .eq. jValue) cycle  ! numbers need to be distinct
          if (iValue + jValue .eq. baseValue) then
             seen = .true.
             exit outer
          end if
       end do
    end do outer

    verify = seen

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
