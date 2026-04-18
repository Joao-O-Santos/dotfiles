# OpenCode Manuscript Workflow

A specialized AI agent system designed for academic manuscript writing, revision, and optimization. This workflow employs a team of specialized agents that collaborate to help users create high-quality academic papers through structured drafting, expert review, and iterative improvement.

## Overview

The OpenCode Manuscript Workflow implements a multi-agent system where each agent has a specific role in the academic writing process:

- **Planner**: Orchestrates the workflow, decomposes tasks, and manages overall progress
- **Writer**: Handles manuscript drafting and revision for both empirical and theoretical papers
- **Reviewer Trio**: Provides specialized feedback:
  - *Reviewer-Structure*: Focuses on big-picture elements (structure, arguments, impact)
  - *Reviewer-Detail*: Examines citations, conceptual clarity, and argument issues
  - *Copyeditor*: Reviews prose, titles, paragraphs, sentences, words, and markdown compliance
- **Support Agents**: 
  - *Literature-review*: Fast academic search and paper summaries
  - *Deep-research*: Exhaustive multi-step evidence gathering
  - *R-analysis*: R/Quarto pipeline edits and statistical code changes
  - *Automation*: Shell, git, and terminal-native execution
  - *Guard*: Safety checkpoints, regression control, and loop detection

## Key Features

- **Section-Based Skills**: Replaced paper-type-centric approaches with specialized skills for each manuscript section (introduction, literature review, methods, results, discussion)
- **Synthetic Examples**: Integrated opencode-snippets plugin for inline, task-appropriate examples instead of lengthy example files
- **Optimized Model Assignements**: Cost-effective model selection with family diversity to prevent homogenization of outputs
- **Streamlined Documentation**: Reduced AGENTS.md from 342 to ~100 lines and STYLE.md from 230 to ~80 lines for better comprehension
- **Specialized Reviewer System**: Three distinct reviewer agents providing triangulated feedback superior to single generic reviewer

## Installation & Setup

### Prerequisites
- Node.js (for opencode-snippets plugin)
- Access to LLM providers (configured in auth.json)

### Setup Steps
1. Clone this repository
2. Install dependencies: `npm install` (for snippets plugin)
3. Configure API keys in `auth.json`:
   ```json
   {
     "openrouter": {"type": "api", "key": "your-openrouter-key"},
     "mistral": {"type": "api", "key": "your-mistral-key"},
     "huggingface": {"type": "api", "key": "your-hf-key"},
     "opencode-go": {"type": "api", "key": "your-opencode-go-key"},
     "ollama-cloud": {"type": "api", "key": "your-ollama-cloud-key"}
   }
   ```
4. Verify installation by running an Opencode command

## Usage

### Basic Commands
- Invoke agents directly: `@writer "Help me draft an introduction section"`
- Request checkpoints: "guard checkpoint" or "run guard"
- Switch workflow modes: "high-control mode" or "autonomous batch mode"

### Workflow Modes
- **High-Control Mode** (Default): Pauses for approval at key decision points
- **Autonomous Batch Mode**: Continues until blocked by checkpoints, loop detection, or user intervention

### Agent Invocation Format
```
@agentname "Your specific request here"
```

Examples:
- `@writer "Draft an introduction section for a paper on machine learning applications in healthcare"`
- `@reviewer-structure "Review the structure of my methods section"`
- `@copyeditor "Improve the prose and flow of this paragraph"`
- `@literature-review "Find recent papers on transformer architectures"`

## Configuration

### opencode.json
The main configuration file defines:
- Agent models and fallback options
- Permission settings for each agent
- Plugin configurations (including opencode-snippets)

### Model Assignments (Current)
- **Writer**: ollama-cloud/gemma-2-9b (Gemma family)
- **Reviewer-Structure**: qwen/qwen2.5-7b-instruct (Qwen family)
- **Reviewer-Detail**: microsoft/phi-3-mini-128k-instruct (Phi family)
- **Copyeditor**: mistral/mistral-7b-instruct (Mistral family)
- Other agents configured for optimal performance/cost ratios

## Extending the System

### Adding Custom Skills
1. Create a new directory under `skills/`
2. Add a `SKILL.md` file with skill definition
3. Reference the skill in agent configurations as needed

### Adding Snippet Examples
1. Create markdown files in the `snippet/` directory
2. Use the format `#snippet-name` in skills or messages to expand examples
3. Refer to existing snippets for formatting guidelines

### Modifying Agent Permissions
Edit the permission blocks in `opencode.json` to adjust what each agent can do:
- `edit`: Allow/deny file editing capabilities
- `webfetch`: Allow/deny web fetching
- `bash`: Allow/deny bash command execution (with granular controls)

## Contributing

Contributions are welcome! Please follow these guidelines:
1. Fork the repository
2. Create a feature branch for your changes
3. Ensure modifications align with the system's design principles
4. Update documentation as needed
5. Submit a pull request with a clear description of changes

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

Thanks to the open-source AI community and the various LLM providers that make this workflow possible.