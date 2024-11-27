Return-Path: <linux-kernel+bounces-423726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CEE9DABF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBC7B23DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932A200BB8;
	Wed, 27 Nov 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="PhfuUTss"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB2200BA3;
	Wed, 27 Nov 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725884; cv=none; b=OEzPzqt7L5mXpdyIhkI/Roybzqk0UBCbiMO8/Ko4W7pT5avUr7CveQnD9HOt1ETHVejnE/x2M2fDReNDGdpaB9/YMFMK3u4Nv0WPHbFR1P/tFWhyr1/g4k2vOPgg4zj7AWvqPIXWoFMsF1iSqvLXIHOH0QZnUdwy7DWWXTwuahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725884; c=relaxed/simple;
	bh=gUjM1dpIwBdlgK1gcDpU85tOGxsJBAbOWJnShHwzhL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2IklXyZWYIHCS8EsHe2iNmNfJ+Sag5xF3q6+EuOo7Hhyzphd5q8YpztAhb9yMqOHl14YFj8iKIhe8a7hLnwNvlAe/m7iq81whxN+2/x1tcSSQqFD+ko7Orl8o44jZ2fPOpKmSs2moP9Y5eGRntGRJ7HEgej6ycFTAgDdq0sbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=PhfuUTss; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6433CBFB98;
	Wed, 27 Nov 2024 17:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725878; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=X1oXhqEsz9Br6MRzf1dH+hH5nzNYl1h9TOKMungz6pU=;
	b=PhfuUTss9WT1lTnktA3gwOzlukMBwMCL5XxMcHMzvuVZxzw405Yu/EdBKcgLpLs1oPRium
	nsAfKe5cPl97Dciy8rJfBUmw8kpqbQSgkDy7/GQLwBNAZuyu6xAIbvH95woGjV2dENQopq
	7Uryj0YpuJFClA31uUMIHAQuxSYgSgTqsjKZwjHhBO3gMAHITVBXmEOCD26WmaN90wcux6
	QfsoZHeHe7bwQPSBJL+1iAS+CIpDwd9rL7YNWInh8z1jOaXt31Y6Uy0YUlmY16Gytz8qdN
	vkY17uogNSb5XKx4N/FsvE/O35tnVY+QpitvfIJaGyuGtaWnKs3GHmN3mzRwhw==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 04/11] arm64: dts: imx8mp-skov-reva: Use hardware signal for SD card VSELECT
Date: Wed, 27 Nov 2024 17:42:20 +0100
Message-ID: <20241127164337.613915-5-frieder@fris.de>
In-Reply-To: <20241127164337.613915-1-frieder@fris.de>
References: <20241127164337.613915-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The USDHC controller is able to control the IO voltage of the SD card.
There is no reason to use a GPIO to control it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* new patch
---
 arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi
index 59813ef8e2bb3..33031e946329d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi
@@ -232,7 +232,6 @@ pmic@25 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupts-extended = <&gpio1 3 IRQ_TYPE_EDGE_RISING>;
-		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
@@ -555,7 +554,6 @@ MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA				0x400001c3
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03			0x41
-			MX8MP_IOMUXC_GPIO1_IO04__GPIO1_IO04			0x41
 		>;
 	};
 
@@ -623,6 +621,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0			0x1d0
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1			0x1d0
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2			0x1d0
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3			0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT			0xc0
 		>;
 	};
 
@@ -634,6 +633,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0			0x1d4
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1			0x1d4
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2			0x1d4
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3			0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT			0xc0
 		>;
 	};
 
@@ -645,6 +645,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0			0x1d6
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1			0x1d6
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2			0x1d6
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3			0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT			0xc0
 		>;
 	};
 
-- 
2.46.1


