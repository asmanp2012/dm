# Docker Manager (dm)

A simple and practical management tool for Docker that makes daily container and image tasks easier.

---

## 📖 Table of Contents

- [Description](#-description)
- [Features](#-features)
- [Installation](#-installation)
- [Usage](#-usage)
- [Examples](#-examples)
- [Interactive Menu](#-interactive-menu)
- [License](#-license)

---

## 📝 Description

Docker Manager (dm) is a Bash script that simplifies complex Docker commands. This tool is designed for developers and system administrators who frequently work with Docker, increasing productivity by providing a simple command-line interface and interactive menu.

## ✨ Features

- ✅ **Container Management**: Start, stop, remove, and connect to containers
- ✅ **Image Management**: Save, load, export, import, and manipulate images
- ✅ **Interactive Menu**: Easy-to-use numbered menu for all operations
- ✅ **Auto-completion**: Bash completion for commands and parameters
- ✅ **Path Resolution**: Automatic handling of relative and absolute paths
- ✅ **Batch Operations**: Support for multiple port mappings
- ✅ **Cleanup Tools**: Remove temporary files and clean container caches
- ✅ **Progress Display**: Shows progress during import/export operations (if `pv` is installed)---

## 📦 Installation

### Step1: Cloning```bash

```bash
# Clone the repository
git clone https://github.com/yourusername/dm.git
cd dm

# Make the script executable
chmod +x bin/dm
```

### Step 2: Import to `.bashrc`

Add this line to your `.profile` or `.bash_profile`

```bash
export DM_PATH="/path/to/dm/bin"

if [ -f "$DM_PATH/.bashrc" ]; then
    source "$DM_PATH/.bashrc"
fi
```

## 🧪 UsageHere are some of the most common commands

| Command | Description |
| ----------------- | ------------- |
| `dm lsdc` | List all containers |
| `dm lsi` | List all images |
| `dm rmi` | Remove an image |
| `dm sshc` | Connect to a container |
| `dm rmc` | Remove a container |
| `dm stop` | Stop a container |
| `dm start` | Start a container |
| `dm clean` | Clean temporary files and logs |
| `dm commit` | Create an image from a container |
| `dm save`       | Save an image to a `.tar` file |
| `dm load` | Load an image from a `.tar` file |
| `dm export` | Export container filesystem to a `.tar` |
| `dm import` | Import a `.tar` file to an image |
| `dm run` | Run a container with custom settings |
| `dm --menu` | Launch the interactive menu |

---

## 🧪 Examples

```bash

# List all containers
dm lsdc

# Connect to a container
dm sshc my-container

# Remove an image
dm rmi nginx:latest

# Create a new image from a container
dm commit my-container my-image:latest

# Save an image to a file
dm save my-image:latest my-image.tar

# Load an image from a file
dm load my-image.tar

# Export container filesystem
dm export my-container

# Import a file to an image
dm import my-exported.tar my-image:new

# Run a container with custom ports and CMD
dm run my-app "8080:803000:3000" my-image:latest "/usr/bin/supervisord -n"

