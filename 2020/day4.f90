! Day 4 - Passport Processing
! https://adventofcode.com/2020/day/4

program passportProcessing
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-4-test-input.txt"
  character(len=256) :: line
  character(50), allocatable :: pairs(:)
  character(50) :: thingie, key, value
  integer :: readStatus
  integer :: n, i, scan

  type :: PassportSeen
     logical :: byrSeen = .false.
     logical :: iyrSeen = .false.
     logical :: eyrSeen = .false.
     logical :: hgtSeen = .false.
     logical :: hclSeen = .false.
     logical :: eclSeen = .false.
     logical :: pidSeen = .false.
     logical :: cidSeen = .false.
  end type

  type(PassportSeen) :: passport

  open(unit=23, file=filename, status='old', action='read')

  passport = PassportSeen()
  do
     ! read a line
     read(23, '(A)', iostat=readStatus) line
     if (readStatus .eq. iostat_end) then
        exit
     end if

     ! see how many records on a line
     n = count(transfer(line, 'a', len(line)) == ":")

     ! no records means done with this passport. Evaluate it
     if (n .eq. 0) then
        print *, "NEW RECORD. Last passport: ", passport

        ! evaluate

        passport = PassportSeen()
        cycle
     end if

     
     ! pull apart the line into key:value pairs
     allocate(pairs(n))
     read(line, *) pairs

     do i = 1, n
        thingie = trim(pairs(i))

        ! replace ':' with ' '
        do scan = 1, len(thingie)
           select case(thingie(scan:scan))
           case(':'); thingie(scan:scan) = ' '
           end select
        end do

        ! split
        read(thingie, *) key, value
        select case(trim(key))
        case('byr'); passport%byrSeen = .true.
        case('iyr'); passport%iyrSeen = .true.
        case('eyr'); passport%eyrSeen = .true.
        case('hgt'); passport%hgtSeen = .true.
        case('hcl'); passport%hclSeen = .true.
        case('ecl'); passport%eclSeen = .true.
        case('pid'); passport%pidSeen = .true.
        case('cid'); passport%cidSeen = .true.
        end select
        
     end do ! each pair in this line

     deallocate(pairs)

  end do ! each passport
  close(23)

end program
