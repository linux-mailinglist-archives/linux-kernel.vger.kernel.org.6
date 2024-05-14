Return-Path: <linux-kernel+bounces-178293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E28C4B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F4CB21B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C22A171A5;
	Tue, 14 May 2024 03:31:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3C11725;
	Tue, 14 May 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715657503; cv=none; b=YH0ku0VQb0Ge2FzQDQjFhRyrOta+RxPxEM/stBEZQWQ811oYptSEMghM10apW+oxxzHdvX1jnIYqiDgzClRt0UluwS7J3DKPxkR0n9J89YnGCHXGXzwTXSMC7ONDjv+90KqXUyGV37OqW8MwuQAOcQZmmGhTp3Tf4vsqRsWmxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715657503; c=relaxed/simple;
	bh=uZ4ArMp3uQ9mQWoPEupZmFWXJPh2k6MA5dsgzfDsY8o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=IpgZoXGU62xgxbdGbqA80ivEEWVNPfVwdJweRSlOLGYYLp68x1bHrzmeQ+4bx4rF9P3TQH4YIQsmdtqquN5Fo8LkP4U81ttxxohoI04WCMBeujl/frKjXocOZ6SomjXz8vseCwXSXIcJ7KPABlsfbb94HXv7NU/mof/yYFBRM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D9E32017D4;
	Tue, 14 May 2024 05:31:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EE4582017CF;
	Tue, 14 May 2024 05:31:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B90D0180222F;
	Tue, 14 May 2024 11:31:37 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
Date: Tue, 14 May 2024 11:12:08 +0800
Message-Id: <1715656329-8061-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.

The difference between each platform is in below table.

+---------+--------+----------+--------+
|  SOC	  |  PHY   | eARC/ARC | SPDIF  |
+---------+--------+----------+--------+
| i.MX8MP |  V1    |  Yes     |  Yes   |
+---------+--------+----------+--------+
| i.MX93  |  N/A   |  N/A     |  Yes   |
+---------+--------+----------+--------+
| i.MX95  |  V2    |  N/A     |  Yes   |
+---------+--------+----------+--------+

On i.MX95, there are two PLL clock sources, they are the parent
clocks of the XCVR root clock. one is for 8kHz series rates, named
as 'pll8k', another one is for 11kHz series rates, named as 'pll11k'.
They are optional clocks, if there are such clocks, then the driver
can switch between them to support more accurate sample rates.

As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4'
for clocks and clock-names properties.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,xcvr.yaml   | 55 +++++++++++++++----
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
index 0eb0c1ba8710..70bcde33e986 100644
--- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
@@ -22,6 +22,7 @@ properties:
     enum:
       - fsl,imx8mp-xcvr
       - fsl,imx93-xcvr
+      - fsl,imx95-xcvr
 
   reg:
     items:
@@ -44,18 +45,12 @@ properties:
     minItems: 1
 
   clocks:
-    items:
-      - description: Peripheral clock
-      - description: PHY clock
-      - description: SPBA clock
-      - description: PLL clock
+    minItems: 4
+    maxItems: 6
 
   clock-names:
-    items:
-      - const: ipg
-      - const: phy
-      - const: spba
-      - const: pll_ipg
+    minItems: 4
+    maxItems: 6
 
   dmas:
     items:
@@ -97,6 +92,46 @@ allOf:
       properties:
         interrupts:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx95-xcvr
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Peripheral clock
+            - description: PHY clock
+            - description: SPBA clock
+            - description: PLL clock
+            - description: PLL clock source for 8kHz series
+            - description: PLL clock source for 11kHz series
+          minItems: 4
+        clock-names:
+          items:
+            - const: ipg
+            - const: phy
+            - const: spba
+            - const: pll_ipg
+            - const: pll8k
+            - const: pll11k
+          minItems: 4
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Peripheral clock
+            - description: PHY clock
+            - description: SPBA clock
+            - description: PLL clock
+        clock-names:
+          items:
+            - const: ipg
+            - const: phy
+            - const: spba
+            - const: pll_ipg
 
 additionalProperties: false
 
-- 
2.34.1


