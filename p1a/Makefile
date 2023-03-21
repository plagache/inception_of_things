ssh:
	vagrant ssh $$(vagrant status | grep "running" | fzy | cut -d' ' -f1)

up:
	vagrant up

status:
	vagrant status

clean:
	vagrant destroy -f
	rm node-token

re: clean up

.SILENT: clean up ssh status
