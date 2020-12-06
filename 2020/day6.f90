! Day 6 - Custom Customs
! https://adventofcode.com/2020/day/5

module class_CharacterSet
  implicit none
  integer, parameter :: arrayCount = 26

  type, public :: CharacterSet 
     integer :: seenCharacters(arrayCount) = 0
     integer :: linesSeen = 0
     
   contains
     procedure :: seeLine => cset_see
     procedure :: uniqueSeenCount => cset_uniqueSeenCount
     procedure :: allSeenCount => cset_allSeenCount
  end type
  
contains
  subroutine cset_see(this, line)
    class(CharacterSet), intent(inout) :: this
    character(len=50), intent(in) :: line
    
    integer :: length, scan, setIndex, currentValue
    character :: char

    print *, "    ", trim(line)
    
    length = len(trim(line))
    this%linesSeen = this%linesSeen + 1

    do scan = 1, length
       char = line(scan:scan)
       setIndex = index("abcdefghijklmnopqrstuvwxyz", char)
       if (setIndex .eq. 0) then
          print *, "  skipping '", char, "'"
          cycle
       end if

       currentValue = this%seenCharacters(setIndex)
       this%seenCharacters(setIndex) = currentValue + 1

       if (currentValue + 1 > this%linesSeen) stop "argh"
    end do

  end subroutine

  integer function cset_uniqueSeenCount(this)
    class(CharacterSet), intent(inout) :: this

    integer :: count = 0, scan
    
    stop "argh"

    cset_uniqueSeenCount = 0

    do scan = 1, arrayCount
       if (this%seenCharacters(scan) .gt. 0) then
          cset_uniqueSeenCount = cset_uniqueSeenCount + 1
       end if
    end do

  end function

  integer function cset_allSeenCount(this)
    class(CharacterSet), intent(inout) :: this

    integer :: scan

    cset_allSeenCount = 0

    do scan = 1, arrayCount
       if (this%seenCharacters(scan) .eq. this%linesSeen) then
          cset_allSeenCount = cset_allSeenCount + 1
       end if

       if (this%seenCharacters(scan) .gt. this%linesSeen) then
          stop "huh"
       end if
    end do

  end function

end module


program customCustoms
  use :: iso_fortran_env
  use class_CharacterSet
  implicit none

  type(CharacterSet) :: cset

  character(*), parameter :: filename = "day-6-input.txt"
  character(len=50) :: line
  integer :: readStatus, sum

  cset = CharacterSet()
  sum = 0

  open(unit=23, file=filename, status='old', action='read')
  do
     read(23, '(a)', iostat=readStatus) line

     if (readStatus .eq. iostat_end) then
        print *, "EOF - count is ", cset%allSeenCount(), "out of ", cset%linesSeen
        sum = sum + cset%allSeenCount()
        exit
     end if
     if (readStatus .ne. 0) then
        exit
     end if

     if (len(trim(line)) == 0) then
        print *, "END OF RECORD - count is ", cset%allSeenCount(), "out of ", cset%linesSeen
        print *, ""

        sum = sum + cset%allSeenCount()
        cset = CharacterSet()
        cycle
     end if

     call cset%seeLine(line)
     
  end do
  print *, "sum of all counts ", sum
  
end program
