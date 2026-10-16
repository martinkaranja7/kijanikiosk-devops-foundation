Started with a default security score of 6.8, which was way too loose for a payments node.

Worked the score down step-by-step by locking down filesystem mounts, dropping extra privileges, and stripping kernel capabilities.

Threw out SystemCallFilter because it blocked the Node.js runtime and crashed the service on startup.

Skipped ProtectKernelModules since it wasn't relevant to our app layer.

Ended up with a final score of 2.1, and the service still boots and runs cleanly
