program ifs
  real :: angle

  angle = 999

  if (angle < 90.0) then 
     print *, "angle is acute"
  else if (angle < 180.0) then
     print *, "angle is obtuse"
  else
     print *, "Angle is reflex"
  end if

end program ifs
