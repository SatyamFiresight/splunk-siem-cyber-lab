# Splunk-SIEM-Cyber-Lab

### Project Description
This project simulates a real-world Security Operations Center (SOC) environment. It uses **Splunk Enterprise** to centralize log collection, analyze network activity, and detect simulated cyber threats. The project demonstrates a fundamental skill in cybersecurity: leveraging a Security Information and Event Management (SIEM) tool to gain visibility into system activity and identify malicious behavior.

### Tools & Technologies Used
* **Splunk Enterprise:** The primary SIEM platform for log ingestion, analysis, and visualization.
* **Virtual Machine (VM):** A Linux-based VM (e.g., Ubuntu) that serves as the host for log generation.
* **Splunk Universal Forwarder:** An agent installed on the VM to securely send logs to the Splunk Enterprise server.
* **Attack Simulation Tools:** Tools such as `Nmap` (for port scanning) and brute-force scripts that were used to generate security-relevant logs.

### Project Architecture
The project architecture is a simple client-server model. The Splunk Universal Forwarder on the VM acts as a client, collecting specific log files and forwarding them to the Splunk Enterprise server. The server then indexes this data, allowing for real-time searching, analysis, and dashboard creation.



### Implementation Steps & Methodology
1.  **VM and Forwarder Setup:** A Linux VM was configured, and the Splunk Universal Forwarder was installed and configured to monitor critical security logs like `auth.log` and `syslog`.
2.  **Log Forwarding:** The forwarder was connected to the Splunk Enterprise server using an output group, ensuring all relevant logs were streamed to the Splunk Indexer.
3.  **Threat Simulation:** Common cybersecurity attacks were simulated against the VM to generate log data for analysis. Examples of simulated attacks include:
    * **Failed SSH Brute-Force Attempts:** Repeated, failed login attempts against a user account.
    * **Port Scanning:** Using tools like Nmap to scan for open ports on the VM.
4.  **Data Analysis & Dashboard Creation:** Splunk's Search Processing Language (SPL) was used to query the ingested logs. Dashboards were created to visualize key security metrics and identify threats at a glance.

### Analysis & Findings
The Splunk dashboards and reports successfully identified the simulated attacks, proving the effectiveness of the centralized monitoring setup. Key findings included:
* **Detection of brute-force attacks** by correlating multiple failed login attempts from a single source IP address.
* **Identification of port scans** by analyzing network traffic logs and detecting a high volume of connection attempts to various ports.

### Key Splunk Queries (SPL)
This project showcases my ability to write effective SPL queries to perform threat detection. The queries used for the dashboards are available in the `detection_queries.spl` file in this repository.

### Dashboard Screenshots
Here are screenshots of the Splunk dashboards created for this project, which provide a high-level overview of the detected security events.

* **Authentication Monitoring Dashboard:**
    _A screenshot showing failed login attempts, successful logins, and top source IPs for authentication activity._
    !

* **Port Scan & Network Activity Dashboard:**
    _A screenshot showing network connections, port scan attempts, and other network traffic anomalies._
    !

### Skills Demonstrated
* **Security Information and Event Management (SIEM):** Hands-on experience with a leading SIEM platform.
* **Log Analysis & Threat Hunting:** Ability to analyze raw log data to identify malicious activity and indicators of compromise (IOCs).
* **Splunk Search Processing Language (SPL):** Proficiency in writing custom queries for data analysis, reporting, and alerting.
* **Incident Detection & Response:** Understanding the first phase of incident response by identifying and triaging security events.

### Future Enhancements
* Integrate additional log sources (e.g., web server logs, firewall logs).
* Create automated alerts and notifications for critical security events.
* Develop more complex detection rules to identify advanced threats.
