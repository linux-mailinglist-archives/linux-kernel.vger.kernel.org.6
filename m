Return-Path: <linux-kernel+bounces-560296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8DA60200
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA061894063
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF41F4613;
	Thu, 13 Mar 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbDKHbKG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D01F4162;
	Thu, 13 Mar 2025 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896635; cv=none; b=VYXLH8+zrX3LYoMDUUO4fBLSutzHEuDdA12nEnrfdb8tnaC4gLb9kxue4LpS2Z4yde2QmaF/WNCOF46z5BvjnwjUFsnps4HPZSCs7rNkBptWFMsBeLpGJeEnwYMwyzciyk6ZJE7aqK0PJr1ETghylA63w4P7NAzpQ1Ma9DkJV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896635; c=relaxed/simple;
	bh=rSprVLq4wKErcyA52MkRJiFaUs3GUzkMVcq1+mxPIeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/gaj4rBBvETlwBgpJCIKQAZaIvSaf8nBYGbrJdYVkWLXYAnn6R4gYuiulJ2QyHErn/X3l7EmmTg8H8aIm/VvohKSqs2CPm4fDUNbn1v9mjc0Qq1LW/ppca1elY1yVejfshmDRi+lFMruMfotLNRinyGyI+dPgjXdz2Yk3DqHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbDKHbKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F62CC4CEE3;
	Thu, 13 Mar 2025 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741896635;
	bh=rSprVLq4wKErcyA52MkRJiFaUs3GUzkMVcq1+mxPIeU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BbDKHbKGZfviq5NHf3wowXQ3a0pW0paoxvxpk/g+N/cn2xLe/mdxc2hNBXI6h/c+x
	 Xa9Rz/pQZ66mLwB8aW1foP7uku5gdZeMvaWKQqRgxS5djDEPV9yAzjA9HJvEa7l2c8
	 2KyXRGSJecFjfXjAIwRNDGQGRAUJfDB6wG+jPYmBr9IBD8lXfYuC12uiikj5hM2OVD
	 eZJLPd82V3bpDNRBYevteX1zmuohQ0FmcIyS4X+IE0ShWsxnLF3MSY5wdQ31VyiQOU
	 YDvDO4Ek9bI2XdlERF+0glGOAY75mRsQyQ1iF/SC6FvWMJBTGUewVi6dvWlWDGyHnr
	 fnDzYNr7cxRBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB4C35FF4;
	Thu, 13 Mar 2025 20:10:35 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Date: Fri, 14 Mar 2025 04:10:31 +0800
Subject: [PATCH v6 2/2] hwmon: document: add gpd-fan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-gpd_fan-v6-2-1dc992050e42@gmail.com>
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
In-Reply-To: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>, 
 someone5678 <someone5678.dev@gmail.com>, 
 Justin Weiss <justin@justinweiss.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, command_block <mtf@ik.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3219;
 i=Cryolitia@gmail.com; s=20250314; h=from:subject:message-id;
 bh=yKEH2zZr/9pr9MCfA81S8Mz0acVtQK0WlJPfsK/+PBM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm4wenU0cFhHZVllTCtiTmk1TDFOMmdtQnRBZkFyCnQvMnMxZVlXR1EwMVdkay9w
 R3VKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWjlNN3VBQUt
 DUkErWFJkeS9JcU8zWmZyQ0FERmtPOXJJalhQanRzZ0ZqT0dmNTQvSnpEelVKemkyYnJzek0zcA
 piSGNyZEFmZnNMY1MrYkFFd29zL1pscVBxVWZ6dm1sK2V0K2M5VGRHb1dIeVQ2SS9jaEt0NVZTV
 Epod1RYTmtRCk1QMEs0Y085MFl2TVBTQ1g3Rnl6ZDBYT3l4eXdJQmw5b3ZEaG9yQlBmSURMTVhU
 ZUVCZjgyQ2V4S0VHYVB4ZTQKSjAzUzRhbUZ3R0xUSkwyU0pwY1h2clppYlorZGkzODVFTGIzNGx
 wODdPWVQ4VVVyOHJYcVd1enFZVGJkZUxxYwoxTStVNWZKaDdSZTFuRkgzbUJZZ043MXZUUk1wYW
 FxaHQ0T3NESW9IaFRxZ2d4UWp1bnlHM3pHcXZ4QmNNc3FECkNRMGhBRXpuOFRLT2pSYmdWYldIQ
 XhLanJ5Qk5jM1dMbjVwdmZ1N3UwRDRPeVNnTwo9VzZxUQotLS0tLUVORCBQR1AgTUVTU0FHRS0t
 LS0tCg==
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/20250314 with
 auth_id=358
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

From: Cryolitia PukNgae <Cryolitia@gmail.com>

Add GPD fan driver document

Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
---
 Documentation/hwmon/gpd-fan.rst | 71 +++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst   |  1 +
 MAINTAINERS                     |  1 +
 3 files changed, 73 insertions(+)

diff --git a/Documentation/hwmon/gpd-fan.rst b/Documentation/hwmon/gpd-fan.rst
new file mode 100644
index 0000000000000000000000000000000000000000..55059d1dfc5c6a1219c88c1c4c3c4c776fa79cdb
--- /dev/null
+++ b/Documentation/hwmon/gpd-fan.rst
@@ -0,0 +1,71 @@
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
+ - GPD Win Mini (HX370)
+ - GPD Pocket 4
+ - GPD Duo
+ - GPD Win Max 2 (6800U)
+ - GPD Win Max 2 2023 (7840U)
+ - GPD Win Max 2 2024 (8840U)
+ - GPD Win Max 2 2025 (HX370)
+ - GPD Win 4 (6800U)
+ - GPD Win 4 (7840U)
+
+Module parameters
+-----------------
+
+gpd_fan_board
+  Force specific which module quirk should be used.
+  Use it like "gpd_fan_board=wm2".
+
+   - wm2
+       - GPD Win 4 (7840U)
+       - GPD Win Max 2 (6800U)
+       - GPD Win Max 2 2023 (7840U)
+       - GPD Win Max 2 2024 (8840U)
+       - GPD Win Max 2 2025 (HX370)
+   - win4
+       - GPD Win 4 (6800U)
+   - win_mini
+       - GPD Win Mini (7840U)
+       - GPD Win Mini (8840U)
+       - GPD Win Mini (HX370)
+       - GPD Pocket 4
+       - GPD Duo
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
index 55f1111594b2e9ada4a881e5d4d8884f33256d1f..d5c7cd0cfdeb7059b6cd83050ae98aa7cb1334e6 100644
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
index 777ba74ccb07ccc0840c3cd34e7b4d98d726f964..20faebeae981e4b7619fb10331c50525d98db944 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9766,6 +9766,7 @@ GPD FAN DRIVER
 M:	Cryolitia PukNgae <Cryolitia@gmail.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
+F:	Documentation/hwmon/gpd-fan.rst
 F:	drivers/hwmon/gpd-fan.c
 
 GPD POCKET FAN DRIVER

-- 
2.48.1



