package main

import (
	"fmt"
	"io"
	"os"
	"path/filepath"
	"strings"
)

// sanitizePath replaces path separators to make a valid filename
func sanitizePath(path string) string {
	return strings.ReplaceAll(path, string(os.PathSeparator), "_")
}

// copyFile copies a file to the destination with a unique name
func copyFile(src, destDir, root string) error {
	relPath, err := filepath.Rel(root, src)
	if err != nil {
		return err
	}
	relPath = sanitizePath(relPath) // Ensure unique filename
	dest := filepath.Join(destDir, relPath)

	// Open source file
	srcFile, err := os.Open(src)
	if err != nil {
		return err
	}
	defer srcFile.Close()

	// Create destination file
	destFile, err := os.Create(dest)
	if err != nil {
		return err
	}
	defer destFile.Close()

	// Copy contents
	_, err = io.Copy(destFile, srcFile)
	return err
}

// findAndCopyTFState searches for .tfstate files and copies them
func findAndCopyTFState(root, destDir string) error {
	return filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		// Skip directories
		if info.IsDir() {
			return nil
		}
		// Check if file is .tfstate
		if strings.HasSuffix(info.Name(), ".tfstate") {
			fmt.Println("Found:", path)
			return copyFile(path, destDir, root)
		}
		return nil
	})
}

func main() {
	// Get root directory
	rootDir, err := os.Getwd()
	if err != nil {
		fmt.Println("Error getting current directory:", err)
		return
	}

	// Get destination directory from CLI args
	destDir := rootDir
	if len(os.Args) > 1 {
		destDir = os.Args[1]
	}

	// Ensure destination exists
	if err := os.MkdirAll(destDir, 0755); err != nil {
		fmt.Println("Error creating destination directory:", err)
		return
	}

	fmt.Println("Searching for .tfstate files in:", rootDir)
	fmt.Println("Copying to:", destDir)

	if err := findAndCopyTFState(rootDir, destDir); err != nil {
		fmt.Println("Error:", err)
	}
}
