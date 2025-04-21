Executing: program /usr/bin/ssh host remote, user (unspecified), command scp -v -t test.rds
OpenSSH_8.9p1 Ubuntu-3ubuntu0.10, OpenSSL 3.0.2 15 Mar 2022
debug1: Reading configuration data /home/echo/.ssh/config
debug1: /home/echo/.ssh/config line 14: Applying options for remote
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files
debug1: /etc/ssh/ssh_config line 21: Applying options for *
debug1: Connecting to ssh.cn-zhongwei-1.paracloud.com [36.103.203.6] port 22.
debug1: Connection established.
debug1: identity file /home/echo/.ssh/id_ecdsa_chaosuan2 type 2
debug1: identity file /home/echo/.ssh/id_ecdsa_chaosuan2-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.10
debug1: Remote protocol version 2.0, remote software version ParaCloud
debug1: compat_banner: no match: ParaCloud
debug1: Authenticating to ssh.cn-zhongwei-1.paracloud.com:22 as 't0s000324@BSCC-T'
debug1: load_hostkeys: fopen /home/echo/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: algorithm: curve25519-sha256
debug1: kex: host key algorithm: rsa-sha2-512
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: SSH2_MSG_KEX_ECDH_REPLY received
debug1: Server host key: ssh-rsa SHA256:UsQxLMhhInxyp2gEfcYBUMBiJP2Pcfp+4LliI03orZ0
debug1: load_hostkeys: fopen /home/echo/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
debug1: Host 'ssh.cn-zhongwei-1.paracloud.com' is known and matches the RSA host key.
debug1: Found key in /home/echo/.ssh/known_hosts:4
debug1: rekey out after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: rekey in after 134217728 blocks
debug1: get_agent_identities: bound agent to hostkey
debug1: get_agent_identities: agent returned 3 keys
debug1: Will attempt key: echo@pop-os RSA SHA256:kMEZPGoFLRXRps6P/Hg2BbizFyiC8snk6LE3fJE20xU agent
debug1: Will attempt key: echo@pop-os RSA SHA256:JMW2CebtaUO1RVjlt3+ngQYT32z79h8Eaz24cggIGfg agent
debug1: Will attempt key: echo@pop-os ED25519 SHA256:7OFrlgfKVA/9mgP0EGgJvZqwxi4aPxwIQYq6St5iP5I agent
debug1: Will attempt key: /home/echo/.ssh/id_ecdsa_chaosuan2 ECDSA SHA256:uNz6y//9aPyhJJBJYayR8atuRuoYWpD/OuKNP081Qdw explicit
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: password,publickey
debug1: Next authentication method: publickey
debug1: Offering public key: echo@pop-os RSA SHA256:kMEZPGoFLRXRps6P/Hg2BbizFyiC8snk6LE3fJE20xU agent
debug1: send_pubkey_test: no mutual signature algorithm
debug1: Offering public key: echo@pop-os RSA SHA256:JMW2CebtaUO1RVjlt3+ngQYT32z79h8Eaz24cggIGfg agent
debug1: send_pubkey_test: no mutual signature algorithm
debug1: Offering public key: echo@pop-os ED25519 SHA256:7OFrlgfKVA/9mgP0EGgJvZqwxi4aPxwIQYq6St5iP5I agent
debug1: Authentications that can continue: password,publickey
debug1: Offering public key: /home/echo/.ssh/id_ecdsa_chaosuan2 ECDSA SHA256:uNz6y//9aPyhJJBJYayR8atuRuoYWpD/OuKNP081Qdw explicit
debug1: Server accepts key: /home/echo/.ssh/id_ecdsa_chaosuan2 ECDSA SHA256:uNz6y//9aPyhJJBJYayR8atuRuoYWpD/OuKNP081Qdw explicit
Authenticated to ssh.cn-zhongwei-1.paracloud.com ([36.103.203.6]:22) using "publickey".
debug1: channel 0: new [client-session]
debug1: Entering interactive session.
debug1: pledge: filesystem
debug1: Sending environment.
debug1: channel 0: setting env LC_ALL = "en_US.UTF-8"
debug1: channel 0: setting env LANG = "en_US.UTF-8"
debug1: Sending command: scp -v -t test.rds
scp: debug1: fd 3 clearing O_NONBLOCK
Sending file modes: C0664 144059691 infe.epithelial.rds
Sink: C0664 144059691 infe.epithelial.rds
