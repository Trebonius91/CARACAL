!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
!   EVB-QMDFF - RPMD molecular dynamics and rate constant calculations on
!               black-box generated potential energy surfaces
!
!   Copyright (c) 2021 by Julien Steffen (steffen@pctc.uni-kiel.de)
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
!     subroutine "numeral" converts an input integer number into the
!     corresponding right- or left-justified text numeral
!
!     number  integer value of the number to be transformed
!     string  text string to be filled with corresponding numeral
!     size    on input, the minimal acceptable numeral length, if
!               zero then output will be right justified, if
!               nonzero then numeral is left-justified and padded
!               with leading zeros as necessary; upon output, the
!               number of non-blank characters in the numeral
! 
!     part of others
!
subroutine numeral (number,string,size)
implicit none
integer i,number,size
integer multi,pos
integer length,minsize,len
integer million,hunthou
integer tenthou,thousand
integer hundred,tens,ones
logical right,negative
character*1 digit(0:9)
character*(*) string
data digit  / '0','1','2','3','4','5','6','7','8','9' /
!
!     set justification and size bounds for numeral string
!
if (size .eq. 0) then
   right = .true.
   size = 1
else
   right = .false.
end if
minsize = size
length = len(string)
!
!     test the sign of the original number
!
if (number .ge. 0) then
   negative = .false.
else
   negative = .true.
   number = -number
end if
!
!     use modulo arithmetic to find place-holding digits
!
million = number / 1000000
multi = 1000000 * million
hunthou = (number-multi) / 100000
multi = multi + 100000*hunthou
tenthou = (number-multi) / 10000
multi = multi + 10000*tenthou
thousand = (number-multi) / 1000
multi = multi + 1000*thousand
hundred = (number-multi) / 100
multi = multi + 100*hundred
tens = (number-multi) / 10
multi = multi + 10*tens
ones = number - multi
!
!     find the correct length to be used for the numeral
!
if (million .ne. 0) then
   size = 7
else if (hunthou .ne. 0) then
   size = 6
else if (tenthou .ne. 0) then
   size = 5
else if (thousand .ne. 0) then
   size = 4
else if (hundred .ne. 0) then
   size = 3
else if (tens .ne. 0) then
   size = 2
else
   size = 1
end if
size = min(size,length)
size = max(size,minsize)
!
!     convert individual digits to a string of numerals
!
if (size .eq. 7) then
   string(1:1) = digit(million)
   string(2:2) = digit(hunthou)
   string(3:3) = digit(tenthou)
   string(4:4) = digit(thousand)
   string(5:5) = digit(hundred)
   string(6:6) = digit(tens)
   string(7:7) = digit(ones)
else if (size .eq. 6) then
   string(1:1) = digit(hunthou)
   string(2:2) = digit(tenthou)
   string(3:3) = digit(thousand)
   string(4:4) = digit(hundred)
   string(5:5) = digit(tens)
   string(6:6) = digit(ones)
else if (size .eq. 5) then
   string(1:1) = digit(tenthou)
   string(2:2) = digit(thousand)
   string(3:3) = digit(hundred)
   string(4:4) = digit(tens)
   string(5:5) = digit(ones)
else if (size .eq. 4) then
   string(1:1) = digit(thousand)
   string(2:2) = digit(hundred)
   string(3:3) = digit(tens)
   string(4:4) = digit(ones)
else if (size .eq. 3) then
   string(1:1) = digit(hundred)
   string(2:2) = digit(tens)
   string(3:3) = digit(ones)
else if (size .eq. 2) then
   string(1:1) = digit(tens)
   string(2:2) = digit(ones)
else
   string(1:1) = digit(ones)
end if
!
!     right-justify if desired, and pad with blanks
!
if (right) then
   do i = size, 1, -1
      pos = length - size + i
      string(pos:pos) = string(i:i)
   end do
   do i = 1, length-size
      string(i:i) = ' '
   end do
else
   do i = size+1, length
      string(i:i) = ' '
   end do
end if
return
end subroutine numeral
