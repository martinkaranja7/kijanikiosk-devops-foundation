# Region and Multi-Availability Zone Reliability Thinking

## 1. Region Selection
- **Selected Region:** e.g., `af-south-1` (Cape Town) or `eu-west-1` (Ireland) depending on primary audience proximity.
- **Selection Criteria:**
  - **Latency:** Positioned close to primary user traffic in East/Southern Africa to minimize network round-trip time.
  - **Data Governance & Compliance:** Ensures local compliance with regional data protection requirements.
  - **Feature Availability:** Selected region supports all required managed cloud services (IAM, VPC, PaaS, Managed DBs).

## 2. Multi-Availability Zone (AZ) Architecture
- **Fault Tolerance:** Deploying across a minimum of **2 Availability Zones (e.g., AZ-a and AZ-b)** protects against data center outages caused by power loss, hardware failures, or network disruptions.
- **High Availability (HA):**
  - **Compute Layer:** Application instances are distributed equally across AZs behind a multi-AZ Application Load Balancer (ALB).
  - **Database Layer:** Uses a Multi-AZ database deployment with a primary instance in AZ-a and a synchronous standby replica in AZ-b for instant failover.
