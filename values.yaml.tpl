master:
  installPlugins:
<<<<<<< values.yaml.tpl
    - matrix-auth:2.6.2
    - kubernetes:1.26.4
=======
    - matrix-auth:2.6.1
    - kubernetes:1.26.0
>>>>>>> values.yaml.tpl
    - docker-workflow:1.23
    - workflow-job:2.39
    - workflow-aggregator:2.6
    - credentials-binding:1.23
    - git:4.2.2
<<<<<<< values.yaml.tpl
    - credentials:2.3.12
=======
    - credentials:2.3.7
>>>>>>> values.yaml.tpl
    - job-dsl:1.77
    - kubernetes-cd:2.3.0
    - kubernetes-cli:1.8.3
  JCasC:
    enabled: true
<<<<<<< values.yaml.tpl
    pluginVersion: "1.42"
=======
    pluginVersion: "1.36"
>>>>>>> values.yaml.tpl
    configScripts:
      welcome-message: |
        jenkins:
          systemMessage: Welcome to our CI\CD server.  This Jenkins is configured and managed 'as code'.
        credentials:
          system:
            domainCredentials:
              - credentials:
%{ for credential in credentials }
                - usernamePassword:
                    scope: GLOBAL
                    id: "${credential.id}"
                    username: "${credential.username}"
                    password: "${credential.password}"
%{ endfor }
%{ for secret_string in secret_strings }
                - string:
                    scope: GLOBAL
                    id: "${secret_string.id}"
                    description: "${secret_string.description}"
                    secret: "${secret_string.secret}"
%{ endfor }
        jobs:
          - script: >
              pipelineJob('pipeline') {
                triggers {
                  cron('@daily')
                }
                definition {
                  cpsScm {
                    scriptPath 'Jenkinsfile'
                    scm {
                      git {
                        remote { url 'https://gitlab.hrz.tu-chemnitz.de/faeng--tu-chemnitz.de/react_docker_app.git'}
                        branch ''
                        extensions {}
                      }
                    }
                  }
                }
              }
  extraPorts:
  - name: ssh
    port: 2222
    externalPort: 22
    protocol: TCP
  - name: slvlistener-jen
    port: 50000
    externalPort: 50000
    protocol: TCP
  ingress:
    enabled: true
    apiVersion: 'networking.k8s.io/v1beta1'
    hostName: ${host_name}
    tls:
    - hosts:
      - ${host_name}
      secretName: letsencrypt-staging
    annotations:
      kubernetes.io/ingress.class: nginx
  serviceType: ClusterIP

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