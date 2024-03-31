package main

import (
	"bytes"
	_ "embed"
	"text/template"
)

//go:embed enumTemplate.tpl
var enumTemplate string

type enumInfo struct {
	Name       string
	Value      string
	HTTPCode   int
	CamelValue string
	Comment    string
	HasComment bool
}

type enumWrapper struct {
	Name   string
	Type   string
	Enumes []*enumInfo
}

func (e *enumWrapper) execute() string {
	buf := new(bytes.Buffer)
	tmpl, err := template.New("enum").Parse(enumTemplate)
	if err != nil {
		panic(err)
	}
	if err := tmpl.Execute(buf, e); err != nil {
		panic(err)
	}
	return buf.String()
}
