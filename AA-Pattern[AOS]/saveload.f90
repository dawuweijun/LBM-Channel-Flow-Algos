!===========================================================================

      subroutine loadinitpartpos
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      character (len = 150):: fnm

      real, dimension(3,msize) :: yp_db
      real, dimension(3,npart) :: ypglb_db

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10)

      fnm = '/glade/scratch/ayala/LBM2Ddd/cntdpart/'           &
            //'initpartpos_409600/initpartpos.'                        &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(14, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      read(14) nps, ipglb
      read(14) yp_db, ypglb_db

      close(14)

      yp = yp_db
      ypglb = ypglb_db

      end subroutine loadinitpartpos
!===========================================================================

      subroutine saveprerelax
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      character (len = 120):: fnm

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10)

      fnm = trim(dirinitflow)//'prerelax_01/finit.'                  &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(10, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      write(10) istep
      write(10) f(:,:,:,:), rho
      write(10) ux, uy, uz

      close(10)

      end subroutine saveprerelax
!===========================================================================

      subroutine loadprerelax
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      character (len = 120):: fnm

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10)

      fnm = trim(dirinitflow)//'prerelax_01/finit.'                  &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(10, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      read(10) istep
      read(10) f(:,:,:,:), rho
      read(10) ux, uy, uz

      close(10)

      end subroutine loadprerelax
!===========================================================================

      subroutine saveinitflow
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      character (len = 120):: fnm

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10) 

      fnm = trim(dirinitflow)//'finit.'                                &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(10, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      write(10) istat 
      write(10) f(:,:,:,:)

      close(10)

      end subroutine saveinitflow
!===========================================================================

      subroutine loadinitflow
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      character (len = 120):: fnm

      real, allocatable, dimension(:,:,:,:):: f9
      allocate (f9(0:npop-1,lx,ly,lz))

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10)

! read in double precision f9 in binary format
      fnm = trim(dirinitflow)//'finit.'                                &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

!      fnm = '/ptmp//finit.'   &
!            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(10, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      read(10) istat 
      read(10) f9

      close(10)
      
      f(:,:,:,:) = f9   

! output double precision f9 to ascii format
!      fnm = trim(dirinitflow)//'real4_02/finit.'                       &
!          //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

!      open(10, file = trim(fnm), status = 'unknown',                   &
!               form = 'formatted')
!      write(10,105) f9 

!      close(10)

      deallocate (f9)

105   format(2x,8(1pe16.6))

!      istat = 1  
! read in single precision f in ascii format
!      fnm = trim(dirinitflow)//'real4_02/finit.'                       &
!          //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

!       open(10, file = trim(fnm), status = 'unknown',                   &
!                form = 'formatted')
!       read(10,105) f

!       close(10)

! output single precision f in ascii format for checking
!       fnm = trim(dirinitflow)//'real4_02chk/finit.'                    &
!          //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)
 
!       open(10, file = trim(fnm), status = 'unknown',                   &
!               form = 'formatted')
!       write(10,105) f

!       close(10) 
     
      end subroutine loadinitflow
!===========================================================================

      subroutine savecntdflow
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      character (len = 120):: fnm

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10) 

      istep = istep0+nsteps
      istp1 = istep / 1000000
      istp2 = mod(istep,1000000) / 100000
      istp3 = mod(istep,100000) / 10000
      istp4 = mod(istep,10000) / 1000
      istp5 = mod(istep,1000) / 100
      istp6 = mod(istep,100) / 10
      istp7 = mod(istep,10)

      fnm = trim(dircntdflow)//'endrunflow2D16x8.'                   &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)//char(istp7 + 48)&
            //'.'                                                      &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(12, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      write(12) istep, istat, imovie 
      write(12) f(:,:,:,:)

      close(12)

      end subroutine savecntdflow      
!===========================================================================   
      subroutine loadcntdflow
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      character (len = 120):: fnm

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10) 

      istp1 = istpload / 1000000
      istp2 = mod(istpload,1000000) / 100000
      istp3 = mod(istpload,100000) / 10000
      istp4 = mod(istpload,10000) / 1000
      istp5 = mod(istpload,1000) / 100
      istp6 = mod(istpload,100) / 10
      istp7 = mod(istpload,10)

! Only for first run with particles
!     fnm = trim(dircntdflow0)//'endrunflow2D16x8.'                 &
      fnm = trim(dircntdflow)//'endrunflow2D16x8.'                 &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)  &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)  &
            //char(istp7 + 48)//'.'                                 &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(12, file = trim(fnm), status = 'unknown',                &
               form = 'unformatted')

      read(12) istep0, istat, imovie 
      read(12) f(:,:,:,:)

      close(12)

      end subroutine loadcntdflow      
!===========================================================================
! this subroutine is the same as "savecntdpart01" above, except that
! the global variables of "ypglb, wp, omgp" are only stored in process 0,
! which will broadcast the global values to the other processes after loading.
      subroutine savecntdpart
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      character (len = 120):: fnm

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10)

      istp1 = istep / 1000000
      istp2 = mod(istep,1000000) / 100000
      istp3 = mod(istep,100000) / 10000
      istp4 = mod(istep,10000) / 1000
      istp5 = mod(istep,1000) / 100
      istp6 = mod(istep,100) / 10
      istp7 = mod(istep,10)

      fnm = trim(dircntdpart)//'endrunpart2D.'                           &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)  &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)  &
            //char(istp7 + 48)//'.'   &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(14, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      write(14) nps, ipglb
      write(14) ibnodes0, isnodes0
      write(14) yp, thetap
      write(14) forcepp, torqpp
      write(14) dwdt, domgdt
      if(myid == 0) write(14) ypglb, wp, omgp

      close(14)

      end subroutine savecntdpart
!===========================================================================

      subroutine loadcntdpart  
      use mpi
      use var_inc
      implicit none

      integer iprc1, iprc2, iprc3
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      character (len = 120):: fnm
      
      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10)

      istp1 = istpload / 1000000
      istp2 = mod(istpload,1000000) / 100000
      istp3 = mod(istpload,100000) / 10000
      istp4 = mod(istpload,10000) / 1000
      istp5 = mod(istpload,1000) / 100
      istp6 = mod(istpload,100) / 10
      istp7 = mod(istpload,10)

!     fnm = trim(dircntdpart0)//'endrunpart2D.'                 &
      fnm = trim(dircntdpart)//'endrunpart2D.'                           &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)  &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)  &
            //char(istp7 + 48)//'.'                                  &
            //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(14, file = trim(fnm), status = 'unknown',                   &
               form = 'unformatted')

      read(14) nps, ipglb
      read(14) ibnodes0, isnodes0   
      read(14) yp, thetap
      read(14) forcepp, torqpp
      read(14) dwdt, domgdt
      if(myid == 0) read(14) ypglb, wp, omgp

      ibnodes = ibnodes0
      isnodes = isnodes0

      close(14)

      call MPI_BARRIER(MPI_COMM_WORLD,ierr)     
      call MPI_BCAST(ypglb,3*npart,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(wp,3*npart,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(omgp,3*npart,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      
      end subroutine loadcntdpart      
!===========================================================================

      subroutine outputflow   
      use var_inc
      implicit none

      integer, dimension(lx,ny,nz):: ibnodes9

      call ibnodeassmbl(ibnodes9)

      call outputux(ibnodes9)

      call outputuy(ibnodes9)

      call outputuz(ibnodes9)

      call outputpress(ibnodes9)

!     call outputvort(ibnodes9)

      end subroutine outputflow   
!===========================================================================

! This subroutine has already been modified for 2D DD
      subroutine ibnodeassmbl(ibnodes9) 
      use mpi
      use var_inc
      implicit none

      integer, dimension(lx,ny,nz):: ibnodes9
      integer, dimension(lx,ly,lz):: ibnodes1

      integer ip, ilen, indy9, indz9
      integer status(MPI_STATUS_SIZE)

      if(ipart)then
        ilen = lx*ly*lz

        if(myid == 0)then
          ibnodes9(:,1:ly,1:lz) = ibnodes 

          do ip = 1,nproc-1
            call MPI_RECV(ibnodes1,ilen,MPI_INTEGER,ip,1,              &
                          MPI_COMM_WORLD,status,ierr)

       indy9 = mod(ip,nprocY)
       indz9 = int(ip/nprocY)

       ibnodes9(:,indy9*ly+1:indy9*ly+ly,indz9*lz+1:indz9*lz+lz)=ibnodes1 
       end do

       else
          call MPI_SEND(ibnodes,ilen,MPI_INTEGER,0,1,                  &
                        MPI_COMM_WORLD,ierr)
       end if

      else

        ibnodes9 = -1
      
      end if

      end subroutine ibnodeassmbl      
!===========================================================================

! This has been modified for 2D DD
      subroutine outputux(ibnodes9)   
      use mpi 
      use var_inc
      implicit none

      integer, dimension(lx,ny,nz):: ibnodes9

      integer ip, ilen, indy9, indz9
      integer status(MPI_STATUS_SIZE)
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      
      real, dimension(lx,ny,nz):: ux9
      real, dimension(lx,ly,lz):: ux0

      character (len = 120):: fnm

      ilen = lx*ly*lz

      if(myid == 0)then

       ux9(:,:,1:lz) = ux

       do ip = 1,nproc-1
         call MPI_RECV(ux0,ilen,MPI_REAL8,ip,1,MPI_COMM_WORLD,status,ierr)

      indy9 = mod(ip,nprocY)
      indz9 = int(ip/nprocY)
      ux9(:,indy9*ly+1:indy9*ly+ly,indz9*lz+1:indz9*lz+lz) = ux0          
      end do

      else
       call MPI_SEND(ux,ilen,MPI_REAL8,0,1,MPI_COMM_WORLD,ierr)
      end if

      if(myid == 0)then

! zero out the velocity inside particle for plot purpose
!        where(ibnodes9 > 0) ux9 = 0.0

        istp1 = istep / 1000000
        istp2 = mod(istep,1000000) / 100000
        istp3 = mod(istep,100000) / 10000
        istp4 = mod(istep,10000) / 1000
        istp5 = mod(istep,1000) / 100
        istp6 = mod(istep,100) / 10
        istp7 = mod(istep,10)    

        fnm = trim(dirflowout)//'ux'                                   &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //char(istp7 + 48)//'.dat' 

        open(16, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted')

        write(16,160) ux9 

        close(16)

      end if

160   format(2x,8(1pe16.6))

      end subroutine outputux   
!===========================================================================

      subroutine outputuy(ibnodes9) 
      use mpi 
      use var_inc
      implicit none

      integer, dimension(lx,ly,nz):: ibnodes9

      integer ip, ilen, indy9, indz9
      integer status(MPI_STATUS_SIZE)
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      
      real, dimension(lx,ny,nz):: uy9
      real, dimension(lx,ly,lz):: uy0

      character (len = 120):: fnm

      ilen = lx*ly*lz

      if(myid == 0)then

        uy9(:,:,1:lz) = uy   

        do ip = 1,nproc-1
          call MPI_RECV(uy0,ilen,MPI_REAL8,ip,1,MPI_COMM_WORLD,status,ierr)

      indy9 = mod(ip,nprocY)
      indz9 = int(ip/nprocY)
          uy9(:,indy9*ly+1:indy9*ly+ly,indz9*lz+1:indz9*lz+lz) = uy0          
        end do

      else
        call MPI_SEND(uy,ilen,MPI_REAL8,0,1,MPI_COMM_WORLD,ierr)
      end if

      if(myid == 0)then

! zero out the velocity inside particle for plot purpose
!        where(ibnodes9 > 0) uy9 = 0.0

        istp1 = istep / 1000000
        istp2 = mod(istep,1000000) / 100000
        istp3 = mod(istep,100000) / 10000
        istp4 = mod(istep,10000) / 1000
        istp5 = mod(istep,1000) / 100
        istp6 = mod(istep,100) / 10
        istp7 = mod(istep,10)    

        fnm = trim(dirflowout)//'uy'                                   &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //char(istp7 + 48)//'.dat' 

        open(17, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted')

        write(17,170) uy9 

        close(17)

      end if

170   format(2x,8(1pe16.6))

      end subroutine outputuy      
!===========================================================================

      subroutine outputuz(ibnodes9)   
      use mpi 
      use var_inc
      implicit none

      integer, dimension(lx,ly,nz):: ibnodes9

      integer ip, ilen, indy9, indz9
      integer status(MPI_STATUS_SIZE)
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      
      real, dimension(lx,ny,nz):: uz9    
      real, dimension(lx,ly,lz):: uz0    

      character (len = 120):: fnm

      ilen = lx*ly*lz

      if(myid == 0)then

        uz9(:,:,1:lz) = uz       

        do ip = 1,nproc-1
          call MPI_RECV(uz0,ilen,MPI_REAL8,ip,1,MPI_COMM_WORLD,status,ierr)

      indy9 = mod(ip,nprocY)
      indz9 = int(ip/nprocY)
          uz9(:,indy9*ly+1:indy9*ly+ly,indz9*lz+1:indz9*lz+lz) = uz0          
        end do

      else
        call MPI_SEND(uz,ilen,MPI_REAL8,0,1,MPI_COMM_WORLD,ierr)
      end if

      if(myid == 0)then

! zero out the velocity inside particle for plot purpose
!        where(ibnodes9 > 0) uz9 = 0.0

        istp1 = istep / 1000000
        istp2 = mod(istep,1000000) / 100000
        istp3 = mod(istep,100000) / 10000
        istp4 = mod(istep,10000) / 1000
        istp5 = mod(istep,1000) / 100
        istp6 = mod(istep,100) / 10
        istp7 = mod(istep,10)    

        fnm = trim(dirflowout)//'uz'                                   &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //char(istp7 + 48)//'.dat' 

        open(18, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted')

        write(18,180) uz9 

        close(18)

      end if

180   format(2x,8(1pe16.6))

      end subroutine outputuz      
!===========================================================================

      subroutine outputpress(ibnodes9)      
      use mpi 
      use var_inc
      implicit none

      integer, dimension(lx,ly,nz):: ibnodes9

      integer ip, ilen, indy9, indz9
      integer status(MPI_STATUS_SIZE)
      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      
      real, dimension(lx,ny,nz):: rho9    
      real, dimension(lx,ly,lz):: rho1    

      character (len = 120):: fnm

      ilen = lx*ly*lz

      if(myid == 0)then

        rho9(:,:,1:lz) = rho       

        do ip = 1,nproc-1
          call MPI_RECV(rho1,ilen,MPI_REAL8,ip,1,MPI_COMM_WORLD,status,ierr)

      indy9 = mod(ip,nprocY)
      indz9 = int(ip/nprocY)
          rho9(:,indy9*ly+1:indy9*ly+ly,indz9*lz+1:indz9*lz+lz) = rho1            
        end do

      else
        call MPI_SEND(rho,ilen,MPI_REAL8,0,1,MPI_COMM_WORLD,ierr)
      end if

      if(myid == 0)then

! zero out the density inside particle for plot purpose
!        where(ibnodes9 > 0) rho9 = 0.0

        istp1 = istep / 1000000
        istp2 = mod(istep,1000000) / 100000
        istp3 = mod(istep,100000) / 10000
        istp4 = mod(istep,10000) / 1000
        istp5 = mod(istep,1000) / 100
        istp6 = mod(istep,100) / 10
        istp7 = mod(istep,10)    

        fnm = trim(dirflowout)//'press'                                &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //char(istp7 + 48)//'.dat' 

        open(19, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted')

        write(19,190) rho9/3.0 

        close(19)

      end if

190   format(2x,8(1pe16.6))

      end subroutine outputpress      
!===========================================================================

      subroutine outputvort(ibnodes9)      
      use mpi 
      use var_inc
      implicit none

      integer, dimension(lx,ly,nz):: ibnodes9

      integer ip, ilen
      integer status(MPI_STATUS_SIZE)
      integer istp1, istp2, istp3, istp4, istp5, istp6
      
      real, dimension(lx,ly,nz):: vort9    
      real, dimension(lx,ly,lz):: vort, vort0    

      character (len = 120):: fnm

! prepare vorticity field ox, oy, oz, and magnitude field vort
      call vortcalc

      vort = sqrt(ox*ox + oy*oy + oz*oz)
   
      ilen = lx*ly*lz

      if(myid == 0)then

        vort9(:,:,1:lz) = vort         

        do ip = 1,nproc-1
          call MPI_RECV(vort0,ilen,MPI_REAL8,ip,1,MPI_COMM_WORLD,status,ierr)

          vort9(:,:,(ip*lz + 1):((ip + 1)*lz)) = vort0            
        end do

      else
        call MPI_SEND(vort,ilen,MPI_REAL8,0,1,MPI_COMM_WORLD,ierr)
      end if

      if(myid == 0)then

! zero out the vorticity inside particle for plot purpose
!        where(ibnodes9 > 0) vort9 = 0.0

        istp1 = istep / 100000
        istp2 = mod(istep,100000) / 10000
        istp3 = mod(istep,10000) / 1000
        istp4 = mod(istep,1000) / 100
        istp5 = mod(istep,100) / 10
        istp6 = mod(istep,10)    

        fnm = trim(dirflowout)//'vort'                                 &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //'.dat' 

!       open(20, file = trim(fnm), status = 'unknown',                 &
!                form = 'formatted')

!       write(20,200) vort9      

!       close(20)

      end if

200   format(2x,8(1pe16.6))

      end subroutine outputvort      
!===========================================================================

      subroutine outputpart       
      use mpi
      use var_inc
      implicit none

      integer ip, id, ilen 
      real, dimension(3,npart):: thglb0, thglb

      integer istp1, istp2, istp3, istp4, istp5, istp6, istp7
      character (len = 120):: fnm

! prepare for thglb, the global thetap
      thglb0 = 0.0

      do ip = 1,nps
        id = ipglb(ip)

        thglb0(:,id) = thetap(:,ip)
      end do 

      ilen = 3*npart
      call MPI_ALLREDUCE(thglb0,thglb,ilen,MPI_REAL8,MPI_SUM,           &
                         MPI_COMM_WORLD,ierr)

      if(myid == 0)then

      istp1 = istep / 1000000
      istp2 = mod(istep,1000000) / 100000
      istp3 = mod(istep,100000) / 10000
      istp4 = mod(istep,10000) / 1000
      istp5 = mod(istep,1000) / 100
      istp6 = mod(istep,100) / 10
      istp7 = mod(istep,10)

        fnm = trim(dirpartout)//'partS1'                                 &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)  &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)  &
            //char(istp7 + 48)//'.dat' 

        open(22, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted')

        do id = 1,npart
          write(22,220) id, ypglb(1,id), ypglb(2,id), ypglb(3,id),     &
                            thglb(1,id), thglb(2,id), thglb(3,id),     &
                            wp(1,id), wp(2,id), wp(3,id),              &
                            omgp(1,id), omgp(2,id), omgp(3,id),        &
                            fHIp(1,id), fHIp(2,id), fHIp(3,id),        &
                            flubp(1,id), flubp(2,id), flubp(3,id),     &
                            torqp(1,id), torqp(2,id), torqp(3,id)
        end do

        close(22)
      
      end if

220   format(2x,i5,21(1pe16.6))

      end subroutine outputpart    
!===========================================================================
! to compute kinetic energy spectrum, dissipation rate spectrum
! also the skewness and flatness

      subroutine statistc
      use mpi
      use var_inc
      implicit none

      integer ik, nxyz,i,kglb,idZ
      character (len = 120):: fnm1, fnm2, fnm3, fnm4
      real ek, e_t, eks, e_ts, dissp, qq
      real ttt, qqq, dissppp, eta, vk, tk, uprm
      real tmse, Re, xl, et, kmxeta, xintls, vskew, vflat
      real cc2, cc2t, cc3, cc3t, cc4, cc4t,yplus

      REAL,DIMENSION     (ly,lz)  ::  tmp2D
      REAL,DIMENSION  (nx) :: vxave,vyave,vzave,vxsq,vysq,vzsq,stress_xz,stress_xy,stress_yz
      REAL,DIMENSION  (nx) :: prave,prsq,pravet,prsqt
      REAL,DIMENSION  (nx) :: vxavet,vyavet,vzavet,vxsqt,vysqt,vzsqt,stress_xzt,stress_xyt,stress_yzt
      REAL vxavet9,vyavet9,vzavet9,vxsqt9,vysqt9,vzsqt9,stress_xzt9,stress_xyt9,stress_yzt9
      REAL pravet9,prsqt9

      if(myid == 0)then
        fnm4 = trim(dirstat)//'profiles.dat'

        open(27, file = trim(fnm4), status = 'unknown',                &
                 form = 'formatted', position = 'append')
      end if

! Profiles
        vxave = 0.0
        vyave = 0.0
        vzave = 0.0
        vxsq = 0.0
        vysq = 0.0
        vzsq = 0.0
        stress_xz = 0.0
        stress_xy = 0.0
        stress_yz = 0.0
        prave = 0.0
        prsq = 0.0

       do i=1,lx
       tmp2D = ux(i,:,:)
       vxave(i) = sum (tmp2D(:,:) )
       tmp2D = uy(i,:,:)
       vyave(i) = sum (tmp2D(:,:) )
       tmp2D = uz(i,:,:)
       vzave(i) = sum (tmp2D(:,:) )

       tmp2D = ux(i,:,:)*uz(i,:,:)
       stress_xz(i) = sum ( tmp2D(:,:) )
       tmp2D = ux(i,:,:)*uy(i,:,:)
       stress_xy(i) = sum ( tmp2D(:,:) )
       tmp2D = uy(i,:,:)*uz(i,:,:)
       stress_yz(i) = sum ( tmp2D(:,:) )

       tmp2D = (ux(i,:,:))**2
       vxsq(i) = sum ( tmp2D(:,:) )
       tmp2D = (uy(i,:,:))**2
       vysq(i) = sum ( tmp2D(:,:) )
       tmp2D = (uz(i,:,:))**2
       vzsq(i) = sum ( tmp2D(:,:) )

       tmp2D = rho(i,:,:)
       prave(i) = sum (tmp2D(:,:) )
       tmp2D = rho(i,:,:)*rho(i,:,:)
       prsq(i) = sum ( tmp2D(:,:) )

       end do

       call MPI_BARRIER(MPI_COMM_WORLD,ierr)

       CALL MPI_ALLREDUCE (vxave,vxavet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vyave,vyavet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vzave,vzavet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vxsq,vxsqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vysq,vysqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vzsq,vzsqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (stress_xz,stress_xzt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (stress_xy,stress_xyt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (stress_yz,stress_yzt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)

       CALL MPI_ALLREDUCE (prave,pravet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (prsq,prsqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)

       if (myid.eq.0) then
       vxavet = vxavet/(ny*nz)/ustar
       vyavet = vyavet/(ny*nz)/ustar
       vzavet = vzavet/(ny*nz)/ustar
       vxsqt = vxsqt/(ny*nz)/ustar**2
       vysqt = vysqt/(ny*nz)/ustar**2
       vzsqt = vzsqt/(ny*nz)/ustar**2
       stress_xzt = stress_xzt/(ny*nz)/ustar**2
       stress_xyt = stress_xyt/(ny*nz)/ustar**2
       stress_yzt = stress_yzt/(ny*nz)/ustar**2
       vxsqt = vxsqt - vxavet**2
       vysqt = vysqt - vyavet**2
       vzsqt = vzsqt - vzavet**2
       stress_xzt = stress_xzt - vxavet*vzavet
       stress_xyt = stress_xyt - vxavet*vyavet
       stress_yzt = stress_yzt - vyavet*vzavet

       pravet = pravet/(ny*nz)/ustar**2
       prsqt = prsqt/(ny*nz)/ustar**4
       prsqt = prsqt - pravet*pravet

       write(27,*)istep

       do i=1,lx
       vxavet9 = vxavet(i)
       vyavet9 = vyavet(i)
       vzavet9 = vzavet(i)
       vxsqt9 = vxsqt(i)
       vysqt9 = vysqt(i)
       vzsqt9 = vzsqt(i)
       stress_xzt9 = stress_xzt(i)
       stress_xyt9 = stress_xyt(i)
       stress_yzt9 = stress_yzt(i)

       pravet9 = pravet(i)
       prsqt9 = prsqt(i)

       yplus = (real(i)-0.5)/ystar
       if(i.gt.lxh) yplus = ( real(lx-i) + 0.5 )/ystar

!      vxavet9 = (vxavet(i) + vxavet(lx+1-i))/2.0
!      vyavet9 = (vyavet(i) + vyavet(lx+1-i))/2.0
!      vzavet9 = (vzavet(i) + vzavet(lx+1-i))/2.0
!      vxsqt9 = (vxsqt(i) + vxsqt(lx+1-i) )/2.
!      vysqt9 = (vysqt(i) + vysqt(lx+1-i) )/2.
!      vzsqt9 = (vzsqt(i) + vzsqt(lx+1-i) )/2.
!      stress_xzt9 = (stress_xzt(i) + stress_xzt(lx+1-i) )/2.
!      stress_xyt9 = (stress_xyt(i) + stress_xyt(lx+1-i) )/2.
!      stress_yzt9 = (stress_yzt(i) + stress_yzt(lx+1-i) )/2.
       write(27,460)real(i)-0.5, yplus ,vxavet9,vyavet9,vzavet9, &
             vxsqt9,vysqt9,vzsqt9, stress_xzt9,stress_xyt9,stress_yzt9 &
          ,pravet9,prsqt9
       end do
460    format(2x,13(1pe15.6))
        close(27)
       end if

      end subroutine statistc 
!===========================================================================
! to compute kinetic energy spectrum, dissipation rate spectrum
! also the skewness and flatness
! The nodes inside solid particle are excluded here.

      subroutine statistc2
      use mpi
      use var_inc
      implicit none

      integer ik, nxyz,i,kglb,idZ
      character (len = 120):: fnm1, fnm2, fnm3, fnm4
      real ek, e_t, eks, e_ts, dissp, qq
      real ttt, qqq, dissppp, eta, vk, tk, uprm
      real tmse, Re, xl, et, kmxeta, xintls, vskew, vflat
      real cc2, cc2t, cc3, cc3t, cc4, cc4t,yplus
! ibnodes = -1 fluid
! ibnodes = 1 solid particles
! node that channel walls are outside of the array dimension

      REAL,DIMENSION     (ly,lz)  ::  tmp2D
      integer, dimension(ly,lz) :: itmp2D
      REAL,DIMENSION  (nx) :: vxave,vyave,vzave,vxsq,vysq,vzsq,stress_xz,stress_xy,stress_yz
      REAL,DIMENSION  (nx) :: prave,prsq,pravet,prsqt,volf_fluid
      INTEGER, DIMENSION (nx) :: nfluid,nfluid0
      REAL,DIMENSION  (nx) :: vxavet,vyavet,vzavet,vxsqt,vysqt,vzsqt,stress_xzt,stress_xyt,stress_yzt
      REAL vxavet9,vyavet9,vzavet9,vxsqt9,vysqt9,vzsqt9,stress_xzt9,stress_xyt9,stress_yzt9
      REAL pravet9,prsqt9,volf_fluid9,volf_solid9

      if(myid == 0)then
        fnm4 = trim(dirstat)//'profiles2.dat'

        open(27, file = trim(fnm4), status = 'unknown',                &
                 form = 'formatted', position = 'append')
      end if

! Profiles
        vxave = 0.0
        vyave = 0.0
        vzave = 0.0
        vxsq = 0.0
        vysq = 0.0
        vzsq = 0.0
        stress_xz = 0.0
        stress_xy = 0.0
        stress_yz = 0.0
        prave = 0.0
        prsq = 0.0

       do i=1,lx
       itmp2D = ibnodes(i,:,:)

       nfluid0(i) = count(itmp2D < 0)

       tmp2D = ux(i,:,:)
       vxave(i) = sum (tmp2D,MASK = (itmp2D < 0) )
       tmp2D = uy(i,:,:)
       vyave(i) = sum (tmp2D,MASK = (itmp2D < 0) )
       tmp2D = uz(i,:,:)
       vzave(i) = sum (tmp2D,MASK = (itmp2D < 0) )

       tmp2D = ux(i,:,:)*uz(i,:,:)
       stress_xz(i) = sum (tmp2D,MASK = (itmp2D < 0) )
       tmp2D = ux(i,:,:)*uy(i,:,:)
       stress_xy(i) = sum (tmp2D,MASK = (itmp2D < 0) )
       tmp2D = uy(i,:,:)*uz(i,:,:)
       stress_yz(i) = sum (tmp2D,MASK = (itmp2D < 0) )

       tmp2D = (ux(i,:,:))**2
       vxsq(i) = sum (tmp2D,MASK = (itmp2D < 0) )
       tmp2D = (uy(i,:,:))**2
       vysq(i) = sum (tmp2D,MASK = (itmp2D < 0) )
       tmp2D = (uz(i,:,:))**2
       vzsq(i) = sum (tmp2D,MASK = (itmp2D < 0) )

       tmp2D = rho(i,:,:)
       prave(i) = sum (tmp2D,MASK = (itmp2D < 0) )
       tmp2D = rho(i,:,:)*rho(i,:,:)
       prsq(i) = sum (tmp2D,MASK = (itmp2D < 0) )

       end do

       call MPI_BARRIER(MPI_COMM_WORLD,ierr)

       call MPI_ALLREDUCE(nfluid0,nfluid,lx,MPI_INTEGER,MPI_SUM,mpi_comm_world,ierr)

       CALL MPI_ALLREDUCE (vxave,vxavet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vyave,vyavet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vzave,vzavet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vxsq,vxsqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vysq,vysqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (vzsq,vzsqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (stress_xz,stress_xzt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (stress_xy,stress_xyt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (stress_yz,stress_yzt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)

       CALL MPI_ALLREDUCE (prave,pravet,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
       CALL MPI_ALLREDUCE (prsq,prsqt,lx,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)

       if (myid.eq.0) then
       vxavet = vxavet/real(nfluid)/ustar
       vyavet = vyavet/real(nfluid)/ustar
       vzavet = vzavet/real(nfluid)/ustar
       vxsqt = vxsqt/real(nfluid)/ustar**2
       vysqt = vysqt/real(nfluid)/ustar**2
       vzsqt = vzsqt/real(nfluid)/ustar**2
       stress_xzt = stress_xzt/real(nfluid)/ustar**2
       stress_xyt = stress_xyt/real(nfluid)/ustar**2
       stress_yzt = stress_yzt/real(nfluid)/ustar**2
       volf_fluid = real(nfluid)/real(ny*nz)
       vxsqt = vxsqt - vxavet**2
       vysqt = vysqt - vyavet**2
       vzsqt = vzsqt - vzavet**2
       stress_xzt = stress_xzt - vxavet*vzavet
       stress_xyt = stress_xyt - vxavet*vyavet
       stress_yzt = stress_yzt - vyavet*vzavet

       pravet = pravet/real(nfluid)/ustar**2
       prsqt = prsqt/real(nfluid)/ustar**4
       prsqt = prsqt - pravet*pravet

       write(27,*)istep

       do i=1,lx
       vxavet9 = vxavet(i)
       vyavet9 = vyavet(i)
       vzavet9 = vzavet(i)
       vxsqt9 = vxsqt(i)
       vysqt9 = vysqt(i)
       vzsqt9 = vzsqt(i)
       stress_xzt9 = stress_xzt(i)
       stress_xyt9 = stress_xyt(i)
       stress_yzt9 = stress_yzt(i)

       pravet9 = pravet(i)
       prsqt9 = prsqt(i)
       volf_fluid9 = volf_fluid(i)
       volf_solid9 = 1.0 - volf_fluid9

       yplus = (real(i)-0.5)/ystar
       if(i.gt.lxh) yplus = ( real(lx-i) + 0.5 )/ystar

!      vxavet9 = (vxavet(i) + vxavet(lx+1-i))/2.0
!      vyavet9 = (vyavet(i) + vyavet(lx+1-i))/2.0
!      vzavet9 = (vzavet(i) + vzavet(lx+1-i))/2.0
!      vxsqt9 = (vxsqt(i) + vxsqt(lx+1-i) )/2.
!      vysqt9 = (vysqt(i) + vysqt(lx+1-i) )/2.
!      vzsqt9 = (vzsqt(i) + vzsqt(lx+1-i) )/2.
!      stress_xzt9 = (stress_xzt(i) + stress_xzt(lx+1-i) )/2.
!      stress_xyt9 = (stress_xyt(i) + stress_xyt(lx+1-i) )/2.
!      stress_yzt9 = (stress_yzt(i) + stress_yzt(lx+1-i) )/2.
       write(27,460)real(i)-0.5, yplus ,vxavet9,vyavet9,vzavet9, &
             vxsqt9,vysqt9,vzsqt9, stress_xzt9,stress_xyt9,stress_yzt9 &
          ,pravet9,prsqt9,volf_fluid9,volf_solid9
       end do
460    format(2x,15(1pe15.6))
        close(27)
       end if

      end subroutine statistc2

!===========================================================================
! this is to monitor the mean and maximum flow velocity and particle
! velocity
      subroutine diag
      use mpi
      use var_inc
      implicit none

!********THIS IS CHANGED*******************************
!      integer, dimension(2):: idwp, idomgp

      integer, dimension(1):: idwp, idomgp

      real ttt, vmax, wpmax, omgpmax,volf
      real, dimension(lx,ly,lz):: vel
      real, dimension(npart):: wpmag, omgpmag
      real, dimension(nproc):: vmax0,vmax0t
      integer, dimension(nproc):: im,jm,km,im0,jm0,km0
      real umean,vmean,wmean,urms,vrms,wrms,urmst,vrmst,wrmst
      real umeant,vmeant,wmeant
      integer i,j,k,imout,jmout,kmout,nfluid0,nfluid

      character (len = 120):: fnm
!!!!!!!!!!!
      umean = 0.0
      vmean = 0.0
      wmean = 0.0

      nfluid0 = count(ibnodes < 0)
      umean = sum (ux,MASK = (ibnodes < 0) )
      vmean = sum (uy,MASK = (ibnodes < 0) )
      wmean = sum (uz,MASK = (ibnodes < 0) )
      urms = sum (ux*ux,MASK = (ibnodes < 0) )
      vrms = sum (uy*uy,MASK = (ibnodes < 0) )
      wrms = sum (uz*uz,MASK = (ibnodes < 0) )

      call MPI_BARRIER(MPI_COMM_WORLD,ierr)

      CALL MPI_ALLREDUCE(nfluid0,nfluid,1,MPI_INTEGER,MPI_SUM,mpi_comm_world,ierr)
      CALL MPI_ALLREDUCE(umean,umeant,1,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
      CALL MPI_ALLREDUCE(vmean,vmeant,1,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
      CALL MPI_ALLREDUCE(wmean,wmeant,1,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
      CALL MPI_ALLREDUCE(urms,urmst,1,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
      CALL MPI_ALLREDUCE(vrms,vrmst,1,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)
      CALL MPI_ALLREDUCE(wrms,wrmst,1,MPI_REAL8,MPI_SUM,mpi_comm_world,ierr)

!!!!!!!!!!!

      vel = sqrt(ux*ux + uy*uy + uz*uz)
      where(ibnodes > 0) vel = 0.0

!     vmax0 = maxval(vel)
      im = 0
      jm = 0
      km = 0
      vmax0 = 0.0
      do k=1,lz
      do j=1,ly
      do i=1,lx
      if(vel(i,j,k).gt.vmax0(myid) ) then
      vmax0(myid) = vel(i,j,k)
      im(myid)=i
      jm(myid)=j +  indy*ly
      km(myid)=k +  indz*lz
      end if
      end do
      end do
      end do
!
!     call MPI_REDUCE(vmax0,vmax,1,MPI_REAL8,MPI_MAX,0,MPI_COMM_WORLD,ierr)

      call MPI_BARRIER(MPI_COMM_WORLD,ierr)
      call MPI_ALLREDUCE(im,im0,nproc,MPI_INTEGER,MPI_SUM,MPI_COMM_WORLD,ierr)
      call MPI_ALLREDUCE(jm,jm0,nproc,MPI_INTEGER,MPI_SUM,MPI_COMM_WORLD,ierr)
      call MPI_ALLREDUCE(km,km0,nproc,MPI_INTEGER,MPI_SUM,MPI_COMM_WORLD,ierr)
      call MPI_ALLREDUCE(vmax0,vmax0t,nproc,MPI_REAL8,MPI_SUM,MPI_COMM_WORLD,ierr)

!     if(myid == 0)then
!       wpmax = 0.0
!       omgpmax = 0.0
!       idwp = 0
!       idomgp = 0

!       if(ipart)then
!         wpmag = sqrt(wp(1,:)**2 + wp(2,:)**2 + wp(3,:)**2)
!         wpmax = maxval(wpmag)
!         idwp = maxloc(wpmag)

!         omgpmag = sqrt(omgp(1,:)**2 + omgp(2,:)**2 + omgp(3,:)**2)
!         omgpmax = maxval(omgpmag)
!         idomgp = maxloc(omgpmag)
!       end if

!     end if

          rhoerr = maxval(rho,MASK = (ibnodes < 0))
          call MPI_ALLREDUCE(rhoerr,rhomax,1,MPI_REAL8,MPI_MAX, &
                             MPI_COMM_WORLD,ierr)
          rhoerr = minval(rho,MASK = (ibnodes < 0))
          call MPI_ALLREDUCE(rhoerr,rhomin,1,MPI_REAL8,MPI_MIN, &
                             MPI_COMM_WORLD,ierr)
          if(myid == 0 ) write(*,*)istep, rhomax, rhomin

      if(myid == 0)then
       umeant = umeant/real(nfluid)
       vmeant = vmeant/real(nfluid)
       wmeant = wmeant/real(nfluid)
       urmst = sqrt(urmst/real(nfluid) - umeant**2)
       vrmst = sqrt(vrmst/real(nfluid) - vmeant**2)
       wrmst = sqrt(wrmst/real(nfluid) - wmeant**2)

       umeant = umeant/ustar
       vmeant = vmeant/ustar
       wmeant = wmeant/ustar
       urmst = urmst/ustar
       vrmst = vrmst/ustar
       wrmst = wrmst/ustar

       volf = 1. - real(nfluid)/real(nx*ny*nz)

        fnm = trim(dirdiag)//'diag.dat'

        open(26, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted', position = 'append')

        ttt = real(istep)

        vmax = 0.0
        do i = 1, nproc
        if(vmax0t(i).gt.vmax)then
        vmax = vmax0t(i)
        imout = im0(i)
        jmout = jm0(i)
        kmout = km0(i)
        end if

        end do


       write(26,260) ttt,vmax,imout,jmout,kmout,umeant,vmeant,wmeant,urmst,vrmst,wrmst,volf, &
                rhomax,rhomin
       write(*,*)'ttt,vmax,imout,jmout,kmout,umean,vmean,wmean,umeans,vmeans,wmeans=', &
         ttt,vmax,imout,jmout,kmout,umeant,vmeant,wmeant,urmst,vrmst,wrmst,volf, &
                rhomax,rhomin
        close(26)

      end if

260   format(2x, 2(1pe16.6),3I6,9(1pe16.6) )

      end subroutine diag

!===========================================================================
! this is to output vorticity magnitude and center location of particles,
! and radius projected on the xy-plane of z=256.5 (512^3 domain) in the
! Tecplot format. The data will be used for movie production

      subroutine moviedata
      use mpi
      use var_inc
      implicit none

      integer,parameter:: npart9 = npart/10
! eddy turnover time at t = 0
!      real,parameter:: et0 = 2.356480E+01

      integer id, ii, ilen, mpart, i, j, iroot, sly
      integer,dimension(npart9):: idpart

      real xx, yy, zz9, zdist, ttt
      real, dimension(lx,ly,lz):: vort
      real, dimension(nx,ny):: vort9,vort9c
      real, dimension(npart9):: rad9

      character (len = 120):: fnm1, fnm2

      zz9 = 256.5

      iroot = nprocZ/2
      ilen = lx*ly

      if(myid == 0)then

        ttt = real(istep)*tscale
! normalized by eddy turnover time at t = 0
!       ttt = ttt / et0

        mpart = 0
        do id = 1,npart
          zdist = abs(ypglb(3,id) - zz9)
          if(zdist < rad)then
            mpart = mpart + 1

            if(mpart > npart9)then
              write(*,*) 'Too many particles on z = 256.5 plane.'
              stop
            end if

            idpart(mpart) = id
            rad9(mpart) = sqrt(rad*rad - zdist*zdist)
          end if
        end do

      end if

      if(myid == 0)then

        fnm1 = trim(dirmoviedata)//'vort_z2565.dat'
        fnm2 = trim(dirmoviedata)//'part_z2565.dat'

        open(28, file = trim(fnm1), status = 'unknown',                &
                 form = 'formatted', position = 'append')
        open(29, file = trim(fnm2), status = 'unknown',                &
                 form = 'formatted', position = 'append')

!       if(imovie == 0)then
!         write(28,280) ' '
!         write(29,290) ' '
!       end if

!       write(28,281) istep, lx/2, ly/2
!       do j = 1,ny
!       do i = 1,nx
!         xx = real(i) - 0.5
!         yy = real(j) - 0.5
          write(28,282) ((vort9c(i,j),i=1,nx),j=1,ny)
!       end do
!       end do

        write(29,291) istep, mpart
        do ii = 1,mpart
          id = idpart(ii)
          write(29,292) id, ypglb(1,id), ypglb(2,id), rad9(ii)
        end do

        close(28)
        close(29)

      end if

      imovie = imovie + 1

280   format(1x,'title = "',a2,'"',/,1x,                               &
             'variables = "x", "y", "vorticity"')
281   format(/,1x,'zone t = "',i5,'", i = ',i5, ', j = ',i5,           &
             ', f = point')
282   format(2x,8(1pe12.4))

290   format(1x,'title = "',a2,'"',/,1x,                               &
             'variables = "num", "x", "y", "diam", "time"')
291   format(/,1x,'istep = "',i8,'", mpart = ',i5,', f = point')
292   format(2x,i5,3(1pe16.5))

      end subroutine moviedata

!===========================================================================
! this is to claculate the temporal evolution of rms particle velocity 
! with rms fluid velocity, and rms particle angular velocity with rms fluid
! vorticity

      subroutine rmsstat 
      use mpi
      use var_inc
      implicit none
! eddy turnover time at t = 0
!      real,parameter:: et0 = 2.356480E+01

      integer nf0, nf 
      character (len = 120):: fnm
      real ttt, portionf     

      real uxt0, uyt0, uzt0, uxt, uyt, uzt      
      real uxmn, uymn, uzmn     
      real uxrms0, uyrms0, uzrms0, uxrms, uyrms, uzrms      
      real velfrms, velfmn, velprms, velpmn   
      real wpxmn, wpymn, wpzmn, wpxrms, wpyrms, wpzrms    

      real oxt0, oyt0, ozt0, oxt, oyt, ozt  
      real oxmn, oymn, ozmn 
      real oxrms0, oyrms0, ozrms0, oxrms, oyrms, ozrms    
      real omgfrms, omgfmn, omgprms, omgpmn  
      real omgpxmn, omgpymn, omgpzmn 
      real omgpxrms, omgpyrms, omgpzrms  

! first calculate fluid rms velocity
      nf0 = count(ibnodes < 0) 
      call MPI_REDUCE(nf0,nf,1,MPI_INTEGER,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uxt0 = sum(ux, MASK = (ibnodes < 0))
      call MPI_REDUCE(uxt0,uxt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uyt0 = sum(uy, MASK = (ibnodes < 0))
      call MPI_REDUCE(uyt0,uyt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uzt0 = sum(uz, MASK = (ibnodes < 0))
      call MPI_REDUCE(uzt0,uzt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      if(myid == 0)then
        uxmn = uxt / real(nf)        
        uymn = uyt / real(nf)        
        uzmn = uzt / real(nf)        
      end if

      call MPI_BCAST(uxmn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(uymn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(uzmn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)

      uxrms0 = sum((ux - uxmn)**2, MASK = (ibnodes < 0))
      call MPI_REDUCE(uxrms0,uxrms,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uyrms0 = sum((uy - uymn)**2, MASK = (ibnodes < 0))
      call MPI_REDUCE(uyrms0,uyrms,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uzrms0 = sum((uz - uzmn)**2, MASK = (ibnodes < 0))
      call MPI_REDUCE(uzrms0,uzrms,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      if(myid == 0)then
        uxrms = sqrt(uxrms / real(nf))
        uyrms = sqrt(uyrms / real(nf))
        uzrms = sqrt(uzrms / real(nf))

        velfrms = sqrt(uxrms**2 + uyrms**2 + uzrms**2)
        velfmn = sqrt(uxmn**2 + uymn**2 + uzmn**2) 
      end if


! then calculate particle rms velocity
      if(ipart .and. istep >= irelease)then

      if(myid == 0)then
        wpxmn = sum(wp(1,:)) / real(npart)
        wpymn = sum(wp(2,:)) / real(npart)
        wpzmn = sum(wp(3,:)) / real(npart)

        wpxrms = sqrt(sum((wp(1,:) - wpxmn)**2) / real(npart))
        wpyrms = sqrt(sum((wp(2,:) - wpymn)**2) / real(npart))
        wpzrms = sqrt(sum((wp(3,:) - wpzmn)**2) / real(npart))

        velprms = sqrt(wpxrms**2 + wpyrms**2 + wpzrms**2)
        velpmn = sqrt(wpxmn**2 + wpymn**2 + wpzmn**2)
      end if 

      else

      if(myid == 0)then
        wpxmn = 0.0
        wpymn = 0.0
        wpzmn = 0.0
        wpxrms = 0.0
        wpyrms = 0.0
        wpzrms = 0.0
        velprms = 0.0
        velpmn = 0.0
      end if

      end if 
      

! compute fluid rms vorticity
! prepare vorticity field ox, oy, and oz
      call vortcalc

      oxt0 = sum(ox, MASK = (ibnodes < 0))
      call MPI_REDUCE(oxt0,oxt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      oyt0 = sum(oy, MASK = (ibnodes < 0))
      call MPI_REDUCE(oyt0,oyt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      ozt0 = sum(oz, MASK = (ibnodes < 0))
      call MPI_REDUCE(ozt0,ozt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      if(myid == 0)then
        oxmn = oxt / real(nf)
        oymn = oyt / real(nf)
        ozmn = ozt / real(nf)
      end if

      call MPI_BCAST(oxmn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(oymn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(ozmn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)

      oxrms0 = sum((ox - oxmn)**2, MASK = (ibnodes < 0))
      call MPI_REDUCE(oxrms0,oxrms,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      oyrms0 = sum((oy - oymn)**2, MASK = (ibnodes < 0))
      call MPI_REDUCE(oyrms0,oyrms,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      ozrms0 = sum((oz - ozmn)**2, MASK = (ibnodes < 0))
      call MPI_REDUCE(ozrms0,ozrms,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      if(myid == 0)then
        oxrms = sqrt(oxrms / real(nf))
        oyrms = sqrt(oyrms / real(nf))
        ozrms = sqrt(ozrms / real(nf))

        omgfrms = sqrt(oxrms**2 + oyrms**2 + ozrms**2)
        omgfmn = sqrt(oxmn**2 + oymn**2 + ozmn**2)
      end if

! compute particle rms angular velocity. Note that vorticity is twice 
! the rotation rate of a small fluid line segment oriented along a 
! principal direction of rate-of-strain tensor

      if(ipart .and. istep >= irelease)then

      if(myid == 0)then
        omgpxmn = sum(omgp(1,:)) / real(npart)
        omgpymn = sum(omgp(2,:)) / real(npart)
        omgpzmn = sum(omgp(3,:)) / real(npart)

        omgpxrms = sqrt(sum((omgp(1,:) - omgpxmn)**2) / real(npart))
        omgpyrms = sqrt(sum((omgp(2,:) - omgpymn)**2) / real(npart))
        omgpzrms = sqrt(sum((omgp(3,:) - omgpzmn)**2) / real(npart))

        omgprms = sqrt(omgpxrms**2 + omgpyrms**2 + omgpzrms**2)
        omgpmn = sqrt(omgpxmn**2 + omgpymn**2 + omgpxmn**2)
      end if

      else

      if(myid == 0)then
        omgpxmn = 0.0
        omgpymn = 0.0
        omgpzmn = 0.0
        omgpxrms = 0.0
        omgpyrms = 0.0
        omgpzrms = 0.0
        omgprms = 0.0
        omgpmn = 0.0
      end if

      end if

      if(myid == 0)then
        ttt = real(istep)*tscale
! normalized by eddy turnover time at t = 0
        ttt = ttt / et0

        portionf = real(nf) / real(nx**3)

        fnm = trim(dirstat)//'rms.dat'
        open(30, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted', position = 'append')

        write(30,300) ttt, nf, portionf,                               &
                      uxmn, uymn, uzmn, uxrms, uyrms, uzrms,           &
                      velfrms, velfmn,                                 &
                      wpxmn, wpymn, wpzmn, wpxrms,wpyrms, wpzrms,      &
                      velprms, velpmn,                                 &
                      oxmn, oymn, ozmn, oxrms, oyrms, ozrms,           &
                      omgfrms/2.0, omgfmn,                             &
             omgpxmn, omgpymn, omgpzmn, omgpxrms, omgpyrms, omgpzrms,  &
                      omgprms, omgpmn,                                 &
                      omgfrms**2, velfrms**2          
        close(30)

      end if

300   format(2x,1(1pe16.6),i12,35(1pe16.6))
       
      end subroutine rmsstat 
!============================================================================
! This subroutine is the same as "sijstat03" above, except that it only
! calculate till the Sij2_m1, Sij2_m2, uprm2, and then save these arrays
! for further processing.
      subroutine sijstat
      use mpi
      use var_inc
      implicit none

      integer ix, iy, iz
      real, dimension(0:npop-1) :: f9
      real, dimension(lx,ly,lz) :: Sij2_m1, Sij2_m2, uprm2
      real rho9, ux9, uy9, uz9, ux9s, uy9s, uz9s
      real eqm1, eqm6, eqm8, eqm10, eqm11, eqm12
      real sum1, sum2, sum6, sum7, sum8, sum9, sum10, sum11
      real evlm1, evlm6, evlm8, evlm10, evlm11, evlm12
      real neqm1, neqm9, neqm11, neqm13, neqm14, neqm15
      real Sxx, Syy, Szz, Sxy, Syz, Szx
      real usqr, edtu, wght, feq9, fneq9

      integer iprc1, iprc2, iprc3
      integer istp1, istp2, istp3, istp4, istp5, istp6

      real Sij2_m1t0, Sij2_m2t0, Sij2_m1t, Sij2_m2t
      real Sij2_m1_avg, Sij2_m2_avg, Sij2m2_tmp

      integer nf0, nf, ip
      real uxt0, uyt0, uzt0, uxt, uyt, uzt
      real uxmn, uymn, uzmn
      real uprm2t0, uprm2t, uprm2_avg

      character (len = 120):: fnm

      Sij2_m1 = 0.0  
      Sij2_m2 = 0.0  

      do iz = 1,lz
      do iy = 1,ly
      do ix = 1,lx
      if(ibnodes(ix,iy,iz) < 0)then
! to calculate Sij*Sij as a local array of (lx,ly,lz),

! Method 1: calculate in the moment space.
! see Yu H. et al. Computers & Fluids 35, pp. 957-965, 2006, Appendix.

        f9 = f(ix,iy,iz,:)

        rho9 = rho(ix,iy,iz)
        ux9 = ux(ix,iy,iz)
        uy9 = uy(ix,iy,iz)
        uz9 = uz(ix,iy,iz)
        ux9s = ux9*ux9
        uy9s = uy9*uy9
        uz9s = uz9*uz9

        eqm1 = -11.0*rho9 + 19.0*(ux9s + uy9s + uz9s)
        eqm6 = 2.0*ux9s - uy9s - uz9s
        eqm8 = uy9s - uz9s
        eqm10 = ux9*uy9
        eqm11 = uy9*uz9
        eqm12 = ux9*uz9

        sum1 = f9(1) + f9(2) + f9(3) + f9(4) + f9(5) + f9(6)
        sum2 = f9(7) + f9(8) + f9(9) + f9(10) + f9(11) + f9(12)        &
             + f9(13) + f9(14) + f9(15) + f9(16) + f9(17) + f9(18)
        sum6 = f9(1) + f9(2)
        sum7 = f9(3) + f9(4) + f9(5) + f9(6)
        sum8 = f9(7) + f9(8) + f9(9) + f9(10) + f9(11) + f9(12)        &
             + f9(13) + f9(14)
        sum9 = f9(15) + f9(16) + f9(17) + f9(18)
        sum10 = f9(3) + f9(4) - f9(5) - f9(6)
        sum11 = f9(7) + f9(8) + f9(9) + f9(10) - f9(11) - f9(12)       &
              - f9(13) - f9(14)

        evlm1 = -30.0*f9(0) + coef2*sum1 + coef3*sum2
        evlm6 = coef5*sum6 - sum7 + sum8 - coef5*sum9
        evlm8 = sum10 + sum11
        evlm10 = f9(7) - f9(8) - f9(9) + f9(10)
        evlm11 = f9(15) - f9(16) - f9(17) + f9(18)
        evlm12 = f9(11) - f9(12) - f9(13) + f9(14)

        neqm1 = s1*(evlm1 - eqm1)
        neqm9 = s9*(evlm6 - eqm6)
        neqm11 = s9*(evlm8 - eqm8)
        neqm13 = s9*(evlm10 - eqm10)
        neqm14 = s9*(evlm11 - eqm11)
        neqm15 = s9*(evlm12 - eqm12)

        Sxx = -(neqm1 + 19.0*neqm9) / 38.0
        Syy = -(2.0*neqm1 - 19.0*(neqm9 - 3.0*neqm11)) / 76.0
        Szz = -(2.0*neqm1 - 19.0*(neqm9 + 3.0*neqm11)) / 76.0
        Sxy = -1.5*neqm13
        Syz = -1.5*neqm14
        Szx = -1.5*neqm15

        Sij2_m1(ix,iy,iz) = Sxx*Sxx + Syy*Syy + Szz*Szz                &
                    + 2.0*(Sxy*Sxy + Syz*Syz + Szx*Szx)

! Method 2: calculate in the discrete velocity space, f-space.
! Sij = -3/(2*rho0*tau)*Sigma_alpha{f_alpha(x,t)-f^(0)_alpha(x,t)}*e_alpha_i*
! e_alpha_j, where alpha = 0, 1, 2, ..., 18, f^(0) = f^(eq), the equilibrium
! distribution function, i,j = x, y, z

        Sxx = 0.0
        Syy = 0.0
        Szz = 0.0
        Sxy = 0.0
        Syz = 0.0
        Szx = 0.0

        usqr = 1.5*(ux9s + uy9s + uz9s)

        do ip = 1,npop-1
! first, calculate the equilibrium distribution function
          if(ip <= 6) wght = ww1
          if(ip > 6) wght = ww2

          edtu = cix(ip)*ux9 + ciy(ip)*uy9 + ciz(ip)*uz9
          feq9 = wght*(rho9 + 3.0*edtu + 4.5*edtu**2 - usqr)

          fneq9 = f9(ip) - feq9

          Sxx = Sxx + fneq9*real(cix(ip)*cix(ip))
          Syy = Syy + fneq9*real(ciy(ip)*ciy(ip))
          Szz = Szz + fneq9*real(ciz(ip)*ciz(ip))
          Sxy = Sxy + fneq9*real(cix(ip)*ciy(ip))
          Syz = Syz + fneq9*real(ciy(ip)*ciz(ip))
          Szx = Szx + fneq9*real(ciz(ip)*cix(ip))
        end do

        Sij2m2_tmp = Sxx*Sxx + Syy*Syy + Szz*Szz                       &
                    + 2.0*(Sxy*Sxy + Syz*Syz + Szx*Szx)

        Sij2_m2(ix,iy,iz) = Sij2m2_tmp*(1.5 / tau)**2
      end if
      end do
      end do
      end do

! to calculate urms*urms as a local array of (lx,ly,lz)
! first calculate fluid rms velocity
      nf0 = count(ibnodes < 0)
      call MPI_REDUCE(nf0,nf,1,MPI_INTEGER,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uxt0 = sum(ux, MASK = (ibnodes < 0))
      call MPI_REDUCE(uxt0,uxt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uyt0 = sum(uy, MASK = (ibnodes < 0))
      call MPI_REDUCE(uyt0,uyt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      uzt0 = sum(uz, MASK = (ibnodes < 0))
      call MPI_REDUCE(uzt0,uzt,1,MPI_REAL8,MPI_SUM,0,MPI_COMM_WORLD,ierr)

      if(myid == 0)then
        uxmn = uxt / real(nf)
        uymn = uyt / real(nf)
        uzmn = uzt / real(nf)
      end if

      call MPI_BCAST(uxmn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(uymn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      call MPI_BCAST(uzmn,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)

      uprm2 = ((ux - uxmn)**2 + (uy - uymn)**2 + (uz - uzmn)**2) / 3.0

! to calculate the averaged value of Sij2_m1, Sij2_m2, and uprm2
! over all the fluid nodes in the domain
      Sij2_m1t0 = sum(Sij2_m1, MASK = (ibnodes < 0))
      call MPI_REDUCE(Sij2_m1t0,Sij2_m1t,1,MPI_REAL8,MPI_SUM,0,         &
                      MPI_COMM_WORLD,ierr)

      Sij2_m2t0 = sum(Sij2_m2, MASK = (ibnodes < 0))
      call MPI_REDUCE(Sij2_m2t0,Sij2_m2t,1,MPI_REAL8,MPI_SUM,0,         &
                      MPI_COMM_WORLD,ierr)

      uprm2t0 = sum(uprm2, MASK = (ibnodes < 0))
      call MPI_REDUCE(uprm2t0,uprm2t,1,MPI_REAL8,MPI_SUM,0,             &
                      MPI_COMM_WORLD,ierr)

      if(myid == 0)then
        Sij2_m1_avg = Sij2_m1t / real(nf)
        Sij2_m2_avg = Sij2_m2t / real(nf)
        uprm2_avg = uprm2t / real(nf)
      end if


      IF(ipart .and. istep >= irelease) THEN

      iprc1 = myid / 100
      iprc2 = mod(myid,100) / 10
      iprc3 = mod(myid,10)

      istp1 = istep / 100000
      istp2 = mod(istep,100000) / 10000
      istp3 = mod(istep,10000) / 1000
      istp4 = mod(istep,1000) / 100
      istp5 = mod(istep,100) / 10
      istp6 = mod(istep,10)

      fnm = trim(dirstat)//'sijdata/sij.'                            &
          //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
          //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
          //'.'                                                      &
          //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

      open(31, file = trim(fnm), status = 'unknown',                 &
               form = 'unformatted')

      write(31) Sij2_m1, Sij2_m2, uprm2, ibnodes  
      if(myid == 0) write(31) ypglb, Sij2_m1_avg, Sij2_m2_avg, uprm2_avg


      close(31)

      END IF

      end subroutine sijstat

!===========================================================================
! This subroutine is for debugging overlap problem and can be deleted after
      subroutine writepartpair 
      use mpi
      use var_inc
      implicit none


      end subroutine writepartpair
!===========================================================================


!==========================================================================
! This subroutine is for writing out a slice of the instantaneous flow field
      subroutine writeflowfieldstart
      use mpi
      use var_inc
      implicit none

      real,dimension(ly,lz)::uxplane
      integer i,k,j
      integer iprc1, iprc2, iprc3
      character (len = 120):: fnm1

        iprc1 = myid / 100
        iprc2 = mod(myid,100) / 10
        iprc3 = mod(myid,10)

        fnm1 = trim(dirstat)//'flowfield2Dstart.dat.'         &
              //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

        open(44, file = trim(fnm1), status = 'unknown',                 &
                 form = 'unformatted')

          uxplane = ux(lx/2,:,:)

          write(44) uxplane

       close(44)

      end subroutine writeflowfieldstart
!===========================================================================

!==========================================================================
! This subroutine is for writing out a slice of the instantaneous flow field
      subroutine writeflowfield
      use mpi
      use var_inc
      implicit none

      real,dimension(ly,lz)::uxplane
      integer i,k,j
      integer iprc1, iprc2, iprc3
      character (len = 120):: fnm1

        iprc1 = myid / 100
        iprc2 = mod(myid,100) / 10
        iprc3 = mod(myid,10)

        fnm1 = trim(dirstat)//'flowfield2D.dat.'         &
              //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

        open(66, file = trim(fnm1), status = 'unknown',                 &
                 form = 'unformatted')

          uxplane = ux(lx/2,:,:)

          write(66) uxplane

          close(66)

      end subroutine writeflowfield
!===========================================================================

!==========================================================================
! This subroutine is for writing out a slice of the instantaneous flow field
      subroutine writeflowfieldend
      use mpi
      use var_inc
      implicit none

      real,dimension(ly,lz)::uxplane
      integer i,k,j
      integer iprc1, iprc2, iprc3
      character (len = 120):: fnm1

        iprc1 = myid / 100
        iprc2 = mod(myid,100) / 10
        iprc3 = mod(myid,10)

        fnm1 = trim(dirstat)//'flowfield2Dend.dat.'         &
              //char(iprc1 + 48)//char(iprc2 + 48)//char(iprc3 + 48)

        open(55, file = trim(fnm1), status = 'unknown',                 &
                 form = 'unformatted')

          uxplane = ux(lx/2,:,:)

          write(55) uxplane

          close(55)

      end subroutine writeflowfieldend
!===========================================================================

!===========================================================================
      subroutine colldata(fnm2) 
      use mpi
      use var_inc
      implicit none

      integer ip, id, ilen
      integer istp1, istp2, istp3, istp4, istp5, istp6
      character (len = 120):: fnm,fnm2

!     if(myid == 0)then

        istp1 = istep / 100000
        istp2 = mod(istep,100000) / 10000
        istp3 = mod(istep,10000) / 1000
        istp4 = mod(istep,1000) / 100
        istp5 = mod(istep,100) / 10
        istp6 = mod(istep,10)

        fnm = trim(dirpartout)//trim(fnm2)         &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //'.dat'

        open(60, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted', position = 'append')

        do id = 1,npart
          write(60,600) id, ypglb(1,id), ypglb(2,id), ypglb(3,id),     &
                            wp(1,id), wp(2,id), wp(3,id),              &
                            fHIp(1,id), fHIp(2,id), fHIp(3,id)
        end do

        close(60)

!     end if

600   format(2x,i5,9(1pe16.6))
      end subroutine colldata 
!============================================================================

!===========================================================================
      subroutine checkredisbefore 
      use mpi
      use var_inc
      implicit none

      integer ip, id, ilen
      integer istp1, istp2, istp3, istp4, istp5, istp6
      character (len = 120):: fnm

      if(myid == 0)then

        istp1 = istep / 100000
        istp2 = mod(istep,100000) / 10000
        istp3 = mod(istep,10000) / 1000
        istp4 = mod(istep,1000) / 100
        istp5 = mod(istep,100) / 10
        istp6 = mod(istep,10)

        fnm = trim(dirpartout)//'checkRedisBefore2D'                                 &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //'.dat'

        open(70, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted', position = 'append')

        do id = 1,npart
          write(70,700) id, ypglb(1,id), ypglb(2,id), ypglb(3,id),     &
                            wp(1,id), wp(2,id), wp(3,id),              &
                            fHIp(1,id), fHIp(2,id), fHIp(3,id)
        end do

        close(70)

      end if

700   format(2x,i5,9(1pe16.6))
      end subroutine checkredisbefore
!============================================================================

!===========================================================================
      subroutine checkredisafter
      use mpi
      use var_inc
      implicit none

      integer ip, id, ilen
      integer istp1, istp2, istp3, istp4, istp5, istp6
      character (len = 120):: fnm

      if(myid == 0)then

        istp1 = istep / 100000
        istp2 = mod(istep,100000) / 10000
        istp3 = mod(istep,10000) / 1000
        istp4 = mod(istep,1000) / 100
        istp5 = mod(istep,100) / 10
        istp6 = mod(istep,10)

        fnm = trim(dirpartout)//'checkRedisAfter2D'                                 &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //'.dat'

        open(80, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted', position = 'append')

        do id = 1,npart
          write(80,800) id, ypglb(1,id), ypglb(2,id), ypglb(3,id),     &
!                           forcep(1,id), forcep(2,id), forcep(3,id),              &
                            wp(1,id), wp(2,id), wp(3,id),              &
                            fHIp(1,id), fHIp(2,id), fHIp(3,id)
        end do

        close(80)

      end if

800   format(2x,i5,9(1pe16.6))
      end subroutine checkredisafter
!============================================================================

      subroutine dataf(fnm2)
      use mpi
      use var_inc
      implicit none

      integer ip,i9,j9,k9,id, ilen
      integer istp1, istp2, istp3, istp4, istp5, istp6
      character (len = 120):: fnm,fnm2

      if(myid == 0)then

        istp1 = istep / 100000
        istp2 = mod(istep,100000) / 10000
        istp3 = mod(istep,10000) / 1000
        istp4 = mod(istep,1000) / 100
        istp5 = mod(istep,100) / 10
        istp6 = mod(istep,10)

        fnm = trim(dirpartout)//trim(fnm2)                           &
            //char(istp1 + 48)//char(istp2 + 48)//char(istp3 + 48)     &
            //char(istp4 + 48)//char(istp5 + 48)//char(istp6 + 48)     &
            //'.dat'

        open(60, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted', position = 'append')

       do k9 = 2,31
       do j9 = 2,31
       do i9 = 1,64
       write(60,600)i9,j9,k9,ibnodes(i9,j9,k9),f(1,i9,j9,k9),f(2,i9,j9,k9) &
                   ,f(3,i9,j9,k9),f(4,i9,j9,k9)
       end do
       end do
       end do

        close(60)

      end if

600   format(2x,4i5,4(1pe16.6))
      end subroutine dataf

!===========================================================================
!==========================================================================
      subroutine vortcalc
      use mpi
      use var_inc
      implicit none

      real, dimension(lx+2,lly,lz) :: tmp

      ox = 0.0
      oy = 0.0
      oz = 0.0

      end subroutine vortcalc
!==========================================================================
!==========================================================================
      subroutine probe
      use mpi
      use var_inc
      implicit none

      integer id
      character (len = 120):: fnm
      character (len = 25):: filenum
      real, dimension(nproc) :: uprob, vprob, wprob

      CALL MPI_BARRIER(MPI_COMM_WORLD,ierr)

! gather center velocity data from each process
! MPI gather automatically puts data in order of rank
      if(ibnodes(lx/2,ly/2,lz/2).le.0)then
        CALL MPI_GATHER(ux(lx/2, ly/2, lz/2), 1, MPI_REAL8, uprob, 1, MPI_REAL8, 0, MPI_COMM_WORLD, ierr)
        CALL MPI_GATHER(uy(lx/2, ly/2, lz/2), 1, MPI_REAL8, vprob, 1, MPI_REAL8, 0, MPI_COMM_WORLD, ierr)
        CALL MPI_GATHER(uz(lx/2, ly/2, lz/2), 1, MPI_REAL8, wprob, 1, MPI_REAL8, 0, MPI_COMM_WORLD, ierr)
! give exactly 0 if node is in bead
      else
        CALL MPI_GATHER(0.0, 1, MPI_REAL8, uprob, 1, MPI_REAL8, 0, MPI_COMM_WORLD, ierr)
        CALL MPI_GATHER(0.0, 1, MPI_REAL8, vprob, 1, MPI_REAL8, 0, MPI_COMM_WORLD, ierr)
        CALL MPI_GATHER(0.0, 1, MPI_REAL8, wprob, 1, MPI_REAL8, 0, MPI_COMM_WORLD, ierr)
      endif

      if(myid == 0)then !print ut probe data to file
        write (filenum, "(I10)") istep
        fnm = trim(dirprobe)//'probe'//trim(adjustl(filenum))//'.dat'

        open(60, file = trim(fnm), status = 'unknown',                 &
                 form = 'formatted')

        write(60,*) 'Center probe at istep ', istep
        write(60,*) 'Processor    x-velocity    y-velocity    z-velocity'

        do id = 1,nproc
          write(60,600) id-1, uprob(id), vprob(id), wprob(id)
        enddo
      endif

600   format(2x,1i5,3(1pe16.6))
      end subroutine probe

