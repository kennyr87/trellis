# 🎩 trellis-database-uploads-migration

Ansible playbook for Trellis that manages database and uploads migration. Inspired by [valentinocossar/trellis-database-uploads-migration](https://github.com/valentinocossar/trellis-database-uploads-migration).


## ⚙️ Setup

1. Add `databases/*` to the end of the Bedrock `.gitignore` file
2. Copy vagrant ansible inventory to `hosts/vagrant`
3. Set alias for host files as mentioned below in the hosts configuration section
4. Vagrant should be running, if not, run `vagrant up --no-provision` to from trellis root

## 🏄 Usage

To backup database and uploads run

```
./bin/deploy.sh <environment> <site name>
```

To push or pull uploads run

```
./bin/uploads.sh <environment> <mode> <site name>
```

### 📌 Tips

* Available `<mode>` options for uploads task: `push`, `pull`
* The `push` is for sending to the selected environment and the `pull` for receiving from it

## 🛠 Hosts configuration

### Development

```ini
[development]
vagrant ansible_host=192.168.50.5 ansible_connection=ssh ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/default/virtualbox/private_key ansible_ssh_extra_args="-o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o ForwardAgent=yes"

[web]
vagrant ansible_host=192.168.50.5 ansible_connection=ssh ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/default/virtualbox/private_key ansible_ssh_extra_args="-o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o ForwardAgent=yes"
```

### Staging

```ini
[staging]
staging_host ansible_host=your_server_hostname

[web]
staging_host ansible_host=your_server_hostname
```

### Production

```ini
[production]
production_host ansible_host=your_server_hostname

[web]
production_host ansible_host=your_server_hostname
```
