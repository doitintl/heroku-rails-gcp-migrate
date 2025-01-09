#! /usr/bin/env bash

export PROJECT_ID=$(gcloud config get-value project) # my-project [CHANGEME]
export PROJECT_USER=$(gcloud config get-value core/account) # set current user
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")


############################################################
# initialize project for Terraform
# using short-lived token (1hr) instead of permanent key
############################################################
# create bucket for shared state
export BUCKET_NAME="$PROJECT_ID-tfstate"

gcloud storage buckets create gs://$BUCKET_NAME

# set tf env for Apple silicon env
export TFENV_ARCH=amd64
export TFENV_CONFIG_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/tfenv/${TFENV_ARCH}

# authenticate current user with short-lived token for tf
export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token)

# authenticate current user for local SDK testing
gcloud auth application-default login

