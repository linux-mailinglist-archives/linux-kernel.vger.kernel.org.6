Return-Path: <linux-kernel+bounces-546471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A6A4FB13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766AD7A74A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8F205AC8;
	Wed,  5 Mar 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mJwfWkV2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AC205E09;
	Wed,  5 Mar 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168942; cv=none; b=UYLK0aMg2nQceQEO4+6/fA455bkRrySfqQZPM43+8sXODHrzvTL4xlvFp2A8qm2fUxLY1h3akRfWv8GdZUFhZjb1u0QzMyctrOim3AfYhtJOH3Mvue9fn7IRrnVIwOLW24xCwR/IU0wJeIhpXUq2K+j1xn1VEMykQI0Xq5CxhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168942; c=relaxed/simple;
	bh=4JCFsrT2zb8UXbPhImj5AFIqomJ1rAKZQeo0+RoriJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcCEIoJ5to284x0PoUZNyNcQIsjae94XcZLi0GJUYgfIVoBZ22j51uyoCQMwq66NFQbhArTePs7niV+LfedFMXFGL0DoIy2uLTnx01kUoo/DW4nLQFTua0/YnMJuL40j60oZXoKSgBlO3nRx+Htq2yk7eMyqbwBsIQoYOrHE+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mJwfWkV2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741168941; x=1772704941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4JCFsrT2zb8UXbPhImj5AFIqomJ1rAKZQeo0+RoriJU=;
  b=mJwfWkV2O5yozJu/5thc/d4QVXOy7TEq58j2MUQBBb0r3mkDhUfqI5iV
   9gPUquBuVSZ5fINhD7Jf1POocwAwC35MDnFkoLzwsMzKVJe62EWSPaxBG
   DyCKmFFWjGyNCufILYh+OjYx/3QlGGoMwj/3+uoVdTflODLX6H9cdT6QO
   Cp5Fw+u5whUcJRYvk+JLRFVeO0x540rie/EBjmVV8FZC9p2W+tivQiNCr
   FAQ6QW+ccyAY8fo88LejYGZzrgrdASlydKWG+OarUw0SyfbeBbBNYnRhD
   /aP5OkwAA/2SLZfBIcrH0Tlny9bExLYYRd7wV4dbqBTggGIo+f6zL+ZUs
   g==;
X-CSE-ConnectionGUID: RIEadWJlSxmIHHqHflXrKA==
X-CSE-MsgGUID: W7gZ41UASgOJJTu0KDXMpA==
X-IronPort-AV: E=Sophos;i="6.14,222,1736838000"; 
   d="scan'208";a="38444126"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2025 03:02:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Mar 2025 03:02:12 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 5 Mar 2025 03:02:05 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 2/2] ARM: dts: microchip: sama5d29_curiosity: Add nvmem-layout in QSPI to describe EUI48 MAC address region
Date: Wed, 5 Mar 2025 15:31:34 +0530
Message-ID: <20250305100134.1171124-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305100134.1171124-1-manikandan.m@microchip.com>
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add nvmem-layout in QSPI to describe EUI48 MAC address region.
This is useful for cases where U-Boot is skipped and the Ethernet
MAC address is needed to be configured in Linux.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 7be215781549..81aca8502195 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -480,6 +480,16 @@ flash@0 {
 		label = "atmel_qspi1";
 		status = "okay";
 
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mac_address_eui48: mac-address@261 {
+				reg = <0x261 0x6>;
+			};
+		};
+
 		at91bootstrap@0 {
 			label = "at91bootstrap";
 			reg = <0x0 0x40000>;
-- 
2.25.1


