#!/usr/bin/env bash
# Agent model assignments — source this before launching opencode
# Usage: source ~/.config/opencode/set_models.sh

# Prefix all models with opencode-go/
export PLANNER_MODEL="opencode-go/deepseek-v4-pro"
export WRITER_MODEL="opencode-go/deepseek-v4-pro"
export REVIEWER_STRUCTURE_MODEL="opencode-go/glm-5.1"
export REVIEWER_DETAIL_MODEL="opencode-go/mimo-v2.5"
export COPYEDITOR_MODEL="opencode-go/minimax-m3"
export EDITOR_MODEL="opencode-go/qwen3.7-plus"
export GUARD_MODEL="opencode-go/qwen3.7-plus"
export LITERATURE_REVIEWER_MODEL="opencode-go/deepseek-v4-pro"
export DEEP_RESEARCH_MODEL="opencode-go/glm-5.1"
export AUTOMATION_MODEL="opencode-go/minimax-m3"
export R_ANALYSIS_MODEL="opencode-go/qwen3.7-plus"
# Temperatures are set directly in opencode.json for each agent.
