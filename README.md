# Usta Kılavuz

A Turkish, step-by-step field guide prototype for common home repair tasks and post-earthquake safety checks. It includes risk labels, task progress, a local progress passport, photo attachments, and a handoff summary for a qualified professional.

## Run locally

Requirements: Windows PowerShell 5.1 or later. No package installation is required.

From the project directory, run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\start-localhost.ps1
```

Open [http://localhost:8000/](http://localhost:8000/) in your browser. Press `Ctrl+C` in the server terminal to stop it.

## Project files

- `usta-kilavuz-kubik.html` - the application; HTML, CSS, and JavaScript are bundled in this file.
- `start-localhost.ps1` - a dependency-free local HTTP server for Windows PowerShell.

## Safety

This is an educational prototype, not a substitute for professional training, certification, or qualified service. Electrical, natural gas, and other high-risk work should be handled by an authorized professional. In a natural gas emergency in Turkey, leave the building and call 187 from a safe location.
