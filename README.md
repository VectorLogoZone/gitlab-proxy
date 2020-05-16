# GitLab SVG Proxy

This server is a proxy to [GitLab](https://about.gitlab.com/) to serve SVG files.

The problem with linking directly is with the HTTP headers.  GitLab sends `Content-Disposition: attachment`, which makes the browser try to download the image instead of displaying it.

GitLab [does allow hotlinking](https://gitlab.com/gitlab-com/support-forum/-/issues/2314).

## Credits

[![Docker](https://www.vectorlogo.zone/logos/docker/docker-ar21.svg)](https://www.docker.com/ "Deployment")
[![Gitlab](https://www.vectorlogo.zone/logos/gitlab/gitlab-ar21.svg)](https://about.gitlab.com/ "Git Repositories")
[![Google Cloud Run](https://www.vectorlogo.zone/logos/google/google-ar21.svg)](https://cloud.google.com/run/ "Hosting")
[![nginx](https://www.vectorlogo.zone/logos/nginx/nginx-ar21.svg)](https://www.nginx.com/ "reverse-proxy webserver")

- [water.css](https://watercss.netlify.app/)

## Tests

```bash
# API with raw suffix: content-disposition: attachment; filename="Samsung.svg"; filename*=UTF-8''Samsung.svg
curl --verbose https://gitlab.com/api/v4/projects/celebdor%2Fdesign/repository/files/logos%2FSamsung.svg/raw?ref=master

# raw subdirectory: content-disposition: attachment
curl --verbose https://gitlab.com/celebdor/design/raw/master/logos/Samsung.svg
```

## To Do

- [ ] status.json
- [ ] license
- [ ] contributing
- [ ] caching on the nginx server [docs](https://www.nginx.com/blog/nginx-caching-guide/).  Do I need this if CloudFlare is already caching?
