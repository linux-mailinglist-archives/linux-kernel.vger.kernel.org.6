Return-Path: <linux-kernel+bounces-322145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A509724B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029271C23644
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5AB18C919;
	Mon,  9 Sep 2024 21:54:07 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69438F5A;
	Mon,  9 Sep 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725918847; cv=none; b=rXUQEqPat1mWRNi+t6xi1QXdprh5RBj4D6wT9s0eMkyNO8KIqW+WC55nNKi5mWyiuIJ7GNRrqMqzIh4eSGAANeTnsD1rIEuLjdo5N4EJ6/yzgra934jO1xLXEbdNediyzkKCAdA9Kdc6nleu+czAEl4KobMrS+6PX8fF5PfWoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725918847; c=relaxed/simple;
	bh=OkAJo248tKLDNkWPbKRksWV7A/KTwjY3L0KE6W6ettg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bxhIj7OUJ/+MYBNDWLbZeNnaUq4Rb3EkswbgJUKtEIQOupJqSppqJ9SoNOnHlZNBhBwkz+Md5g9XovHkzgo5ZrdiCiTfp8xRjxB0jEKj3HNbVLTghTgI9Ye/RueM9Slk/vFDCCFks6PnpTbZ/q1WW9nygVruBW6pO6oEzy5hXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1snmKe-00EUmv-Ta;
	Mon, 09 Sep 2024 21:54:01 +0000
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
Subject: [PATCH] arm64: dts: imx8mp-venice*: enable NPU support
Date: Mon,  9 Sep 2024 14:53:59 -0700
Message-Id: <20240909215359.780561-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMX8MP has a VeriSilicon (Vivante VIP8000) NPU which
is supported by the etnaviv driver. Enable it.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index 6c75a5ecf56b..f0211a96855b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -393,6 +393,10 @@ &i2c3 {
 	status = "okay";
 };
 
+&npu {
+	status = "okay";
+};
+
 /* off-board header */
 &uart1 {
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 9885948952b4..8a04b66a4afc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -666,6 +666,10 @@ &i2c4 {
 	status = "okay";
 };
 
+&npu {
+	status = "okay";
+};
+
 &pcie_phy {
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
 	fsl,clkreq-unsupported;
-- 
2.25.1


