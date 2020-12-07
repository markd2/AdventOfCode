program handyHaversack
  use hashtbl
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-7-test-input.txt"
  character(len=150) :: line   ! longest line in day-7-input.txt is 123 characters
  integer :: readStatus

  character(len=30), allocatable :: splitBuffer(:)

  type(hash_tbl_sll) :: table
  
  character(len=:), allocatable :: out
  call table%init(100)

  open(unit=23, file=filename, status='old', action='read')
  do
     read(23, '(A)', iostat=readStatus) line
!     print *, "read line ", line
     if (readStatus .eq. iostat_end) then
        print *, "EOF"
        exit
     end if
     call splitString(line)
     
  end do

contains

  ! light red bags contain 1 bright white bag, 2 muted yellow bags.
  subroutine splitString(line)
    implicit none

    character(len=150), intent(inout) :: line
    integer :: i
    character(len=30), allocatable :: split(:)
    character(len=30), allocatable :: splitLine(:)

    integer :: wordStart, wordEnd, splitIndex

    allocate(split(30))

    ! light red bags contain 1 bright white bag, 2 muted yellow bags.
    wordStart = 1
    wordEnd = 1
    splitIndex = 1
    do i = 1, len(trim(line))
       if (line(i:i) .eq. ".") then 
          wordEnd = wordEnd - 1
          exit
       end if
       if (line(i:i) .eq. " " .or. line(i:i) .eq. ",") then
          if (wordStart .ne. wordEnd) then
             allocate(splitLine(wordEnd - wordStart + 1))
             splitLine = " "
             split(splitIndex) = line(wordStart:wordEnd)
             print *, "seeing ", line(wordStart:wordEnd)

!             print *, "found word from ", wordStart, "to ", wordEnd - 1
!             split(splitIndex) = line(wordStart:wordEnd)
!             splitIndex = splitIndex + 1
          end if
          wordStart = i + 1
          wordEnd = i + 1
          cycle
       end if
       wordEnd = i + 1
    end do

    ! mop up last word
    if (wordStart .ne. wordEnd) then
       allocate(splitLine(wordEnd - wordStart + 1))
       splitLine = " "
       split(splitIndex) = line(wordStart:wordEnd)
       print *, "seeing ", line(wordStart:wordEnd)
    end if

!    print *, split

  end subroutine

end program

