Return-Path: <linux-kernel+bounces-310268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5925967740
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9309B21241
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F618308A;
	Sun,  1 Sep 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="onXNPUZ5"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3E18133F;
	Sun,  1 Sep 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206268; cv=none; b=Vx05bOrebPgOME174VyGA1ep5GKkzon+CEt7ep+TU52HjMBo1qib1GhrhH4d9z2Lf0Xk533LTqKRZDQKR4HZDIqBNvWZf/rm3uveN5eijCi76LafX8wAp1yvI6BLxch+B1bOSxnzhH8IXRrQ6rDdFTZpNq1Vu6NsNzdO6azcIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206268; c=relaxed/simple;
	bh=Z7vndyJxunyyj5VF2nUkyzoEx0s8ZyV6I8RnGaowdZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrKCae1wWvGFgkLqZTGbjO9E5W9csujo+hbocVcYGjYrMpphYFmVGJXzN65T4rOuxohMrB6FXywj2vJtXc84gyms5XgCPrRXFIiSsaKiGah1aDxQiGeeJOWvfsKM8Mjz9GuotjsmfVJkaR7lzLgEuFliOdpjGFQVVAIIGelsrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=onXNPUZ5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 466F01FA1D;
	Sun,  1 Sep 2024 17:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206257;
	bh=bbgIXRbk6h0Jgo5jOxc1Jg4WIH37efdJl8/8+iAAz7k=; h=From:To:Subject;
	b=onXNPUZ5hAIqarXic4LWsumUxdcpfCKWZ7Ae4Z+pBQhXbqH54h8VLki5aT/OPJ/+M
	 +nwspx1Eux1TQ3M+H6UmPJXtfYIWv2qf7X+zJ2iZ1qvrzeOs3kVCpnz+f7k+thD6TS
	 IGRA0KzUic++UkQ+zL0ENu8rrRa0Hq/fKWYb8I3R5FHG4GbqFAXpnc8RcwrnbZ/JD5
	 KdyQrsrNX6sC+EJjFq3SH348jn/HUZIPk0doBcbTOukUJRDlYYgfkgry5+NPc7dZfe
	 Wo2VP6/WTuQdrE2RJDxE1w1xMwORN8Am15an2gCm6m0RkfcQx6xGuZf1uLgimL8CO9
	 xbd/Ze11wD1BA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] arm64: dts: colibri-imx8x: Add fxl6408 gpio expander
Date: Sun,  1 Sep 2024 17:57:14 +0200
Message-Id: <20240901155721.7912-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fxl6408 gpio expander, this is required for Wi-Fi, Bluetooth and USB
functionalities.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index d88f2dd20afa..210db574b425 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -108,6 +108,21 @@ touchscreen@2c {
 		adi,conversion-interval = /bits/ 8 <255>;
 		status = "disabled";
 	};
+
+	gpio_expander_43: gpio@43 {
+		compatible = "fcs,fxl6408";
+		reg = <0x43>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "Wi-Fi_W_DISABLE",
+				  "Wi-Fi_WKUP_WLAN",
+				  "PWR_EN_+V3.3_WiFi_N",
+				  "PCIe_REF_CLK_EN",
+				  "USB_RESET_N",
+				  "USB_BYPASS_N",
+				  "Wi-Fi_PDn",
+				  "Wi-Fi_WKUP_BT";
+	};
 };
 
 /* TODO i2c lvds0 accessible on FFC (X2) */
-- 
2.39.2


