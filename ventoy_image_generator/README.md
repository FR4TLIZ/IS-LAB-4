# Disk Backup Script

A simple Bash script to create a full disk image backup and verify its integrity using cryptographic checksums.

## Features

- Creates a full disk image of `/dev/sda`
- Stores backups with a timestamp in `/mnt/disk_images`
- Computes **MD5, SHA256, and SHA512** checksums for verification
- Automatically verifies integrity after the backup process

## Prerequisites

- **Root privileges** (the script must be run as root)
- Sufficient storage space on `/mnt/disk_images`
- `dd`, `md5sum`, `sha256sum`, and `sha512sum` installed

## Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/FR4TLIZ/IS-LAB-4.git
   cd IS-LAB-4
   ```

2. **Make the script executable**:
   ```bash
   chmod +x backup.sh
   ```

3. **Run the script as root**:
   ```bash
   sudo ./backup.sh
   ```

4. **Backup will be saved in** `/mnt/disk_images/YYYY-MM-DD_HH-MM-SS/`

## Example Backup Structure

```
/mnt/disk_images/
  ├── 2024-04-02_12-30-00/
  │   ├── backup_2024-04-02_12-30-00.img
  │   ├── md5_2024-04-02_12-30-00.txt
  │   ├── sha256_2024-04-02_12-30-00.txt
  │   ├── sha512_2024-04-02_12-30-00.txt
```

## Verification

After the backup is completed, the script will automatically verify the integrity of the image.
