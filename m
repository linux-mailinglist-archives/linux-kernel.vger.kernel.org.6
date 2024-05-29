Return-Path: <linux-kernel+bounces-193805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479188D325D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651211C235C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F7169AD8;
	Wed, 29 May 2024 08:56:12 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9E168C3B;
	Wed, 29 May 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972971; cv=none; b=cfE5IKBcf4wZxXvlIuH27/lMcRFy3pRXZJ/ZMmbg2p3v5VEPcbFwATT2d6eemIi3jimr5AoCNuvm3TgfTntbaLuG+gjcPvJisIVWlCefYb3reKXWPN06BVxO9dlmYEO0cFL/E8z/nHRpgx2bzJ5zAhQGgLddTqtoPo5KHCkjjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972971; c=relaxed/simple;
	bh=aIeKtC8Nw2XKj9cg5CHoZdIovhCvGCSW6dffczCPMMg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=g0d4FJX/YQbaPWvUfWziioL9IsG7mtiXkbROhZQY4h35tAS6ghBVa61jV9APoMko3ezGaG6cXXlLofZWu8fAx3GGOvy1OfgcvsJhPD1K9Sd5ak8pq1LgVmdvtxlbMX0rCx562RswtWxBzUmMoF/AnFmEQUbI0APmV9bq1rJfBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A46691A1398;
	Wed, 29 May 2024 10:56:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 19AE21A083E;
	Wed, 29 May 2024 10:56:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4874F183B72F;
	Wed, 29 May 2024 16:55:58 +0800 (+08)
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
Subject: [PATCH v4 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
Date: Wed, 29 May 2024 16:40:01 +0800
Message-Id: <1716972002-2315-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
References: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
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

As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
clocks and clock-names properties.

On i.MX95, the 'interrupts' configuration has the same constraint
as i.MX93.

Only on i.MX8MP, the 'resets' is required, but for i.MX95 and i.MX93
there is no such hardware setting.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,xcvr.yaml   | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
index 0eb0c1ba8710..197ae8ba9c30 100644
--- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
@@ -22,6 +22,7 @@ properties:
     enum:
       - fsl,imx8mp-xcvr
       - fsl,imx93-xcvr
+      - fsl,imx95-xcvr
 
   reg:
     items:
@@ -49,6 +50,9 @@ properties:
       - description: PHY clock
       - description: SPBA clock
       - description: PLL clock
+      - description: PLL clock source for 8kHz series
+      - description: PLL clock source for 11kHz series
+    minItems: 4
 
   clock-names:
     items:
@@ -56,6 +60,9 @@ properties:
       - const: phy
       - const: spba
       - const: pll_ipg
+      - const: pll8k
+      - const: pll11k
+    minItems: 4
 
   dmas:
     items:
@@ -79,15 +86,24 @@ required:
   - clock-names
   - dmas
   - dma-names
-  - resets
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mp-xcvr
+    then:
+      required:
+        - resets
+
   - if:
       properties:
         compatible:
           contains:
             enum:
               - fsl,imx93-xcvr
+              - fsl,imx95-xcvr
     then:
       properties:
         interrupts:
@@ -98,6 +114,20 @@ allOf:
         interrupts:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mp-xcvr
+              - fsl,imx93-xcvr
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


