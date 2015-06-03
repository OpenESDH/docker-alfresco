# Create an Alfresco docker image.

Run this command:
```
  docker build -t <tag> <directory containing Dockerfile>
```
where tag can be something like opene/alfresco:5.0.d

Now, a container can be started like this:
```
  docker run --name alfresco -d -p 8080:8080 opene/alfresco:5.0.d
```
