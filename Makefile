mpich:
	docker build -t jedbrown/mpich mpich

petsc:
	docker build -t jedbrown/petsc:master petsc

petsc-root:
	docker build -t jedbrown/petsc-root:master petsc-root

fenics:
	docker build -t jedbrown/fenics fenics

push:
	docker push jedbrown/mpich jedbrown/petsc:master jedbrown/petsc-root:master jedbrown/fenics

.PHONY: mpich petsc petsc-root fenics push
