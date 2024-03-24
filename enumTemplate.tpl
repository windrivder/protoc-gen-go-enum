// {{ .Name }}Names returns a list of possible string values of {{ .Name }}.
func {{ .Name }}Names() []string {
	return []string{
{{- range .Enumes }}
		"{{.Value}}",
{{- end }}
    }
}

// {{ .Name }}Values returns a list of the values for {{ .Name }}
func {{ .Name }}Values() []{{ .Name }} {
	return []{{ .Name }}{
{{- range .Enumes }}
		{{.Name}}_{{.Value}},
{{- end }}
	}
}

// IsValid provides a quick way to determine if the typed value is
// part of the allowed enumerated values
func (x {{ .Name }}) IsValid() bool {
	_, err := Parse{{ .Name }}(string(x))
	return err == nil
}

// Parse{{ .Name }} attempts to convert a string to a {{ .Name }}.
func Parse{{ .Name }}(name string) (v {{ .Name }}, err error) {
	if v, ok := {{ .Name }}_value[name]; ok {
		return {{ .Name }}(v), nil
	}
	return v, fmt.Errorf("%s is not a valid {{ .Name }}", name)
}

// MustParse{{ .Name }} converts a string to a {{ .Name }}, and panics if is not valid.
func MustParse{{ .Name }}(name string) {{ .Name }} {
	val, err := Parse{{ .Name }}(name)
	if err != nil {
		panic(err)
	}
	return val
}
