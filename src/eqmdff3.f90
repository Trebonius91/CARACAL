!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
!   CARACAL - Ring polymer molecular dynamics and rate constant calculations
!             on black-box generated potential energy surfaces
!
!   Copyright (c) 2023 by Julien Steffen (mail@j-steffen.org)
!                         Stefan Grimme (grimme@thch.uni-bonn.de) (QMDFF code)
!
!   Permission is hereby granted, free of charge, to any person obtaining a
!   copy of this software and associated documentation files (the "Software"),
!   to deal in the Software without restriction, including without limitation
!   the rights to use, copy, modify, merge, publish, distribute, sublicense,
!   and/or sell copies of the Software, and to permit persons to whom the
!   Software is furnished to do so, subject to the following conditions:
!
!   The above copyright notice and this permission notice shall be included in
!   all copies or substantial portions of the Software.
!
!   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
!   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
!   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
!   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
!   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
!   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
!   DEALINGS IN THE SOFTWARE.
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!
!     subroutine eqmdff3: for an 3-dimensional evb-qmdff-forcefield, the energies of the
!     3 single qmdff´s are calculated; needed for evbopt and others
!
!     part of EVB
!
subroutine eqmdff3(xyz2,e_qmdff1,e_qmdff2,e_qmdff3)
use general
use evb_mod
implicit none
integer::i,j,n2
real(kind=8)::xyz2(3,natoms),e_evb,g_evb(3,natoms)
real(kind=8)::e1_shifted,e2_shifted,e_two,gnorm_two
real(kind=8)::e3_shifted,e_three,gnorm_three,e_qmdff3
real(kind=8)::ediff,offdiag,off4,root2,deldiscr,delsqrt
real(kind=8)::e,gnorm,e_qmdff1,e_qmdff2,e_one
n=natoms
!     first convolute the unit
!if (convolute) then
   do i=1,natoms
      do j=1,3
         xyz2(j,i)=xyz2(j,i)/bohr
      end do
   end do
!end if

!
!     First QMDFF      
!
call ff_eg(n,at,xyz2,e_one,g_one)
call ff_nonb(n,at,xyz2,q,r0ab,zab,r094_mod,sr42,c6xy,e_one,g_one)
call ff_hb(n,at,xyz2,e_one,g_one)
!
!     Second QMDFF
!
call ff_eg_two(n,at,xyz2,e_two,g_two)
call ff_nonb_two(n,at,xyz2,q_two,r0ab,zab,r094_mod,sr42, &
 &            c6xy_two,e_two,g_two)
call ff_hb_two(n,at,xyz2,e_two,g_two)
     
!
!     Third QMDFF
!
call ff_eg_three(n,at,xyz2,e_three,g_three)
call ff_nonb_three(n,at,xyz2,q_three,r0ab,zab,r094_mod,sr42, &
 &            c6xy_two,e_three,g_three)
call ff_hb_three(n,at,xyz2,e_three,g_three)

 
!
!     Shift the energies
!
e1_shifted=e_one+E_zero1  !E(qmdff1)
e2_shifted=e_two+E_zero2  !E(qmdff2)
e3_shifted=e_three+E_zero3
e_qmdff1=e1_shifted
e_qmdff2=e2_shifted
e_qmdff3=e3_shifted

return
end subroutine eqmdff3 

