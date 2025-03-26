Return-Path: <linux-kernel+bounces-576573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D5A7114B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC683AD6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BF19995E;
	Wed, 26 Mar 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kea5o65R"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E6199FB2;
	Wed, 26 Mar 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973776; cv=none; b=qEk/5BihH0NqJ4A+ut138+FwjGjTUD96oUAT7/l6qXdDq4wVI3vsuR3kmi1hDHi/1EzfWQO28oGWLaOHcpfiakqi1+ws5AkKK5P9ltSFXmBTZ9S/70e2aABojuv8usXQJPy9hdoMnoNaGSeMdHsgShYCIAYz4DULU1qz9eSmJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973776; c=relaxed/simple;
	bh=sxCn43o1ihJ7Lubb3/UrAKd1VNrvg+hbLnroVKlybMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u23bz7/Jzw1VcwjHPSq3C9EeEsT2e7aA08JM0mLf0iwsJ36D/SoA1Al0TBtISa+N0Ql73yeFmKSHCeGcXawlHF8LvakIWcn2H2qqkTIFoeQujojuVG3EqoZKDQAVeKKAWbo/PYN+Og6p6w4R82l8iFG863K5a73/7F+Nce7cY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kea5o65R; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742973775; x=1774509775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxCn43o1ihJ7Lubb3/UrAKd1VNrvg+hbLnroVKlybMg=;
  b=Kea5o65RjF8uZ+X3sOeeu8HWlGVZN44+v7CkYPNxqbP5HkxXaC1FIUFY
   9vt3Q/8TOShcbhHJEsuelh8CAfLM/1F5B9RRm6OET3VrbmE/VUoByH60x
   OP3ZbiVTQI1ErJ9vnVlqYeexxPJYExD8DWkpOqT1YYDyxS0xJG3I6t6+d
   p5uFSUXd/2bqEBxg45i4DuzXdArl0F3W3WjRm3lP+XKVM/bSbpLqKwM6i
   NL5PYWgZJXvP3e+mIwAwycyONEQ/tpcBhFPuhDSXfxKtJly5tFGtLaadN
   mwJRmhr88By0pqssMiCP7eDrPymORRqXBTKprXk/gkCjOwne9dyN5rTYc
   A==;
X-CSE-ConnectionGUID: fNQgDXBrQGWw5+E3ZnPSgg==
X-CSE-MsgGUID: qSyP69NURbKOY18dqN0TFw==
X-IronPort-AV: E=Sophos;i="6.14,277,1736838000"; 
   d="scan'208";a="40182266"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 00:22:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 00:22:27 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 00:22:20 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 3/3] ARM: dts: microchip: sama5d29_curiosity: Add nvmem-layout in QSPI for EUI48 MAC Address
Date: Wed, 26 Mar 2025 12:51:40 +0530
Message-ID: <20250326072140.172244-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250326072140.172244-1-manikandan.m@microchip.com>
References: <20250326072140.172244-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add nvmem-layout in QSPI to read the EUI48 Mac address by the
net drivers using the nvmem property.The offset is set to 0x0
since the factory programmed address is available in the
resource managed space and the size determine if the requested
address is of EUI48 (0x6) or EUI-64 (0x8) type.
This is useful for cases where U-Boot is skipped and the Ethernet
MAC address is needed to be configured by the kernel

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 35756cc01e68..6c5ff08f0b3f 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -478,6 +478,16 @@ flash@0 {
 		label = "atmel_qspi1";
 		status = "okay";
 
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mac_address_eui48: mac-address@0 {
+				reg = <0x0 0x6>;
+			};
+		};
+
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
-- 
2.25.1


