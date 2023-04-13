We have deployed a single instance of our application, but what if we wanted
to deploy a second instance of the same application.

Since we used ``kapp`` to deploy the application let's try creating a second
deployment but tell ``kapp`` to use a different name for the application.

```terminal:execute
command: kapp deploy -a website-2 -f resources-v1/
```

For this you should get an error message similar to the following:

```
Target cluster 'https://10.96.0.1:443'

kapp: Error: Ownership errors:
- Resource 'service/website (v1) namespace: {{session_namespace}}' is already associated with a different app 'website' namespace: {{session_namespace}} (label 'kapp.k14s.io/app=1625719747378634752')
- Resource 'deployment/website (apps/v1) namespace: {{session_namespace}}' is already associated with a different app 'website' namespace: {{session_namespace}} (label 'kapp.k14s.io/app=1625719747378634752')
```

The reason for the error is that ``kapp`` detected for us that we were trying
to create a new application but where the names of resources we gave it clash
with existing resources in the cluster for another application.

Of note, if we had used ``kubectl apply`` instead of ``kapp`` it wouldn't have
warned us and would have just seen it as updating the existing resources. So
``kapp`` provides us a safety net in this case and tells us there is a
problem.

In order to be able to deploy a second instance of our application we would
either have to deploy it in a different namespace, or we would need to create
a copy of the resources so we can edit them and change any references to the
name of the application.

For the deployment resource we need to change the name of the resource, as
well as labels applied to the resources created from the
deployment.

```editor:select-matching-text
file: ~/exercises/resources-v1/deployment.yaml
text: "website"
```

Similarly in the service resource we would need to change the name of the
resource and the label selector used to match the pods the service should map
to.

```editor:select-matching-text
file: ~/exercises/resources-v1/service.yaml
text: "website"
```
