
# name=findsimilar

# conda env
conda create -n fastdup -c conda-forge python==3.9
conda activate fastdup 
pip install poetry pyinstaller \
  fastdup ttkthemes

# skeleton
new_python findsimilar
nvim pyproject.toml

# test
if [ 0 ]; then
  cd findsimilar
  poetry run python scripts/run_tool.py
fi

# build and package
poetry lock 
poetry build
pip install .

# pyinstaller config file
pyi-makespec --onefile --windowed findsimilar/main.py

# docker
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": [
  "https://hub.uuuadc.top",
  "https://docker.anyhub.us.kg",
  "https://dockerhub.jobcher.com",
  "https://dockerhub.icu",
  "https://docker.ckyl.me",
  "https://docker.awsl9527.cn"
  ]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

cp ~/.vim/others/new_python_dockerfile Dockerfile
sudo docker build -t findsimilar-app .

sudo docker run --rm findsimilar-app ls /app/dist/
# sudo docker run -d findsimilar-app ls /app/dist/main
# sudo docker run --name findsimilar-app-container findsimilar-app

id=$(sudo docker ps -a | grep findsimilar-app | awk '{print $1}')
if [ ! -z "$id" ]; then
    sudo docker cp $id:/app/dist/main dist/findsimilar
fi

ids=$(sudo docker ps -a | grep 'findsimilar-app' | awk '{print $1}')
for id in ${(f)ids}; do
  sudo docker rm -f $id
done

mv ./dist/findsimilar -t ~/Downloads/

cp . -r -t "/media/echo/My Passport/"
echo "pip install . -i https://pypi.tuna.tsinghua.edu.cn/simple" > "/media/echo/My Passport/"

