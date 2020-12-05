! Day 4 - Passport Processing
! https://adventofcode.com/2020/day/4

module class_Passport
  implicit none

  private
  real :: blah = 1.2345 ! class-wide private constant

  type, public :: Passport
     logical :: byrSeen = .false.
     logical :: iyrSeen = .false.
     logical :: eyrSeen = .false.
     logical :: hgtSeen = .false.
     logical :: hclSeen = .false.
     logical :: eclSeen = .false.
     logical :: pidSeen = .false.
     logical :: cidSeen = .false.
   contains
     procedure :: see => passport_see
     procedure :: valid => passport_valid
  end type

contains

  subroutine passport_see(this, key, value)
    class(Passport), intent(inout) :: this
    character(50), intent(in) :: key
    character(50), intent(in) :: value

    select case(trim(key))
    case('byr'); this%byrSeen = .true.
    case('iyr'); this%iyrSeen = .true.
    case('eyr'); this%eyrSeen = .true.
    case('hgt'); this%hgtSeen = .true.
    case('hcl'); this%hclSeen = .true.
    case('ecl'); this%eclSeen = .true.
    case('pid'); this%pidSeen = .true.
    case('cid'); this%cidSeen = .true.
    end select
  end subroutine

  function passport_valid(this) result(valid)
    class(Passport), intent(in) :: this
    logical :: valid

    integer :: seenCount

    valid = .false.
    seenCount = 0

    if (this%byrSeen) then
       seenCount = seenCount + 1
    end if
    if (this%iyrSeen) then
       seenCount = seenCount + 1
    end if
    if (this%eyrSeen) then
       seenCount = seenCount + 1
    end if
    if (this%hgtSeen) then
       seenCount = seenCount + 1
    end if
    if (this%hclSeen) then
       seenCount = seenCount + 1
    end if
    if (this%eclSeen) then
       seenCount = seenCount + 1
    end if
    if (this%pidSeen) then
       seenCount = seenCount + 1
    end if
    if (this%cidSeen) then
       seenCount = seenCount + 1
    end if

    if (seenCount .eq. 8) then
       valid = .true.
       print *, "  valid"
    else if (seenCount .eq. 7) then
       if (this%cidSeen) then
          ! the optional one is there, so this is invalid
       else
          valid = .true.
       end if
    end if

  end function

end module

program passportProcessing
  use class_Passport
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-4-input.txt"
  character(len=256) :: line
  character(50), allocatable :: pairs(:)
  character(50) :: thingie, key, value
  integer :: readStatus
  integer :: n, i, scan, seenCount, validCount
  logical :: done, valid

  type(Passport) :: thePassport

  open(unit=23, file=filename, status='old', action='read')

  done = .false.
  validCount = 0

  thePassport = Passport()
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
        print *, "END OF RECORD. Last passport: ", thePassport

        ! evaluate

        ! if valid, incr validCount
        valid = thePassport%valid()
        if (valid) then
           validCount = validCount + 1
        end if

        if (done) then
           print *, "BAILING OUT"
           exit outer
        end if

        thePassport = Passport()
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

        read(thingie, *) key, value
        call thePassport%see(key, value)
        
     end do ! each pair in this line

     deallocate(pairs)

  end do outer
  close(23)

  print *, "VALID COUNT ", validCount

end program
