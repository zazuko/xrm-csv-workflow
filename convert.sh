#!/bin/sh
npm install
npm run db:create
npm run xrm:sources
npm run rdf:create