Return-Path: <linux-kernel+bounces-414582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775849D2A57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265181F2310A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03701D07A7;
	Tue, 19 Nov 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UEUnS4HY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2F1CCB4E;
	Tue, 19 Nov 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032019; cv=none; b=itgaBqT+T6PcUZEmGhVCVHhBP83tFHy2rcSR2ABK82WUGLdLB3H6hOFpf9X9Zu0ynCXeTY7npkvgtLOe+HISczOpxOgHYyRPdRFa9HE4adJwzLZz71N64w56CG2bNEVQdXe46wZykigl9t1SkJhKJouxJFGyLdVHUL+hnY4N7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032019; c=relaxed/simple;
	bh=Ol4pjF1rs0IdAv1vX85TbwzkYznXpOC2KWkPl4N/csY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtZi7VeR2/PkLWUAqZFseL2ORM4sS6Jo7dblp/EHizArj2r2vdt+0e77+YdI5TA6JkIIN6fnz46jku4KX0utg2Lm+z531s4dpl/4AUOD9WX0yka5qDC5aueGT+gGpTbaOGU4PgL9XPjR6HYtnsJ4Hk2VDQ+OsWX7bxN/IozxSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UEUnS4HY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732032018; x=1763568018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ol4pjF1rs0IdAv1vX85TbwzkYznXpOC2KWkPl4N/csY=;
  b=UEUnS4HYcXEqGMJU0uBtC03sGP1/EGjrJbA5iHYP3LHg8nDwPiPgnkBR
   YQrU+mI4ev1/UpANtoKa1BO27pG5zIK1ldlKZu/h/DemsYlU5faLtFRuw
   RVinVeiwtK/DN1FkWqHl+tQ2/r+6Hz6EYMN3PPCtQsDvp/v6fn+fYqkj7
   qKeeQQzzcfJIlHNblg9N4LEgJjDhyacKwOlUFjmOiTIyQQBMKHdliaK8N
   rOWxQWNb2rF6SYEValGoDVW0yk5upfBPcPs6rxtnCrTS0Lptqu3hqGtLP
   AsljNTdTbXOdtX0vE4v7GnI7lvoR77KliKu/ewNVYrZp5n504ycmDM6jC
   g==;
X-CSE-ConnectionGUID: jx9uf5d4QJWO8ovvuPewRw==
X-CSE-MsgGUID: zerSjUQ+SmaIvFgELvLcuQ==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="34515000"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:00:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:00:10 -0700
Received: from ROB-ULT-M91496.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:00:08 -0700
From: <cristian.birsan@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Cristian Birsan
	<cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/2] ARM: dts: microchip: sama5d27_wlsom1_ek: Add no-1-8-v property to sdmmc0 node
Date: Tue, 19 Nov 2024 18:01:07 +0200
Message-ID: <20241119160107.598411-3-cristian.birsan@microchip.com>
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

On this board, PA10 is used as GPIO to enable the power switch controlling
USB Vbus for the USB Host. The change is needed to fix the PA10 voltage
level to 3.3V instead of 1.8V.

Fixes: 5d4c3cfb63fe ("ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1 and wlsom1-ek")
Suggested-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..35a933eec573 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -197,6 +197,7 @@ qspi1_flash: flash@0 {
 
 &sdmmc0 {
 	bus-width = <4>;
+	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	status = "okay";
-- 
2.34.1


