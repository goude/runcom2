#!/usr/bin/env bash

set -e

nvim +PlugClean +PlugInstall +PlugUpdate +quit!
