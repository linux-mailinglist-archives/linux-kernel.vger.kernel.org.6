Return-Path: <linux-kernel+bounces-335470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DF97E62E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C9C1F21608
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C744C8C;
	Mon, 23 Sep 2024 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xogev/wr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D9286A3;
	Mon, 23 Sep 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074254; cv=none; b=MOuY3hL97s0Wd68opVM9nU5w3vixl9o2gB7ASaBcrdsrvY3J6klJQo4AMLk51f96ZEnD9KMxzWr7dLxO/r0HL76df8AJWFe1NVwX3nCyqt1+YujFCWlVDmjFlR89L7Bgcry7q4L3w0ebD16aGiFPmzfi7KKfY7zqZjJ9NlcXmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074254; c=relaxed/simple;
	bh=wb2GBC7wQUH3F1JQWlhvXnNwMTYmGLZmlzIgJkKpLjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VM8Hps1FWtqvm8AtonKcoK1a7IUVjheSee3XTuQ5nzMbtnFs+TWrGEYYSMagZT6bQHmCqat8CQPlwEDeXCZp1BYMyNbwtuI3L/amWDDZ4nQCGNdTJeG/YVqbNlHoVRg2yXpk1lMNTYCE17iVuG8F+fGhDLwjZxJtZXW0ywaQVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xogev/wr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727074253; x=1758610253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wb2GBC7wQUH3F1JQWlhvXnNwMTYmGLZmlzIgJkKpLjg=;
  b=Xogev/wrgOpcmgrCM3BgcyIHrzTy+BsL/XLC/YnXUYLWliiNct1EWHgI
   PgGFvwNJux/94K1ANhkeFOlW2y2qpW02NCIo9JCIBevYYVDZA+Yksh/bi
   +DH8rK6XY5UZiqVXklIm1tIeIKTMyoST2TZKjowIXKqrhEIq39wjtttJ6
   ABuWFTwNjb+JRaU2pZF/SkbyMN4VYiPsbb6KmuMK8ximCSKH+NuDQrV3D
   X23od2QKrO7sNNyKgz0PoFO2jmI1JNMpNGitj02Kqd0V5hTY3xTLadlb/
   i21yi4d13Sd7abaSP6rs2FUUK6W++aj/8iJ1ylVBuXQdvMySD/tp9QeQJ
   g==;
X-CSE-ConnectionGUID: nbowMA2OSLiJEr3vdSwxZA==
X-CSE-MsgGUID: Semz+/50SQeuWkVqHzFr8w==
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="263115658"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2024 23:50:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 22 Sep 2024 23:50:12 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 22 Sep 2024 23:50:09 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/5] ARM: dts: microchip: sama5d2_icp: Add power monitor support
Date: Mon, 23 Sep 2024 09:49:29 +0300
Message-ID: <20240923064932.5797-3-mihai.sain@microchip.com>
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
 .../boot/dts/microchip/at91-sama5d2_icp.dts   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 5e2bb517a480..8f617cb29d36 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -195,6 +195,37 @@ i2c6: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
+		power-monitor@10 {
+			compatible = "microchip,pac1934";
+			reg = <0x10>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@1 {
+				reg = <0x1>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDD3V3_1";
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDD3V3_2";
+			};
+
+			channel@3 {
+				reg = <0x3>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDDCORE";
+			};
+
+			channel@4 {
+				reg = <0x4>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDDIODDR";
+			};
+		};
+
 		mcp16502@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
-- 
2.46.1


