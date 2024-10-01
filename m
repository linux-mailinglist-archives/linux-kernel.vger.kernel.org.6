Return-Path: <linux-kernel+bounces-346240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A115098C199
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61731282646
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF91CB51C;
	Tue,  1 Oct 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G6RjIYwv"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBC1CB30F;
	Tue,  1 Oct 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796424; cv=none; b=IVy0l5jJcmThSAzFM7gnMJvUgIZl4DyXCoMlEGnVpQV6xYKkfx+hh6AVKgCssd/DpruUuI7tZ4JRUYfhbOoXWexBzl4rhjX0XGzXWs08Qz91nJGkhxZXtpyB3Gl4uzQs62Adj5XgAC/8GUJuUv8ZGboz3IVpFtRMBA+E9xzlz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796424; c=relaxed/simple;
	bh=/Kd5u0VINYMqh2PljtqzaupEDdOzidndfBWAwnTst8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5rOUhk+CpWrZBdn2BYa/eBi7slXNU1qxSFQv6YXrsaodbPH1PvQ60O2UHMgEuH+IKw+nbLSRS7Fyvkze5idnwHDar35KFdgx71VvZAtvI2qSE5m0K+Z6e/p5azad2d3LEWi9KbiFGHiz8c7ltBqG1M0O9ajijCNjCI5O6y+H+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G6RjIYwv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727796423; x=1759332423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Kd5u0VINYMqh2PljtqzaupEDdOzidndfBWAwnTst8E=;
  b=G6RjIYwvJf+N1oh+faBQp1GXFCrkwgHSNcpwa+1R9v9LaWircSNTywPq
   jb4ofNb/tDnRbeo78NXxtFpN4+LruduRO4Kaa20B5PkeC6tjCyapUvimQ
   RGmxxoWzWPBq/+Ja6TZJAC+yicu4odjWBnWOWKoVm7YLRh+itkz1zMV8L
   35MUKADG/XWzxH0/UQIUP+f4OM+FbpWXZdin+mJpQYbK9fDZNPcB66IHj
   rIyOscIBMcNOUOMa1w3pBhynG3g7FWTM7hbMhmCgxJkJlq5Z8vm9gYuD9
   iHNGmaca3w4M4To3z4PJd0mi43ejdYFogfglmYxxHTugbHNEV2Y7EeMNe
   A==;
X-CSE-ConnectionGUID: C4iJhjyxTv2OpDXExwgrvQ==
X-CSE-MsgGUID: 33QSdtsNSSKdrxGNvmedKA==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="35727110"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 08:26:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 08:26:50 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 08:26:46 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Alexander Dhal <ada@thorsis.com>
Subject: [PATCH v2 4/4] ARM: dts: microchip: aks-cdu: Add label for LED sub nodes
Date: Tue, 1 Oct 2024 18:25:41 +0300
Message-ID: <20241001152541.91945-5-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001152541.91945-1-andrei.simion@microchip.com>
References: <20241001152541.91945-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the label property here and use the old node name as value to stay
stable and avoid breaking the userspace applications that depend on those
paths.

Suggested-by: Alexander Dhal <ada@thorsis.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- added in v2 by suggestion of Alexander Dhal
---
 arch/arm/boot/dts/microchip/aks-cdu.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
index 0c3373ad1723..b65f80e1ef05 100644
--- a/arch/arm/boot/dts/microchip/aks-cdu.dts
+++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
@@ -99,22 +99,26 @@ leds {
 		compatible = "gpio-leds";
 
 		led-red {
+			label = "red";
 			gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "none";
 		};
 
 		led-green {
+			label = "green";
 			gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
 		led-yellow {
+			label = "yellow";
 			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
 		led-blue {
+			label = "blue";
 			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
-- 
2.34.1


