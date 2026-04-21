# Effective Prompt Patterns for Claude Code

## Bootstrap (every session)
```
Read CLAUDE.md fully. Run git status and git log --oneline -5. Report: current phase, last commit, exact next action. No clarifying questions.
```

## Feature Development
```
Use Feature Forge to spec [feature name]. Include: user stories, acceptance criteria, technical requirements, edge cases. Then use Architecture Designer if multi-service. Start GSD plan after spec approved.
```

## Bug Investigation
```
Use gstack-investigate on [file/module]. Check git blame for recent changes. Run tests. Report: root cause, affected files, fix options with trade-offs.
```

## Code Review
```
Review [file/PR]. Use code-review plugin. Check: security (semgrep), performance, maintainability, test coverage. Flag any CLAUDE.md rule violations.
```

## Architecture Decision
```
Use Architecture Designer. I need to choose between [option A] and [option B] for [context]. Document trade-offs, make recommendation, create Architecture Decision Record in CLAUDE.md.
```

## Red Team / Challenge
```
Use The Fool. Challenge my plan to [plan description]. Apply: devil's advocate, pre-mortem, red team, second-order effects, opportunity cost.
```

## API Design
```
Use API Designer. Design REST API for [feature]. Include: endpoints, request/response schemas, auth, rate limiting, OpenAPI spec. Follow CLAUDE.md security rules.
```

## Deploy Checklist
```
Pre-deploy check: run tests, npm audit, check .env not staged, verify CORS whitelist, confirm conventional commit format. Use gsd-ship.
```

## Token-Efficient Session
```
$caveman
[then your actual prompt]
```

## Swarm (rare — parallel work)
```
npx ruflo@latest swarm init --topology hierarchical --max-agents 8
Spawn: coder for [task A], tester for [task B], reviewer for [task C]. Run parallel.
```