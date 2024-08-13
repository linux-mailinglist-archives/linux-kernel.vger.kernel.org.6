Return-Path: <linux-kernel+bounces-284211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B40694FE7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1FC1C22AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C213A27E;
	Tue, 13 Aug 2024 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OGclVwcA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rZBogA4b"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43D132464;
	Tue, 13 Aug 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533442; cv=none; b=b9KxZY3RKp/2TfbRodsiH1XVs0IhyLsGqN2IJf6swUqKlMnKI82Q8sYMhhtiELEiJnGqaxUSlV8O6MYiENw6H6fuBKOFru1Bjw4X6HdJOQgoyAhOVbs0nccYUExGwj92Rvmp8SkUoIQcYAjIbl+Hoh3UoKxD0YNW7nrMRsk/7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533442; c=relaxed/simple;
	bh=fiYkfZLpbpthrE0Yv932tHYaCq6iHiUCyjL7gRXQ/fY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PuffEsHO9og7RRXJVG9Ii23g5xM7MkKrW8qpNZLxmlTEXYmCAtx1PHleBUr9PkUNxZlFdUV5KhVK/FTc0Xr6GqPY/yuel46s9JxiCih4/fSJtAJZhYP4e+VLumERiseYfGaKVdjeCFLyt6XAg19rDx90WqHdNjSiJrsp9qJ+Ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OGclVwcA; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rZBogA4b reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533439; x=1755069439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhjLcigutvds5/oUPw2rkEjfCNEIlIQloXIvrY/LJFM=;
  b=OGclVwcAtpZ2EhAM3sVLqUyTKfDPmDAR2KKcLklL0cYd7ZjZxLejRAjW
   tT9geoWwn/D9iXecH1KVLnquTjd5MjlI9td+r/xrQFyRY2JMl+eoUUUMX
   kYf6XGYSTwqIe+6ZMc6FPOS5BIiji5AHdETVd0Rbu13n19BKadgrOys8j
   rxCxNh9C2ycdK+2wHGNixjUPKdi9MxsVjPbjZctuLASj7k2OoQH15xUUa
   MYfA61b0+Uec6V2Xfwl33oSlniaaUzqhfepUh/9RX4PK0qOJRhLcC9zDr
   WneplhXbU7qTP/y6UsU/hrmt93ONQaEK+srgCOfCueKHDKGUSrBxyJq/8
   A==;
X-CSE-ConnectionGUID: FPzBX33+RyW1wbHq0AUy8Q==
X-CSE-MsgGUID: vaNTAS9JTfOzvuuV+7L1uQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375835"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:17 +0200
X-CheckPoint: {66BB087D-9-E9ED6009-C4B0BEC8}
X-MAIL-CPID: 54C7D845C47E43E71E4CBC4EF74F6F05_3
X-Control-Analysis: str=0001.0A782F17.66BB087D.0086,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9206A16423A;
	Tue, 13 Aug 2024 09:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533433; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QhjLcigutvds5/oUPw2rkEjfCNEIlIQloXIvrY/LJFM=;
	b=rZBogA4bsO9f6Hy8AWLix3li/1o90ShFN2fyYa25GD4WEIX5EfMNNFxmSdN6FgxN62Y+rc
	7EjEIWpd5aJTI/mxVGgt4guusDoNYH81rIwiREpSdN5FwGmBYqnaqBR2N2aUXFBmCqHIKU
	S44MqawUYffEq0XaeRuqhW8YvdRrJDlobJDpuVY0c2L9tnR0O0ihv8Fu2ACL1JMDRSOe2j
	LZAtcuaqML2l9/Lq7nVLRG4uSYnNoq3c/C6j3a2Pp0oTcxv5QvDnueAkaJzYQ/usTPxlYL
	2Gis4cdibOfxZZXBOAjdtZbVHC5SmbaDEh7+w9nquNtkM6IfNZ0hL4s0nLkVYw==
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
Subject: [PATCH 02/10] ARM: dts: tqma7: change copyright entry to current TQ Copyright style
Date: Tue, 13 Aug 2024 09:16:28 +0200
Message-Id: <20240813071637.72528-3-Max.Merchel@ew.tq-group.com>
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
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi   | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi  | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts   | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts   | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi | 6 ++++--
 6 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index a25376296f64..5aa3e14b3b87 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -2,8 +2,10 @@
 /*
  * Device Tree Include file for TQ-Systems MBa7 carrier board.
  *
- * Copyright (C) 2016 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2016 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ *
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  *
  * Note: This file does not include nodes for all peripheral devices.
diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
index 95602ed1e6c5..3dce6afb61bb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -2,8 +2,10 @@
 /*
  * Device Tree Include file for TQ-Systems TQMa7x boards with full mounted PCB.
  *
- * Copyright (C) 2016 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2016 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ *
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
index e9a49777d19d..a499ab5a96b6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
@@ -2,8 +2,10 @@
 /*
  * Device Tree Source for TQ-Systems TQMa7D board on MBa7 carrier board.
  *
- * Copyright (C) 2016 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2016 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ *
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
index a7c701bb56b4..119b6b1e990c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
@@ -2,8 +2,10 @@
 /*
  * Device Tree Include file for TQ-Systems TQMa7D board with NXP i.MX7Dual SoC.
  *
- * Copyright (C) 2016 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2016 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ *
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts b/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
index cdcb4097ce8c..17ea082729e1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
@@ -2,8 +2,10 @@
 /*
  * Device Tree Source for TQ-Systems TQMa7S board on MBa7 carrier board.
  *
- * Copyright (C) 2016 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2016 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ *
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
index 125db5cd1528..6692742b358b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
@@ -2,8 +2,10 @@
 /*
  * Device Tree Include file for TQ-Systems TQMa7S board with NXP i.MX7Solo SoC.
  *
- * Copyright (C) 2016 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2016 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ *
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
 
-- 
2.33.0


