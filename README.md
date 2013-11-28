# docker-workbench

This is my personal docker workbench.  I use this workbench for linking to running dockers that expose an ssh port.  This allows me to administrate and debug long living containers.  The workbench containers themselves are meant to be disposable and not long lived.

## Image Creation

```
$ sudo docker build -t="paintedfox/workbench" .
```

## Container Creation / Running

This example shows how to link the workbench to a running container.  It assumes the running container's name is *container* and gives it the alias *child*, but you can modify this to meet your needs.

```
$ sudo docker run -t -i -link container:child paintedfox/workbench
```
