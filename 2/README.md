# Recruitment Task
This is a recruitment task for a DevOps Engineer role at .

The task is meant to test your Kubernetes and Terraform skills, as well as using Terraform providers (if you already know the one we are requiring, that's a plus for you) and general coding style and habits. Treat this task as an opportunity to show us how you would work on a real-life project.

# Overview
The objective is to build and host a small web application on a Kubernetes cluster ([minikube](https://github.com/kubernetes/minikube) for simplicity) using the [Terraform Provider for Kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html).

# Web Application Build and Web Server
The `web-application-build` directory includes a `Dockerfile` describing the build process of a web-application. For simplicity in this recruiting task the `Dockerfile` just takes a `index.html` file and outputs it again, but imagine it is a complex static website build process instead.

Make the `web-application-build` Docker image available to the `minikube` cluster using a local Docker registry or by creating the image right inside the `minikube` Docker environment.

Configure Kubernetes to run the build container and serve the output afterwards through a webserver of your choice. The webserver is running on the Kubernetes cluster and shall be accessible through the `minikube` IP 192.168.XXX.XXX on port 1337.

# Expectations
* Create all resources in Kubernetes under a dedicated namespace.
* After running `terraform init && terraform apply` the resources on the Kubernetes cluster are created.
* The `index.html` page is served by entering `http://<:MINIKUBE_IP>:1337`.
* There are 3 replicas of the webserver configured to be run on the Kubernetes cluster.
* Document the steps to deploy the web-application in this README file.

# Technical Requirements and Process
* [minikube](https://github.com/kubernetes/minikube) is used to serve a Kubernetes cluster. We will test the Terraform configuration against a local `minikube` on our end.
* You must use the [Terraform Provider for Kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html) to create Kubernetes resources (i.e. Deployment and Service).
* Please work in a branch and create a pull request to merge into the master branch assigned to `@` once you are finished.
* Don't forget to checkin the `terraform.tfstate` file to your branch.
* We want to see a nice solution you happily submitted. We don't want you to do this task in a hurry just to finish it before the upcoming interview. If you need more time we are happy to reschedule the interview. However, we think, that this task should take approximately 4 dedicated work hours.
* If you are stuck with any aspect of the task, please still try to complete the solution, but mention or document, that you did not take care about a specific aspect. It still should feel like a good solution.
* If you have any questions please don't hesitate to ask by filing an issue here on Github or sending a mail to Talent / Diana.

# Sources & Docs
* https://www.terraform.io/docs/providers/kubernetes/index.html
* https://github.com/kubernetes/minikube
