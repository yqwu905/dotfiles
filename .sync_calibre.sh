#!/usr/bin/env bash

rsync -azP ~/onedrive/Calibre root@video.yqwu.site:/video
ssh root@video.yqwu.site "systemctl restart calibre-server"
