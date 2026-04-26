#!/usr/bin/env bash
# Agent model assignments — source this before launching opencode
# Usage: source ~/.config/opencode/set_models.sh

# Prefix all models with opencode-go/
export PLANNER_MODEL="opencode-go/mimo-v2.5-pro"
export AUTOMATION_MODEL="opencode-go/qwen3.6-plus"
export WRITER_MODEL="opencode-go/deepseek-v4-flash"
export REVIEWER_STRUCTURE_MODEL="opencode-go/deepseek-v4-pro"
export REVIEWER_DETAIL_MODEL="opencode-go/mimo-v2.5"
export COPYEDITOR_MODEL="opencode-go/qwen3.6-plus"
export EDITOR_MODEL="opencode-go/kimi-k2.6"
export GUARD_MODEL="opencode-go/deepseek-v4-flash"
export LITERATURE_REVIEWER_MODEL="opencode-go/deepseek-v4-flash"
export DEEP_RESEARCH_MODEL="opencode-go/deepseek-v4-pro"
export R_ANALYSIS_MODEL="opencode-go/qwen3.6-plus"

# Temperatures
export PLANNER_TEMP="0.1"
export AUTOMATION_TEMP="0.3"
export WRITER_TEMP="0.8"
export REVIEWER_DETAIL_TEMP="0.3"
export COPYEDITOR_TEMP="0.4"
export EDITOR_TEMP="0.3"
export GUARD_TEMP="0.2"
export LITERATURE_REVIEWER_TEMP="0.3"
export R_ANALYSIS_TEMP="0.2"

# DeepSeek thinking mode ignores temperature entirely, so these have no effect.
# export REVIEWER_STRUCTURE_TEMP="0.3"
# export DEEP_RESEARCH_TEMP="0.3"
