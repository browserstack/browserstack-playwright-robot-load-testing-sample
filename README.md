# browserstack-playwright-robot-load-testing-sample
Sample repository for Playwright framework to do load testing

## Set your credentials

The BrowserStack CLI reads your credentials from environment variables. Copy your username and access key from [Account Settings](https://www.browserstack.com/accounts/settings) and export them in the shell you run the test from:

On macOS or Linux (bash or zsh), run the lines below. The second one prompts for the key without echoing it, so the key stays out of your shell history:

```sh
export BROWSERSTACK_USERNAME="<your-username>"
printf 'BrowserStack access key: '; read -rs BROWSERSTACK_ACCESS_KEY; echo; export BROWSERSTACK_ACCESS_KEY
```

On Windows, run these in PowerShell. The second line prompts for the key in the same way:

```powershell
$env:BROWSERSTACK_USERNAME = "<your-username>"
$env:BROWSERSTACK_ACCESS_KEY = [System.Net.NetworkCredential]::new('', (Read-Host -AsSecureString 'BrowserStack access key')).Password
```

These variables last only for the current terminal session. If the CLI reports an authentication error, check that both are set in the terminal you run it from.

**Never commit your credentials.** Keep your access key out of `browserstack-load.yml` and every other file you push. If a key is ever exposed, regenerate it from Account Settings.

## Run the sample

1. Download the BrowserStack CLI for your operating system. The download is a zip: extract it and place the `browserstack-cli` binary (`browserstack-cli.exe` on Windows) in the root of this project. On macOS or Linux, also run `chmod +x browserstack-cli`, since some unzip tools drop the executable bit.
   - [macOS x86](https://load-api.browserstack.com/api/v1/binary?os=macos&arch=x64)
   - [macOS ARM](https://load-api.browserstack.com/api/v1/binary?os=macos&arch=arm64)
   - [Windows x86](https://load-api.browserstack.com/api/v1/binary?os=win&arch=x64)
   - [Linux x86](https://load-api.browserstack.com/api/v1/binary?os=linux&arch=x64)
   - [Linux ARM](https://load-api.browserstack.com/api/v1/binary?os=linux&arch=arm64)
2. On macOS and Windows, check that the binary is signed by BrowserStack before running it. On macOS the command must succeed: it only passes if an Apple-issued certificate for BrowserStack's team (`YQ5FZQ855D`) signed the binary; on Windows, `Status` must be `Valid` with BrowserStack as the signer. If the check fails, do not run the binary. There is no signature check for the Linux build.

   ```sh
   codesign --verify --strict -R '=anchor apple generic and certificate leaf[subject.OU] = "YQ5FZQ855D"' ./browserstack-cli
   ```

   ```powershell
   # Windows (PowerShell)
   Get-AuthenticodeSignature .\browserstack-cli.exe | Format-List Status, SignerCertificate
   ```
3. Start the test:

   ```sh
   ./browserstack-cli load run
   ```

   ```powershell
   # Windows (PowerShell)
   .\browserstack-cli.exe load run
   ```

## Notes before you adapt this sample

- **Dependencies are hash-pinned.** `requirements.txt` is a lock with a hash for every package, so pip refuses anything that doesn't match. Edit the direct dependencies in `requirements.in`, then regenerate the lock:

  ```sh
  uv pip compile requirements.in --universal --python-version 3.10 --generate-hashes -o requirements.txt
  ```

- **Set thresholds for your own SLA.** `browserstack-load.yml` ships an error-rate and a p95 response-time threshold. Without thresholds every run reports as passed, however the application behaves.
- **Every VU logs in as the same demo user.** That's fine against bstackdemo.com. Against your own application, give each VU its own test account. Concurrent sessions sharing one account race on the same cart and orders, and that can hide real failures.
