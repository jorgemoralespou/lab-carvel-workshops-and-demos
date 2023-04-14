We have an application that we want to package in a distributable bundle:

```editor:select-matching-text
file: ~/exercises/app.yaml
text: "image: (.*)"
isRegex: true
group: 1
```

Create image lock file for referred images in the app.

```terminal:execute
command: kbld -f app.yaml --imgpkg-lock-output .imgpkg/images.yml
```

Let's take a look at the images lock file:

```editor:open-file
file: ~/exercises/.imgpkg/images.yml
```

Create OCI bundle for our application:

```terminal:execute
command: imgpkg push -b {{ registry_host }}/my-bundle -f .
```

Relocate bundle with all referred images in one command

```terminal:execute
command: imgpkg copy -b {{ registry_host }}/my-bundle --to-repo {{ registry_host }}/my-bundle-new
```

Verify the contents of the relocated bundle. We extract it into a new folder `relocated`:

```terminal:execute
command: imgpkg pull -b {{ registry_host }}/my-bundle-new -o relocated
```

Verify the original image reference has been relocated:

```editor:select-matching-text
file: ~/exercises/relocated/.imgpkg/images.yml
text: "image: (.*)"
isRegex: true
group: 1
```
