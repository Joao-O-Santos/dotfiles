#!/usr/bin/env bash
# Agent model assignments — source this before launching opencode
# Usage: source ~/.config/opencode/set_models.sh

# Prefix all models with opencode-go/
export PLANNER_MODEL="opencode-go/mimo-v2.5-pro"
export AUTOMATION_MODEL="opencode-go/qwen3.7-plus"
export WRITER_MODEL="opencode-go/deepseek-v4-pro"
export REVIEWER_STRUCTURE_MODEL="opencode-go/glm-5.1"
export REVIEWER_DETAIL_MODEL="opencode-go/mimo-v2.5"
export COPYEDITOR_MODEL="opencode-go/qwen3.7-plus"
export EDITOR_MODEL="opencode-go/qwen3.7-plus"
export GUARD_MODEL="opencode-go/deepseek-v4-pro"
export LITERATURE_REVIEWER_MODEL="opencode-go/deepseek-v4-pro"
export DEEP_RESEARCH_MODEL="opencode-go/glm-5.1"
export R_ANALYSIS_MODEL="opencode-go/qwen3.7-plus"

# Temperatures are set directly in opencode.json for each agent.
