!config navigation breadcrumbs=False scrollspy=False

# Isopod class=center style=font-weight:600;font-size:350%;

### Inverse Optimization Code class=center style=font-weight:200;font-size:200%

Isopod is an application for solving inverse optimization problems using MOOSE using the MOOSE optimization module.  
Isopod uses the optimization executioner in the MOOSE optimization modeul to perform PDE constrained optimization using the PETSC TAO optimization solver.
Isopod uses the MOOSE Optimization module to solve force and and material inversion
problems.  Isopod mainly contains experimental capabilities that have not been
migrated to the MOOSE optimization module for varying reason.

!row!
!col! small=12 medium=4 large=4 icon=settings
### [Syntax](syntax/index.md) class=center style=font-weight:400;

Isopod provides capabilities that can be applied to a wide variety of problems. The syntax
provides detailed documentation of specific code features.
!col-end!
!row-end!

Isopod is based on [MOOSE](http://mooseframework.org). It is an extremely flexible environment that
permits the solution of coupled physics problems of varying size and dimensionality. These can be
solved using computer hardware appropriate for the model size, ranging from laptops and workstations
to large high performance computers.

!media media/inl_blue.png style=float:right;width:30%;margin-left:30px;

Code reliability is a central principle in code development, and this project employs a well defined
development and testing strategy.  Code changes are only merged into the repository after both a
manual code review and the automated regression test system have been completed.  The testing process
and status of Isopod is available at [www.moosebuild.inl.gov](https://moosebuild.inl.gov/repo/5/).

Isopod and MOOSE are developed by the Idaho National Laboratory by a team of computer scientists
and engineers and is supported by various funding agencies including the
[United States Department of Energy](http://energy.gov).  Development of these codes is ongoing at
INL and by collaborators throughout the world.
