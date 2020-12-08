! Handheld Halting
! https://adventofcode.com/2020/day/8

program handheldHalting
  use :: iso_fortran_env
  implicit none

  ! I/O
  character(*), parameter :: filename = "day-8-input.txt"
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

  ! part two
  character(len=3) :: savedOpcode

  lineCount = fileCount(filename)
  print *, lineCount

  ! +1 are to account for an END instruction
  allocate(instructionSeen(lineCount + 1))
  instructionSeen = .false.

  allocate(instructions(lineCount + 1))
  allocate(operands(lineCount + 1))

  open(unit=23, file=filename, status='old', action='read')

  ! read in the things
  do i = 1, lineCount
     read (23, *) opcode, delta
     instructions(i) = opcode
     operands(i) = delta
  end do
  instructions(lineCount + 1) = "END"

  ! run!

  fuzzer: do i = 1, lineCount

     select case(instructions(i))
     case('nop')
        ! print *, "changing nop to jmp at ", i
        savedOpcode = 'nop'
        instructions(i) = 'jmp'
     case('acc')
        cycle
     case ('jmp')
        ! print *, "changing jmp to nop at ", i
        savedOpcode = 'jmp'
        instructions(i) = 'nop'
     end select

     accumulator = 0
     programCounter = 1
     instructionSeen = .false.

     do
        ! print *, "program counter ", programCounter
        
        if (instructionSeen(programCounter)) then
           print *, "instruction seen at PC ", programCounter
           exit
        end if
        
        instructionSeen(programCounter) = .true.
        ! print *, "    ", instructions(programCounter)
        
        select case(instructions(programCounter))
        case('nop')
           programCounter = programCounter + 1
        case('acc')
           accumulator = accumulator + operands(programCounter)
           programCounter = programCounter + 1
        case('jmp')
           programCounter = programCounter + operands(programCounter)
        case('END')
           print *, "WIN"
           exit fuzzer
        end select
        
     end do ! run simulation

     instructions(i) = savedOpcode

   end do fuzzer

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
