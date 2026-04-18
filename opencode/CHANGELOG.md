# Changelog
All notable changes to the OpenCode Manuscript Workflow will be documented in this file.

## [Unreleased]
### Added
- Placeholder for upcoming changes

## [2026-04-18] - Major Manuscript Workflow Refactor
### Added
- New section-based skills: intro, lit-review, methods, results, discussion, manuscript-workflow
- Specialized reviewer agents: reviewer-structure, reviewer-detail, copyeditor  
- opencode-snippets plugin integration with synthetic examples
- Streamlined AGENTS.md (~100 lines) and STYLE.md (~80 lines)
- tui.json for snippets plugin UI configuration

### Changed
- Replaced empirical-paper and theoretical-paper skills with section-specific skills
- Updated writer agent with primary model: ollama-cloud/gemma-2-9b
- Optimized reviewer model assignments for family diversity:
  * Reviewer-structure: qwen/qwen2.5-7b-instruct (Qwen family)
  * Reviewer-detail: microsoft/phi-3-mini-128k-instruct (Phi family)  
  * Copyeditor: mistral/mistral-7b-instruct (Mistral family)
- Updated agent permissions and configurations
- Enhanced workflow documentation and routing logic

### Removed
- Old empirical-paper/ and theoretical-paper/ skill directories
- Legacy reviewer.md agent file
- Separate example files for skills (replaced with synthetic snippets)

## [2026-04-16] - Initial Setup
### Added
- Core agent definitions: planner, automation, writer, guard, literature-review, deep-research, r-analysis
- Generic reviewer agent
- Empirical-paper and theoretical-paper skills
- STYLE.md and AGENTS.md documentation
- Basic opencode.json configuration
