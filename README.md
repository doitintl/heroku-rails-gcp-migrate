# Running Rails / Sidekiq on Docker
This example is how to containerize a Ruby on Rails app running Sidekiq 
workers and connecting to PostgreSQL and Redis data stores.

# Key files added or modified from default Rails app install
- `myapp/docker-run.sh` (example commands to start web and workers)
- `myapp/Dockerfile`
- `myapp/bin/docker-entrypoint` (added check for 'sidekiq' arg to toggle startup)
- `myapp/config/database.yml` (configured DB urls as env vars)
- `myapp/config/sidekiq.yml` (added test scheduled worker Hard Job)
- `myapp/config/routes.rb` (added /sidekiq dashboard route)
- `myapp/.env` (not committed to source control)

# Example .env file contents
```bash
RAILS_ENV="production"
RAILS_MASTER_KEY="< YOUR KEY FROM myapp/config/master.key >"
DATABASE_URL="postgres://myapp:<YOUR_PASSWORD>@host.docker.internal/myapp_development"
REDIS_URL="redis://host.docker.internal:6379/0"
APP_NAME="myapp"
IMAGE_NAME="myapp" # TODO :version-tag
```

# Running the app
1. Add necessary Docker files to existing repo
1. Configure correct Ruby/Rails version configs
1. Create `.env` file with correct values for above
1. Build and run containers in same directory as `Dockerfile` ...
    - Build image
        - `docker build -t myapp .`
    - Run containers
        - `./docker-run.sh` (or enter each command separately in terminal)
    - Check whether running
        - `docker ps`
        - if app missing, `docker ps -a`, then check logs
            - `docker logs myapp` or `docker logs myapp-worker`
    - Test in browser (this test app example URLs)
        - `http://localhost:3000/posts`
        - `http://localhost:3000/sidekiq`
    - Shut down apps
        - `docker stop myapp`
        - `docker stop myapp-worker`
    - Remove containers (optional)
        - `docker rm myapp`
        - `docker rm myapp-worker`

# Deploy to cloud
TODO
- `/cloud-config` folder with Terraform infra setup
- CI/CD to push images to container registry
- database migration
- traffic routing
