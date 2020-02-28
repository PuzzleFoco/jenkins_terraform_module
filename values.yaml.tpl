master:
  numExecutors: ${master.numExecutors}

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
