# Changelog
All notable changes to the OpenCode Manuscript Workflow will be documented in this file.

## [Unreleased]
### Added
- Placeholder for upcoming changes

## [2026-04-19] - Manuscript Workflow Refactor (Completed)
### Added
- Four shared snippets: style-core, placeholder-discipline, anti-fabrication-short, note-on-examples
### Changed
- Replaced STYLE.md file-load instructions with #style-core snippet inclusions in intro, lit-review, abstract, discussion, methods, results, title, r-analysis-quarto skills
- Added #style-core snippet inclusion to discussion skills Rules section
- Added anti-fabrication and placeholder discipline snippets to results skill
- Added placeholder discipline and note on examples to manuscript-workflow skill
- Renamed lit-review skill directory to lit-review-section
- Renamed literature-review skill directory to finding-refs
- Renamed literature-review agent to literature-reviewer
- Updated all references in AGENTS.md, opencode.json, planner, writer, deep-research agents
- Updated skill descriptions and frontmatter to match new directory names

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
- Core agent definitions: planner, automation, writer, guard, literature-reviewer, deep-research, r-analysis
- Generic reviewer agent
- Empirical-paper and theoretical-paper skills
- STYLE.md and AGENTS.md documentation
- Basic opencode.json configuration
