Return-Path: <linux-kernel+bounces-417912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F69D5AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F514282E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088818BBB7;
	Fri, 22 Nov 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bl0QVVYP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27E17D8A9;
	Fri, 22 Nov 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262761; cv=none; b=cEd1DNOW+EcTCpj+ucwnfXFa6QdoVqWmCizftLrkj2heEhoH/SmMG0pZi3dz4RCulao9/1Thnl46TieDa0f/noHHB/TZUcrVPMpQ6UowW4nIQNMUmggGO+slGgYMNHnSxic/SlWqeqf/3s9BSgRbVw3weN1yV5RI9GL07lcWXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262761; c=relaxed/simple;
	bh=x1b5yns0kG4sf7nOEqgzB78tAxBQeRDGz4ZSwFyrogM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAYszRrl3RAY1mLkiMzegE6fIBioasQ4lwyhmilMmWNDjP0U8ieCDxTuJDVhqDNdoK5hL2w5+rNxlynTDi/zo4Kmhx31MEu0UBz5mOQ7DNhy0XMpqfkZ7VV9UPSwsVFMB9+Mv2HiXRcRwfz8BRLItDTjo5r7sr2Q/ypgUP8F4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bl0QVVYP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732262760; x=1763798760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x1b5yns0kG4sf7nOEqgzB78tAxBQeRDGz4ZSwFyrogM=;
  b=bl0QVVYPkj5Ji2Md8QlfB5AC3k8pG9KvKAIXzVRpVlWuMq8j9BxAEtQ3
   l8JHuoH9t4UvlogTqNfdEJH4w0fDZ0kD/ho032eKMAPrdrP7IJR+S4DGv
   3/IEEBecl0dJ7a7Jokt669kD8OmZZ9EAcbZ1m2Q2M2mzV0xa7Zg8cXusU
   JthnCEyZ0gviaN4pK1mzkdGZtb0IW8u7gUPsYVfthwynio4KUFtHhm5+q
   iRrDPmTMCyTdJ57XQtxGycHJHkFzd8DmYq7GpfhoCdHsQ4NcZXhHiFeL4
   EZFCmjTqgYvLI30m+hYsUTNRJkrvXLZFbV1D6KeWDLYSCjExIeh7ASbmQ
   A==;
X-CSE-ConnectionGUID: 1R1gq0hdRfOMYCXRCiBJmQ==
X-CSE-MsgGUID: l0P3LG4iRe6wOxoKJnSVXA==
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="265826808"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2024 01:05:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Nov 2024 01:05:47 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 22 Nov 2024 01:05:45 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/2] ARM: dts: microchip: sam9x75_curiosity: Add power monitor support
Date: Fri, 22 Nov 2024 10:05:23 +0200
Message-ID: <20241122080523.3941-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122080523.3941-1-mihai.sain@microchip.com>
References: <20241122080523.3941-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add PAC1934 support in order to monitor the board power consumption.
Device is connected on flexcom7 in twi mode.

[root@SAM9X75 ~]$ awk -f pac1934.awk
VDD3V3 current:   10.675 mA, voltage: 3295.41 mV
VDDOUT4 current:  5.7625 mA, voltage: 1196.78 mV
VDDCORE current: 115.442 mA, voltage: 1243.65 mV
VDDIODDR current: 29.585 mA, voltage: 1345.21 mV

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 .../dts/microchip/at91-sam9x75_curiosity.dts  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
index d453800f8e35..76d7a756e08c 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
@@ -198,6 +198,52 @@ regulator-state-standby {
 	};
 };
 
+&flx7 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+};
+
+&i2c7 {
+	dmas = <0>, <0>;
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flx7_default>;
+	status = "okay";
+
+	power-monitor@10 {
+		compatible = "microchip,pac1934";
+		reg = <0x10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@1 {
+			reg = <0x1>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDD3V3";
+		};
+
+		channel@2 {
+			reg = <0x2>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDOUT4";
+		};
+
+		channel@3 {
+			reg = <0x3>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDCORE";
+		};
+
+		channel@4 {
+			reg = <0x4>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDIODDR";
+		};
+	};
+};
+
 &i2s {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2s_default>;
@@ -231,6 +277,12 @@ pinctrl_flx6_default: flx6-default {
 				<AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 				<AT91_PIOA 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 		};
+
+		pinctrl_flx7_default: flx7-default {
+			atmel,pins =
+				<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>;
+		};
 	};
 
 	gpio-keys {
-- 
2.47.0


