type {{ .Type }} string

const (
{{- range .Enumes }}
	{{ $.Type }}_{{ .Value }} {{ $.Type }} = "{{ .Value }}"
{{- end }}
)

const (
{{- range .Enumes }}
	{{ $.Type }}Comment_{{ .Value }} = "{{ .Comment }}"
{{- end }}
)

var {{ .Type }}Names = []string{
{{- range .Enumes }}
	"{{ .Value }}",
{{- end }}
}

var {{ .Type }}Values = []{{ .Type }}{
{{- range .Enumes }}
	{{ $.Type }}_{{ .Value }},
{{- end }}
}

var {{ .Type }}Comments = []string{
{{- range .Enumes }}
	{{ $.Type }}Comment_{{ .Value }},
{{- end }}
}

func (x {{ .Type }}) IsValid() bool {
	_, err := Parse{{ .Type }}(string(x))
	return err == nil
}

func (x {{ .Type }}) String() string {
	return string(x)
}

func (x {{ .Type }}) Comment() string {
	for idx, item := range {{ .Type }}Values {
		if item == x {
			return {{ .Type }}Comments[idx]
		}
	}
	return ""
}

func Parse{{ .Type }}(name string) (v {{ .Type }}, err error) {
	for idx, item := range {{ .Type }}Names {
		if item == name {
			return {{ .Type }}Values[idx], nil
		}
	}
	return v, fmt.Errorf("%s is not a valid {{ .Type }}", name)
}

func MustParse{{ .Type }}(name string) {{ .Type }} {
	val, err := Parse{{ .Type }}(name)
	if err != nil {
		panic(err)
	}
	return val
}

func Parse{{ .Type }}Comment(comment string) (v {{ .Type }}, err error) {
	for idx, item := range {{ .Type }}Comments {
		if item == comment {
			return {{ .Type }}Values[idx], nil
		}
	}
	return v, fmt.Errorf("%s is not a valid {{ .Type }}", comment)
}

func MustParse{{ .Type }}Comment(comment string) {{ .Type }} {
	val, err := Parse{{ .Type }}Comment(comment)
	if err != nil {
		panic(err)
	}
	return val
}
