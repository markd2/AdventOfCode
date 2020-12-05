! Day 5 - Binary Boarding
! https://adventofcode.com/2020/day/5

program binaryBoarding
  use class_Passport
  use :: iso_fortran_env
  implicit none

  character(*), parameter :: filename = "day-5-input.txt"
  character(len=10) :: line
  integer :: readStatus

  integer :: row, column
  integer :: i, seat, bitWidth, exponent, effectiveIndex
  integer :: highestSeat

  logical :: seatMap(1024)
  integer :: lastSeenTrue

  seatMap = .true.

  highestSeat = -1

  open(unit=23, file=filename, status='old', action='read')
  do
     read(23, '(A)', iostat=readStatus) line
     print *, "read line ", line
     if (readStatus .eq. iostat_end) then
        exit
     end if

     if (len(trim(line)) .ne. 10) then
        print *, "    bad line length  ", len(trim(line))
     end if

     row = 0
     bitWidth = 7
     do i = 1, 7
        if (line(i:i) .eq. "B") then
           exponent = bitWidth - i
           row = row + 2 ** exponent
        end if
     end do

     column = 0
     bitWidth = 3
     do i = 8, 10
        effectiveIndex = i - 7
        if (line(i:i) .eq. "R") then
           exponent = bitWidth - effectiveindex
           column = column + 2 ** exponent
        end if
     end do
     
     seat = row * 8 + column
     print *, trim(line), row, column, seat
     seatMap(seat) = .false.

     highestSeat = max(seat, highestSeat)
  end do
  close(23)

  print *, "Highest seat ", highestSeat

  lastSeenTrue = 1
  do i = 1, 1024
     if (seatMap(i)) then
        if (i > lastSeenTrue + 1) then
           print *, "found discontinuity at ", i
           exit
        end if
        lastSeenTrue = i
     end if
  end do


end program


