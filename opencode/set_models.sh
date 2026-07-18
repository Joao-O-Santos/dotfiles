#!/usr/bin/env bash
# Agent model assignments — source this before launching opencode
# Usage: source ~/.config/opencode/set_models.sh

# # ChatGPT Plus tiers: Luna = economy, Terra = balanced, Sol = premium.
: "${OPENAI_ECONOMY_MODEL:=openai/gpt-5.6-luna}"
: "${OPENAI_BALANCED_MODEL:=openai/gpt-5.6-terra}"
: "${OPENAI_PREMIUM_MODEL:=openai/gpt-5.6-sol}"
: "${OPENAI_CODE_MODEL:=openai/gpt-5.3-codex-spark}"

# Balanced: core manuscript judgment and complex synthesis.
export PLANNER_MODEL="$OPENAI_BALANCED_MODEL"
export WRITER_MODEL="$OPENAI_BALANCED_MODEL"
export REVIEWER_STRUCTURE_MODEL="$OPENAI_BALANCED_MODEL"
export DEEP_RESEARCH_MODEL="$OPENAI_BALANCED_MODEL"

# Economy: routine, high-volume, or downstream-checked work.
export AUTOMATION_MODEL="$OPENAI_ECONOMY_MODEL"
export REVIEWER_DETAIL_MODEL="$OPENAI_ECONOMY_MODEL"
export COPYEDITOR_MODEL="$OPENAI_ECONOMY_MODEL"
export EDITOR_MODEL="$OPENAI_ECONOMY_MODEL"
export LITERATURE_REVIEWER_MODEL="$OPENAI_ECONOMY_MODEL"

# Premium: rare, checkpoint-gated adversarial judgment.
export REVIEWER_STRUCTURE_2_MODEL="$OPENAI_PREMIUM_MODEL"
export STRATEGIST_MODEL="$OPENAI_PREMIUM_MODEL"

# Code-specialized.
export R_CODER_MODEL="$OPENAI_CODE_MODEL"
