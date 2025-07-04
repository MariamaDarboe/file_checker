File Integrity Checker (Hash-Watch)

This is a mini project for Security Script Programming. This Bash script helps detect file tampering and configuration drift using MD5 checksums.

Team Members
1. Mariama E. Darboe
2. Omar E. Touray

# Features
1. Baseline file hashing
2. Change detection using "md5sum"
3. Colored output for clarity
4. Functional structure: "--init", "--check", "--help"

How to Use ("testdir" is a directory)
bash
# Create baseline
./file_integrity.sh --init testdir

# Check for changes
./file_integrity.sh --check testdir

# Show help
./file_integrity.sh --help
