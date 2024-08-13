Return-Path: <linux-kernel+bounces-284230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E165D94FEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B1B1F24324
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB418950A;
	Tue, 13 Aug 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DKlB0JhR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GrXh2KW4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4B187571;
	Tue, 13 Aug 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533682; cv=none; b=IenmcnEwh593dTVoEgS2NxKW1qXiT/lMoNKrpSTL71B+9+DHkIRtEMsucaqIFGD+bey6yUywBGCJsZInoo6qEuEMgKwWo+G+5GoTg4mFbTMB18Xkc1U8VQkrg64JYIJkMutf/SF4e664CmteZUu/GQSv5uALo2eLzfZJ8Wym6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533682; c=relaxed/simple;
	bh=bLtz5nQ04zTFEVggORwXtxwqx5cFy6DrP9Nnu9yFw2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYQRqcZuNDegudmqL3G1cMPu0CoHyk64dT4tsgG4dA3OpM/wBfiDSwDdZOVpt+5J8JvBpDQPVdiMiNVzlGI61ei/DRlbBwHDvToIwJNOjXgA3XN7gXMz/ih8ZWxVmOkdIlSzswp0wCQ/dU1viXeh1M24LRrHUasutCFO54y3ALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=DKlB0JhR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GrXh2KW4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533680; x=1755069680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVwASdAR8EU2PXQRA/yGPoFV5yFCrBmLTTbs4254+qw=;
  b=DKlB0JhRTl0O0lfdWAWmr7CJOq0wIdg2g8L1XfC83Lamrpa6Is+TNAb+
   AeG7TGdj7pwVzjHFGh6av6RwrJTZJ81wJJTXysi8slXCW4MKI74Opmss1
   0utWfCb+/Fbkz+2UgOulWkiqEy4z9bBKIYwFNErzMYjQdG6vViSHvw/+6
   zw4CUlBm5mvKRtKKecDY7IwxsRHYsKcTUbkvZz8/jnMSz73edl5SEIEAe
   i8af5SAOHgaBfWXdhPQMGZtXaku+iM1WSuc6anrkLEfliRvVu12MiwGc4
   mAVUHU1rIj/YxY5YItF62WDGG35YuGxuw7ZHAEWzJ+5pv6f0lE+AUxNH4
   w==;
X-CSE-ConnectionGUID: ZtFVUOJeSo24j/Zb97Nb4g==
X-CSE-MsgGUID: RktuUGwXQAe6nT656Xodnw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38376023"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:21:13 +0200
X-CheckPoint: {66BB0969-15-FF00FE11-F2A862FD}
X-MAIL-CPID: 53E267B03837F43B6C1C09E0CD9B260E_5
X-Control-Analysis: str=0001.0A782F23.66BB0969.014F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1127116A296;
	Tue, 13 Aug 2024 09:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533669; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GVwASdAR8EU2PXQRA/yGPoFV5yFCrBmLTTbs4254+qw=;
	b=GrXh2KW46oWfXNcUOy4KsKxx5Qc6ZChY3b7u1d+afFE1qTmR6eRI6ZvNKl2vJf70uxnxZp
	KxdcAiN8df0JMrmcUv2j1AhNxQsm34xMalOCPyXEDhoVD8su6j7pBuQ/HMbsktDu3ik3+Z
	S7SDLo7V1VMi7nmeUxStmVVwbemoZDHuVmIjOYXoxX9O39AGtAPbV1vP2FdjukvjOonW4A
	3CXKgUW0jcDRTCRYs5i7jtNHytVH62a4qW6upmZT7pCFEj5Yes1qFPvb/vfTHfGK1PJlIb
	tVMmYR91AQZRcVMRGLIZcOpmN3hc2TveIuWsmeWkTcgIya+hApcpQrRqnDoLZQ==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 7/7] arm64: dts: tqma8xx: change copyright entry to current TQ Copyright style
Date: Tue, 13 Aug 2024 09:20:19 +0200
Message-Id: <20240813072019.72735-8-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240813072019.72735-1-Max.Merchel@ew.tq-group.com>
References: <20240813072019.72735-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Unification of TQ-Systems copyright entries

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi       | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi         | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi       | 2 +-
 arch/arm64/boot/dts/freescale/mba8xx.dtsi                 | 2 +-
 arch/arm64/boot/dts/freescale/tqma8xx.dtsi                | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts
index d74b5338befe..256050c5c442 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
diff --git a/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi
index 9d2bf9178d86..bbc4525e6e93 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
index 7894a3ab26d6..478234cf30b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
 /*
- * Copyright 2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts
index 3544c347cdcd..92fe51f52b21 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi
index c3983391486d..6885c8fac909 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
index 3149c383e1c2..40b0191ff949 100644
--- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
diff --git a/arch/arm64/boot/dts/freescale/tqma8xx.dtsi b/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
index 9659804c5f3b..fdeebde955da 100644
--- a/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
-- 
2.33.0


