#!/bin/bash

git add . && git commit && git push origin master && gitbook build && cp -r _book/* ../ngsgarden_book && cd ../ngsgarden_book && git add . && git commit && git push origin gh-pages
