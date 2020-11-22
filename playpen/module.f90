module myMod
  implicit none

  private    ! all entitesare module-private by default
  public publicVar, printMatrix   ! explicitly export public entities

  real, parameter :: publicVar = 2
  integer :: privateVar

  contains
    
    subroutine printMatrix(A)
      real, intent(in) :: A(:,:)  ! an assumed-shape dummy argument
      integer :: i
      
      do i = 1, size(A, 1)
         print *, A(i, :)
      end do

    end subroutine printMatrix
    
end module myMod


program useMod
  ! use myMod
  ! use myMod, only: publicVar    ! explicit import list
  use myMod, only: printMat => printMatrix
  use myMod, only: publicVar
  
  implicit none

  real :: mat(10, 10)
  mat(:,:) = publicVar

  ! call printMatrix(mat)
  call printMat(mat)

end program useMod

