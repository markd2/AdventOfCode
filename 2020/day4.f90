! Day 4 - Passport Processing
! https://adventofcode.com/2020/day/4


program passportProcessing
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-4-input.txt"
  character(len=256) :: line
  character(50), allocatable :: pairs(:)
  character(50) :: thingie, key, value
  integer :: readStatus
  integer :: n, i, scan, seenCount, validCount
  logical :: done

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

  done = .false.
  validCount = 0

  passport = PassportSeen()
outer:  do
     ! read a line
     read(23, '(A)', iostat=readStatus) line
     if (readStatus .eq. iostat_end) then
        done = .true.
        print *, "EOF"
     end if

     if (.not. done) then
        ! see how many records on a line
        n = count(transfer(line, 'a', len(line)) == ":")
     end if

        ! no records means done with this passport. Evaluate it
     if (done .or. n .eq. 0) then
        print *, "END OF RECORD. Last passport: ", passport

        ! evaluate
        seenCount = 0
        if (passport%byrSeen) then
           seenCount = seenCount + 1
        end if
        if (passport%iyrSeen) then
           seenCount = seenCount + 1
        end if
        if (passport%eyrSeen) then
           seenCount = seenCount + 1
        end if
        if (passport%hgtSeen) then
           seenCount = seenCount + 1
        end if
        if (passport%hclSeen) then
           seenCount = seenCount + 1
        end if
        if (passport%eclSeen) then
           seenCount = seenCount + 1
        end if
        if (passport%pidSeen) then
           seenCount = seenCount + 1
        end if
        if (passport%cidSeen) then
           seenCount = seenCount + 1
        end if

        if (seenCount .eq. 8) then
           validCount = validCount + 1
           print *, "  valid"
        else if (seenCount .eq. 7) then
           if (passport%cidSeen) then
              ! the optional one is there, so this is invalid
           else
              validCount = validCount + 1
              print *, "  valid"
           end if
        end if
        print *, "SEEN ", seenCount

        if (done) then
           print *, "BAILING OUT"
           exit outer
        end if

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

  end do outer
  close(23)

  print *, "VALID COUNT ", validCount

end program
