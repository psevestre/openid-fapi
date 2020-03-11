* Build the build command using docker: 

```
docker build -t openid.net/xml2rfc .
```

* Build the HTML/TXT versions of the specification: 

```
docker run -v `pwd`:/data openid.net/xml2rfc Financial_API_Grant_Management.md
```

NOTE: If you are experiencing problems with the build process, you might try this build command

```
docker build -t openid.net/xml2rfc . --no-cache
```
