! https://adventofcode.com/2020/day/10

program adapterArray
  ! I/O
  character(*), parameter :: filename = "day-10-test-input-1.txt"
  integer :: preamble = 5
!  character(*), parameter :: filename = "day-10-test-input-2.txt"
!  integer :: preamble = 5
!  character(*), parameter :: filename = "day-10-input.txt"
!  integer :: preamble = 25
  character(len=50) :: line
  integer :: readStatus, sum
  integer :: lineCount
  logical :: isValid

  integer :: oneCount, twoCount, threeCount

  integer, allocatable :: stream(:)
  integer, allocatable :: ignoreIndices(:)

  lineCount = fileCount(filename)
  print *, lineCount
  allocate(stream(lineCount + 2))  ! for zero-charger and for the device
  allocate(ignoreIndices(lineCount + 2))  ! for zero-charger and for the device

  open(unit=23, file=filename, status='old', action='read')
  do i = 1, lineCount
     read (23, *) number
     stream(i) = number
  end do
  close(23)

  ! charger is 0
  stream(lineCount + 1) = 0
  stream(lineCount + 2) = 999999

  call quicksort(stream, 1, lineCount + 2)

  ! device is 3 more than the last adapter
  stream(lineCount + 2) = stream(lineCount + 1) + 3

  oneCount = 0
  twoCount = 0
  threeCount = 0

  do i = 1, lineCount + 1
     select case(stream(i+1) - stream(i))
     case(1)
        oneCount = oneCount + 1
     case(2)
        twoCount = twoCount + 1
     case(3)
        threeCount = threeCount + 1
     case default
        stop "hammer time"
     end select
  end do

  print *, oneCount, twoCount, threeCount
  print *, "solution is ", oneCount * threeCount

  ignoreIndices = [1, 2, 3]
  isValid = valid(stream, lineCount + 2, ignoreIndices)
  print *, "valid", isValid

contains
  logical function valid(stream, highIndex, ignoreIndicies)
    integer, intent(in) :: stream(:)
    integer, intent(in) :: highIndex
    integer, intent(in) :: ignoreIndicies(:)
    integer :: i

    integer :: diff

    !! also need to move the start index
    do i = 1, size(stream) - 1
       if (any(ignoreIndicies == i)) then
          print *, "skipping ", i
          cycle
       end if
       diff = stream(i + 1) - stream(i)
       if ((diff .lt. 1) .or. (diff .gt. 3)) then
          valid = .false.
          return
       end if
       lastIndex = i

    end do

    valid = .true.
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


  recursive subroutine quicksort(a, first, last)
    implicit none
    integer*4  a(*), x, t
    integer first, last
    integer i, j
    
    x = a( (first+last) / 2 )
    i = first
    j = last
    do
       do while (a(i) < x)
          i=i+1
       end do
       do while (x < a(j))
          j=j-1
       end do
       if (i >= j) exit
       t = a(i);  a(i) = a(j);  a(j) = t
       i=i+1
       j=j-1
    end do
    if (first < i-1) call quicksort(a, first, i-1)
    if (j+1 < last)  call quicksort(a, j+1, last)
  end subroutine quicksort
  
end program


