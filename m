Return-Path: <linux-kernel+bounces-178532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7508C4F19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C591281593
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0EF13A257;
	Tue, 14 May 2024 09:53:12 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30655C1A;
	Tue, 14 May 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680392; cv=none; b=TA1P9afcgRfimvCOJP0EnpkqS6KBhWtWph2oLAXSCq1VFtgvqDv3VKi538mQ2BFlEu0IgpxSTZ9cNdgjLOe18oglQklRUEonBsigsaTXLOC0rbTDich7jlKfk2NWFni/t3hp5tQpCWM52m9p7UUqrhGWk3PJY3PP7VVMGbHFzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680392; c=relaxed/simple;
	bh=BpkOooU1s4m3CWExxo5Bz93jiYM7/cI8NedWu2YZ93I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=C1CPTWGo2o29Yc1X/fz1Y12yf6q+8Wr1GC+5FcxdNRwRqBHnRUFEMZxJnI3uWGdhssAIVN7ZZNMajfp/uiqyuOQVwpQ4tLMWxDMf2ar4StBFKabOks8XqXniMYJ4SdfJO4ieZigik6PAwKonhLFZLxz4Cucr4vzgLLJ59QK/AZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 220B5200938;
	Tue, 14 May 2024 11:52:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CD4C42005E2;
	Tue, 14 May 2024 11:52:56 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 87D931820F77;
	Tue, 14 May 2024 17:52:54 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 1/6] dt-bindings: reset: fsl,imx8mp-audiomix-reset: add bindings
Date: Tue, 14 May 2024 17:33:25 +0800
Message-Id: <1715679210-9588-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Audio Block Control contains clock distribution and gating
controls, as well as reset handling to several of the AUDIOMIX
peripherals. Especially the reset controls for Enhanced Audio
Return Channel (EARC) PHY and Controller.

Add DT-Schema bindings for the reset function in i.MX8MP audiomix
block controller.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../reset/fsl,imx8mp-audiomix-reset.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx8mp-audiomix-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx8mp-audiomix-reset.yaml b/Documentation/devicetree/bindings/reset/fsl,imx8mp-audiomix-reset.yaml
new file mode 100644
index 000000000000..71a10646ab2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/fsl,imx8mp-audiomix-reset.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8MP AudioMix reset controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: The reset controller node must be a sub-node of the i.MX8MP
+  AudioMix Block Control node
+
+properties:
+  $nodename:
+    const: reset-controller
+
+  compatible:
+    const: fsl,imx8mp-audiomix-reset
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller {
+        compatible = "fsl,imx8mp-audiomix-reset";
+        #reset-cells = <1>;
+    };
-- 
2.34.1


