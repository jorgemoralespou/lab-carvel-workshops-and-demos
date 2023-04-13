## Monitor what's being created

```terminal:execute
command: watch kubectl get all
session: 2
```
## Take a look at the app to deploy

```editor:open-file
file: ~/exercises/app.yaml
```

## Deploy an app

```terminal:execute
command: kapp deploy -a testapp -f app.yaml -y
```

## Change a value in the descriptor (scale from 1 to 2)

```editor:select-matching-text
file: ~/exercises/app.yaml
text: "replicas: (.*)"
isRegex: true
group: 1
```

```editor:replace-text-selection
file: ~/exercises/app.yaml
text: 2
```

## Apply the change

We provide `-c` flag to see the changes that will be applied.

```terminal:execute
command: kapp deploy -a testapp -f app.yaml -c
```

Confirm
```terminal:execute
command: Y
```
## Inspect the app

```terminal:execute
command: kapp inspect -a testapp
```

## List all the existing apps

```terminal:execute
command: kapp list
```

## Delete the app

```terminal:execute
command: kapp delete -a testapp
```

Confirm
```terminal:execute
command: Y
```