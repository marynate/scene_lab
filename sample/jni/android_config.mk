# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Locations of 3rd party and FPL libraries.
FPL_ROOT:=$(SCENE_LAB_SAMPLE_DIR)/../../../libs
# If the dependencies directory exists either as a subdirectory or as the
# container of this project directory, assume the dependencies directory is
# the root directory for all libraries required by this project.
$(foreach dep_dir,$(wildcard $(SCENE_LAB_SAMPLE_DIR)/../dependencies) \
                  $(wildcard $(SCENE_LAB_SAMPLE_DIR)/../../../dependencies),\
  $(eval DEPENDENCIES_ROOT?=$(dep_dir)))
ifneq ($(DEPENDENCIES_ROOT),)
  THIRD_PARTY_ROOT:=$(DEPENDENCIES_ROOT)
  FPL_ROOT:=$(DEPENDENCIES_ROOT)
else
  THIRD_PARTY_ROOT:=$(FPL_ROOT)/../../../external
endif

SCENE_LAB_SAMPLE_GENERATED_OUTPUT_DIR := $(SCENE_LAB_SAMPLE_DIR)/gen/include

# Location of the Flatbuffers library.
DEPENDENCIES_FLATBUFFERS_DIR?=$(FPL_ROOT)/flatbuffers
# Location of the fplutil library.
DEPENDENCIES_FPLUTIL_DIR?=$(FPL_ROOT)/fplutil
# Location of the fplbase library.
DEPENDENCIES_FPLBASE_DIR?=$(FPL_ROOT)/fplbase
# Location of the googletest library.
DEPENDENCIES_GTEST_DIR?=$(FPL_ROOT)/googletest
# Location of the MathFu library.
DEPENDENCIES_MATHFU_DIR?=$(FPL_ROOT)/mathfu
# Location of the Motive library.
DEPENDENCIES_MOTIVE_DIR?=$(FPL_ROOT)/motive
# Location of the CORGI library.
DEPENDENCIES_CORGI_DIR?=$(FPL_ROOT)/corgi
# Location of the FlatUI library.
DEPENDENCIES_FLATUI_DIR?=$(FPL_ROOT)/flatui
# Location of the CORGI Component Library.
DEPENDENCIES_CORGI_COMPONENT_LIBRARY_DIR?=\
  $(DEPENDENCIES_CORGI_DIR)/component_library
# Location of the Scene Lab library.
ifneq ($(wildcard $(FPL_ROOT)/scene_lab),)
  DEPENDENCIES_SCENE_LAB_DIR?=$(FPL_ROOT)/scene_lab
else
  DEPENDENCIES_SCENE_LAB_DIR?=$(SCENE_LAB_SAMPLE_DIR)/..
endif
# Location of the breadboard library.
DEPENDENCIES_BREADBOARD_DIR?=$(FPL_ROOT)/breadboard
# Location of the breadboard module library's module collection.
DEPENDENCIES_BREADBOARD_MODULE_LIBRARY_DIR?=\
    $(DEPENDENCIES_BREADBOARD_DIR)/module_library
# Location of the Bullet Physics library.
DEPENDENCIES_BULLETPHYSICS_DIR?=$(THIRD_PARTY_ROOT)/bulletphysics

