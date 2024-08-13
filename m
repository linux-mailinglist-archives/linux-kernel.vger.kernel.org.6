Return-Path: <linux-kernel+bounces-284219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E6594FE90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427DD285B45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5B1898F4;
	Tue, 13 Aug 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="N34ViYI2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TCnNItx1"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D213699B;
	Tue, 13 Aug 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533471; cv=none; b=sPC8U9vWlXJLQDL7zJyvcybKU0k2Jiz7Fo+3a6RxN+REET6ae8QrJVrUnJEQGrLvEcDgc31W7oDUmkcDhft2aL0tnnH8PjUufb6ALRwIbaVqx/XLfAVSLlCsbSOfc/tg1PGcG7rHf7Kh3V5XHtSYC2kexdJmsj+LJC0ulSslCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533471; c=relaxed/simple;
	bh=MHoFKcsOQaeLf4SSoG/7TGS5SHrvUYwPAIW6ipgYNNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRT8R40XxE2dR+Th436IorbXLeQfc06U4OfgA9Nv6U5KjTqQtlYqcEOLxiwjufTpFk+uMFYzmjOpj/+PYsKEE/gyrR6duJ7pv4Sz4oRnz3C3Y5IXORPmfWZcFA34/ZR+Nm8ANL54FZ2JDiJv+H//j3UcmJW/uJXENpqgqiMM5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=N34ViYI2; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TCnNItx1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533469; x=1755069469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PGszcAonfhOIcHvMr4ZGq8AA83HtxnAhfd56bpE6SZw=;
  b=N34ViYI2HMp/XGZvq8eMJJtaEbqAdyBuL4Z+HAkBBLliAYuFmnAnneKt
   psRKyPxVKRlU1hgbaZke5XJqmuLdt3Z0spLQ1eRowamqe/w6t8+OaUEBV
   +QFjp61o3XlEe0bRaIxEnzyHmW7a4cssw3W+Eu8uAo86KmeehNzxz13f8
   oepE9OEIetQlFEXIQKjMpxUcAuLefQ/ETIrzjccysn/wgpii7kshVhIAs
   mp1MVT4Wi0dmMduUYLHxYAUaXZHJ8myhHjLEx8iqSJnCjFwP6pq5/1EJq
   rJDm0ClwVwbk3tbIQZpxtLmmkjmsQ8v9MfhxNKS1rNE9U1HhJd+012E2M
   w==;
X-CSE-ConnectionGUID: ymLGq4BWQ32u0BybNXqMpg==
X-CSE-MsgGUID: xlUIsFu+Trq7Sqkt5aMXbQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375862"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:48 +0200
X-CheckPoint: {66BB089C-10-FF00FE11-F2A862FD}
X-MAIL-CPID: F7EE550243D9A5F3F93398D117044A3C_5
X-Control-Analysis: str=0001.0A782F1D.66BB089C.0183,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 106D6164A59;
	Tue, 13 Aug 2024 09:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533464; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PGszcAonfhOIcHvMr4ZGq8AA83HtxnAhfd56bpE6SZw=;
	b=TCnNItx1fpBG3Tf+1yJ4IlQTdIQZsQ5eFjqJzx+5X+BjJFjioW29MMKGl2VHhydrxtq/Ro
	5I2O+zDvg9VKASgJJxL6k/EiUQS48drG3laZO7vGn2gXIolamo3wuSBMEWR5d2qOcad/9K
	wcm3qj9OUBICEr2EdzI+vyyVt6rz2Zo5i0VPeVXK8U0KiEXuu6JN8wN8UT3NOMCTED4QzL
	7oSC5NefAp47URKwuINF5FLVoi0dVyrs7OxOxWh6IGFESOYiSF7djIYKKZVtkbth0Kqzh+
	zl3SU998exG8IMBRcOZBJQafHchXQFkB9gw9dT0ps6QsI+9ava34ybqkgwiqew==
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
Subject: [PATCH 09/10] ARM: dts: tqmls1021: change licenses to use the same as ls1021a
Date: Tue, 13 Aug 2024 09:16:35 +0200
Message-Id: <20240813071637.72528-10-Max.Merchel@ew.tq-group.com>
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

commit 784bdc6f2697c ("ARM: dts: ls1021a: change to use SPDX identifiers")
license of imx7sls1021a.dtsi changed to
"GPL-2.0-or-later OR MIT license."
Therefore, the licenses of the tqmls1021 device tree are changed to the
same licenses.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts | 2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts
index 34636fcdfd6a..d441a67fb4ee 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
  * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
index 1b13851ad997..2f9387c34ca3 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
  * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
-- 
2.33.0


