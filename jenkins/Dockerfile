FROM jenkins/jenkins:lts-jdk11

# skip the initial setup wizard
#ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# skip install plugins
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
