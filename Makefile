#!/bin/bash
SHELL := /bin/bash


# folders
DATA=data
ENV=.env
SRC=src
TESTS=tests

TEST_DATA=${TESTS}/data

TEMPLATE_KEYWORD=template
PROJECT_NAME=new_project
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

.PHONY: rename init rename-github rename-vscode rename-src rename-tests rename-makefile rename analyze tests clean


###############################
# renaming automation targets #
###############################

rename-github:
	sed -i 's/${TEMPLATE_KEYWORD}/${PROJECT_NAME}/g' .github/workflows/${TEMPLATE_KEYWORD}.yml
	mv .github/workflows/${TEMPLATE_KEYWORD}.yml .github/workflows/${PROJECT_NAME}.yml

rename-vscode:
	sed -i 's/${TEMPLATE_KEYWORD}/${PROJECT_NAME}/g' .vscode/launch.json
	sed -i 's/${TEMPLATE_KEYWORD}/${PROJECT_NAME}/g' .vscode/settings.json

rename-src:
	mv ${SRC}/${TEMPLATE_KEYWORD} ${SRC}/${PROJECT_NAME}

rename-tests:
	sed -i 's/${TEMPLATE_KEYWORD}/${PROJECT_NAME}/g' ${TESTS}/${TEMPLATE_KEYWORD}/features/${TEMPLATE_KEYWORD}.feature
	sed -i 's/${TEMPLATE_KEYWORD}/${PROJECT_NAME}/g' ${TESTS}/${TEMPLATE_KEYWORD}/features/steps/${TEMPLATE_KEYWORD}.py

	mv ${TESTS}/${TEMPLATE_KEYWORD}/features/${TEMPLATE_KEYWORD}.feature ${TESTS}/${TEMPLATE_KEYWORD}/features/${PROJECT_NAME}.feature
	mv ${TESTS}/${TEMPLATE_KEYWORD}/features/steps/${TEMPLATE_KEYWORD}.py ${TESTS}/${TEMPLATE_KEYWORD}/features/steps/${PROJECT_NAME}.py
	mv ${TESTS}/${TEMPLATE_KEYWORD} ${TESTS}/${PROJECT_NAME}

rename-makefile:
	sed -i 's/TEMPLATE_KEYWORD=${TEMPLATE_KEYWORD}/TEMPLATE_KEYWORD=${PROJECT_NAME}/g' Makefile

rename: rename-github rename-vscode rename-src rename-tests rename-makefile
	echo Renamed from ${TEMPLATE_KEYWORD} to ${PROJECT_NAME}


##################
# public targets #
##################

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
