#############################################################
# Generic Makefile for C/C++ Program
#
# License: GPL (General Public License)
# Author:  	whyglinux <whyglinux AT gmail DOT com>
#	  	   	schips    <schips AT dingtalk DOT com>
#
# Date:    	2006/03/04 (version 0.1)@whyglinux
#	 	   	2007/03/24 (version 0.2)@whyglinux
#	 	   	2007/04/09 (version 0.3)@whyglinux
#	 	   	2007/06/26 (version 0.4)@whyglinux
#	 	   	2008/04/05 (version 0.5)@whyglinux
#	 	   	..
#	 	   	2020/02/25 (version 1.0)@schips : More powerful search, add cross complie
#	 	   	2020/03/24 (version 1.1)@schips : Disable making dependencies
#	 	   	2020/08/14 (version 1.2)@schips : Enable dependencies and hide them
#	 	   	2020/08/22 (version 1.3)@schips : Enable make lib for .so, .a
#	 	   	2020/08/26 (version 1.4)@schips : Add color for UI
#
# Description:
# ------------
# This is an easily customizable makefile template. The purpose is to
# provide an instant building environment for C/C++ programs.
#
# It searches all the C/C++ source files in the specified directories,
# makes dependencies, compiles and links to form an executable.
#
# For GNU make
#
# Usage:
# ------
# 1. Copy the Makefile to your program directory.
# 2. Customize in the "Customizable Section" only if necessary:
# 		* TYPE 'DIY' TO LOCATE THE POSITION WHERE YOU CAN CUSTOMIZE
#       * to search sources/header in more directories, set to <SRCDIRS>, <INCDIRS>
#       * to specify your program name, set to <PROGRAM>
# 3. Type `make` to build your program.
# 		* `make help` for more details.

##========================================================================##
## Customizable Section: adapt those variables to suit your program.      ##
##========================================================================##

##==========================DIY=START=====================================##
#include ../Makefile.param
#include $(PWD)/../$(OSTYPE).mak

# The type of the result, can be "so" for .so, "a" for .a .
# or empty(Default for executable file)
TYPE=

# STRIP can help smaller volume. But elf can't not be debug as lost symbols.
CONFIG_STRIP=yes

# DEPEND can help track head files. But it may alse cause errors when file-renamed
CONFIG_DEP=no

# The output file name.
# If not specified, for difference TYPE, result will be 
#   (Default): current directory name(or 'a.out'), eg : xx or a.out
#         so : current directory name,             eg : libxx.so
#          a : current directory name,             eg : libxx.a
PROGRAM   ?= sample_custom

# The pre-processor and compiler options.
# For c/c++ (All)
CUSTDEFINE=-fPIE -pie -s -Wall -fsigned-char -DOT_RELEASE -DVER_X=1 -DVER_Y=0 -DVER_Z=0 -DVER_P=0 -DVER_B=10 -DUSER_BIT_64 -DKERNEL_BIT_64 -Wno-date-time
SENSOR_DEFILE=-DSENSOR0_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DSENSOR1_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DSENSOR2_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DSENSOR3_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DOT_ACODEC_TYPE_HDMI -DOT_ACODEC_TYPE_INNER -DOT_VQE_USE_STATIC_MODULE_REGISTER -DOT_AAC_USE_STATIC_MODULE_REGISTER -DOT_AAC_HAVE_SBR_LIB

SDK=$(PWD)/sdk
VENDOR=$(PWD)/vendor
ALLFLAGS  = 
# Just for c   compiler
CFLAGS    = -Wall -g -Dss928v100 -DOT_XXXX -lpthread -lm -ldl -DISP_V2 -lstdc++ -Wall -fsigned-char -mcpu=cortex-a53 -fno-aggressive-loop-optimizations -ldl -ffunction-sections -fdata-sections -O2 -fstack-protector-strong -fPIC -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE  -fPIE -pie -s -Wall -fsigned-char -DOT_RELEASE -DVER_X=1 -DVER_Y=0 -DVER_Z=0 -DVER_P=0 -DVER_B=10 -DUSER_BIT_64 -DKERNEL_BIT_64 -Wno-date-time -DSENSOR0_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DSENSOR1_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DSENSOR2_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DSENSOR3_TYPE=OV_OS08A20_MIPI_8M_30FPS_12BIT -DOT_ACODEC_TYPE_HDMI -DOT_ACODEC_TYPE_INNER -DOT_VQE_USE_STATIC_MODULE_REGISTER -DOT_AAC_USE_STATIC_MODULE_REGISTER -DOT_AAC_HAVE_SBR_LIB $(SENSOR_DEFILE) $(LONG_LIB_FLAGS) $(CUSTDEFINE)
# Just for cpp compiler(man cpp for more).
CXXFLAGS  = 

# The options used in linking as well as in any direct use of ld.
LDFLAGS   = -lss_mpi -lss_ae -lss_isp -lot_isp -lss_awb -lss_dehaze -lss_extend_stats -lss_drc -lss_ldci -lss_crb -lss_bnr -lss_calcflicker -lss_ir_auto -lss_acs -lss_acs -lsns_os08a20 -lsns_os05a10_2l_slave -lsns_imx347_slave -lsns_imx485 -lsns_os04a10 -lsns_os08b10 -lss_hdmi -fno-common -mcpu=cortex-a53 -fno-aggressive-loop-optimizations -Wl,-z,relro -Wl,-z,noexecstack -Wl,-z,now,-s -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -ldl -rdynamic  -lss_voice_engine -lss_upvqe -lss_dnvqe -laac_comm -laac_enc -laac_dec -laac_sbr_enc -laac_sbr_dec -lvqe_res -lvqe_record -lvqe_hpf -lvqe_anr -lvqe_aec -lvqe_agc -lvqe_eq -lvqe_talkv2 -lvqe_wnr -laac_dec -laac_enc -laac_comm -laac_sbr_dec -laac_sbr_enc  -lsecurec

# For cross complie, as same as gcc if not specified.
CROSS_COMPILE ?= aarch64-mix210-linux-
#CROSS_COMPILE=arm-linux-

# The directories in which source/include/library files reside.
# If not specified, Makefile will:
#   for SRCDIRS, INCDIRS : search current directory recursively
SRCDIRS   = . common
INCDIRS   = . common $(SDK)/include $(VENDOR)/es8388 $(VENDOR)/lt8618sx common/audio/adp
#   for LIBDIR : only the current directory will be serached.
LIBDIR    = $(SDK)/lib

# The list of the libs' name used in project.
LIBS = pthread m dl ss_voice_engine

##==========================DIY=END=======================================##

##========================================================================##
## Implicit Section: change the following only when necessary.            ##
##========================================================================##

# The source file types (headers excluded).
# .c indicates C source files, and others C++ ones.
SRCEXTS = .c .C .cc .cpp .CPP .c++ .cxx .cp

# The header file types.
HDREXTS = .h .H .hh .hpp .HPP .h++ .hxx .hp

# Compatible cross complie
CC     = $(CROSS_COMPILE)gcc
CXX    = $(CROSS_COMPILE)g++
AR     = $(CROSS_COMPILE)ar
LD     = $(CROSS_COMPILE)ld
AS     = $(CROSS_COMPILE)as
STRIP  = $(CROSS_COMPILE)strip
OBJCOPY= $(CROSS_COMPILE)objcopy

# The command used to delete file.
#RM     = rm -f

ETAGS = etags
ETAGSFLAGS =

CTAGS = ctags
CTAGSFLAGS =


##========================================================================##
## Stable Section: usually no need to be changed. But you can add more.   ##
##========================================================================##
SHELL   = /bin/sh
EMPTY   =
SPACE   = $(EMPTY) $(EMPTY)
ifeq ($(PROGRAM),)
  CUR_PATH_NAMES = $(subst /,$(SPACE),$(subst $(SPACE),_,$(CURDIR)))
  PROGRAM = $(word $(words $(CUR_PATH_NAMES)),$(CUR_PATH_NAMES))
  ifeq ($(PROGRAM),)
	PROGRAM = a.out
  endif
endif

ifneq ($(TYPE),)
PROGRAM  = lib$(word $(words $(CUR_PATH_NAMES)),$(CUR_PATH_NAMES)).$(TYPE)
endif

ifeq ($(SRCDIRS),)
	SRCDIRS:=$(shell find . -type d)
endif

ifeq ($(INCDIRS),)
	INCDIRS:=$(shell find . -type d)
endif

ifeq ($(LIBDIR),)
	LIBDIR=.
endif

INC_P    = -I
LIBD_P   = -L
LIB_P    = -l

CFLAGS   += $(addprefix $(INC_P), $(INCDIRS))
ifeq ("$(TYPE)","so")
ALLFLAGS   += -fPIC
endif

CXXFLAGS += $(addprefix $(INC_P), $(INCDIRS))

ALLLIBS  += $(addprefix $(LIB_P), $(LIBS))
ALLLIBS  += $(addprefix $(LIBD_P), $(LIBDIR))


SOURCES = $(foreach d,$(SRCDIRS),$(wildcard $(addprefix $(d)/*,$(SRCEXTS))))
HEADERS = $(foreach d,$(INCDIRS),$(wildcard $(addprefix $(d)/*,$(HDREXTS))))
SRC_CXX = $(filter-out %.c,$(SOURCES))
OBJS    = $(addsuffix .o, $(basename $(SOURCES)))
ifeq ("$(CONFIG_DEP)","yes")
DEPS    = $(foreach f, $(OBJS), $(addprefix $(dir $(f))., $(patsubst %.o, %.d, $(notdir $(f)))))
endif

## Define some useful variables.
#DEP_OPT = $(shell if `$(CC) --version | grep -i "GCC" >/dev/null`; then \ 
DEP_OPT = $(shell if `gcc --version | grep -i "GCC" >/dev/null`; then \
                  echo "-MM"; else echo "-M"; fi )
#DEPEND      = $(CC)  $(DEP_OPT)   $(CFLAGS) $(ALLFLAGS)
DEPEND      = gcc  $(DEP_OPT)   $(CFLAGS) $(ALLFLAGS)
DEPEND.d    = $(subst -g ,,$(DEPEND))
COMPILE.c   = $(CC)   $(CFLAGS)   $(ALLFLAGS) -c
COMPILE.cxx = $(CXX)  $(CXXFLAGS) $(ALLFLAGS) -c
LINK.c      = $(CC)   $(CFLAGS)   $(ALLFLAGS) $(LDFLAGS)
LINK.cxx    = $(CXX)  $(CXXFLAGS) $(ALLFLAGS) $(LDFLAGS)

.PHONY: all objs tags ctags clean distclean help show

# Delete the default suffixes
.SUFFIXES:

all: $(PROGRAM)

# Rules for creating dependency files (.d).
#------------------------------------------
.%.d:%.c
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

.%.d:%.C
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

.%.d:%.cc
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

.%.d:%.cpp
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

.%.d:%.CPP
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

.%.d:%.c++
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

.%.d:%.cp
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

.%.d:%.cxx
	@echo -n $(dir $<) > $@
	@$(DEPEND.d) $< >> $@

# Rules for generating object files (.o).
#----------------------------------------
objs:$(OBJS)
	@echo -e "\u276f \c "
%.o:%.c
	@echo -e "\u273f \c "
	$(COMPILE.c) $< -o $@

%.o:%.C
	@echo -e "\u273f \c "
	$(COMPILE.cxx) $< -o $@

%.o:%.cc
	@echo -e "\u273f \c "
	$(COMPILE.cxx) $< -o $@

%.o:%.cpp
	@echo -e "\u273f \c "
	$(COMPILE.cxx) $< -o $@

%.o:%.CPP
	@echo -e "\u273f \c "
	$(COMPILE.cxx) $< -o $@

%.o:%.c++
	@echo -e "\u273f \c "
	$(COMPILE.cxx) $< -o $@

%.o:%.cp
	@echo -e "\u273f \c "
	$(COMPILE.cxx) $< -o $@

%.o:%.cxx
	@echo -e "\u273f \c "
	$(COMPILE.cxx) $< -o $@

# Rules for generating the tags.
#-------------------------------------
tags: $(HEADERS) $(SOURCES)
	$(ETAGS) $(ETAGSFLAGS) $(HEADERS) $(SOURCES)

ctags: $(HEADERS) $(SOURCES)
	$(CTAGS) $(CTAGSFLAGS) $(HEADERS) $(SOURCES)

# Rules for generating the executable.
#-------------------------------------
$(PROGRAM):$(OBJS)
	@echo -e "\e[36m\u2794 \e[0m\c"
ifeq ($(SRC_CXX),)	      # C program
ifeq ("$(TYPE)","so")     ## C and so
	$(LINK.c) -shared  $(OBJS) $(ALLLIBS) -o $@
else
ifeq ("$(TYPE)","a")      ## C and a
	$(AR) rcs $@ $^
else
	$(LINK.c)   $(OBJS) $(ALLLIBS) -o $@

endif
endif
else			          # C++ program
ifeq ("$(TYPE)","so")     ## C++ and so
	$(LINK.cxx) -shared  $(OBJS) $(ALLLIBS) -o $@
else
ifeq ("$(TYPE)","a")      ## C++ and a
	$(AR) rcs $@ $^
else
	$(LINK.cxx) $(OBJS) $(ALLLIBS) -o $@
endif
endif
endif

ifeq ("$(CONFIG_STRIP)","yes")
	@$(STRIP) $@
endif

	@echo -e "\e[32m\u2713 \e[0m\c"
	@echo "Made [$@]"

ifeq ("$(CONFIG_DEP)","yes")
ifneq ($(DEPS),)
sinclude $(DEPS)
endif
endif

clean:
	@echo  -e "\e[31m\u2717 \e[0m\c"
	@$(RM) $(OBJS) $(PROGRAM) $(PROGRAM).exe
	@echo  -e "$(RM) $(OBJS) $(PROGRAM)"

distclean: clean
	@echo  -e "\e[31m\u2717 \e[0m\c"
	$(RM) $(DEPS) TAGS

# Show help.
help:
	@echo 'Generic Makefile for C/C++ Programs (gcmakefile) version 1.2'
	@echo 'Copyright (C) schips <schips@dingtalk.com>'
	@echo
	@echo 'Usage: make [TARGET]'
	@echo 'TARGETS:'
	@echo '  all       (=make) compile and link.'
	@echo '  CONFIG_DEP=yes make with generating dependencies.'
	@echo '  objs      compile only (no linking).'
	@echo '  tags      create tags for Emacs editor.'
	@echo '  ctags     create ctags for VI editor.'
	@echo '  clean     clean objects and the executable file.'
	@echo '  distclean clean objects, the executable and dependencies.'
	@echo '  show      show variables (for debug use only).'
	@echo '  help      print this message.'

# Show variables (for debug use only.)
show:
	@echo 'PROGRAM     :' $(PROGRAM)
	@echo 'SRCDIRS     :' $(SRCDIRS)
	@echo 'INCDIRS     :' $(INCDIRS)
	@echo 'SOURCES     :' $(SOURCES)
	@echo 'HEADERS     :' $(HEADERS)
	@echo 'SRC_CXX     :' $(SRC_CXX)
	@echo 'OBJS        :' $(OBJS)
	@echo 'DEPS        :' $(DEPS)
	@echo 'DEPEND      :' $(DEPEND)
	@echo 'COMPILE.c   :' $(COMPILE.c)
	@echo 'COMPILE.cxx :' $(COMPILE.cxx)
	@echo 'link.c      :' $(LINK.c)
	@echo 'link.cxx    :' $(LINK.cxx)

## End of the Makefile ##
##############################################################
