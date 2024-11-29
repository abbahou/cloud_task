

# **Web Server Setup Script**

## **Instructions**

### **2. Make the Script Executable**
Run the following command to grant execution permissions:

```bash
chmod +x installsh
```

---

### **3. Run the Script**
To set up the web server, use:

```bash
./installsh [web_server]
```

Replace `[web_server]` with either:

- `nginx` for Nginx
- `apache2` for Apache

#### **Examples**
Install and configure Nginx:
```bash
./installsh nginx
```

Install and configure Apache2:
```bash
./installsh apache2
```

---

### **4. Access the Web Page**
Once the script completes, access the web page using the server's public IP:

```plaintext
http://<your-public-ip>
```

---

