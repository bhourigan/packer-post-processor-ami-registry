package main

import (
	"compress/flate"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"text/template"

	"github.com/mitchellh/packer/common"
	"github.com/mitchellh/packer/packer"
)

var builtins = map[string]string{
	"mitchellh.amazonebs": "amazonebs",
	"mitchellh.amazon.instance": "amazoninstance",
}

type Config struct {
	common.PackerConfig `mapstructure:",squash"`

	tpl *packer.ConfigTemplate
}

type PostProcessor struct {
	configs map[string]*Config
}

func (p *PostProcessor) Configure(raws ...interface{}) error {
	return nil
}

func (p *PostProcessor) PostProcess(ui packer.Ui, artifact packer.Artifact) (packer.Artifact, bool, error) {
	name, ok := builtins[artifact.BuilderId()]
	if !ok {
		return nil, false, fmt.Errorf(
			"Unsupported artifact type: %s", artifact.BuilderId())
	}

	Id := artifact.Id()
	ui.Message(fmt.Sprintf("AMI IDs: %s", Id))

	return artifact, false, nil
}
