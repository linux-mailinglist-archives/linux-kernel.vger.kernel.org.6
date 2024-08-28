Return-Path: <linux-kernel+bounces-305464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50718962F29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069A42833B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198A1A7AF6;
	Wed, 28 Aug 2024 18:01:27 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D319DF40;
	Wed, 28 Aug 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868086; cv=none; b=GIq8GYqaQGg/w6+Q72fQqlFpApTufReNTHiVpV0IL3jc20PzIxqwZqPS7kZV3gNNcnNHXANkwT32D+nkbhP5NE84uP0Tu/jbnJrN68PBzDXTP4mTY8XSJS8weNrMGRn98N5/hcUS0oz3Jzja+OtRNLzbhe5pjlgp0I9ronTcfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868086; c=relaxed/simple;
	bh=Bir9DzxYH2KlY03PYUHYPMX0jfsReNkotxUb7Eyt9uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjKtVTRNQhYpFh49W4JWNKVQmBRFjMY8OtH46eenWuMzfyfT19wYdHRSl8x3EyYy44afuOH/rjS1x/VvNoABw64kgqDoP+S3k9KbqIsbECxLMtUK9ZZ/2n1eEAK3Qnorbz/Ee3FgZ7xtqTHANQILRfgn9SKr/d3d3hL0hsGBLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1sjMbG-005gbd-U8;
	Wed, 28 Aug 2024 17:36:55 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/2 v2] arm64: dts: freescale: rename gw7905 to gw75xx
Date: Wed, 28 Aug 2024 10:36:51 -0700
Message-Id: <20240828173651.4053753-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828173651.4053753-1-tharvey@gateworks.com>
References: <20240828173651.4053753-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GW7905 was renamed to GW7500 before production release.

While we typically do not change compatibles, the GW7905 was never
released before its product name was changed to a GW7500.

The use the the 'xx' wildcard is to denote the fact that this
device-tree can support range of board models from GW7500 to GW7599 as
has been done historically with the Gateworks baseboards to support
various build customizatoins based on the same PCB.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - added to commit log reason for non-standard rename
 - added to commit log reason for a-typical wildcard (xx) in model name
---
 arch/arm64/boot/dts/freescale/Makefile                      | 4 ++--
 ...8mm-venice-gw7905-0x.dts => imx8mm-venice-gw75xx-0x.dts} | 6 +++---
 ...{imx8mm-venice-gw7905.dtsi => imx8mm-venice-gw75xx.dtsi} | 0
 ...8mp-venice-gw7905-2x.dts => imx8mp-venice-gw75xx-2x.dts} | 6 +++---
 ...{imx8mp-venice-gw7905.dtsi => imx8mp-venice-gw75xx.dtsi} | 0
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw7905-0x.dts => imx8mm-venice-gw75xx-0x.dts} (67%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw7905.dtsi => imx8mm-venice-gw75xx.dtsi} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mp-venice-gw7905-2x.dts => imx8mp-venice-gw75xx-2x.dts} (67%)
 rename arch/arm64/boot/dts/freescale/{imx8mp-venice-gw7905.dtsi => imx8mp-venice-gw75xx.dtsi} (100%)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 033baee533cd..48ef7131017f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -129,11 +129,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw75xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7903.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7904.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7905-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-mallow.dtb
@@ -185,7 +185,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw72xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw73xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw7905-2x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw75xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-mallow.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dts
similarity index 67%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dts
index 914753f062cd..04f06a55da5c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905-0x.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dts
@@ -7,11 +7,11 @@
 
 #include "imx8mm.dtsi"
 #include "imx8mm-venice-gw700x.dtsi"
-#include "imx8mm-venice-gw7905.dtsi"
+#include "imx8mm-venice-gw75xx.dtsi"
 
 / {
-	model = "Gateworks Venice GW7905-0x i.MX8MM Development Kit";
-	compatible = "gateworks,imx8mm-gw7905-0x", "fsl,imx8mm";
+	model = "Gateworks Venice GW75xx-0x i.MX8MM Development Kit";
+	compatible = "gateworks,imx8mm-gw75xx-0x", "fsl,imx8mm";
 
 	chosen {
 		stdout-path = &uart2;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw7905.dtsi
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dts
similarity index 67%
rename from arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts
rename to arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dts
index 4a1bbbbe19e6..7ca68df9e516 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905-2x.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dts
@@ -7,11 +7,11 @@
 
 #include "imx8mp.dtsi"
 #include "imx8mp-venice-gw702x.dtsi"
-#include "imx8mp-venice-gw7905.dtsi"
+#include "imx8mp-venice-gw75xx.dtsi"
 
 / {
-	model = "Gateworks Venice GW7905-2x i.MX8MP Development Kit";
-	compatible = "gateworks,imx8mp-gw7905-2x", "fsl,imx8mp";
+	model = "Gateworks Venice GW75xx-2x i.MX8MP Development Kit";
+	compatible = "gateworks,imx8mp-gw75xx-2x", "fsl,imx8mp";
 
 	chosen {
 		stdout-path = &uart2;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mp-venice-gw7905.dtsi
rename to arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
-- 
2.25.1


