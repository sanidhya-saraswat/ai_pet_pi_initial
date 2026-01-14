## Run flow
1. Add GITHUB_TOKEN to a .env
2. Run command
    ```
    curl -fsSL https://raw.githubusercontent.com/sanidhya-saraswat/ai_pet_pi_initial/main/first_time_setup.bash | sudo bash
    ```

## Shutdown pi
sudo shutdown -h now
## Reboot pi
sudo reboot

# Docker
Kill all containers
```
docker kill $(docker ps -q)
```
Remove all containers
```
docker ps -aq | xargs -r docker rm -f
```