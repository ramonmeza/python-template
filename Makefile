#!/bin/bash
SHELL := /bin/bash


# folders
DATA=data
ENV=.env
SRC=src
TESTS=tests

TEST_DATA=${TESTS}/data

PROJECT_NAME=project
PROJECT_SRC=${SRC}/${PROJECT_NAME}
PROJECT_TEST=${TESTS}/${PROJECT_NAME}
PROJECT_TEST_FEATURES=${PROJECT_TEST}/features


# commands
ACTIVATE_ENV_CMD=source ${ENV}/bin/activate
CREATE_ENV_CMD=python3 -m venv ${ENV}
INSTALL_DEPS_CMD=pip3 install -r requirements.txt

REMOVE_PY_OBJS_CMD=python3 -Bc "import pathlib; [p.unlink() for p in pathlib.Path('.').rglob('*.py[co]')]"
REMOVE_PYCACHE_CMD=python3 -Bc "import pathlib; [p.rmdir() for p in pathlib.Path('.').rglob('__pycache__')]"

ANALYZE_CMD=python3 -m flake8
TEST_CMD=python3 -m behave


# targets
.PHONY: init analyze tests clean

init:
	${CREATE_ENV_CMD}
	( \
		${ACTIVATE_ENV_CMD}; \
		${INSTALL_DEPS_CMD}; \
	)

analyze:
	( \
		${ACTIVATE_ENV_CMD}; \
		${ANALYZE_CMD} ${SRC}; \
		${ANALYZE_CMD} ${TESTS}; \
	)

tests:
	( \
		${ACTIVATE_ENV_CMD}; \
		${TEST_CMD} ${PROJECT_TEST_FEATURES}; \
	)

clean:
	rm -rf ${ENV}
	${REMOVE_PY_OBJS_CMD}
	${REMOVE_PYCACHE_CMD}
