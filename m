Return-Path: <linux-kernel+bounces-181975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9D58C8480
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576481F24496
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5082339AD6;
	Fri, 17 May 2024 10:05:44 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578542E646;
	Fri, 17 May 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940343; cv=none; b=vAJV4o7CuK1Er41xFnlXYsB5OVqaHlKIXIkRoELCMQ4jHsta4KELMqd0a62IDfHCwpg6bNlMRdE9CAUnhBEuSE+T5BPQfyR7bATq7DR3erDCXcuinwDaYXFKMTsIRJqcYh1B1JS5uirhOusY9V+lHcsc0gHJaCfuUJCTgQesl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940343; c=relaxed/simple;
	bh=6MSGlKBYOtbIfBrOwKOEfO+LalxWOYW7++dbVZ3bZ5A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=m0XQWL6el3WZlrOIHV8hodfJkGrCZFwdkUo8EBqTHkM6MDO5M+H18WuhJBEvj2mnPgihGYzwUV99djq2SnOfFOse/86SyK2/y8Y7FIZQTLepM3r1bEV319RxkBksFCv4C9b/b0VGP6L7nDvQk/iE4MIF1HfwT56WyRhsU1QcBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0A601A04A4;
	Fri, 17 May 2024 12:05:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86D221A0F4C;
	Fri, 17 May 2024 12:05:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DFB7B1820F76;
	Fri, 17 May 2024 18:05:32 +0800 (+08)
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
Subject: [PATCH 1/2] ASoC: dt-bindings: fsl,mqs: Add i.MX95 platform support
Date: Fri, 17 May 2024 17:45:45 +0800
Message-Id: <1715939146-13031-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715939146-13031-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715939146-13031-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In order to support the MQS module on i.MX95, a new property
"fsl,mqs-ctrl" needs to be added, as there are two MQS instances
on the i.MX95 platform, the definition of bit positions in the
control register is different. This new property is to distinguish
these two instances.

Without this property, the difference of platforms except the
i.MX95 was handled by the driver itself. But this new property can
also be used for previous platforms.

The MQS only has one control register, the register may be
in General Purpose Register memory space, or MQS its own
memory space, or controlled by System Manager.
The bit position in the register may be different for each
platform, there are four parts (bits for module enablement,
bits for reset, bits for oversampling ratio, bits for divider ratio).
This new property includes all these things.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,mqs.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
index 8b33353a80ca..a2129b7cb147 100644
--- a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
@@ -23,6 +23,7 @@ properties:
       - fsl,imx8qm-mqs
       - fsl,imx8qxp-mqs
       - fsl,imx93-mqs
+      - fsl,imx95-mqs
 
   clocks:
     minItems: 1
@@ -45,6 +46,22 @@ properties:
   resets:
     maxItems: 1
 
+  fsl,mqs-ctrl:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 6
+    maxItems: 6
+    description: |
+      Contains the control register information, defined as,
+      Cell #1: register type
+               0 - the register in owned register map
+               1 - the register in general purpose register map
+               2 - the register in control of system manager
+      Cell #2: offset of the control register from the syscon
+      Cell #3: shift bits for module enable bit
+      Cell #4: shift bits for reset bit
+      Cell #5: shift bits for oversampling ratio bit
+      Cell #6: shift bits for divider ratio control bit
+
 required:
   - compatible
   - clocks
-- 
2.34.1


