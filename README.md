# python-template

A template for creating Python projects. Incorporates Github Actions to analyze code with [Flake8](https://github.com/PyCQA/flake8) and to run tests with [behave](https://github.com/behave/behave).


## Prerequisites

* `make`
* `Python 3.10`
* `venv` from `pip`
* uh...
* that's it, just make and python, then just run the make commands, oops. spoilers. anyways tl;dr.

## Usage

Follow these steps after pressing the "Use this template" button from [Github](https://github.com/ramonmeza/python-template) and cloning the repository locally.


### Renaming the project

The first thing you should do when creating a repo from this template is to run the `rename` target in [Makefile](Makefile). `rename` requires you to pass the `PROJECT_NAME` variable to it, which specifies the name of your project.

```sh
make rename PROJECT_NAME=my_project
```


### Initializing your local environment

After renaming the project, you may want to setup your virtual environment. This is done with the `init` target, which will initialize a virtual python environment with `venv`, named `.env` by default. This will also install the pip dependencies specified in [requirements.txt](requirements.txt).

```sh
make init
```


### Linting the code with Flake8

It's as simple as running the `lint` target. This will use [Flake8](https://github.com/PyCQA/flake8) to analyze the `src` and `tests` directories.

```sh
make lint
```


### Analyzing the code with Flake8

Run the `analyze` target. This will use [mypy](https://github.com/python/mypy) to analyze the `src` and `tests` directories.

```sh
make analyze
```


### Running `behave` tests

Use the `tests` target to run the [behave](https://github.com/behave/behave) tests. This will automatically pass the project's `features` into `behave` to test. The only tests ran explicitly with this template are located at `tests/<your_project_name>/features`

```sh
make tests
```


### Cleaning your environment

Stanard `clean` target is included to remove the following:

* virtual environment folder
* `__pycache__` directories
* `*.pyc` and `*.pyo` files

```sh
make clean
```


## That's all...

*folks...*
