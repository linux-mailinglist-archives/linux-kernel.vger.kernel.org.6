Return-Path: <linux-kernel+bounces-241323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2055D9279C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B388AB25044
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2AD1B1507;
	Thu,  4 Jul 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EPGhwt9a"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32E1B120D;
	Thu,  4 Jul 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106103; cv=none; b=EIPYLImwgKZY6HE5N3vvgQROkNW2R3+t2UlzkZ94D4/XCYRYxTeC95uTPn0T4iz8cQYcw4ftSo6/uMBAKJK7so2T34R+j7165Gd8N7TqmMmdomMba5NuRIuYarWeUUhrICmnC68WeevJAEJqSsetDt6M//qxiGMQjJQvacgtcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106103; c=relaxed/simple;
	bh=bMDhmfj+Bb4L+S8Pfh5zsMu0A3hqn9Js10Qw2E4BBlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAS/7iJsyyMawikJi5Wl2o7js5lAsu/K4l/kDxC6nDwkNyRRs8IJ2t6lGD+TSWCME1Wr6i9JlN8jpJvNk81lVqcbmMc8d0BtOpmV5SsVgCEGBlmhaU2NEC71ouSnrO+b9x3tDDiXEtyvaCG+bj4LjtUCQJy/vZ6LarirMtsQmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EPGhwt9a; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106101; x=1751642101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bMDhmfj+Bb4L+S8Pfh5zsMu0A3hqn9Js10Qw2E4BBlc=;
  b=EPGhwt9aptq1z3S09wvR+TXtIvyKAh2qF/kZNOVzB+xgKyiPhwFu4Kf8
   SdTktD/4wCZ/sWiLQbeyCTasqs8CuvkyJFjeKSt7m998LZB3B82W5bc4h
   CDhGQtTJEIMWuDJgQJtfhiHMiSZ7f8xAP2sD4bYVnwNLy0Fr7IkiHs2Q0
   TJvQ3naNjX4hEGKC/J8YRr5rHhMQr8YZqT+42a7kskQFpOtXuQR7V1v/9
   H3G7Headr+dSnHaPQaPI04AZ574ttXRuLUTXrO2VAZrlQtD/oixqJecMF
   /2CUO6MU5uUSxJi+O4nHxonrrVu7pSrGNkurC6wydp1HsJlVtc9YTJxAo
   A==;
X-CSE-ConnectionGUID: QsL3knLaRq6A8nmQ6t3mOw==
X-CSE-MsgGUID: nwQjXg/UR5KcDUnMDOhU1Q==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29497518"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:14:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:53 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:50 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 5/7] ARM: dts: microchip: at91sam9g20ek_common: Align the eeprom nodename
Date: Thu, 4 Jul 2024 18:14:09 +0300
Message-ID: <20240704151411.69558-6-andrei.simion@microchip.com>
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
 arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
index 565b99e79c52..4e7cfbbd4241 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
@@ -220,7 +220,7 @@ usb0: ohci@500000 {
 	i2c-gpio-0 {
 		status = "okay";
 
-		24c512@50 {
+		eeprom@50 {
 			compatible = "atmel,24c512";
 			reg = <0x50>;
 			vcc-supply = <&reg_3v3>;
-- 
2.34.1


