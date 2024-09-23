Return-Path: <linux-kernel+bounces-335468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963397E62A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51541F21599
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A52940D;
	Mon, 23 Sep 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MAa8Ei2o"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B579E1;
	Mon, 23 Sep 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074231; cv=none; b=jfQQ0F9ylVH+PnGrTjf+NMPR9QiI+g8G2cSNlI83NVWvaZfZPEFvONe34ujtfcunq7T11ZYiCIN2szI4peZ0+q/F1VpfFoIDrchapR1wQs3u+BgS7iiPFvCGBvOtL7LGQukCgx8pXTMTJnXH+LrrHZcvgfbPzI3hv++snKNNDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074231; c=relaxed/simple;
	bh=4pFe+LKNT/3bDaKjRJ6PORZtjwOBmMGi0IqA1mX80fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PN+7STx8A6034XuObfNYuRB8On0o+2ZxjXD/C9hMdMSTn9xVJBGjzSCYBBPkd5yF0A/7gQJDCGpVEiX1cvkATqy967LF37tZkdaTlssPmALUN+4tj1eyIsa0jZjrI0FAOV7sPH6XXZoKnAvvix95RS+RXL3gOgfoU90ll7snseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MAa8Ei2o; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727074229; x=1758610229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4pFe+LKNT/3bDaKjRJ6PORZtjwOBmMGi0IqA1mX80fw=;
  b=MAa8Ei2oaKcRuOiWsZAJIHUsZ9dMT3TZyOdNB/W5YKFHgTUwYt2FA7i9
   MWlpL5eBtzRYVKqWX+tzsrt2x4qKSjlinF8iLgpQiKLoqODzr52yFZ9kY
   wUkd+dpy7oOm+mf3bDa1W4RTSQCzoColmGPsP43NlF86E0fZYaF2XvOn1
   s1PmKL2Au1jS47DNvJ4yjDthJmaGIy4Tn/nUzVVTbnaGOZs2S0mkjosAY
   0JaUpLluAgZS6v/VlkVQUTIY6y6RzaXp4FpjlD6EkGEiFxYWhHWE7CE69
   hrgzXJil3s2fvH09UdLCPQKQm9JHUKpwK0//I9C4I7QQKIOKScv3rJ4nO
   w==;
X-CSE-ConnectionGUID: U10XO7xER1qeFauEdbUvEA==
X-CSE-MsgGUID: Mizc+XO8TNqEiqLtdb9EVA==
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="32721982"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2024 23:50:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 22 Sep 2024 23:50:14 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 22 Sep 2024 23:50:12 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 3/5] ARM: dts: microchip: sama7g54_curiosity: Add power monitor support
Date: Mon, 23 Sep 2024 09:49:30 +0300
Message-ID: <20240923064932.5797-4-mihai.sain@microchip.com>
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
 .../dts/microchip/at91-sama7g54_curiosity.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
index 645e49fdb7fe..2dec2218f32c 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts
@@ -186,6 +186,37 @@ i2c10: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
+		power-monitor@1f {
+			compatible = "microchip,pac1934";
+			reg = <0x1f>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@1 {
+				reg = <0x1>;
+				shunt-resistor-micro-ohms = <47000>;
+				label = "VDD3V3";
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				shunt-resistor-micro-ohms = <47000>;
+				label = "VDDIODDR";
+			};
+
+			channel@3 {
+				reg = <0x3>;
+				shunt-resistor-micro-ohms = <47000>;
+				label = "VDDCORE";
+			};
+
+			channel@4 {
+				reg = <0x4>;
+				shunt-resistor-micro-ohms = <47000>;
+				label = "VDDCPU";
+			};
+		};
+
 		eeprom@51 {
 			compatible = "atmel,24c02";
 			reg = <0x51>;
-- 
2.46.1


