package main

import (
	"fmt"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strings"
	"text/template"
	"time"

	yaml "gopkg.in/yaml.v2"
)

type Command struct {
	Command string `yaml:"command"`
	Result  string
}

type Resource struct {
	Name   string `yaml:"name"`
	Source string `yaml:"source"`
}

type Recipe struct {
	Commands  []*Command `yaml:"commands"`
	Resources []*Resource
}

type Info struct {
	Date     string
	Hardware string
	Recipe
}

func generatePage(file string, info *Info) error {
	fmt.Println(file)
	buf, err := os.ReadFile(file + ".yaml")
	if err != nil {
		return err
	}

	tempDir, err := os.MkdirTemp("", "")
	if err != nil {
		return err
	}
	defer os.RemoveAll(tempDir)

	yaml.Unmarshal(buf, &info.Recipe)
	for _, res := range info.Recipe.Resources {
		b, err := os.ReadFile(path.Join(path.Dir(file), res.Source))
		if err != nil {
			return err
		}
		err = os.WriteFile(path.Join(tempDir, res.Name), b, 0644)
		if err != nil {
			return err
		}
	}

	for _, com := range info.Recipe.Commands {
		cmd := exec.Command("zsh", "-c", com.Command)
		cmd.Dir = tempDir
		output, _ := cmd.CombinedOutput()
		com.Result = strings.TrimSpace(string(output))
	}

	dst, err := os.Create(path.Join("../content", file+".md"))
	if err != nil {
		return err
	}
	defer dst.Close()

	tmpl, err := template.ParseFiles(file + ".md")
	if err != nil {
		return err
	}

	err = tmpl.Execute(dst, info)
	if err != nil {
		return err
	}
	return nil
}

func main() {
	var info Info
	info.Date = time.Now().Format("2006-01-02")
	info.Hardware = "M1 Mac (Monterey)"

	files, err := filepath.Glob("./*/*/*.md")
	if err != nil {
		panic(err)
	}

	for _, file := range files {
		err := generatePage(strings.TrimSuffix(file, filepath.Ext(file)), &info)
		if err != nil {
			panic(err)
		}
	}
}
