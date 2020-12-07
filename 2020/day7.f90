program handyHaversack
  use hashtbl
  implicit none
  type(hash_tbl_sll) :: table
  
  character(len=:), allocatable :: out


  call table%init(23)

  call table%put(key="bright white", val="12")

  call table%get("bright white", out)
  print *, allocated(out)
  print *, out

  call table%get("splunge", out)
  print *, allocated(out)

end program

