# DevOps Intern Final Assessment

**Name:** Muhammad
**Date:** August 15, 2026

## Project Description

This repository demonstrates a small but complete DevOps workflow using
open-source tooling: Git/GitHub, Linux shell scripting, Docker, GitHub
Actions (CI/CD), HashiCorp Nomad (job scheduling/deployment), and
Grafana Loki (log monitoring). Each step produces a real artifact used
by the next step, simulating a realistic DevOps pipeline end to end.

![CI](https://github.com/saadhussain07/devops-intern-final/actions/workflows/ci.yml/badge.svg)

---

## 1. Git & GitHub Setup

A public repository was created with this README and a sample script,
`hello.py`, which prints `Hello, DevOps!`.

Run it directly:

```bash
python hello.py
```

---

## 2. Linux & Scripting Basics

`scripts/sysinfo.sh` prints the current user, current date, and disk
usage.

Make it executable and run it:

```bash
chmod +x scripts/sysinfo.sh
./scripts/sysinfo.sh
```

Example output:

```
===== System Info =====
Current user: muhammad
Current date: Sat Aug 15 12:00:00 PKT 2026
Disk usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   20G   28G  42% /
```

---

## 3. Docker Basics

`Dockerfile` containerizes `hello.py` so it runs automatically on
container startup.

Build and run locally:

```bash
docker build -t devops-intern-final-hello .
docker run --rm devops-intern-final-hello
```

Expected output:

```
Hello, DevOps!
```

Since this was built and tested on a resource-limited machine, the
build and run were validated inside GitHub Actions instead
(see `.github/workflows/ci.yml`). Screenshot below shows the CI run
building the image and executing the container, printing
`Hello, DevOps!`:

![Docker build and run in CI](container.png)

---

## 4. CI/CD with GitHub Actions

`.github/workflows/ci.yml` runs `python hello.py` automatically on
every push to `main`. The status badge at the top of this README
reflects the latest run.

You can also trigger it manually from the **Actions** tab using
"workflow_dispatch."

Successful run, printing `Hello, DevOps!`:

![CI run](run.png)

---

## 5. Job Deployment with Nomad

`nomad/hello.nomad` defines a `service` type job that runs the Docker
image built in step 3, with minimal CPU/memory allocated.

Run it (requires a running Nomad agent, e.g. `nomad agent -dev`):

```bash
nomad job run nomad/hello.nomad
nomad job status hello-devops
```

> Note: build/tag the image locally first (`docker build -t
> devops-intern-final-hello:latest .`) so the Nomad Docker driver can
> find it, or push it to a registry and update the `image` field in
> `hello.nomad` accordingly.

**Not executed live in this submission** due to local machine resource
constraints (limited RAM, no WSL). The job file above is provided as
the deliverable and follows the required `type = "service"` spec with
minimal CPU/memory allocation.

---

## 6. Monitoring with Grafana Loki

Loki was run locally in Docker to collect logs from the containerized
job, and Grafana was used to view them. Full setup steps, the log
forwarding command, and the log-viewing query are documented in
[`monitoring/loki_setup.txt`](monitoring/loki_setup.txt).

*(Add a screenshot here of the Grafana Explore view showing the
"Hello, DevOps!" log line.)*

---

## 7. Extra Credit (Optional)

Not attempted in this submission. Potential next steps:
- `mlflow/` — log a dummy MLflow experiment run.
- `vm/` — deploy a VirtualBox VM and run the Docker/Nomad job inside it.

---

## Repository Structure

```
devops-intern-final/
├── README.md
├── hello.py
├── Dockerfile
├── scripts/
│   └── sysinfo.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── nomad/
│   └── hello.nomad
└── monitoring/
    └── loki_setup.txt
```