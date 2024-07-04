Return-Path: <linux-kernel+bounces-241325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E29279C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079921C241F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E5E1B29BA;
	Thu,  4 Jul 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lNSOui0A"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977D1B142B;
	Thu,  4 Jul 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106103; cv=none; b=IzylTpINiXsA72CPNzXjOUS8iQbt2FoeoTR89mad74lZwV83vvqnPMUrn+80q+zT8ih50Y+PDui5Efy5AxP/Vijo8J8rrktw+NcytPMq/9XmkZIpr1H4GOeWlP6Eq8DUxvO0rkGSMxGPDJSGX0lziGQlcSp8RiKFbVm43v0oOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106103; c=relaxed/simple;
	bh=Pat4BXxSAr0FSQ4ENkZwnG/PIQXfvzZ8frFZzUU2m+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBcVJ9i5BRIO/t5EjiR/Y4O0ZXH7SYnmksceYk/51ZPwM6bRT5n02W0Ww26b1XO279jK31cYiJmKZUJ01+WI/tDLNmwwU+3LwPLaPd2fHT3YO2/0mNi09bd4fe8v5H4r/Lw1hIXhQkkahbegN6Lr2w0tkhjRnXKzDGsIUoKROwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lNSOui0A; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106102; x=1751642102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pat4BXxSAr0FSQ4ENkZwnG/PIQXfvzZ8frFZzUU2m+o=;
  b=lNSOui0AxSoEHZwAYWWvqvDM5GprpYymvRxUYO4iZtSdtDSOHxrvV4mm
   hh6E5a18esjTX8kixVTqWBy2zKBlXt6c8HqpxhH9qmRYMZ/6C37Gs/B0V
   y+NAwfb2/zMZStXpXMdvonHhTMyZWfDuhvoQhusKlQ2lgU/y5Pr1cdnio
   sd/LhLvIp9nV7yQH5z+R6QukCFBUN/6ixoPgiqLU6WdGp6L4/kp9Jtd6t
   oyZaoc+HLn+UwrotktH28r+ZZAuOwpqi2BFpdWnZC7XDjBoegvt9wpeZt
   qPvWUeL74CebEdR+1VNa9TGcV7QwESYUmBsqNbw2C66XlG1mF6a756ERW
   g==;
X-CSE-ConnectionGUID: QsL3knLaRq6A8nmQ6t3mOw==
X-CSE-MsgGUID: K3RlSHPWSjm2kM0lgJ5DGA==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29497519"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:14:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:56 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:53 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 6/7] ARM: dts: microchip: at91sam9260ek: Align the eeprom nodename
Date: Thu, 4 Jul 2024 18:14:10 +0300
Message-ID: <20240704151411.69558-7-andrei.simion@microchip.com>
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

Align the eeprom nodename according to device tree specification
and at24.yaml.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 arch/arm/boot/dts/microchip/at91sam9260ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91sam9260ek.dts b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
index 720c15472c4a..6bd60dce8378 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
@@ -165,7 +165,7 @@ button-4 {
 	i2c-gpio-0 {
 		status = "okay";
 
-		24c512@50 {
+		eeprom@50 {
 			compatible = "atmel,24c512";
 			reg = <0x50>;
 		};
-- 
2.34.1


