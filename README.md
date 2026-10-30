# browserstack-playwright-robot-load-testing-sample
Sample repository for Playwright framework to do load testing

## Notes before you adapt this sample

- **Dependencies are hash-pinned.** `requirements.txt` is a lock with a hash for every package, so pip refuses anything that doesn't match. Edit the direct dependencies in `requirements.in`, then regenerate the lock:

  ```sh
  uv pip compile requirements.in --universal --python-version 3.10 --generate-hashes -o requirements.txt
  ```

- **Set thresholds for your own SLA.** `browserstack-load.yml` ships an error-rate and a p95 response-time threshold. Without thresholds every run reports as passed, however the application behaves.
- **Every VU logs in as the same demo user.** That's fine against bstackdemo.com. Against your own application, give each VU its own test account. Concurrent sessions sharing one account race on the same cart and orders, and that can hide real failures.
