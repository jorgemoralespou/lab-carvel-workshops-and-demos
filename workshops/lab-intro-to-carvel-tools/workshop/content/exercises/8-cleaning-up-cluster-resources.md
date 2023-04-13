Given that `kapp` tracks all resources that were deployed to the Kubernetes cluster, deleting them is as easy as running the `kapp` delete command:

```execute
kapp delete -a simple-app
```

The initial output should be similar to:

```
Changes

Namespace                         Name                        Kind        Age  Op      Op st.  Wait to  Rs  Ri  
{{session_namespace}}  simple-app                  Deployment  24m  delete  -       delete   ok  -  
^                                 simple-app                  Endpoints   24m  -       -       delete   ok  -  
^                                 simple-app                  Service     24m  delete  -       delete   ok  -  
^                                 simple-app-5469bd48bf       ReplicaSet  12m  -       -       delete   ok  -  
^                                 simple-app-7466d7df75       ReplicaSet  24m  -       -       delete   ok  -  
^                                 simple-app-7676674444       ReplicaSet  7m   -       -       delete   ok  -  
^                                 simple-app-9d9bddc89        ReplicaSet  16m  -       -       delete   ok  -  
^                                 simple-app-9dcf64954        ReplicaSet  3m   -       -       delete   ok  -  
^                                 simple-app-9dcf64954-d7hzl  Pod         3m   -       -       delete   ok  -  

Op:      0 create, 2 delete, 0 update, 7 noop, 0 exists
Wait to: 0 reconcile, 9 delete, 0 noop

Continue? [yN]: 
```

When prompted, confirm that you do indeed want to delete all the resources:

```terminal:input
text: y
```

To verify that the namespace is empty run:

```execute
kubectl get all
```
