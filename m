Return-Path: <linux-kernel+bounces-422084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770F9D9451
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22659283D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78F1C2323;
	Tue, 26 Nov 2024 09:22:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC51B4F08
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612941; cv=none; b=MY1rv8AYvTxyibvBZ2WqaO+SbyjOEF8J6Ggae/RMaqhVDFdoCvMDdGV80CRap9XPSA5ojyoVum1sHRyVdq05cNtRFnQdM43iP6rWHGnhLdSXfIg8pqveCX8uBHmJRuGScWsoMi7zlEOvLQ240AjAusVi3HtCR0Xiz8NfiCG747Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612941; c=relaxed/simple;
	bh=rBuLrPc3xzjgkqlUnknHGr0EQxbbCWBO/qnIC6uzYhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSSYdDOZDzBmyw1e9Fon35pzKGV40kVEEmAziJ9dmVDskZpjcxLrTrqo4rubaF7nOqI+ZMQSeI0jS4r3FJEXAht2XxlLw5k6PtqPzjyCybZochjIGTuhnSmP3rQMR0tI/PrmRrWyjAZJj42+3tLp9ShyiMlr3AuJFlezqip17wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tFrlu-0005uB-Fr; Tue, 26 Nov 2024 10:22:14 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tFrlt-000DzL-1d;
	Tue, 26 Nov 2024 10:22:14 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tFrlt-00B5zE-1v;
	Tue, 26 Nov 2024 10:22:14 +0100
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Date: Tue, 26 Nov 2024 10:22:15 +0100
Subject: [PATCH 3/3] ARM: dts: imx6sx: add phy-3p0-supply to usb phys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-v6-12-topic-imx-3p0-regulator-v1-3-c618ed111c75@pengutronix.de>
References: <20241126-v6-12-topic-imx-3p0-regulator-v1-0-c618ed111c75@pengutronix.de>
In-Reply-To: <20241126-v6-12-topic-imx-3p0-regulator-v1-0-c618ed111c75@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The integrated usb phys are supplied by the 3p0 regulator, which has a
voltage range of 2.625V to 3.4V. Thus the min and max values are
corrected and the regulator added as a proper supply for the usb phys.

This fixes the following warnings during the probe of the mxs_phy
driver:

mxs_phy 20c9000.usbphy: supply phy-3p0 not found, using dummy regulator
mxs_phy 20ca000.usbphy: supply phy-3p0 not found, using dummy regulator

The regulator handling was introduced by commit `966d73152078 (usb: phy:
mxs: enable regulator phy-3p0 to improve signal qualilty, 2024-07-26)`.

Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index a9550f115f82699336f62c33214c9a9bb04e79e0..5132b575b001564b9767605ae7ff044701516673 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -637,8 +637,8 @@ reg_vdd1p1: regulator-1p1 {
 				reg_vdd3p0: regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <3150000>;
+					regulator-min-microvolt = <2625000>;
+					regulator-max-microvolt = <3400000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x120>;
 					anatop-vol-bit-shift = <8>;
@@ -731,6 +731,7 @@ usbphy1: usbphy@20c9000 {
 				reg = <0x020c9000 0x1000>;
 				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_USBPHY1>;
+				phy-3p0-supply = <&reg_vdd3p0>;
 				fsl,anatop = <&anatop>;
 			};
 
@@ -739,6 +740,7 @@ usbphy2: usbphy@20ca000 {
 				reg = <0x020ca000 0x1000>;
 				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_USBPHY2>;
+				phy-3p0-supply = <&reg_vdd3p0>;
 				fsl,anatop = <&anatop>;
 			};
 

-- 
2.39.5


