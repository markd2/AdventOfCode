! Day 4 - Passport Processing
! https://adventofcode.com/2020/day/4

module class_Passport
  implicit none

  private
  real :: blah = 1.2345 ! class-wide private constant

  type, public :: Passport
     logical :: byrSeen = .false.
     character(50) :: byrValue = ""
     logical :: iyrSeen = .false.
     character(50) :: iyrValue = ""
     logical :: eyrSeen = .false.
     character(50) :: eyrValue = ""
     logical :: hgtSeen = .false.
     character(50) :: hgtValue = ""
     logical :: hclSeen = .false.
     character(50) :: hclValue = ""
     logical :: eclSeen = .false.
     character(50) :: eclValue = ""
     logical :: pidSeen = .false.
     character(50) :: pidValue = ""
     logical :: cidSeen = .false.
     character(50) :: cidValue = ""
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
    case('byr')
       this%byrSeen = .true.
       this%byrValue = trim(value)
    case('iyr')
       this%iyrSeen = .true.
       this%iyrValue = trim(value)
    case('eyr')
       this%eyrSeen = .true.
       this%eyrValue = trim(value)
    case('hgt')
       this%hgtSeen = .true.
       this%hgtValue = trim(value)
    case('hcl')
       this%hclSeen = .true.
       this%hclValue = trim(value)
    case('ecl')
       this%eclSeen = .true.
       this%eclValue = trim(value)
    case('pid')
       this%pidSeen = .true.
       this%pidValue = trim(value)
    case('cid')
       this%cidSeen = .true.
       this%cidValue = trim(value)
    end select
  end subroutine

  function validNumber(candidate, low, high) result(valid)
    character(50), intent(in) :: candidate
    integer :: low, high
    logical :: valid

    integer :: blah

    read(candidate, *) blah
    valid = blah .ge. low .and. blah .le. high
  end function

  function validPassportID(candidate) result(valid)
    character(50), intent(in) :: candidate
    logical :: valid
    integer :: length, scan

    valid = .true.

    ! make sure 9 long
    if (len(trim(candidate)) .ne. 9) then
       valid = .false.
       return
    end if

    ! make sure just digits
    valid = verify(trim(candidate), "0123456789") .eq. 0
  end function

  function validHairColor(candidate) result(valid)
    character(50), intent(in) :: candidate
    logical :: valid

    ! make sure 7 long
    if (len(trim(candidate)) .ne. 7) then
       valid = .false.
       return
    end if

    ! make sure starts with #
    if (candidate(1:1) .ne. "#") then
       valid = .false.
       return
    end if

    ! make sure just digits
    valid = verify(trim(candidate(2:7)), "0123456789abcdef") .eq. 0
  end function

  function validEyeColor(candidate) result(valid)
    character(50), intent(in) :: candidate
    logical :: valid

    character(3) :: validColors(7)

    valid = .false.
    validColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

    valid = any(validColors .eq. trim(candidate))
  end function

  function validHeight(candidate) result(valid)
    character(50), intent(in) :: candidate
    logical :: valid
    integer :: length, number
    character(2) :: nom

    valid = .false.

    ! number followed by `cm` or `in`
    length = len(trim(candidate))

    if (length .lt. 2) then
       valid = .false.
       return
    end if

    if ((candidate(length-1:length) .ne. "cm") .and. (candidate(length-1:length) .ne. "in")) then
       valid = .false.
    end if

    ! pull out the number
    read(candidate(1:length-2), *) number

    select case(candidate(length-1:length))
    case('cm')
       valid = ((number .ge. 150) .and. (number .le. 193))
    case('in')
       valid = ((number .ge. 59) .and. (number .le. 76))
    end select
  end function


  function passport_valid(this) result(valid)
    class(Passport), intent(in) :: this
    logical :: valid

    integer :: seenCount

    valid = .false.

    if (this%byrSeen) then
       valid = validNumber(this%byrValue, 1920, 2002)
       print *, "is byr ", trim(this%byrValue), " valid? ", valid
       if (.not. valid) then; return; end if
    else
       valid = .false.; return
    end if

    if (this%iyrSeen) then
       valid = validNumber(this%iyrValue, 2010, 2020)
       print *, "is iyr ", trim(this%iyrValue), " valid? ", valid
       if (.not. valid) then; return; end if
    else
       valid = .false.; return
    end if

    if (this%eyrSeen) then
       valid = validNumber(this%eyrValue, 2020, 2030)
       print *, "is iyr ", trim(this%eyrValue), " valid? ", valid
       if (.not. valid) then; return; end if
    else
       valid = .false.; return
    end if

    if (this%hgtSeen) then
       valid = validHeight(this%hgtValue)
       print *, "is hgt ", trim(this%hgtValue), " valid? ", valid
       if (.not. valid) then; return; end if
    else
       valid = .false.; return
    end if

    if (this%hclSeen) then
       valid = validHairColor(this%hclValue)
       print *, "is hcl ", trim(this%hclValue), " valid? ", valid
       if (.not. valid) then; return; end if
    else
       valid = .false.; return
    end if

    if (this%eclSeen) then
       valid = validEyeColor(this%eclValue)
       print *, "is ecl ", trim(this%eclValue), " valid? ", valid
       if (.not. valid) then; return; end if
    else
       valid = .false.; return
    end if

    if (this%pidSeen) then
       valid = validPassportID(this%pidValue)
       print *, "is pid ", trim(this%pidValue), " valid? ", valid
       if (.not. valid) then; return; end if
    else
       valid = .false.; return
    end if
    ! ignore cid

    ! we survived!
    valid = .true.
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
        print *, "END OF RECORD."

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
