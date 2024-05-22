Return-Path: <linux-kernel+bounces-186748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142C48CC84A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464771C20F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A6146D70;
	Wed, 22 May 2024 21:51:03 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E4146A69;
	Wed, 22 May 2024 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414663; cv=none; b=brJXXHn8UVyYlYq//3pjYUBtRkkziVp5pshN1FKvsTjgJ5zrii7RP6B+f2q7C21ioD6gPazOEFl+xGDh84f4A57IuFC2bZ3wQGyBa3TjgBaSIVrI1abH1Wf82GYJCEeUC53d0JHhrvGFVUpV/0cYxVbIiuc6WH451MGC7hWjIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414663; c=relaxed/simple;
	bh=ofPBeRqSIe2vx2hxtmS3fwTatzKosnn0o5DkUNV20jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYr1tAJONW2/3VmnPy8/RWrcdJFGj0/l6M5qRngZUEBTk4gN4fly1D5owkAjTENT3oIR2gAMUg81Px9kaPtAn1ftVWdUSQ3WT6JtPaikuEOyVaUamrCqWtce24Rxjfyl+pCG/sSLFR5LaQyX0SN/+GSgiqRyzUVhg9c8euK5lxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1s9trM-00BO3S-8U;
	Wed, 22 May 2024 21:50:56 +0000
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
Subject: [PATCH 2/2] arm64: dts: freescale: rename gw7905 to gw75xx
Date: Wed, 22 May 2024 14:50:43 -0700
Message-Id: <20240522215043.3747651-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522215043.3747651-1-tharvey@gateworks.com>
References: <20240522215043.3747651-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GW7905 was renamed to GW7500 before production release.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
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
index bd443c2bc5a4..4b234d97a13b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -128,11 +128,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
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
@@ -181,7 +181,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
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


