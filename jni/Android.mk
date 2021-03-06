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

LOCAL_PATH := $(realpath $(call my-dir)/..)

SCENE_LAB_DIR := $(LOCAL_PATH)

# Enable mutable flatbuffer generation.
FLATBUFFERS_FLATC_ARGS:=--gen-mutable

include $(SCENE_LAB_DIR)/jni/android_config.mk
include $(DEPENDENCIES_FLATBUFFERS_DIR)/android/jni/include.mk

SCENE_LAB_GENERATED_OUTPUT_DIR := $(SCENE_LAB_DIR)/gen/include


include $(CLEAR_VARS)
LOCAL_MODULE := scene_lab
LOCAL_ARM_MODE := arm
LOCAL_STATIC_LIBRARIES := \
  corgi_component_library \
  corgi \
  fplbase \
  flatui \
  mathfu

LOCAL_EXPORT_C_INCLUDES := \
  $(SCENE_LAB_DIR)/include \
  $(SCENE_LAB_GENERATED_OUTPUT_DIR)

LOCAL_C_INCLUDES := \
  $(LOCAL_EXPORT_C_INCLUDES) \
  $(DEPENDENCIES_FLATBUFFERS_DIR)/include \
  $(DEPENDENCIES_FLATUI_DIR)/include \
  $(DEPENDENCIES_FPLBASE_DIR)/include \
  $(DEPENDENCIES_FPLUTIL_DIR)/libfplutil/include \
  $(DEPENDENCIES_MATHFU_DIR)/include \
  $(DEPENDENCIES_MOTIVE_DIR)/include \
  $(SCENE_LAB_DIR)/src

LOCAL_SRC_FILES := \
  src/basic_camera.cpp \
  src/edit_options.cpp \
  src/editor_controller.cpp \
  src/editor_gui.cpp \
  src/flatbuffer_editor.cpp \
  src/scene_lab.cpp \
  src/util.cpp

SCENE_LAB_SCHEMA_DIR := $(SCENE_LAB_DIR)/schemas
SCENE_LAB_SCHEMA_INCLUDE_DIRS := \
  $(DEPENDENCIES_FPLBASE_DIR)/schemas \
  $(DEPENDENCIES_CORGI_COMPONENT_LIBRARY_DIR)/schemas \
  $(DEPENDENCIES_MOTIVE_DIR)/schemas

SCENE_LAB_SCHEMA_FILES := \
  $(SCENE_LAB_SCHEMA_DIR)/editor_components.fbs \
  $(SCENE_LAB_SCHEMA_DIR)/flatbuffer_editor_config.fbs \
  $(SCENE_LAB_SCHEMA_DIR)/scene_lab_config.fbs

ifeq (,$(SCENE_LAB_RUN_ONCE))
SCENE_LAB_RUN_ONCE := 1
$(call flatbuffers_header_build_rules, \
  $(SCENE_LAB_SCHEMA_FILES), \
  $(SCENE_LAB_SCHEMA_DIR), \
  $(SCENE_LAB_GENERATED_OUTPUT_DIR), \
  $(SCENE_LAB_SCHEMA_INCLUDE_DIRS), \
  $(LOCAL_SRC_FILES), \
  scene_lab_generated_includes,\
  corgi_component_library_generated_includes \
  motive_generated_includes \
  fplbase_generated_includes)
endif

include $(BUILD_STATIC_LIBRARY)

$(call import-add-path,$(DEPENDENCIES_CORGI_DIR)/..)
$(call import-add-path,$(DEPENDENCIES_FLATBUFFERS_DIR)/..)
$(call import-add-path,$(DEPENDENCIES_FLATUI_DIR)/..)
$(call import-add-path,$(DEPENDENCIES_FPLBASE_DIR)/..)
$(call import-add-path,$(DEPENDENCIES_MATHFU_DIR)/..)
$(call import-add-path,$(DEPENDENCIES_MOTIVE_DIR)/..)

$(call import-module,corgi/component_library/jni)
$(call import-module,corgi/jni)
$(call import-module,flatbuffers/android/jni)
$(call import-module,flatui/jni)
$(call import-module,fplbase/jni)
$(call import-module,mathfu/jni)
$(call import-module,android/cpufeatures)
