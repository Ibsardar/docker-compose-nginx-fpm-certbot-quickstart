# docker-compose-nginx-fpm-certbot-quickstart
 Docker Composed App with NGINX, PHP-FPM, and auto-renewing SSL via Certbot

---

## Quickstart:
- Drop the contents of `drop-into-your-project` into your project.

- Edit as needed using the **[guidelines below](https://github.com/Ibsardar/docker-compose-nginx-fpm-certbot-quickstart#what-to-edit-guide)**.

- Login to machine where docker-compose is installed.

- Pull your project (after the drop + any edits) onto the server.

- Navigate to your project's main directory (where `docker-compose.yml` is).

- Run `chmod +x init-letsencrypt.sh` so you can run the next command

- Run `./init-letsencrypt.sh` to get SSL certifcate(s)

- If you receive an error:

  - Make sure `etc\letsencrypt\<dnsprovider>.ini` exists and is correctly matching the API key given by your DNS provider
  - If you are not using DNS, make sure in `dns_cred_path` is set to an empty string in `init-letsencrypt.sh`

- Run `docker-compose build && docker-compose up`

---

## What-to-Edit Guide:

File | Detail | Example
--- | --- | ---
`dockerfiles/\*.Dockerfile` | Change `"IBRAHIM"` unless it is your name also (yay!) | `LABEL MAINTAINER="JOHN DOE"`
`dockerfiles/phpfpm.Dockerfile` | Uncomment `#ENTRYPOINT sh "${E_NGINX_ROOT}/server/init_phpfpm.sh"` if you want to have a custom entrypoint there instead of the default entrypoint (command(s) would be specified in `server/init_phpfpm.sh`) | `ENTRYPOINT sh "${E_NGINX_ROOT}/server/init_phpfpm.sh"`
`server/init_\*.sh` | Add your own set of commands to be run (will be run every time the container is started) | `echo container started!`
`server/vhost.conf` | Replace all instances of `example.org` with your website name | `example.org`
`server/vhost.conf` | Replace all instances of `/my/custom/root` to the directory you want to serve | `/var/www/html/public`
`.gitignore` | You can merge your existing `.gitignore` into this one | 
`docker-compose.yml` | Set the `NGINX_ROOT`. Must at least prepend the root set in `server/vhost.conf` | `NGINX_ROOT: /var/www/html`
`docker-compose.yml` | Change port numbers on the left (these are the exposed ports on your host machine) | `8080:80` *(if you want `example.com:8080`)*
`docker-compose.yml` | Change volume locations on the host server so they do not conflict with other running docker-compositions on the same host server | `/docker/\<MY_PROJECT\>/volumes/nginx_logs:/var/log/nginx`
`docker-compose.yml` | Change `digitalocean.ini` under `services.certbot_service.volumes` to `\<dnsprovider>.ini` or comment out if you are not using DNS | `/etc/letsencrypt/cloudflare.ini:/etc/letsencrypt/cloudflare.ini`
`index.php` | Everything in the `drop-into-your-project` folder is copied into your nginx root folder, so by default, `index.php` will be the home page | *put `index.php` in a new folder called `public` then set `NGINX_ROOT` as `/var/www/html` and `server/vhost.conf`'s root as `/var/www/html/public`*
`init-letsencrypt.sh` | Replace `domains_list=("example.com www.example.com" "anotha.one www.anotha.one")` with all domains you want to generate certificates for. Each string will generate 1 certificate for that set of domains | `domains_list=("example.com www.example.com")`
`init-letsencrypt.sh` | Set your email by replacing `your@email.com` | `johndoe@gmail.com`
`init-letsencrypt.sh` | Set `staging=1` if you just want to test generating fake certificates | `staging=1`
`init-letsencrypt.sh` | Replace all instances of `digitalocean` with the name of you DNS provider (see comments in the script file for more details) | `cloudflare`

---

#### Troubleshoot:
Run `docker-compose config --services` to check the names of services.

Run `docker-compose ps` to check the status of the services.

Run `docker container ls` to check the status of the containers.

Run `docker-compose exec <SERVICE_NAME> bash` to enter into an up and running service for further investigation. (use sh if bash not available)

Run `docker-compose build --no-cache && docker-compose up` to rebuild everything from scratch.

Run `docker system prune` to clean up everything docker related on your machine

---

#### Some Credits:

- https://github.com/wmnnd/nginx-certbot

- https://github.com/wmnnd/nginx-certbot/issues/70
