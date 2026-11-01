# Fault Injection & Resilience Log

This log documents intentional fault testing across all pipeline stages to verify fail-fast behavior, stage skipping, and post-execution cleanup routines.

| Faulted Stage | Fault Injected | Observed Downstream Behaviour | Design Rationale & Justification |
| :--- | :--- | :--- | :--- |
| **Lint** | Modified `package.json` lint script to `exit 1`. | Lint stage failed immediately. Build, Verify, Archive, and Publish stages were skipped. Workspace was cleaned up in `post { always }`. | Fail-fast code quality checks prevent wasting compute time and resources building flawed or unformatted source code. |
| **Build** | Introduced a syntax error into `src/index.js` causing `npm run build` to exit non-zero. | Build stage failed. Verify, Archive, and Publish stages were skipped. Stash was not created. Post-failure notification triggered. | Compiling defective source code yields invalid build output, so downstream testing and publishing must be aborted immediately. |
| **Verify (Parallel)** | Added a failing test assert (`exit 1`) in `npm test`. | Unit Test branch failed. Security Audit branch finished, but subsequent Archive and Publish stages were skipped. | Publishing unverified artifacts exposes production services to untested logic and security vulnerabilities. |
| **Publish** | Provided invalid credentials in `nexus-npm-credentials` ID. | Checkout, Lint, Build, Verify, and Archive completed successfully. Publish failed upon HTTP 401 response. | Archiving ensures local build diagnostics are retained, while restricting artifact registry writes protects release integrity. |

## Verification Summary
- **Fail-Fast Compliance:** Any stage failure halts subsequent execution steps.
- **Workspace Hygiene:** `cleanWs()` executed successfully during every test run under the `post { always }` block.
- **State Restored:** All faults resolved and pipeline returned to 100% green pass state.
