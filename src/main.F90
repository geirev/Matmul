program main
!   use OMP_LIB
   integer, parameter :: ndim=1024*2*51
   integer, parameter :: nrobs=96
   integer, parameter :: nrens=1000

   real start,finish,cpu0,cpu1

   real A(ndim,nrens)
   real S(nrobs,nrens)
   real R1(ndim,nrobs)
   real R2(ndim,nrobs)
   real res
   integer i,j

   print '(a,i8)','ndim =',ndim
   print '(a,i8)','nrobs=',nrobs
   print '(a,i8)','nrens=',nrens
   print *

   call random_number(A)
   call random_number(S)

   print '(a,i6,a,i6,a)','A(',ndim, ',',nrens,')'
   print '(a,i6,a,i6,a)','S(',nrobs,',',nrens,')'
   print '(a,i6,a,i6,a)','R(',ndim, ',',nrobs,')'
   print *

   cpu0=wtime()
   call cpu_time(start); print '(a)','matmul start:'
   R1=matmul(A,transpose(S))
   cpu1=wtime()
   call cpu_time(finish); print '(a)','matmul finish:'
   print '(2(a,f6.2))','matmul: cpu time=',finish-start,', wall-clock time=',cpu1-cpu0

   print *
   cpu0=wtime()
   call cpu_time(start); print '(a)','dgemm start:'
   call dgemm('n','t',ndim,nrobs,nrens,1.0,A,ndim,S,nrobs,0.0,R2,ndim)
   cpu1=wtime()
   call cpu_time(finish); print '(a)','dgemm finish:'
   print '(2(a,f6.2))','dgemm:  cpu time=',finish-start,', wall-clock time=',cpu1-cpu0

   res=0.0
   do j=1,nrobs
   do i=1,ndim
      res=res+(R2(i,j)-R1(i,j))**2
   enddo
   enddo
   res=res/real(ndim*nrobs)
   res=sqrt(res)

   print '(a,e13.5)','Mean square error is: ',res
contains
    function wtime ( )

!*****************************************************************************80
!
!! WTIME returns a reading of the wall clock time.
!
!  Discussion:
!
!    To get the elapsed wall clock time, call WTIME before and after a given
!    operation, and subtract the first reading from the second.
!
!    This function is meant to suggest the similar routines:
!
!      "omp_get_wtime ( )" in OpenMP,
!      "MPI_Wtime ( )" in MPI,
!      and "tic" and "toc" in MATLAB.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    27 April 2009
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Output, real ( kind = rk ) WTIME, the wall clock reading, in seconds.
!
  implicit none

  integer, parameter :: rk = kind ( 1.0D+00 )

  integer clock_max
  integer clock_rate
  integer clock_reading
  real ( kind = rk ) wtime

  call system_clock ( clock_reading, clock_rate, clock_max )

  wtime = real ( clock_reading, kind = rk ) &
        / real ( clock_rate, kind = rk )

  return
  end function
end program
