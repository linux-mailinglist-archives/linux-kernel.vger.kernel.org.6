Return-Path: <linux-kernel+bounces-253724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EDB9325EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06F8283731
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE28199EB1;
	Tue, 16 Jul 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8JmIpLa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF2199E92;
	Tue, 16 Jul 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130600; cv=none; b=hkVOQ+IaKuyiR0nFoL9TLwaoIwwM/YqOJy21KpHKQP/kLYc3W2As/YaOiYy81SjujeVuSWlVOiyYVljyCv3nwBQKKXF9CTZXPt+6vxwTxs6yL4+PMM6eJsIX9NeRcaZFnP4+lQa5IOR8XOw2+ukLgfl3Y1nExR08dblzVmKKzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130600; c=relaxed/simple;
	bh=Qp5s5s0qoFrNJjn2rOJBg5QOeCH0WdccBxFNyY6GhaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMi2uzGQ+ys0Bp9bu3tGx+oR7q9O2I+KPgsZRXChSHrvGeibwkt3NfypfD0VaIOcot5dtJFC7T3c84nWNj4sl5LRBtMKQ9VdqUq8Nqh2BlRYtLj+2bb1ICn+lhJGR5c1DoB+Plm3gxW25+YqyDSTLiLmJk2LEJOPtZ6yFc35C8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8JmIpLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A4E6C4AF0F;
	Tue, 16 Jul 2024 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721130600;
	bh=Qp5s5s0qoFrNJjn2rOJBg5QOeCH0WdccBxFNyY6GhaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B8JmIpLaAZeAbGcmudTjGR5Gybg5aOVhP1oHkxizq2rAjztO7/nwGy0RQ66h/bNkX
	 PZ46C0L0PtMDJO7CXi22W85q0nlTsZWvQROmW8zfhFYQz47ysKN0UrIynvi7/Ho5W6
	 pwjKlY1V/ddcoXlopvkjTfGO81STbEFNw0yKlMIAEY51b4kh/JsGXuwDeVRH9rxkut
	 z5Zs+3opt4JYkZq8wcE47YJrERwj2bagpVaYfaepLfrWVc62qGz4tE0F4WfmJa50Rr
	 vCa1Vn5zpHtUPBbMlNMg24Vsu9SEuVvv0++3z/Fwrg3UCwpYGyzsR9nzQVFLIUSgxe
	 r519v4q/YxeRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9EDC3DA49;
	Tue, 16 Jul 2024 11:50:00 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Date: Tue, 16 Jul 2024 19:49:54 +0800
Subject: [PATCH 2/2] hwmon: document: add gpd-fan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-gpd_fan-v1-2-34051dd71a06@gmail.com>
References: <20240716-gpd_fan-v1-0-34051dd71a06@gmail.com>
In-Reply-To: <20240716-gpd_fan-v1-0-34051dd71a06@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005;
 i=Cryolitia@gmail.com; h=from:subject:message-id;
 bh=rCZFBuF0vMkbp2kqIBIiOPphrC0bJhpWObJgki8Zq9M=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm1sbDVsOTlwMDU3YXZQVkZ1bjlkWFNqVG5tbld2CklaZEY1aDJuMmwvY1Jzd1lj
 L0NKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWnBaZVpRQUt
 DUkErWFJkeS9JcU8zUm9QQi85b1VDL3ZqOWpxWVFZcnlXLzR0c1VIenV6bkNkSFJkMlRRYXpOZg
 pFYmZoTFhBQ3REN1BrMURVckJYUUNtVHpuK0RrRWpMbk1qd0tyTmEvTHJOT3VBeFNuNHZWNmRhY
 XBvWmpyempiCmxieGJ1QmpBblhQbjVKWnJzOHlWRGNoYlBJM3lkd0w1cEVYaVlQQ0RoSEtxeDRu
 VDVWaWMwSjBrS3JXNlN6MGEKd3hKMUtqN3U1RDE3RFE0bndmUXEwOExub1VtamxML1N3eHZ3Y0l
 ZS0o3ODRUTzZvOTF1QklJL051ZmpDc1BCbgpVRENralJiWS9TY3dXNnJBeGpJclcxTmx4ZWFoSm
 w4TFBrZjFVRjZJcit1MnBia1lyRHp1U0xHd3h2SElJNWpUCklxZllHUE9tVHZ3RlVHNy9LaFV1d
 Gx0eER4SG8yS0xmdlAvK0lnN0oreXFaR0Y4VQo9SEYvYQotLS0tLUVORCBQR1AgTUVTU0FHRS0t
 LS0tCg==
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/default with
 auth_id=186
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

From: Cryolitia PukNgae <Cryolitia@gmail.com>

Add GPD fan driver document

Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
---
 Documentation/hwmon/gpd-fan.rst | 68 +++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst   |  1 +
 MAINTAINERS                     |  1 +
 3 files changed, 70 insertions(+)

diff --git a/Documentation/hwmon/gpd-fan.rst b/Documentation/hwmon/gpd-fan.rst
new file mode 100644
index 000000000000..0e5bb8b5feed
--- /dev/null
+++ b/Documentation/hwmon/gpd-fan.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver gpd-fan
+=========================
+
+Authors:
+    - Cryolitia PukNgae <Cryolitia@gmail.com>
+
+Description:
+------------
+
+Handheld devices from GPD provide fan readings and fan control through
+their embedded controllers.
+
+Supported devices
+-----------------
+
+Currently the driver supports the following handhelds:
+
+ - GPD Win Mini (7840U)
+ - GPD Win Mini (8840U)
+ - GPD Win Max 2
+ - GPD Win Max 2 2023 (7840U)
+ - GPD Win Max 2 2024 (8840U)
+ - GPD Win 4 (6800U)
+ - GPD Win 4 (7840U)
+
+Module parameters
+-----------------
+
+gpd_fan_model
+  Force specific which module quirk should be use.
+
+   - wm2
+       - GPD Win 4 (7840U)
+       - GPD Win Max 2 (6800U)
+       - GPD Win Max 2 2023 (7840U)
+       - GPD Win Max 2 2024 (8840U)
+   - win4
+       - GPD Win 4 (6800U)
+   - win_mini
+       - GPD Win Mini (7840U)
+       - GPD Win Mini (8840U)
+
+Sysfs entries
+-------------
+
+The following attributes are supported:
+
+fan1_input
+  Read Only. Reads current fan RMP.
+
+pwm1_enable
+  Read Write. Enable manual fan control. Write "0" to disable control and run
+  full speed. Write "1" to set to manual, write "2" to let the EC control decide
+  fan speed. Read this attribute to see current status.
+
+pwm1
+  Read Write. Read this attribute to see current duty cycle in the range [0-255].
+  When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
+  to set fan speed.
+
+pwm1_mode
+  Read Only. Should always be "1" by now to indicate the fan being under PWM mode.
+
+update_interval
+  Read Write. Set the interval in milliseconds to update fan speed. The default
+  and minimum time is 1 second
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 913c11390a45..97add26f53b7 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -80,6 +80,7 @@ Hardware Monitoring Kernel Drivers
    gigabyte_waterforce
    gsc-hwmon
    gl518sm
+   gpd-fan
    gxp-fan-ctrl
    hih6130
    hp-wmi-sensors
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ced72cec42b..5079b5bfe4b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9376,6 +9376,7 @@ GPD FAN DRIVER
 M:	Cryolitia PukNgae <Cryolitia@gmail.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
+F:	Documentation/hwmon/gpd-fan.rst
 F:	drivers/hwmon/gpd-fan.c
 
 GPD POCKET FAN DRIVER

-- 
2.45.2



