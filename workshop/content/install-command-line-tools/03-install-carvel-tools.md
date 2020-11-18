To deploy a management cluster and create workload clusters you only need the ``tkg`` command line tool. If you intend deloying any extension services to a cluster, you will also need to have the [Carvel](https://carvel.dev/) command line tools, ``kapp``, ``ytt``, ``imgpkg`` and ``kbld``. These are included in the same package that contained the ``tkg`` command line tool.

To move the Carvel command line tools into the ``bin`` directory and make them executable, run:

```execute-1
mkdir -p $HOME/bin && \
mv tkg/kapp-* $HOME/bin/kapp && \
mv tkg/ytt-* $HOME/bin/ytt && \
mv tkg/imgpkg-* $HOME/bin/imgpkg && \
mv tkg/kbld-* $HOME/bin/kbld && \
chmod +x $HOME/bin/*
```

Verify that the ``kapp`` command can be found by running:

```execute
kapp version
```
