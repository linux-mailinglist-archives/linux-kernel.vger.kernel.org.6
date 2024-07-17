Return-Path: <linux-kernel+bounces-254763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177FE933758
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97675283615
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC61864C;
	Wed, 17 Jul 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0sQhONX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6B171A5;
	Wed, 17 Jul 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198795; cv=none; b=prvpuAXYukATqNOr2hjJI6lIklPXan7soKqeQwGRVlR6GSE+tHKw5OdRPZ85jTFf3UcCZsvDkVazeotaQRibxQx30ad62dCi3W7kuvRFiHfLshob/NWc7Nz4mqYa8S6iSyiFoXK1iGrnkE707k6X+uVe+GE4YF0q//rnNSp/iV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198795; c=relaxed/simple;
	bh=gDkyXHZ+uvQOh5+CSatxWv2gpcXQE70zzlSXyGIc6hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtnoLwWrZGWMPiWtShr8VAT9EuuonTPBvGpP9L+mJMLGHlER2Wxl3u9CdZL1mDBa1947Bx6J3c0lpr/VU3MIFgEOsA1exFHVT1gp0bbHU3gy4jZg8htFte9qWD0ADJQIfd9VWy31hzhd3g4uPG3Iyv6fcFaHou4ddZcIaWU/AHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0sQhONX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DCEAC4AF0F;
	Wed, 17 Jul 2024 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721198794;
	bh=gDkyXHZ+uvQOh5+CSatxWv2gpcXQE70zzlSXyGIc6hE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j0sQhONXQkMQx0HLA7rnDBt+78XNSJuiAeA+Ihyzle1LMF9XJfg5z4XXolNJJS9Nd
	 MCxJ78I+e7j+rEB4dWC6Iy1d63/44JBIN1GNR3Q81iWGmnoKcwhQ+69jh+oskv6Hgu
	 He9IuaF/NC2Rlvy72qH+UU4sWHQLYHau2Yx3tsfj7dw0cutd9RsRQCQQV28y2iuuqf
	 0CDv718/VcieD7KqS8R4/ZaOQ8D2ErZ27q1J4NFKfxY6JeshoOpQ/bQRWt3ljxPC/3
	 H5ix9SIghltT0nnu3B4+KVulHSslwbuzbWhE58ZZXRDDZWAHsBCTl8ENNG14H3XIev
	 ASgYHp6nvmrjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B8C3DA42;
	Wed, 17 Jul 2024 06:46:34 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Date: Wed, 17 Jul 2024 14:46:27 +0800
Subject: [PATCH v3 2/2] hwmon: document: add gpd-fan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-gpd_fan-v3-2-8d7efb1263b7@gmail.com>
References: <20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com>
In-Reply-To: <20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com>
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
 zdkQWNzbVlnQm1sMmpHdDgvaC9wT3M5N3kreUNJazZBSWVaZk1PCkZGaXRkV3VCVlBML1ZqZE54
 ZFNKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWnBkb3hnQUt
 DUkErWFJkeS9JcU8zYUxvQi93TGdxNnBuS05NRWJNWGI1enZaME4zaXA1SndCbzAzd1dSL0NURQ
 pFTERiY0ozZ2N2QUpXYzd5MDU2WXd0UCs5VVRuaDczam9zcjR5dlRaMXdYNEs1MUIycFJFeHhvd
 ERPaUl6NXdDCjFSak5rYVZNNTVmT1VMWldYYmFVeW1zS1VpRnNLMGhLa0lhbEdmcTN5anNxY2Fq
 Wk1teWhGb3dkZkdNRW0ycmoKbE94aU5qM1RUVHVzTXNOdzFselJlcGZCMkRGYWpPYU5HbnRRa2Z
 ta3pmM0dlUEJBL3hZZEo1ajI2WFRGVnhnUgpVVG9mMWxUMGcra0MyN3dpZzZLNThNV3pQbkJ5cG
 JESGVjRDhyVytMUVAzT0QwVFE1a1ljS0FweDBkdDhTOEhIClUyZ1hmbnFkRXB0eUZpK2UxOXhXS
 mhhNlY0NHJ6NjNicmhtNFV5WDd2TzZMVitsRgo9dlVpQQotLS0tLUVORCBQR1AgTUVTU0FHRS0t
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



