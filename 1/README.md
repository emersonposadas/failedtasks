# SRE/DevOps Interview Questions
________________________________________________________________________________
Questions
---------

* Difference between TCP/UDP
* What happens when you type google.com into your browser and press enter?
* How does SSL work?
* How does DNS work? Explain how a computer at home/datacenter resolves a internal and external DNS query.
* Explain the following command:
`(date ; ps -ef | awk '{print $1}' | sort | uniq | wc -l ) >> Activity.log`
* How do you list open file handles?
* What is the difference between a soft link and a hard link?
* When and why would you use a hard link instead of a soft link?
* What is Docker?
* What is the use case for Docker over lets say Virtual Machines?

________________________________________________________________________________
Tasks
-----

### 1. Scripting/Coding
*Please provide your answers/scripts inside the `1.Coding` folder*

1. Automate the process of granting / revoking SSH access to a group of servers instances to a new developer.
You can use any script/tool you would prefer, please also explain the workflow of adding a new user.

2. Write a loop from 1 to 100 and for each number:
  - If the number is divisible by 3, write foo.
  - If the number is divisible by 5, write bar.
  - If the number is divisible by 3 and 5 (ex: 15), write foobar.
  - Otherwise, just print out the number.

### 2. Deployment and Automation
Imagine you’re starting a site called TheFooBarClub, first rule about the site, you dont talk about the foobar. You’re going to be writing articles about the latest and greatest in Automation. The first thing you decide to do is to make a very simple site using Python and Flask. Your team of developers are going to be adding features to the site. To help them speed their releases to Production, you also want to template and automate building an EC2 server. You do this by creating configuration playbooks that your servers can use to automatically install the needed software to run Python and Flask, and pull the latest Flask application repo to the server.

First, create the Flask app. This is the easy part! There’s a QuickStart Guide to working with Flask (http://flask.pocoo.org/docs/quickstart/). Just follow the directions, and don’t worry about making your site any fancier than what’s described in that documentation; getting your site to display “hello world” is fine.

While the developers are writing code, you want to allow them to deploy code themselves. They should be able to deploy the site remotely using any combination of tools like Ansible, Terraform, CloudFormation, awscli, bash, etc.

Here are the specs you want:
```
- OS: Debian Jessie 64-bit
- App Server: Gunicorn/Nginx (Native or Docker)
- Python: 2.7
- Flask: 0.12
```
#### Deliverables:
```
1. A folder inside `2.Automation` with the Flask app.
2. A folder inside `2.Automation` with the Ansible playbooks or other tools.
3. A cli tool (bash/python/etc.) that will:
  - Launch the EC2 server (EG: using aws cli utilities)
  - Bootstrap the server
  - Run the application
```

**DO NOT CHECK THIS INTO GITHUB WITH AWS KEYS OR SECRETS**

*For the AWS environment used for development you can utilize your own account and use AWS Free Tier resources or we can provide you to access to our account with limited permissions*

Remember to restrict port access, basic security guidelines.
Prefix all of your AWS resources (when possible) with your first name (example: firstname-lastname.TheFooBarClub.local).

I should be able to perform the following commands and then interact with a functioning app in my browser.
`ec2.sh <app> <environment> <num_servers> <server_size>`
*ex: ec2.sh hello_world dev 1 t1.micro*

This should return the IP address of the launched server, after which, I can open a browser to http://33.33.33.10 and see the Flask blog app come up!

### 3. Kubernetes
- Set up (in kubernetes/minikube) 2 pods with a java example app: https://github.com/stantonk/java-docker-example
- Load balance the traffic to the backends.
- Create policy to auto-heal or recreate the pod if it goes down or is unresponsive.
- Add a MySQL pod.

(Points below are optional, you can pick any of them. You can write a description, or
actually implement a solution)

- Can you do a HA of a database? Any way to keep the data persistent when pods are
recreated?
  - Having a volume or network database endpoint exposed to the pods
- How do you construct a CI/CD pipeline to this service? What kind of a deployment strategy would you consider?
  - 
- How do you Split your deployment into prd/qa/dev environment (assuming there is only one cluster).
- Please suggest basic monitoring solutions for your system.
- How do scale your service based on metrics? What kind of metrics would you collect and why?
  - Metrics to consider in this priority:
    1. Memory
    2. I/O activity
    3. Query times on the DB

#### Deliverables:
```
1. A yaml file with all required manifests to bring up the service on  minikube.
2. Answers/Implementation details for the optional questions(not mandatory).

Add the files to the folder 3.Kubernetes
```
---
In developing both the app and toolset please use GitHub and try to keep a decent history of how you approached the project.
