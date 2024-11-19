Return-Path: <linux-kernel+bounces-414583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E79D2A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527BF1F23CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051E1CCB4E;
	Tue, 19 Nov 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AR9qxAz5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DD1CFEAE;
	Tue, 19 Nov 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032029; cv=none; b=VMZLJBktXkViw6Rjo382QUjPSlszQCpaqJv1KcqYgtexMe9le2qQtsd7u4EWMw1t2MsqXHe229Ej2UQanWK73Dd/Lp9o3VOaxsURFA0QhTjmNWHHlZ77LohnrLX/Pe2Moj/m0fX7KGRTsyYh/RnzgYjWexc2x5IBR0ddvQUnLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032029; c=relaxed/simple;
	bh=PG6VH6poG77y4wIxB0EeV+toD0HtWQliEBYkvGMzVwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEez4ixjKNmghN/SoWlPdff1gM3qZlLVHldxA1JHHhM4tfmTdbmSJUiVgfGWIUSEKBnMck/TLehp+nFc6Fdsp3wos9jNSilf5VHKpxNlcLW4WJmTP8QSAtyRdSzx+3Ki1+R9KPPho8JeGzZMNfKYKo0MC3CySxbsyzFVAvkVZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AR9qxAz5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732032028; x=1763568028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PG6VH6poG77y4wIxB0EeV+toD0HtWQliEBYkvGMzVwU=;
  b=AR9qxAz5KbR7Bq13yp13qWdwjfymeGoFWKXdgCeMWpvsDTq1NA1hVG28
   88DYRDOSrFnqcasZFoakNOb5FmR7ZEJgPJGm1X2yZ48KRS/zYOrAoOsqu
   BKyRcO8qp3P7M8d/zJ8bVaVORmCF/OgicPXixmZJUDLxn3Y76CbT5ROaQ
   iCVUU3fwchyajnKhmZcsaGdofVux1yOfr2/RgesHrMUCRzqyk7OLe/57n
   qNFHyML3xJUQ0shre6wQLJuAlxSSidLMbnt/UgnSQsdOKll89YQvBcnxT
   /0yHrbQAv9cvzBdl7W5yhqNtScGuaINP1cIqGG/X29CvjeD1DEI5e6cYy
   A==;
X-CSE-ConnectionGUID: 46Cw/aZBStWTzefJ58UrTA==
X-CSE-MsgGUID: 0CjZsGGURZu82JzWAfSU8g==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="265672241"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:00:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:00:07 -0700
Received: from ROB-ULT-M91496.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:00:05 -0700
From: <cristian.birsan@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Cristian Birsan
	<cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/2] ARM: dts: microchip: sama5d29_curiosity: Add no-1-8-v property to sdmmc0 node
Date: Tue, 19 Nov 2024 18:01:06 +0200
Message-ID: <20241119160107.598411-2-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119160107.598411-1-cristian.birsan@microchip.com>
References: <20241119160107.598411-1-cristian.birsan@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Cristian Birsan <cristian.birsan@microchip.com>

Add no-1-8-v property to sdmmc0 node to keep VDDSDMMC power rail at 3.3V.
This property will stop the LDO regulator from switching to 1.8V when the
MMC core detects an UHS SD Card. VDDSDMMC power rail is used by all the
SDMMC interface pins in GPIO mode (PA0 - PA13).

On this board, PA6 is used as GPIO to enable the power switch controlling
USB Vbus for the USB Host. The change is needed to fix the PA6 voltage
level to 3.3V instead of 1.8V.

Fixes: d85c4229e925 ("ARM: dts: at91: sama5d29_curiosity: Add device tree for sama5d29_curiosity board")
Suggested-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 951a0c97d3c6..5933840bb8f7 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -514,6 +514,7 @@ kernel@200000 {
 
 &sdmmc0 {
 	bus-width = <4>;
+	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	disable-wp;
-- 
2.34.1


