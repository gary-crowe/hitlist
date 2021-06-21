# Notes for Openshift3
I was unable to build an Openshift4 cluster so have had to settle for Openshift 3 on my home system.
These are some useful notes.

## Create User Accounts
You will be using the HTPasswdPasswordIdentityProvider provider, you need to generate these user accounts.
You can use the httpd-tools package to obtain the htpasswd binary that can generate these accounts.

```
yum -y install httpd-tools
```
### Create a user account.
```
touch /etc/origin/master/htpasswd
htpasswd -b /etc/origin/master/htpasswd admin redhat
```
You have created a user, admin, with the password, redhat.

### Restart OpenShift services for authentication management 
``
master-restart api
master-restart controllers
```
### Give this user account cluster-admin privileges, which allows it to do everything.
```
$ oc adm policy add-cluster-role-to-user cluster-admin admin
```
NB. When running oc adm commands, you should run them only from the first master listed in the Ansible host inventory file, by default /etc/ansible/hosts.

# Connecting to a running pod under Openshift:
Thes say you have SQL running in a pod in a project.  To connect to that mysql port and run sql commands:
Open a terminal and run:
```
oc port-forward mysql-openshift-1-glqrp 3306:3306
```
Leave that terminal open, then from another you can populate your content.
```
mysql -h localhost -P 3306 --protocol=tcp -u gary -pXXXXX offenders < sqlscripts/CreateTable.sql
```
