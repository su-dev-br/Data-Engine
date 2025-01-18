

# venv set up
python  -m venv "venv"  
.\venv\Scripts\activate

# volume
docker volume ls    
docker volume prune -f
docker volume rm $(docker volume ls -q)
