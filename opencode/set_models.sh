#!/usr/bin/env bash
# Agent model assignments — source this before launching opencode
# Usage: source ~/.config/opencode/set_models.sh

# Prefix all models with opencode-go/
export PLANNER_MODEL="opencode-go/deepseek-v4-pro"
export WRITER_MODEL="opencode-go/deepseek-v4-flash"
export REVIEWER_STRUCTURE_MODEL="opencode-go/deepseek-v4-flash"
export REVIEWER_DETAIL_MODEL="opencode-go/mimo-v2.5"
export COPYEDITOR_MODEL="opencode-go/mimo-v2.5"
export EDITOR_MODEL="opencode-go/mimo-v2.5"
export LITERATURE_REVIEWER_MODEL="opencode-go/mimo-v2.5"
export DEEP_RESEARCH_MODEL="opencode-go/deepseek-v4-flash"
export AUTOMATION_MODEL="opencode-go/mimo-v2.5"
export R_ANALYSIS_MODEL="opencode-go/qwen3.7-plus"
export REVIEWER_STRUCTURE_2_MODEL="opencode-go/glm-5.2"
export STRATEGIST_MODEL="opencode-go/qwen3.7-max"
# Temperatures are set in opencode.json. Model variables are consumed by opencode.json \{env:VAR\} references.
