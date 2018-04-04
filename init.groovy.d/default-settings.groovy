import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule;
import hudson.security.csrf.DefaultCrumbIssuer;
import jenkins.util.SystemProperties;

def env = System.getenv()

def jenkins = Jenkins.getInstance()
jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))
jenkins.setAuthorizationStrategy(new GlobalMatrixAuthorizationStrategy())

def user = jenkins.getSecurityRealm().createAccount(env.JENKINS_USER, env.JENKINS_PASSWORD)
user.save()

jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, env.JENKINS_USER)

// Set the number of executors
// https://github.com/jenkinsci/docker#setting-the-number-of-executors
Jenkins.instance.setNumExecutors(env.JENKINS_EXECUTORS as Integer)

//////////////////////////////////////////
//
// Based on https://github.com/jenkinsci/jenkins/blob/master/core/src/main/java/jenkins/install/SetupWizard.java
//

// Disable jnlp by default, but honor system properties
jenkins.setSlaveAgentPort(SystemProperties.getInteger(Jenkins.class.getName()+".slaveAgentPort",-1));

// require a crumb issuer
jenkins.setCrumbIssuer(new DefaultCrumbIssuer(false));

// set master -> slave security:
jenkins.getInjector().getInstance(AdminWhitelistRule.class)
    .setMasterKillSwitch(false);

//
//
//////////////////////////////////////////

// Disable JNLP protocols except JNLP4
if(!jenkins.isQuietingDown()) {
    Set<String> agentProtocolsList = ['JNLP4-connect', 'Ping']
    if(!jenkins.getAgentProtocols().equals(agentProtocolsList)) {
        jenkins.setAgentProtocols(agentProtocolsList)
        println "Agent Protocols have changed.  Setting: ${agentProtocolsList}"
        jenkins.save()
    }
    else {
        println "Nothing changed.  Agent Protocols already configured: ${jenkins.getAgentProtocols()}"
    }
}
else {
    println 'Shutdown mode enabled.  Configure Agent Protocols SKIPPED.'
}

jenkins.save()
