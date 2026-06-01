# HotServlet

HotServlet is a lightweight deployment automation tool for Java Servlet development.

Instead of manually compiling servlet classes, packaging WAR files, copying them into Tomcat, and restarting the server, HotServlet automates the entire workflow with a single command.

## Features

* Automatic Apache Tomcat installation
* Gradle-based project build
* WAR file generation
* Automatic deployment to Tomcat
* Automatic cleanup of previous deployments
* Tomcat start/stop automation
* Simple one-command deployment

---

## Requirements

Before running HotServlet, make sure the following are installed:

### Operating System

* Linux (Recommended)
* Windows users should use:

  * WSL (Windows Subsystem for Linux), or
  * A Linux Virtual Machine

### Software Requirements

* JDK 17 or later
* curl
* Gradle Wrapper (`gradlew` included in the project)

Verify installation:

```bash
java -version
javac -version
curl --version
```

---

## Configure JAVA_HOME

HotServlet requires the `JAVA_HOME` environment variable.

Find your Java installation:

```bash
which java
```

Example output:

```bash
/usr/lib/jvm/jdk-21/bin/java
```

Set JAVA_HOME:

```bash
export JAVA_HOME=/usr/lib/jvm/jdk-21
export PATH=$JAVA_HOME/bin:$PATH
```

Verify:

```bash
echo $JAVA_HOME
```

To make it permanent, add the commands to:

```bash
~/.bashrc
```

Then reload:

```bash
source ~/.bashrc
```

---

## Project Structure

```text
HotServlet/
├── app/
│   ├── src/
│   ├── build.gradle
│   └── ...
├── gradlew
├── gradlew.bat
├── HotServlet
└── README.md
```

---

## Make the Script Executable

Before running HotServlet:

```bash
chmod +x HotServlet
```

---

## Running HotServlet

Execute:

```bash
./HotServlet
```

The script will:

1. Check if Apache Tomcat is installed
2. Download and install Tomcat if missing
3. Stop Tomcat
4. Remove old deployment files
5. Build the project using Gradle
6. Generate a WAR file
7. Deploy the WAR to Tomcat
8. Start Tomcat
9. Complete deployment automatically

---

## Example Workflow

Instead of manually doing:

```bash
./gradlew build

cp app.war apache-tomcat/webapps/

startup.sh
```

Simply run:

```bash
./HotServlet
```

---

## Future Improvements

* Automatic JAVA_HOME detection
* Hot reload support
* Tomcat Manager deployment
* Docker integration
* Project scaffolding command
* Deployment logs

---

## License

This project is open source and free to modify for learning and personal use.
