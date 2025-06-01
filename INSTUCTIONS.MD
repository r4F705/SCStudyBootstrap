### Streamlined Guide for Creating and Configuring a Custom Study Project in Visual Studio

#### Introduction

This guide is designed to help you set up a custom study project in Visual Studio (VS) to generate a DLL for Sierra Chart. By following these steps, you can leverage VS's powerful editing, debugging, and deployment capabilities without needing to restart Sierra Chart.

#### Prerequisites

- **Visual Studio 2022 Community Edition**
  - Download: [Visual Studio Community 2022](https://visualstudio.microsoft.com/vs/community/)

- **Windows PowerShell Version 6 (or higher)**
  - Check your current version by entering `$PSVersionTable` in PowerShell.
  - Download the latest version if needed: [PowerShell Releases](https://github.com/PowerShell/PowerShell/releases)

- **PowerShell Tools for Visual Studio 2022**
  - Install via Visual Studio:
    - Go to "Extensions" > "Manage Extensions"
    - Search for "PowerShell Tools for Visual Studio 2022" and install it.

#### Creating a Custom Study Project

1. **Install and Launch Visual Studio**: Install VS Community 2022 and open it.
2. **Create a New Project**:
   - Select "C++ – Windows – Desktop" from the dropdowns.
   - Choose "Windows Desktop Wizard" and proceed.
   - Name your project (same as your DLL name) and set your preferred location.
   - Check "Place solution and project in the same directory" and create the project.
3. **Configure Project**:
   - Select "Dynamic Link Library (.dll)" and check "Empty Project."
   - Click "OK" to create the project.
4. **Add Source File**:
   - In "Solution Explorer," add a new item and name your source file (.cpp).
   - If migrating existing code, copy from the original and paste it here.

#### Configuring the Project

1. **Access Project Properties**:
   - Right-click the project in "Solution Explorer" and select "Properties."
2. **Set Directories**:
   - **Output Directory**: Set to Sierra Chart's "Data" folder (e.g., `C:\SierraChart\Data\`).
   - **Output File**: Add `$(TargetName)$(TargetExt)` to the Data folder path.
   - **Include Directories**: Add Sierra Chart's "ACS_Source" path at the end of the list.
3. **Build Configuration**:
   - Adjust between "Debug" and "Release" modes as needed.

#### Automating DLL Management

1. **Pre-Build Event**:
   - Set command: `{path_to_powershell}\pwsh.exe -File "ReleaseDLL.ps1"`
2. **Post-Build Event**:
   - Set command: `{path_to_powershell}\pwsh.exe -File "ReloadDLL.ps1"`
3. **Attach PowerShell Scripts**:
   - Place `ReleaseDLL.ps1` and `ReloadDLL.ps1` in your project folder or specify full paths.
   - Adjust the scripts to match your DLL file name.

#### Final Steps

- **Set UDP Port**: Ensure your Sierra Chart UDP port matches the one in your PowerShell scripts.
- **Manage Existing Studies**: Remove any existing `_64.dll` files before using your new build.

#### Important Note

**Caution**: Ensure Sierra Chart is in SIM mode while testing changes to avoid unintended trades. Only move to live trading once you're confident in your scripts' stability.

With these steps, you're ready to develop and manage your custom studies efficiently using Visual Studio. Happy coding!
