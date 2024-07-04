Return-Path: <linux-kernel+bounces-241321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89179279BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618F028697E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF061B140B;
	Thu,  4 Jul 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FKVo8eF5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D41AE84E;
	Thu,  4 Jul 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106101; cv=none; b=uLPbyM6im2QPDkZFfUE67Ok1On5GvSaupzjLePKCDVcC8hipapXfwCRQ+i5low2AtwMQP5xX5twY4SiUktM4rhqAHVB58sDFLYmDWABDI11EZTOcXOlLA/Vu+S7dV04KYDEQFo2xpT9hH4PxP7Pv4BS7B8kEhdZBys7F66+xpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106101; c=relaxed/simple;
	bh=KNz/RqGfmhvcb/ewZvjB4oMA+ezopjmupNisM2NoHqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6ncvxUtNAr+er9o1i4eN8BqRlcnfYUj4TJDMjQX6sfoftoUOx/QYH+6pA1NgbSfC02jl4iMGPQenmujD6Tn24bfy8sqga3deXpN7pExkDn5TnWipKdjVIAvX/V1xb8OXlfhuGZFc2WmOwkvdhkElyFa8sguqcR+2G+LTjcfexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FKVo8eF5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106099; x=1751642099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNz/RqGfmhvcb/ewZvjB4oMA+ezopjmupNisM2NoHqw=;
  b=FKVo8eF5N5hfwVabr0lgLyVnKGS7vfvRd+s/jvfFTpu+Vahr8QL7CkAm
   jLzsBUi0TyF/vSy1O4SORh7aRqgtPOzr8jJhCbGTu4Lw4auiDuRZgJ7sY
   /gxFIiTvBMHFLcdPQpw4zAktu5XsHSJkbpuzM+AoJXBPuuYZbwLjm3Psx
   xw6Xan3zCeMDuYHBZIq16qVHUkKnQm0FcVFIqRgoUiPh+wr4qt2Qri1fh
   8o+xZVxPOX+mgQuiZ+29KZ+jNvK803yYeqLmS2qLznNnkerS+jjANWFas
   dee1gUJycpBSsnXqB96HxB5H6kYHKPNuVgDFPMo03MDQWW4BwdVeAWpm0
   w==;
X-CSE-ConnectionGUID: QsL3knLaRq6A8nmQ6t3mOw==
X-CSE-MsgGUID: FWv9VsIUS1WR2Oo6pkt/6Q==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29497512"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:14:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:44 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:41 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 2/7] ARM: dts: microchip: at91-sama5d2_ptc_ek: Align the eeprom nodename
Date: Thu, 4 Jul 2024 18:14:06 +0300
Message-ID: <20240704151411.69558-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704151411.69558-1-andrei.simion@microchip.com>
References: <20240704151411.69558-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Aling the eeprom nodename according to device tree specification
and at24.yaml.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
index 200b20515ab1..e4ae60ef5f8a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
@@ -231,7 +231,7 @@ i2c1: i2c@fc028000 {
 				scl-gpios = <&pioA PIN_PC7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
-				at24@50 {
+				eeprom@50 {
 					compatible = "atmel,24c02";
 					reg = <0x50>;
 					pagesize = <8>;
-- 
2.34.1


