Return-Path: <linux-kernel+bounces-280513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312394CB84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585A21C212D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E27176AA6;
	Fri,  9 Aug 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC3lc+gl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D526AD4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189045; cv=none; b=EMaXKwNjDKRN9ZYcmFo+bhtiJtTbDmGcKRSCscpuPmhPVk9uM56vZwDao7ZCy+HSWABKqERT41d+SYWVzb4ngUmi+Bf+vGSKHNzrYfMor10iLJDBOoWHkgo1E2pDWyXybATmM32u7TuJU5nim3TczUTozJyCTGRq+Np+IBjntgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189045; c=relaxed/simple;
	bh=eWcGvlv/zibhmLxKJncnRTRJYnTbYygyTC6z/TtIal8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0QF7l5S3vtiRJVVwdLKNVdW7aTz+VSCZUkoFDUPQXXtdsDZjEdQjztM6zP8M5tp5Jsqu3MjQ//egF/P396YNewGjhxPbrOLw2iJQTBMckaOli/kd1LmJlf2obkmE5jmgfHGUAZ2qzaa/db2uInxELXHYA3D4dGCqrUj22gNUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC3lc+gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE7DC32782;
	Fri,  9 Aug 2024 07:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723189043;
	bh=eWcGvlv/zibhmLxKJncnRTRJYnTbYygyTC6z/TtIal8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mC3lc+glPyGSi3HB7RSpFOh8VkgX1YsbNvUjAC2D38HzzBd9o5wGXZO7bs06Ae1u7
	 6UhnGrE4PX42nG4WkUrIMqmOdrVREu7vVlIwxfrH7endbd2vEupxQpQyQswZQXe1o9
	 gpQPu1zqZjkyk1gce8ycKI5SSRSUKPgHemX3kX6ZxxQwOCZJgNioPMiPxgDLbr8R66
	 coZYVhrSm1c3CGd3SPp6hcmgCg6kgbswQXj9g7T22wzvTWMrYHNd9TSqkoWsXQUHGT
	 PIB9VcvViHAl93jsPOW6gtXd1tGEmJLADC0Z5CCWo/kfoH3yFuvhqsHR8Gi5Ty6Fs5
	 hxVkTN+kl5FHQ==
Date: Fri, 9 Aug 2024 09:37:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240809093718.095d0a34@foz.lan>
In-Reply-To: <20240809082609.1864eabe@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
	<CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
	<20240809004137.01f97da2@foz.lan>
	<20240809082609.1864eabe@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 9 Aug 2024 08:26:09 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 9 Aug 2024 00:41:37 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > > You should be able to use e.g.
> > > 
> > > legacy.py's QEMUMonitorProtocol class for synchronous connections, e.g.
> > > 
> > > from qemu.qmp.legacy import QEMUMonitorProtocol
> > > 
> > > qmp = QEMUMonitorProtocol((host, port))
> > > qmp.connect(negotiate=True)  
> > 
> > That sounds interesting! I give it a try.
> 
> I applied the enclosed patch at the end of my patch series, but
> somehow it is not working. For whatever reason, connect() is
> raising a StateError apparently due to Runstate.CONNECTING.
> 
> I tried both as declaring (see enclosed patch):
> 
> 	class qmp(QEMUMonitorProtocol)
> 
> and using:
> 
> -        super().__init__(self.host, self.port)
> +        self.qmp_monitor = QEMUMonitorProtocol(self.host, self.port)
> 
> On both cases, it keeps waiting forever for a connection.

Nevermind, placing host/post on a tuple made it work.

The enclosed patch converts the script to use QEMUMonitorProtocol.

I'll fold it with the script for the next spin of this series.

Regards,
Mauro

---

[PATCH] scripts/qmp_helper.py: use QEMUMonitorProtocol class

Instead of reinventing the wheel, let's use QEMUMonitorProtocol.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index 756935a2263c..f869f07860b8 100644
--- a/scripts/arm_processor_error.py
+++ b/scripts/arm_processor_error.py
@@ -169,14 +169,11 @@ def send_cper(self, args):
         if args.mpidr:
             cper["mpidr-el1"] = arg["mpidr"]
         elif cpus:
-            get_mpidr = {
-                "execute": "qom-get",
-                "arguments": {
-                    'path': cpus[0],
-                    'property': "x-mpidr"
-                }
+            cmd_arg = {
+                'path': cpus[0],
+                'property': "x-mpidr"
             }
-            ret = qmp_cmd.send_cmd(get_mpidr, may_open=True)
+            ret = qmp_cmd.send_cmd("qom-get", cmd_arg, may_open=True)
             if isinstance(ret, int):
                 cper["mpidr-el1"] = ret
             else:
@@ -291,8 +288,7 @@ def send_cper(self, args):
         context_info_num = 0
 
         if ctx:
-            ret = qmp_cmd.send_cmd('{ "execute": "query-target" }',
-                                   may_open=True)
+            ret = qmp_cmd.send_cmd("query-target", may_open=True)
 
             default_ctx = self.CONTEXT_MISC_REG
 
@@ -363,14 +359,11 @@ def send_cper(self, args):
 
         if "midr-el1" not in arg:
             if cpus:
-                get_mpidr = {
-                    "execute": "qom-get",
-                    "arguments": {
-                        'path': cpus[0],
-                        'property': "midr"
-                    }
+                cmd_arg = {
+                    'path': cpus[0],
+                    'property': "midr"
                 }
-                ret = qmp_cmd.send_cmd(get_mpidr, may_open=True)
+                ret = qmp_cmd.send_cmd("qom-get", cmd_arg, may_open=True)
                 if isinstance(ret, int):
                     arg["midr-el1"] = ret
 
diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 7214c15c6718..e2e0a881f6c1 100644
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -9,6 +9,19 @@
 import socket
 import sys
 
+from os import path
+
+try:
+    qemu_dir = path.abspath(path.dirname(path.dirname(__file__)))
+    sys.path.append(path.join(qemu_dir, 'python'))
+
+    from qemu.qmp.legacy import QEMUMonitorProtocol
+
+except ModuleNotFoundError as exc:
+    print(f"Module '{exc.name}' not found.")
+    print("Try export PYTHONPATH=top-qemu-dir/python or run from top-qemu-dir")
+    sys.exit(1)
+
 from base64 import b64encode
 
 class qmp:
@@ -16,26 +29,23 @@ class qmp:
     Opens a connection and send/receive QMP commands.
     """
 
-    def send_cmd(self, command, may_open=False, return_error=True):
+    def send_cmd(self, command, args=None, may_open=False, return_error=True):
         """Send a command to QMP, optinally opening a connection"""
 
         if may_open:
             self._connect()
-        elif not self.socket:
-            return None
+        elif not self.connected:
+            return False
 
-        if isinstance(command, dict):
-            data = json.dumps(command).encode("utf-8")
-        else:
-            data = command.encode("utf-8")
+        msg = { 'execute': command }
+        if args:
+            msg['arguments'] = args
 
-        self.socket.sendall(data)
-        data = self.socket.recv(1024)
         try:
-            obj = json.loads(data.decode("utf-8"))
-        except json.JSONDecodeError as e:
-            print(f"Invalid QMP answer: {e}")
-            self._close()
+            obj = self.qmp_monitor.cmd_obj(msg)
+        except Exception as e:
+            print(f"Command: {command}")
+            print(f"Failed to inject error: {e}.")
             return None
 
         if "return" in obj:
@@ -49,6 +59,7 @@ def send_cmd(self, command, may_open=False, return_error=True):
         elif isinstance(obj.get("error"), dict):
             error = obj["error"]
             if return_error:
+                print(f"Command: {msg}")
                 print(f'{error["class"]}: {error["desc"]}')
         else:
             print(json.dumps(obj))
@@ -57,75 +68,37 @@ def send_cmd(self, command, may_open=False, return_error=True):
 
     def _close(self):
         """Shutdown and close the socket, if opened"""
-        if not self.socket:
+        if not self.connected:
             return
 
-        self.socket.shutdown(socket.SHUT_WR)
-        while 1:
-            data = self.socket.recv(1024)
-            if data == b"":
-                break
-            try:
-                obj = json.loads(data.decode("utf-8"))
-            except json.JSONDecodeError as e:
-                print(f"Invalid QMP answer: {e}")
-                self.socket.close()
-                self.socket = None
-                return
-
-            if isinstance(obj.get("return"), dict):
-                print(json.dumps(obj["return"]))
-            if isinstance(obj.get("error"), dict):
-                error = obj["error"]
-                print(f'{error["class"]}: {error["desc"]}')
-            else:
-                print(json.dumps(obj))
-
-        self.socket.close()
-        self.socket = None
+        self.qmp_monitor.close()
+        self.connected = False
 
     def _connect(self):
         """Connect to a QMP TCP/IP port, if not connected yet"""
 
-        if self.socket:
+        if self.connected:
             return True
 
-        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
         try:
-            self.socket.connect((self.host, self.port))
-        except ConnectionRefusedError:
+            ret = self.qmp_monitor.connect(negotiate=True)
+        except ConnectionError:
             sys.exit(f"Can't connect to QMP host {self.host}:{self.port}")
-
-        data = self.socket.recv(1024)
-        try:
-            obj = json.loads(data.decode("utf-8"))
-        except json.JSONDecodeError as e:
-            print(f"Invalid QMP answer: {e}")
-            self._close()
             return False
 
-        if "QMP" not in obj:
-            print(f"Invalid QMP answer: {data.decode('utf-8')}")
-            self._close()
-            return False
-
-        result = self.send_cmd('{ "execute": "qmp_capabilities" }')
-        if not result:
-            self._close()
-            return False
+        self.connected = True
 
         return True
 
     def __init__(self, host, port, debug=False):
         """Initialize variables used by the QMP send logic"""
 
-        self.socket = None
+        self.connected = False
         self.host = host
         self.port = port
         self.debug = debug
 
-    def __del__(self):
-        self._close()
+        self.qmp_monitor = QEMUMonitorProtocol(address=(self.host, self.port))
 
     #
     # Socket QMP send command
@@ -142,9 +115,6 @@ def send_cper(self, guid, data):
             }
         }
 
-        command = '{ "execute": "ghes-cper", '
-        command += '"arguments": ' + json.dumps(cmd_arg) + " }"
-
         if self.debug:
             print(f"GUID: {guid}")
             print("CPER:")
@@ -168,7 +138,7 @@ def send_cper(self, guid, data):
 
         self._connect()
 
-        if self.send_cmd(command):
+        if self.send_cmd("ghes-cper", cmd_arg):
             print("Error injected.")
 
     def search_qom(self, path, prop, regex):
@@ -185,14 +155,11 @@ def search_qom(self, path, prop, regex):
         i = 0
         while 1:
             dev = f"{path}[{i}]"
-            cmd =  {
-                "execute": "qom-get",
-                "arguments": {
-                    'path': dev,
-                    'property': prop
-                }
+            args = {
+                'path': dev,
+                'property': prop
             }
-            ret = self.send_cmd(cmd, may_open=True, return_error=False)
+            ret = self.send_cmd("qom-get", args, may_open=True, return_error=False)
             if not ret:
                 break
 


