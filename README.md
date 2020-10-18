# GitLab SVG Proxy [<img alt="SVG Logo" src="https://www.vectorlogo.zone/logos/w3_svg/w3_svg-icon.svg" height="96" align="right"/>](https://logosear.ch/sources/index.html)

This server is a proxy to [GitLab](https://about.gitlab.com/) to serve SVG files.

The problem with linking directly is with the HTTP headers.  GitLab sends `Content-Disposition: attachment`, which makes the browser try to download the image instead of displaying it.

GitLab [does allow hotlinking](https://gitlab.com/gitlab-com/support-forum/-/issues/2314).

It should have been simple, but for some unknown reason (probably caching conflicts), I needed to delete a lot more headers when running in production.

## Running

It is a standard `Dockerfile`.  The only tricky bit is getting the port to be configurable.  See the `run.sh` for the parameters I use to run locally for development.

## Credits

[![Docker](https://www.vectorlogo.zone/logos/docker/docker-ar21.svg)](https://www.docker.com/ "Deployment")
[![Gitlab](https://www.vectorlogo.zone/logos/gitlab/gitlab-ar21.svg)](https://about.gitlab.com/ "Git Repositories")
[![Google Cloud Run](https://www.vectorlogo.zone/logos/google/google-ar21.svg)](https://cloud.google.com/run/ "Hosting")
[![nginx](https://www.vectorlogo.zone/logos/nginx/nginx-ar21.svg)](https://www.nginx.com/ "reverse-proxy webserver")
[![NodePing](https://www.vectorlogo.zone/logos/nodeping/nodeping-ar21.svg)](https://nodeping.com?rid=201109281250J5K3P "Uptime monitoring")
[![water.css](https://www.vectorlogo.zone/logos/netlifyapp_watercss/netlifyapp_watercss-ar21.svg)](https://watercss.netlify.app/ "Classless CSS")

## Tests

```bash
# API with raw suffix: content-disposition: attachment; filename="Samsung.svg"; filename*=UTF-8''Samsung.svg
curl --verbose https://gitlab.com/api/v4/projects/celebdor%2Fdesign/repository/files/logos%2FSamsung.svg/raw?ref=master

# raw subdirectory: content-disposition: attachment
curl --verbose https://gitlab.com/celebdor/design/raw/master/logos/Samsung.svg
```

## To Do

- [ ] send [canonical HTTP header](https://webmasters.googleblog.com/2011/06/supporting-relcanonical-http-headers.html)
- [ ] cleanup 50x error page
- [ ] is redirect.html ever used?
- [ ] robots.txt: allow /index.html
- [ ] switch to custom server using [fiber](https://github.com/gofiber/fiber/tree/master/middleware/proxy)
