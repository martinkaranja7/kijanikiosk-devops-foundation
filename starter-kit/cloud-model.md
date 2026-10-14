# Cloud Service Model Justification

## Selection: Platform as a Service (PaaS) / Containerized PaaS

For the initial launch of the KijaniKiosk platform, we recommend utilizing a **Platform as a Service (PaaS)** model (such as AWS Elastic Beanstalk, Google Cloud Run, or AWS App Runner / ECS).

## Justification

### 1. Focus on Core Business Logic
As an early-stage platform, engineering effort must be directed toward customer-facing feature development rather than infrastructure management. PaaS abstracts host management, OS patching, and low-level provisioning.

### 2. Speed to Market & Operational Simplicity
IaaS requires manual setup of compute nodes, load balancers, auto-scaling groups, and OS maintenance. PaaS provides built-in auto-scaling, load balancing, and health checks out of the box.

### 3. Cost Efficiency
PaaS allows KijaniKiosk to scale resources up or down automatically based on incoming web traffic, avoiding the costs of idle, over-provisioned IaaS virtual machines.

## Future Evolution (IaaS / Hybrid Transition)
As traffic grows significantly and custom networking/performance tuning is needed, individual components (such as dedicated database clusters or high-throughput microservices) can be migrated to an **IaaS** model (e.g., bare EC2 instances or custom Kubernetes clusters).
