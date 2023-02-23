ssh:
	vagrant ssh $$(vagrant status | grep "running" | fzy | cut -d' ' -f1)

up:
	vagrant up

clean:
	vagrant destroy -f
	rm node-token

.PHONY: clean up
.SILENT: clean up
