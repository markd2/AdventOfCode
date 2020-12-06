# Notes

From https://fortran-lang.org/learn/quickstart

# Variables

strongly / statically typed


### Built in types
* integer
* real
* complex
* character
* logical

### Randoms

* Declare with `variableType :: variableName`
* Declarations have to batched together, like K&R C
* Case insensitive
* do `implicit none` - turns off typing based on initial variable name
* assign with `=`
* bools are e.g. `.false.`
* characters surrounded by `'` or `"`
* be ware of assignment at declaration, e.g. `integer :: amount = 1`
    - it's a `save` attribute, retains its value between procedure calls
    - recommended to initialize variables separately to their declaration
* (is there a default value?) . in `variables`, if print before assigning,
  get a 2.
* `parameter` introduces an alias name for a value (like a constant). e.g.
```
  real, parameter :: pi = 3.14159
  integer, parameter :: n = 10
```


### stdio

* print *, 'The blah is:', variable
* read(*, *) variable

### operators 

* `**` exponent
* * / + -

### floating point precision

* desired precison can be explicitly declared using a `kind` paramter.
  iso_fortran_env intrinsic module provides kind parameters for the 
  common 32/64 bit types
* recommend to always use a `kind` suffix for float point literal constants.

```
  use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
  implicit none

  real(sp) :: float32
  real(dp) :: float64
```

* For C interop, use is_c_binding, c_float/c_double.
  (hence the `sp=>concrete type` to make it easier to change later)

```
!  use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
vs
  use, intrinsic :: iso_c_binding, only: sp=>c_float, dp=>c_double
```

### Arrays and Strings

Some cool stuff

* **Arrays are One-Based**
* multi-dimensional arrays stored in **column major order**, so the
  first index varies fastest
* two ways to declare - `dimension`, or appending array dimensions
```
  ! 1D integer array
  integer, dimension(10) :: array1

  ! equivalent
  integer :: array2(10)

  ! 2D real array
  real, dimension(10, 10) :: array3

  ! custom lower and upper index bounds
  real :: array4(0:9)
  real :: array5(-5:5)
```

* Has array slicing
```
  array1(:) = 0       ! set all elements to zero
  array1(1:5) = 1      ! set first five elements to 1
  array1(6:) = 2       ! set all elements after five to 2
```

* initialization
```
  array1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]  ! array constructor
  array1 = [(i, i = 1, 10)]                 ! implied DO loop constructor
```

* printing with various frobs
```
  print *, array1(1:10:2)   ! print out elements at odd indices
  print *, array2(:, 1)     ! print out first column in a 2D array
  print *, array1(10:1:-1)  ! print array in reverse
```

### dynamic (allocatable) arrays

* Declare allocatble w/o size
* explicitly allocate
* explicitly deallocate
* deallocated automatically when they go out of scope for local array

```
  integer, allocatable :: array1(:)
  integer, allocatable :: array2(:,:)

  allocate(array1(10))
  allocate(array2(10,20))

  ! ...

  deallocate(array1)
  deallocate(array2)
```
* not sure what happens if don't allocate - tried not allocating array1,
  and implied DO-looping initalization to something huge. (the compiler took
  longer to run, so maybe it turned into some kind of literal thing)
* double-deallocation does get caught

```
At line 15 of file allocatable.f90
Fortran runtime error: Attempt to DEALLOCATE unallocated 'array1'

Error termination. Backtrace:
#0  0x109c3eebd
#1  0x109c3fb75
#2  0x109c40156
#3  0x109c29bba
#4  0x109c29c56
```

### Character strings

* Strings are arrays, I guess.  Static buffer length.  Overflow in assignment
  gets clipped.

```
  character(len = 4) :: first_name
  character(len = 5) :: last_name
  character(10) :: full_name
```

* `//` for string concatenation
```
full_name = first_name // ' ' // last_name
```

* Strings can be allocatable too

```
  character(:), allocatable :: first_name
  character(:), allocatable :: last_name

  ! explicit allocation statement
  allocate(character(4) :: first_name)
  first_name = 'John'
  
  ! allocation on assignment
  last_name = 'Smith'
```

### Operators and control flow

* Logical operators
* operators and alternatives
```
==   .eq.
/=   .ne.
>    .gt.
<    .lt.
>=   .ge.
<=   .le.
```

and logical operators

```
.and.
.or.
.not.
.eqv.   - true if left has same logical value as right
.neqv.  - true if left has opposite logcal value as right
```

### conditional

* if then / else / else if / end if
* parens around conditional


### loops

* DO loop has an integer counter to track the iteration. `i` is the
  common name
* do i = 1, 10   / do i = 1, 10, 2
```
  do i = 1, 10, 2
     print *, i
  end do
```
* do while / end do
```
  integer :: i

  i = 1
  do while (i < 11)
     print *, i
     i = i + 1
  end do
```

* exit == break, cycle == continue

* nested loops control with tags:
```
  outer_loop: do i = 1, 10
     inner_loop: do j = 1, 10
        if ((j + i) > 10) then  ! print only pairs of i and j that sum to 10
           cycle outer_loop  ! go to the next iteration of the outer loop
        end if
        print *, "I=", i, ' J=', j, " Sum=", j + i
     end do inner_loop
  end do outer_loop
```
* parallelizable loop - `do concurrent`, specifies the inside of the loop
  has no interdependencies, so compiler can use paralleization / SIMD.
  not a basic feature of fortran.
```
  real, parameter :: pi = 3.14159
  integer, parameter :: n = 10
  real :: result_sin(n)

  do concurrent (i = 1 : n)  ! syntax is slightly different
     result_sin(i) = sin(i * pi / 4.)
  end do
```

### Code structure

* two forms of procedure
    - subroutine - invoked by `call`
    - function - invoked within an expression or assignment
* subroutines and functions have access to varibles in the parent scope
  by _argumnt association_
    - unless VALUE attribute is sepcified, which is similar to call by reference

```
  subroutine printMatrix(n, m, A)
    implicit none
    integer, intent(in) :: n
    integer, intent(in) :: m
    real, intent(in) :: A(n, m)
```
* intent is for the dummy arguments.
    - intent(in) - read only
    - intent(out) - write only
    - intent(inout) - read-write
* it's good practice to always specify the intent
* `call printMatrix(10, 20, matrix)`
* the above style (passing in the width/height) is called _explicit-shape_.
  "this will not be necessary if we place our subroutine in a module as
  described later"
* sample function

```
function vectorNorm(n, vec) result(norm)
  implicit none
  integer, intent(in) :: n
  real, intent(in) :: vec(n)
  real :: norm

  norm = sqrt(sum(vec ** 2))
end function vectorNorm
```
* good practice for functions to not modify their arguments. Keep it pure

### Modules

* modules contain definitions that are made accessible to programs, procedures
  and other modules via `use` statement.
    - can contain data objects, type definitons, procedures, and interfaces
    - "allow controlled scoping extension whereby entity access is made explicit"
    - modules automatically generate explicit interfaces required for modern procedures
    - "recommended to alwalys place functions and subroutines w/in modules
* here's a whole one
```
module myMod
  implicit none

  private    ! all entites are module-private by default
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
```
* notice we don't have to explicitly pass the matrix dimensions, instead
  can take advantage of _assumed-shape arguments_ since the module will generate
  the required explicit interface for us.  Much nicer itnerface.
* importing whole module: `use myMod`
* import only pieces: `use myMod, only: publicVar` (can have multiple)
* rename on import: `use myMod, only: printMat => printMatrix`
* "each module should be written in a seperate .f90 sourec file, and should
  be compiled prior to program units that `use` them.

### Derived Types

a.k.a. structures

* use `%` to access members
* Defining, declaring, using

```
  type :: t_pair
     integer :: i
     real :: x
  end type t_pair

  type(t_pair) :: pair

  pair%i = 1
  pair%x = 0.5
```

* Various initialization flavors
```
  pair = t_pair(1, 0.5)  ! positional arguments
  pair = t_pair(i = 1, x = 0.5)  ! keyword arguments
  pair = t_pair(x = 0.5, i = 1)   ! can go in any order
```

* can also have defult values
```
  type :: t_pair
     integer :: i = 1
     real :: x = 0.5
  end type t_pair
```
* which gives us all syntax
```
type [,attribute-list] :: name [(parameterized-declaration-list)]
    [parameterized-definition-statements]
    [private statement or sequence statement]
    [member-variables]
    contains
        [type-bound-procedures]
end type
```

* Attribute list
  - access type `public` or `private`
  - `bind(c)` for C interop
  - `extends(parent)` inheritance (!)
  - `abstract` - OOP feature covered in Advanced Programming Tutorial
  - if bind(c) or `statement: sequence` is used, cannot have attribute: extends
* sequence attribute to declare members should be accessed in same order
  as defined on the type
    - sequence implies the dat types are neither `allocatable` or `pointer` type
    - does not imply these data types will be stored in memory in any particular
       form, no relation to `contiguous` attribute
```
  type :: tPair2
     sequence
     integer :: i
     real :: x
  end type tPair2
  type(tPair2) :: pair2
  pair2 = tPair2(1, 0.5)
```
* public and private, declare that member-variables declared afterward will
  be assgned the attribute
* bind(c) for compatibility with C struct.
```
module fToC
  use iso_c_binding, only: c_int
  implicit none

  type, bind(c) :: f_type
     integer(c_int) :: i
  end type
```
* bind(c) cannot have sequence or extends, nor contain any fortran pointer
  or allocatable types.

* paramterzied declaration list stuff

stopped part-way through "Derived types"

<<<<<<< HEAD
* emacs f90-smart-end to no-blink
=======
## Modern Fortran work-through
>>>>>>> 94b4868 (checkpoint)

### (setup) Open MPI and CoArrays

* Modern Fortran - https://learning.oreilly.com/library/view/modern-fortran
* installed via homebrew - `brew install open-mpi`
* mpif90 --version
* brew install opencoarrays
* `caf array_copy_caf.f90 -o array_copy_caf`
* `cafrun -n 2 array_copy_caf`

* emacs f90-smart-end to no-blink

### Notes

* `parameter` for constants : `integer, parameter :: grid_size`
* Array properties
  - contiguous
  - multi-dimensional (up to 15 dimensions)
  - static or dynamic - set at compile tome, or runtime-dimensions
  - whole-array math - use arithmetic operators and functions on arrays too
  - column-major indexing - like matlab or R (unlike C/Pythong), so left-most index
    varies fastest.  Keep in mind when looping

* these are the same:
```
  real, dimension(grid_size) :: h
  real :: h(grid_size)
```

* allocatable arrays - only specify the rank (number of dimensions), not the size of dimensions
  Once size is known, `allocate` allocates the array. (c.f. chapter 5)
* `stop` to halt and catch fire
```
  if (dt <= 0) stop 'time step dt must be > 0'

./tsunami
STOP time step dt must be > 0
```

* `do` loop if start == end, it will execute once 
* loops can be named
```
outer_loop: do j = 1, jm
  inner_loop: do i = 1, im
    blah
  end do inner_loop
end do outer_loop
```

* can exit a specific label - `exit outer_loop`
* `do concurrent` exists
* typical operator precendence.  For equal precedence, left to right