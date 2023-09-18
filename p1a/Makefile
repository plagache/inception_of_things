install:
	./scripts/install.sh

sshserver:
	vagrant ssh alagacheS

sshworker:
	vagrant ssh alagacheSW

up:
	vagrant up

status:
	vagrant status

clean:
	vagrant destroy -f
	rm node-token

re: clean up

.SILENT: clean up ssh status
