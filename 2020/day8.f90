! Handheld Halting
! https://adventofcode.com/2020/day/8

program handheldHalting
  use :: iso_fortran_env
  implicit none

  ! I/O
  character(*), parameter :: filename = "day-8-test-input.txt"
  character(len=50) :: line
  integer :: readStatus, sum
  integer :: lineCount

  ! reading destinations
  character(len=3) :: opcode
  integer :: delta

  ! program / instruction storage
  logical, allocatable :: instructionSeen(:)
  character(len=3), allocatable :: instructions(:)
  integer, allocatable :: operands(:)

  ! runtime controls
  integer :: accumulator  
  integer :: programCounter

  integer :: i

  lineCount = fileCount(filename)
  print *, lineCount

  allocate(instructionSeen(lineCount))
  instructionSeen = .false.

  allocate(instructions(lineCount))
  allocate(operands(lineCount))

  open(unit=23, file=filename, status='old', action='read')

  ! read in the things
  do i = 1, lineCount
     read (23, *) opcode, delta
     instructions(i) = opcode
     operands(i) = delta
  end do

  ! run!

  programCounter = 1
  accumulator = 0

  do
     print *, "program counter ", programCounter

     if (instructionSeen(programCounter)) then
        print *, "instruction seen at PC ", programCounter
        exit
     end if

     instructionSeen(programCounter) = .true.

     select case(instructions(programCounter))
        case('nop')
           programCounter = programCounter + 1
        case('acc')
           accumulator = accumulator + operands(programCounter)
           programCounter = programCounter + 1
        case('jmp')
           programCounter = programCounter + operands(programCounter)
     end select

  end do

  print *, "accumulator is ", accumulator


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
