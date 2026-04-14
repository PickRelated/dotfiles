Install nvm
===========
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

Create symlinks
===============
```bash
node createSymlinks.js
```

Enable WebGL in Chrome
======================
Enable next flags in chrome://flags
* Override software rendering list
* WebGL Developer Extensions
* WebGL Draft Extensions

keyd
====
sudo mkdir /etc/keyd
sudo touch /etc/keyd/default.conf
echo -e "[ids]\n0001:0001\n\n[main]" | sudo tee /etc/keyd/default.conf > /dev/null
