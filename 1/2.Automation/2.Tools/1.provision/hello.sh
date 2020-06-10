#!/bin/bash
PWD=/home/admin
sudo sh -c "/usr/local/bin/gunicorn hello:app --workers 1"
