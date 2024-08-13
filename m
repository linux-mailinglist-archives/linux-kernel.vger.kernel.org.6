Return-Path: <linux-kernel+bounces-284214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75594FE85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FD21C22B88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9565C14B957;
	Tue, 13 Aug 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mN+xRphz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WXgKmpTg"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90113BC3D;
	Tue, 13 Aug 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533450; cv=none; b=J54etZwRnKmzdlWSdEWErWnNeq+YoinqoTgGHOo5YiSyztWtx3VvrfOOD5S5NJ+NDnVO8ga/GaZg97Y4ViBSNsyVo1mYajmHvMvhiG8V1h2I5tHS2J0GLdYYx/4BTgB+1NUbhOFX8dxjkMwOCTbC3+Hd5NecTsK1dEEVLt9Ab20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533450; c=relaxed/simple;
	bh=bDIxtH7sIv8KtAN8XTLyPoE+1YKRCDo2/3TVd0v/iMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q97/0oYgtHv8J425meUNK+UlhEMrirfRjW5S/nuLi4ytUrM0NFpNZUbGlgd/+WiDfzOnhkkbXafe0GyKcFAsSMbjrZ2nTrZcjjd9NdeD7UFuA7AiZeZogEavjb3VkE4l/aw0hqOhEIZoD2VBKazR0d+62E9Pu78GzEEk/+lH+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mN+xRphz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=WXgKmpTg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533448; x=1755069448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QK9TXlYGghAHZAZREBdsCdKD2VrX25QU93Lv1IQVQT0=;
  b=mN+xRphz61WEoiTQHtauL6JSarVXCBrGFtCo7IlFlMvqp+DempNKS+q6
   7DOXtz6dKvw/oZ2pkTK2pzKwxc0jivQfZMP371PEz6qmm/S79IdiOc4s9
   UAAis+EU650TW8xaw4Br7wQa9D3MHpN8bElj0+hEJYiR5/kYI9f9ChZtJ
   lb260D6Ytcq4xTNpeCZ7IWwit2//B+moZh2gtMq1X2yS9yLfqaRc4dDvj
   gOpFSu7Vk9R9ykXQ8CrlszrvLFhXez04PJyMMAdL4EWSHvMczY25NPOU7
   WzDEqk1cqNrH5c7UcJzujQcKT/jmk1qDzlEAtilnYkOnv+PMIMYTMlLqW
   A==;
X-CSE-ConnectionGUID: uENQW/1aQyCsifSPlHbieQ==
X-CSE-MsgGUID: AbQDqFFUSYio7wujnur3wg==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375840"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:26 +0200
X-CheckPoint: {66BB0886-3-FF00FE11-F2A862FD}
X-MAIL-CPID: 6779B41CD9D0C5B8701B692E717EF3A8_5
X-Control-Analysis: str=0001.0A782F16.66BB0886.006A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 859FF16423A;
	Tue, 13 Aug 2024 09:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533441; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QK9TXlYGghAHZAZREBdsCdKD2VrX25QU93Lv1IQVQT0=;
	b=WXgKmpTgbUNaVAsW9b5oYTSIIVHabUJ+V/fIPd4QNN1QiT9Ie5ODSofZkMP7epTjZ8gFOQ
	phDWZC0DkfRWfS94B5Cr0Z2LC1m0QWSEO1knI2kjB8ZTUeQ5Z6OszBDrc4+a0+RmG/T8Ul
	VGOUNH2yasaOmycKkXSPvpSPu1hkfZvYF5YYGLoywy7skVeZgwGZSsJ/EhaqfPSsH4e5zy
	qbhjoMoPiish1y7n1TExyLyPR4lMDqkbYCjfhCml45sxfpcTi9gd36aGalYxUAehqjIafU
	vjgFQ8e0/lzC86XJxtAvdeqTgRiqtHtUWUbX1ATdii3ixLO6+ILHvC0sY0Ty4Q==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ARM: dts: tqma6: change copyright entry to current TQ Copyright style
Date: Tue, 13 Aug 2024 09:16:30 +0200
Message-Id: <20240813071637.72528-5-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
References: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Replace developer-specific, personal email addresses by mailing list addresses
while retaining the author.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi    | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts    | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts    | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi  | 5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi  | 5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi     | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts     | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts     | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi   | 5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi   | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi  | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi  | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi  | 5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi | 5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi | 5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts    | 5 +++--
 16 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
index b749b424bbd6..9f00f92957ab 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 &ethphy {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts
index df0a96b28af0..81a64409f790 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts
index 610b19d2db0f..268b52ae4c5e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
index 1708195fc93c..c47c4329e5a5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2017 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include "imx6dl.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
index 6755beefe2ae..8731216faaa7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2017 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include "imx6dl.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi
index 0d7be4567291..e21e1d15927f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 &ecspi5 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts b/arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts
index 349a08605a5e..9bf437a462b0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts b/arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts
index 02c9f3e91b8f..059a51a67775 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
index e88efe26963f..e35d29ba61a5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2017 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include "imx6q.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
index 60aa1e947f62..ba78b6cb33e4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include <dt-bindings/clock/imx6qdl-clock.h>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
index 807f3c95e3ce..57c6591d6932 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 &fec {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
index 789733a45b95..53fa83162170 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
@@ -2,8 +2,9 @@
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 &fec {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
index fce5ea4a5320..2600ee2994ab 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2017 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
index 777fe8624dfd..99055895f08a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2017 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
index 8b04ffa91437..d5aabf7b0cd0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2017 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts
index eee2e09d6e94..d622fd1dc7d8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2015-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2015-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 /dts-v1/;
 
-- 
2.33.0


