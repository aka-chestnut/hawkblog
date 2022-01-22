#!/bin/bash

hugo new --kind $1 $2
nvim ./content/$2

