# SCStudyBootstrap

**SCStudyBootstrap** is a PowerShell-based automation tool designed to streamline the setup and configuration of Visual Studio projects for developing custom studies in Sierra Chart. This tool helps developers quickly bootstrap their project environments by automatically generating necessary PowerShell scripts and updating Visual Studio project settings, ensuring seamless integration and efficient development workflows.

Original instruction by ondafringe https://www.sierrachart.com/SupportBoard.php?ThreadID=98328

## Features

- **Interactive CLI**: Easily configure your project with prompted inputs.
- **Automatic Script Creation**: Generates PowerShell scripts for managing DLLs.
- **Visual Studio Integration**: Automatically sets up Visual Studio project configurations for Sierra Chart studies.
- **Efficient Development Workflow**: Simplifies deployment and testing processes.

## Prerequisites

Before using this tool, ensure you have:

- **Visual Studio 2022 Community Edition** installed.
- **Windows PowerShell 7** or higher.
- A Visual Studio project already set up that you wish to configure.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/SCStudyBootstrap.git
   cd SCStudyBootstrap
   ```

2. **Prepare Your Environment**: Make sure PowerShell is running with administrative privileges to modify project files.

## Usage

1. **Run the Script**: Execute the script to start the interactive setup process.

   ```powershell
   .\ConfigureVSProject.ps1
   ```

2. **Follow the Prompts**: Enter the requested information, including:
   - Path to your Visual Studio project.
   - Name of your `.vcxproj` file.
   - Paths for Sierra Chart's "Data" and "ACS_Source" folders.
   - Path to your PowerShell executable.
   - Name of your DLL file.
   - Sierra Chart IP address and UDP port. (UDP is disabled by default)

3. **Verify Setup**: After running the script, ensure that:
   - `ReleaseDLL.ps1` and `ReloadDLL.ps1` scripts are created in your project directory.
   - Visual Studio project configurations are updated.

## Important Notes

- **Backup**: Always back up your project files before running the script to prevent data loss.
- **Permissions**: Ensure you have the necessary permissions to modify the Visual Studio project files.
- **Sierra Chart Settings**: Adjust Sierra Chart settings to match the IP and port configured in the scripts.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

With **SCStudyBootstrap**, you can efficiently set up your development environment for Sierra Chart custom studies, improving productivity and reducing setup time.
