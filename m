Return-Path: <linux-kernel+bounces-255892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDC793464A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF84D1C21AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333C29422;
	Thu, 18 Jul 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0dphP4n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E71B86E2;
	Thu, 18 Jul 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269349; cv=none; b=T+iAU72nK5q+5KbD1fnDXEXE1UKKYHH/q0LnM/4nS7w6kIYCTQPZFrwbmTwVzZ43sGRWaXusJ4iUiI3mv5uFYxoDkNo9NhNwOl48tgJKm6PcAUo0xXMTZ0a4ifE6+zEtm69Q3JCK/VsPtQ2D9BNTRmLWgIRtNjqVuI+/RHtasHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269349; c=relaxed/simple;
	bh=gDkyXHZ+uvQOh5+CSatxWv2gpcXQE70zzlSXyGIc6hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U26zKziVCgy4HzQtpIvc2kQMTDBfas6cTDyLOkKB9cKgnPDfUGKSIVihgBg7AwZhTOLczg4GtPYJIyw9L7emWfyg92f42grmjIJuVlIN3Ef7n8Y77f5YyJnZvIhqkjNk+r0gdehutz+G+mPDxrVNVZiOaKcnHAiNN6KFSO0U2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0dphP4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAB64C4AF12;
	Thu, 18 Jul 2024 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721269348;
	bh=gDkyXHZ+uvQOh5+CSatxWv2gpcXQE70zzlSXyGIc6hE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A0dphP4nJn/3JPeId6DJUHW6gcD8hNLGS8Io2CfK1unCA4jB4kVQXQEwAa1yhnYF1
	 4Yky0HTOYwCpxVFUYwlheE/VINKh4xg7pSaPwjQetwR68hF7v5E9MZOKnoG2v4TRSY
	 1SYRdGKoKDcduS3m6AznAA/ocR8mZmuBteYKVf4GxASmX8hxncGm4bOnWh26/x/sJA
	 HgWbyF/AEL6LAXELJ8T9RXDyb1lNOEYN3NBQ9W+hy0zS4T45wzLMVN0L8H7dcLgOBB
	 ilKQ4kAOmEcMRpILWMDYhCWE+CN5gvdwZ5rfPsEhcL2o2vVeemPqte4sh7pBEYW33S
	 Lkx+E8gYeurow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB888C3DA6A;
	Thu, 18 Jul 2024 02:22:28 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Date: Thu, 18 Jul 2024 10:22:24 +0800
Subject: [PATCH v4 2/2] hwmon: document: add gpd-fan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-gpd_fan-v4-2-116e5431a9fe@gmail.com>
References: <20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com>
In-Reply-To: <20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841;
 i=Cryolitia@gmail.com; h=from:subject:message-id;
 bh=w5ysSKMT+Erogd22vy685m5vnNbd3B3fdSDLl++agfw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm1tSHhpRFl0SmswN3RiNXpxc0s4VlIrV3pRdzJqClFKQnFMeHAvMjdnaGd6a2Jl
 ZXlKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWnBoOFlnQUt
 DUkErWFJkeS9JcU8zVW45Q0FDVFR6bGRPMzBrVXpobHVLTzBYRnp1Z014Zit6OVlycWVsQllvcg
 pDUDQzZ2hNRTRKRGYvV1lEZ09BTVd1QmlVRHQ3OWJVb1B6NExoWHlTZGZHLzE3ZEg1VXN0L0xHR
 FJDMFJIU2RlCjAvNXQ4Y1dHcUduKzBKQk5VWjBielZNS29TNFhJSXY0U3JkZ08za0U0VU1RYkNQ
 dTYycW16aGxQVVlxZ1dlNlQKdjFpS1BwaXNMS2VqeUlLRE1Vd1l2dGpDdjBDZVBNSzQ4M04xUDl
 nRE5rWS9rOHVEY0d2b0JEdXlnUW9TdmFuZgorR0FmUFhDUExocEFvc29OaGtlUmI2aTVqU1NOMU
 FDNGxZZWdkUFYyYUdJeFZvZ2NxcmJwdHRaMlJOc1Z0VWRyCjIvN3UxZExrbU1vZWw0NDVSSmhPS
 E5rdng5SzgxY3hOMkNTbUFCbGp2aDFucExrdQo9VzdLeAotLS0tLUVORCBQR1AgTUVTU0FHRS0t
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
 Documentation/hwmon/gpd-fan.rst | 63 +++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst   |  1 +
 MAINTAINERS                     |  1 +
 3 files changed, 65 insertions(+)

diff --git a/Documentation/hwmon/gpd-fan.rst b/Documentation/hwmon/gpd-fan.rst
new file mode 100644
index 000000000000..68189cdc5b45
--- /dev/null
+++ b/Documentation/hwmon/gpd-fan.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver gpd-fan
+=========================
+
+Author:
+    - Cryolitia PukNgae <Cryolitia@gmail.com>
+
+Description
+------------
+
+Handheld devices from Shenzhen GPD Technology Co., Ltd. provide fan readings and fan control through
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
+  Force specific which module quirk should be used.
+  Use it like "gpd_fan_model=wm2".
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
+  Read Only. Reads current fan RPM.
+
+pwm1_enable
+  Read/Write. Enable manual fan control. Write "0" to disable control and run at
+  full speed. Write "1" to set to manual, write "2" to let the EC control decide
+  fan speed. Read this attribute to see current status.
+
+pwm1
+  Read/Write. Read this attribute to see current duty cycle in the range [0-255].
+  When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
+  to set fan speed.
+
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



