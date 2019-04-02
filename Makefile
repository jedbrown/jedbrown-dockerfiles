mpich:
	docker build -t jedbrown/mpich mpich

petsc:
	docker build -t jedbrown/petsc petsc

petsc-root:
	docker build -t jedbrown/petsc-root petsc-root

fenics:
	docker build -t jedbrown/fenics fenics

push:
	docker push jedbrown/mpich jedbrown/petsc jedbrown/petsc-root jedbrown/fenics

.PHONY: mpich petsc petsc-root fenics push
