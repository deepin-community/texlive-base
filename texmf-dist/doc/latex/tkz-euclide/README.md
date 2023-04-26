# tkz-euclide — for euclidean geometry

Release 4.25c 2022/09/23

## Description

`tkz-euclide` is a package (latex) which allows you to draw  two-dimensional
geometric figures, in other words to create figures of Euclidean geometry.
It uses a Cartesian coordinate system orthogonormal (unit 1cm) 
 as well as tools to define the unique coordinates of points and to
manipulate them. The idea is to allow you to follow step by step a construction
that would be done by hand as naturally as possible.

## Licence

This package may be modified and distributed under the terms and
conditions of the [LaTeX Project Public License](https://www.latex-project.org/lppl/), version 1.3 or greater.


## Requirements

The package compiles with utf8, pdflatex and lualatex, loads and depends on updated versions of:
- [xfp](https://ctan.org/pkg/xfp)
- [tikz](https://ctan.org/pkg/tikz)

## Installation

The package `tkz-euclide` is present in TeXLive and MiKTeX, use the package
manager to install.

You can experiment with the `tkz-euclide` package by placing all of the
distribution files in the directory containing your current tex file.

The different files must be moved into the different directories in your
installation `TDS` tree or in your `TEXMFHOME`:


## How to use it

To use the package `tkz-euclide`, place the following lines in the preamble of
your LaTeX document:

```
\usepackage{tkz-euclide}
\begin{document}
\begin{tikzpicture}
    your code
\end{tikzpicture}
```

The line `\usetkzobj{all}` is no longer required with `tkz-euclide` but you can use it with
other packages.

If you use the `xcolor` package, load that package before `tkz-euclide` to avoid
package conflicts.

## Documentation

Documentation for `tkz-euclide` is available on `CTAN`. 

## Examples

All  examples given in documentation will be stored on my site : [http://altermundus.fr](http://altermundus.fr) as standalone
files, ready for compilation. 

Other examples, in French, are on my site.


## History
- 4.25c. Remove \input{tkz-obj-eu-draw-triangles.tex} from the list of files to load.

- 4.24c. Correction of a bug in the macro `\tkzMarkAngle`;    
         Modification of the macro `\tkzDefCircle[apollonius]`;  
          
         
- 4.23c. Correction of a bug in the macro `\tkzDrawSemiCircle`,
         Modification of `\tkzDefRadicalAxis`,
         Remove old codes,
         Correction of  the documentation;
- 4.22c. Correction of a bug in the macro `\tkzMarkAngle`;  
         Correction of  the documentation:  
         Remove options R, diameter of the macro `\tkzDrawCircle`. To draw a circle you must use two points: the center and a point of the circle.                  
        `\tkzDefPointOnCircle` :
         forgotten "in rad" in the documentation. 
         
Complement in the documentation for the macro `\tkzDefCircle[R](....)`. You can use either  `\tkzGetPoints{o}{x}` or either `\tkzGetPoints{x}`.

- 4.21c the package archive was corrupted, all the "|" disappeared ...

- 4.2c. 

  Now `\tkzDefCircle` gives two points as results: the center of the circle and a point of the circle. When a point of the circle is known, it is enough to use  `\tkzGetPoint`  or  `\tkzGetFirstPoint` 
 to get the center, otherwise  `\tkzGetPoints`  will give you the center and a point of the circle. You can always get the length of the radius with  `\tkzGetLength` . I wanted to favor working with nodes and banish the appearance of numbers in the code.
  
   In order to isolate the definitions, I deleted or modified certain macros which are:  `\tkzDrawLine` ,  `\tkzDrawTriangle` ,  `\tkzDrawCircle` ,  `\tkzDrawSemiCircle`  and   `\tkzDrawRectangle` ;
  
  Thus  `\tkzDrawSquare(A,B)`  becomes  `\tkzDefSquare(A,B)`  `\tkzGetPoints{C}{D}`  then

   `\tkzDrawPolygon(A,B,C,D)` ;

  
  
 If you want to draw a circle, you can't do so  \tkzDrawCircle[R](A,1) . First you have to define the point through which the circle passes, so you have to do 
  `\tkzDefCircle[R](A,1)`   `\tkzGetPoint{a}`  and finally  `\tkzDrawCircle(A,a)` . Another possibilty is to define a point on the circle  `\tkzDefShiftPoint[A](1,O){a}` ;  
  

  The following macros   `\tkzDefCircleBy[orthogonal through]`  and  `\tkzDefCircleBy[orthogonal from]`  become `\tkzDefCircle[orthogonal through]`  and  `\tkzDefCircle[orthogonal from]`  ;  

  
   `\tkzDefLine[euler](A,B,C)`  is a macro that allows you to obtain the line of `Euler` when possible.  `\tkzDefLine[altitude](A,B,C)`  is possible again, as well as  `\tkzDefLine[tangent at=A](O)`  and  `\tkzDefLine[tangent from=P](O,A)`  which did not works;  


    `\tkzDefTangent`  is replaced by  \tkzDelLine[tangent from = ...]  or  \tkzDelLine[tangent at = ...] 


  I added the macro  `\tkzPicAngle[tikz options](A,B,C)`  for those who prefer to use  TIKZ.

  
 The order of the arguments of the macro `\tkzDefPointOnCircle` has changed: now it is center, angle and point or radius.
 I have added two options for working with radians which are `through in rad` and `R in rad`.


  I added the option `reverse` to the arcs paths. This allows to reverse the path and to reverse if necessary the arrows that would be present.


  I have unified the styles for the labels. There is now only `label style` left which is valid for points, segments, lines, circles and angles. I have deleted `label seg style``{label line style` and `label angle style`

  I added the macro  `\tkzFillAngles`  to use several angles.

  Correction option `return` with `tkzProtractor`

 As a reminder, the following changes have been made previously:
  
     `\tkzDrawMedian` ,  `\tkzDrawBisector` ,  `\tkzDrawAltitude` ,  `\tkzDrawMedians` ,  \tkzDrawBisectors  et   \tkzDrawAltitudes  do not exist anymore. The creation and drawing separation is not respected so it is preferable to first create the coordinates of these points with  \tkzDefSpcTriangle[median]  and then to choose the ones you are going to draw with  \tkzDrawSegments  or  \tkzDrawLines ;
 
   `\tkzDrawTriangle`  has been deleted.   `\tkzDrawTriangle[equilateral]`  was handy but it is better to get the third point with  `\tkzDefTriangle[equilateral]`  and then draw with  `\tkzDrawPolygon` ; idem for  `\tkzDrawSquare`  and  `\tkzDrawGoldRectangle` ; 


  The circle inversion was badly defined so I rewrote the macro. The input arguments are always the center and a point of the circle, the output arguments are the center of the image circle and a point of the image circle or two points of the image line if the antecedent circle passes through the pole of the inversion. If the circle passes the inversion center, the image is a straight line, the validity of the procedure depends on the choice of the point on the antecedent circle; 

  Correct allocation for gold sublime and euclide triangles;


  I added the option " next to" for the intersections LC and CC;


  Correction option isoceles right;


   `\tkzDefMidArc(O,A,B)`  gives the middle of the arc center $O$ from $A$ to $B$; 

  Good news : Some useful tools have been added. They are present on an experimental basis and will undoubtedly need to be improved;


  The options "orthogonal from and through" depend now of `tkzDefCircleBy`

  
    `\tkzDotProduct(A,B,C)`  computes the scalar product in an orthogonal reference system of the vectors $\overrightarrow{A,B}$ and $\overrightarrow{A,C}$. 
  
    `\tkzDotProduct(A,B,C)=aa'+bb' if vec{AB} =(a,b) and vec{AC} =(a',b')` 
  
  
    `\tkzPowerCircle(A)(B,C)`  power of point $A$ with respect to the circle of center $B$ passing through $C$;
  
  
    `\tkzDefRadicalAxis(A,B)(C,D)`  Radical axis of two circles of center $A$ and $C$;
  
  
   Some tests :  `\tkzIsOrtho(A,B,C)`  and  `\tkzIsLinear(A,B,C)`  The first indicates whether the lines AB and AC are orthogonal. The second indicates whether the points $A$, $B$ and $C$ are aligned;

   `\tkzIsLinear(A,B,C)`  if A, B, C are aligned then  \tkzLineartrue 
   you can use  `\iftkzLinear`  (idem for  `\tkzIsOrtho` );

  A style for vectors has been added that you can of course modify
  `\tikzset{vector style/.style={>=Latex,->}}` ;


  Now it's possible to add an arrow on a line or a circle with the option  tkz arrow . 


- 4.05b 
      `\tkzInterLC` new option  near  new method to choice the points
      `\tkzInterCC`  new method to choice the points
      `\tkzDefTangent` add method to choice the points
      `\tkzTestInterLC`  and `\iftkzFlagLC`
      `\tkzTestInterLC` and  `\iftkzFlagCC`
      
      `\tkzDefHarmonic` option ext int both then node or R
     ` \tkzDefGoldenRatio` new macro
      `\tkzSwapPoints`  Exchange two points
      `\tkzPermute ` Permutation of two points of a triangle
      `\tkzDefPointsBy` option rotation with nodes no need to know the angle
     ` \tkzMarkArc` and `\tkzLabelArc`
      
      `\tkzDefPointOnCircle[angle=30,center=K1,radius=\rAp]` becomes  
      `\tkzDefPointOnCircle[R= angle 30 center K1 radius \rAp]`
      
      Added  `\tkzDefPointOnCircle[through= angle 30 center K1 point \rAp]`   
      Added some styles to place arrow "tkz arrow" and "tkz arrows" 
      Added " line cap =round" and "line join =round" to all the constructions
      Added information about angles in the documentation
- 4.03 Adaptation of the code and documentation to the changes of the macros for the intersections.
- 4.02
  Major changes for the macros concerning the intersection of a line and a circle or two circles. If one point of the intersection is known then you can use the "common" option and indicate what the common point is. The second point is given in `tkzFirstPointResult`.
  In other cases, for the intersection of two circles the determined points form angles with the centers of the circles. One of the angles measures less than 180 degrees and the other more than 180. The smaller one determines `tkzFirstPointResult`.
 For the intersection of a line and a circle, the method is the same except that the angle is formed by a point on the line and the center of the circle.

- 4.01 
 `\tkzDefOrthogonalCircle` was defined twice so I deleted the version in   tkz-obj-eu-circles-by

 In the tkz-obj-eu-draw-lines.tex   new code for add dim from muzimuzhi Z.
 The code comes from an answer on the site tex.stackexchange.com

 In the file tkz-obj-eu-draw-triangles.tex added options 
  pythagoras and egyptian equivalent to pythagore
  euclid  equivalent to euclide
  two one equivalent to  half
	
 Added option "swap" useful with golden, gold,  school, half, pythagoras

  In the file tkz-obj-eu-circles  correction of bug in `\tkzDefOrthoThroughCircle` : `\tkz@@CalcLength`  has been replaced by 	 `\tkz@@CalcLengthcm `
 	
  Addition of the macro `\tkzDefGoldenRatio` in tkz-obj-eu-points-spc. It allows to split a segment with a ratio equal to the golden ratio

 Minor corrections of the documentation. New  examples about option "dim"
      

- 4.00 correction of bugs, tkz-euclide no longer depends on tkz-base. The unit is "cm". 
       The bounding box is controlled. The documentation has been restructured according to the rule:
        set, calculate, draw, mark and fill, label.
- 3.06 correction of bugs, amelioration of the documentation. 
- 3.05 correction of bugs, amelioration of the documentation.
- 3.02 replacement french documentation by english documentation, correction of bugs.
- 3.01 replacement `fp` for `xfp`, addition of some macros, correction of bugs
- 1.16 correction of bugs
- 1.13 first version

## Author

Alain Matthes, 5 rue de Valence, Paris 75005, al (dot) ma (at) mac (dot) com
