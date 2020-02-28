master:
  numExecutors: ${master.numExecutors}
  extraPorts:
  - name: ssh
    port: 2222
    externalPort: 22
    protocol: TCP
  - name: slvlistener-jen
    port: 50000
    externalPort: 50000
    protocol: TCP

agent:
  enabled: ${agent.enabled}
  image: ${agent.image}
  tag: ${agent.tag}
  alwaysPullImage: ${agent.alwaysPullImage}
  privileged: true
  volumes:
    - type: HostPath
      hostPath: /var/run/docker.sock
      mountPath: /var/run/docker.sock

networkPolicy:
  enabled: true