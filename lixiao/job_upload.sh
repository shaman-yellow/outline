
# cd ~/disk_sdb1/my_job
seaf-cli init -d ~/disk_sdb1/my_job
seaf-cli start

## https://help.seafile.com/syncing_client/linux-cli/

# http://192.168.18.99:8000/#shared-libs/lib/ad3a6679-47ad-48c9-9b7d-3d8604693669/%E9%BB%84%E7%A4%BC%E9%97%AF

seaf-cli sync -l ad3a6679-47ad-48c9-9b7d-3d8604693669/%E9%BB%84%E7%A4%BC%E9%97%AF \
  -s http://192.168.18.99:8000 \
  -d ~/disk_sdb1/my_job \
  -u huanglichuang@wie-biotech.com \
  -p xxk123456

seaf-cli sync -l "the id of the library" -s  "the url + port of server" -d "the folder which the library will be synced with" -u "username on server" [-p "password"]
