Return-Path: <linux-kernel+bounces-335471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A914B97E630
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C661F215CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17554AEF5;
	Mon, 23 Sep 2024 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0snZ/Ojs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C629CF0;
	Mon, 23 Sep 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074255; cv=none; b=e/Eb5huLMAAyimVDjnRmAL+k9Z7UQ5aonlI+gJ7ebS/KRm4YqtKvooL+LnrGBkOcghC+Ok4tAvnXU/bNo4j8/bnlcNcgOG3jDiG/spXogtJRLNy2aY7ZfU1TB8Jlq+0K9D8VARjvKCqvSogxy23K3hcWQR21wwtkGtrKAbV8JIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074255; c=relaxed/simple;
	bh=ZGx/Y4k1IFA7rZ9omAhAdqPCWvwPb8L8z1U/z1R/QuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGoxYdkJq79X4IeLos72tbXPcjp+zzKlbbK536tbXPEENX/oLv2kvxjvJrkvbhwYRoNv0nHSQb6/YJL4fCnkiiT2x4Eac5jqU7fiR29dNkjSi9yaydu1j1hb9I1ZzLmKQfGdv2L9jIddrS5kI7zvNr5xwQwssZLeWBsqdpLr9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0snZ/Ojs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727074254; x=1758610254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZGx/Y4k1IFA7rZ9omAhAdqPCWvwPb8L8z1U/z1R/QuE=;
  b=0snZ/OjsbCt701do5+Lwe5aU30mxMh/zLcT3EYfMD9F5pu6T38SzVnlN
   QkMoNNrhvQj8r9vx6Ium6qvs/pwvXs0/C3YUySkasWWJAnvL+eaZ7yjeu
   fdJT//FZYXk0o3D6dIw8yOO1F/VcsUaNxvLyGDjAR1UG037k6KmRZJ4lC
   FoNYAF7ILyRVSe98pv3BHyo4Bg3Tog99fmNZo/pHKF58H9RB90VBNc0s2
   eEwBY2mSn4gtUSagb84MfLt83QC47qcL7VutaBZBSwGtB2F7aFScgA30l
   bY04YF+1kNhEX3PG0rko/jQsQi8KCCbIGung2crnA1FV7rUNM2MZdUckD
   A==;
X-CSE-ConnectionGUID: nbowMA2OSLiJEr3vdSwxZA==
X-CSE-MsgGUID: z58YvuKbRk2Q8qwMkyjySw==
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="263115656"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2024 23:50:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 22 Sep 2024 23:50:09 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 22 Sep 2024 23:50:06 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/5] ARM: dts: microchip: sam9x60ek: Add power monitor support
Date: Mon, 23 Sep 2024 09:49:28 +0300
Message-ID: <20240923064932.5797-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923064932.5797-1-mihai.sain@microchip.com>
References: <20240923064932.5797-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add PAC1934 support in order to monitor the board power consumption.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 .../arm/boot/dts/microchip/at91-sam9x60ek.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
index 3b38707d736e..6cf699d9b540 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
@@ -260,6 +260,37 @@ i2c6: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
+		power-monitor@17 {
+			compatible = "microchip,pac1934";
+			reg = <0x17>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@1 {
+				reg = <0x1>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDDIOM";
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDDCORE";
+			};
+
+			channel@3 {
+				reg = <0x3>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDD3V3_MPU";
+			};
+
+			channel@4 {
+				reg = <0x4>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDD3V3";
+			};
+		};
+
 		gpio_exp: mcp23008@20 {
 			compatible = "microchip,mcp23008";
 			reg = <0x20>;
-- 
2.46.1


