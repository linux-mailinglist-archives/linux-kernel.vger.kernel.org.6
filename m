Return-Path: <linux-kernel+bounces-401736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05C9C1E85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE06C282886
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5681F12F6;
	Fri,  8 Nov 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NxjYWO2w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BsvMjynv"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874831F754F;
	Fri,  8 Nov 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073816; cv=none; b=AMyMsr+GFat7YJj5ryH3048OXjLFo7oPTGSvZOat+spmnX11ZamPBStuFDQr8ebq+bMNVx/jiwrlNAI8qz6sqirfS6qDA5dmvhPyjFk92G5fb4b31EI0Cnmnx3dgxDClaCCLTAwkdP9mzBXZYNCMxg3qbQTX6FliVfW9Hzh9FQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073816; c=relaxed/simple;
	bh=JXNO5hP7E5V4S/t+2oEhJLRyEnrD6Aq1wt/H24xrlUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+aZ4bJFWvfp8xeNcHSa8RM/YvyZ3CB18FEfqdjl6bghBb5GMp+BVoIgQp4ZuYNL5sQ966Xg5JqzsfKm4CAofdRsfUak2+GMy46oLB1ih9F+0mFNKuTe6RJ8oyfmZfIiiY1GZiZMtDG5l43fq8MXkNZdAbarbeKRTMjo+Jx7z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NxjYWO2w; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BsvMjynv reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073815; x=1762609815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pw79i7q7e/DZSw3U8kbl0tezb776Kpjc5WLXApNdfFU=;
  b=NxjYWO2w6mAJL1R/vz1vXsT+vZeTEkV2l8MHfk4C1ksR23+R7rE95R43
   rMAMDdBYj6Bfve4jkGIhae7hXmCAaBVbV+hYprE2qPGHXWRwePW4HyJDT
   FbE2ZKaZPYrCy7TYLdCmXhoP45NiFkvUA4GAq+wMh1hx1tmhGClaUeHX/
   K/kMxwAw3dUOufVSHWETF3dj2yiHDVoSBgpohp6+seafqY+959TFpqQBz
   ZFKUNyk9wxXoj3jBVk5wjYMQGLS6t3t8P0aq+hiFkD5yGqrWMdtWpEIZT
   dLWymhPPer6st4gFCDbxBk5VV+pS69kzVB5C6Gw5qxLHM/Nm//lDY/3x8
   w==;
X-CSE-ConnectionGUID: NPvH8mAiR6Cj2k7Yy8qn4A==
X-CSE-MsgGUID: wnH/NjH5SnqZiNaRa8xYcQ==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936935"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:50:13 +0100
X-CheckPoint: {672E1715-35-90CD5875-E0265C0B}
X-MAIL-CPID: 34381C6652A21CF8C6F764790CF3E0DB_3
X-Control-Analysis: str=0001.0A682F16.672E1716.003E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E07651655C9;
	Fri,  8 Nov 2024 14:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073809; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pw79i7q7e/DZSw3U8kbl0tezb776Kpjc5WLXApNdfFU=;
	b=BsvMjynvs4PQUPLEKwTggd0gUADAGNR4v+/8IAAInm2y+ds6SDtnbXajvkDBaukqRQr2Ro
	IlutHWZ+I1X5fIh8xDUWzxNsSS/kgfvghGQeW2aO4aAxVbE3AoB3qwviDtORVZxGilZdKV
	+NHouin7qHWKby/cNBYr/hq784fkopXVwOVB7lECyCvq78zbOHEDKO0PWFZ4zR35p5NJpe
	/BT7+j5tTypujzSUivNyWPm1QzqXGzNW/TtCB+/ntcH5Vogn2CUR9HisHF9lCDW5UKKrJe
	0EmkLa5cYmdaDLUJ5DF4MhG2zi8TJtpuqLIlybEEQc8Abgt9pOUobwn/XUYoNQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] ARM: dts: imx7[d]-mba7: add Ethernet PHY IRQ support
Date: Fri,  8 Nov 2024 14:49:25 +0100
Message-Id: <20241108134926.1324626-8-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The regulator-fec*-pwdn regulators were used to deassert the PWDN signal
of ethernet PHY, e.g. not powering. This is not necessary as the line
has a pull-up already.
Instead of the combo pad of the PHY for IRQ support.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi | 23 ++---------------------
 arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts |  3 ++-
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index 304281681abfe..576a7df505d3b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -87,26 +87,6 @@ iio-hwmon {
 			      <&adc2 0>, <&adc2 1>, <&adc2 2>, <&adc2 3>;
 	};
 
-	reg_fec1_pwdn: regulator-fec1-pwdn {
-		compatible = "regulator-fixed";
-		regulator-name = "PWDN_FEC1";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_fec2_pwdn: regulator-fec2-pwdn {
-		compatible = "regulator-fixed";
-		regulator-name = "PWDN_FEC2";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "VBUS_USBOTG1";
@@ -231,7 +211,6 @@ &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
 	phy-mode = "rgmii-id";
-	phy-supply = <&reg_fec1_pwdn>;
 	phy-handle = <&ethphy1_0>;
 	fsl,magic-packet;
 	status = "okay";
@@ -252,6 +231,8 @@ ethphy1_0: ethernet-phy@0 {
 			reset-gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <500>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
index 0443faa3dfae4..e3ee16f1aaa96 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
@@ -21,7 +21,6 @@ &fec2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2>;
 	phy-mode = "rgmii-id";
-	phy-supply = <&reg_fec2_pwdn>;
 	phy-handle = <&ethphy2_0>;
 	fsl,magic-packet;
 	status = "okay";
@@ -42,6 +41,8 @@ ethphy2_0: ethernet-phy@0 {
 			reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <500>;
+			interrupt-parent = <&gpio2>;
+			interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
 		};
 	};
 };
-- 
2.34.1


