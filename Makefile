NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
DEPS = $(go list -f '{{range .TestImports}}{{.}} {{end}}' ./...)
UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
ECHO=echo
else
ECHO=/bin/echo -e
endif

all: 
	@$(ECHO) "$(OK_COLOR)==> Building$(NO_COLOR)"
	go get -v ./...
	go test -v

bin: 
	@$(ECHO) "$(OK_COLOR)==> Building$(NO_COLOR)"
	go build

clean:
	@rm -rf dist/ packer-post-processor-ami-registry

format:
	go fmt ./...

dist:
	@$(ECHO) "$(OK_COLOR)==> Building Packages...$(NO_COLOR)"
	@gox -osarch="darwin/386 darwin/amd64 linux/386 linux/amd64 freebsd/386 freebsd/amd64 openbsd/386 openbsd/amd64 windows/386 windows/amd64 netbsd/386 netbsd/amd64"
	@mv packer-post-processor-ami-registry_darwin_386 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.darwin-i386.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_darwin_amd64 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.darwin-amd64.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_freebsd_386 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.freebsd-i386.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_freebsd_amd64 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.freebsd-amd64.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_linux_386 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.linux-i386.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_linux_amd64 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.linux-amd64.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_netbsd_386 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.netbsd-i386.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_netbsd_amd64 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.netbsd-amd64.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_openbsd_386 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.openbsd-i386.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_openbsd_amd64 packer-post-processor-ami-registry; tar cvfz packer-post-processor-ami-registry.openbsd-amd64.tar.gz packer-post-processor-ami-registry; rm packer-post-processor-ami-registry
	@mv packer-post-processor-ami-registry_windows_386.exe packer-post-processor-ami-registry.exe; zip packer-post-processor-ami-registry.windows-i386.zip packer-post-processor-ami-registry.exe; rm packer-post-processor-ami-registry.exe
	@mv packer-post-processor-ami-registry_windows_amd64.exe packer-post-processor-ami-registry.exe; zip packer-post-processor-ami-registry.windows-amd64.zip packer-post-processor-ami-registry.exe; rm packer-post-processor-ami-registry.exe
	@mkdir -p dist/
	@mv packer-post-processor-ami-registry* dist/.

.PHONY: all clean deps format test updatedeps
