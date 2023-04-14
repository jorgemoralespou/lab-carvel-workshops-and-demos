Weave ytt templating into your own configuration, externalize values to variables, extract repeated snippets to functions, and make whole sections conditional.

Let's look at a simple example.

We want to to template a Pod and Service definition. We add some ytt constructs, conditionals and data-loading capabilities.

```editor:open-file
file: ~/exercises/demo.yaml
```

We define the schema for the values we want the users to input.

```editor:open-file
file: ~/exercises/schema.yaml
```

And these are an instance of user provided values that we want to use.

```editor:open-file
file: ~/exercises/values-a.yaml
```

We can see the output of the template rendering by doing:

```terminal:execute
command: ytt -f schema.yaml -f values-a.yaml -f demo.yaml
```

We can use different values to render the template.

```editor:open-file
file: ~/exercises/values-b.yaml
```

See the new output:

```terminal:execute
command: ytt -f schema.yaml -f values-b.yaml -f demo.yaml
```

**NOTE** that some values we did not provide come from the schema's default values

The schema provides some type validations:

```editor:select-matching-text
file: ~/exercises/schema.yaml
text: "#@schema/validation min_len=1, max_len=8"
```

See the new output:

```terminal:execute
command: ytt -f schema.yaml -f values-validation-error.yaml -f demo.yaml
```

And there's conditionals to render (or not) some output.

```editor:select-matching-text
file: ~/exercises/values-conditional.yaml
text: "enabled: false"
```

See the new output. The service has not been rendered this time.

```terminal:execute
command: ytt -f schema.yaml -f values-conditional.yaml -f demo.yaml
```
