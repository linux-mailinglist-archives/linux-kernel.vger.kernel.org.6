Return-Path: <linux-kernel+bounces-241322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEA9279BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2431C23D84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4791B14E0;
	Thu,  4 Jul 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ky3bJ75+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDE1B11FD;
	Thu,  4 Jul 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106102; cv=none; b=JTVYTBKmzBG0a+NMnb4GbocJTFclcHJYvCcPSn9pRDM3dzewWeT82j/G1gecaVSPJmZRQmyDXCPWdhmsyZAe5OUsVLUKGML6DQyJ3ZZy2mRF2HwDFdTXi7DvZJvFo5QlF5KmteZJQ+i1HxbiJfNGoFU1uCmTdCJ5wBEhjl/ydl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106102; c=relaxed/simple;
	bh=8Uul53FB6Hg13i0ncGo67sPmG3j5ssJtra6U8XSIvKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBcjF/c9QN61nhYs+BtvCFKH7OP5S5svyRDkltIh821VA26PIHSDuxDFo8C6pVOn8XUsai8JuIeiq9wWVZNujw2HUIC3rC12zDJVNnv6jY83ZtSdByqj19fUxJFPP9TJiBfLFjRW6sxCeIPvtnoYAvotyrwhsgKdKN9DlbF7KRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ky3bJ75+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106101; x=1751642101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Uul53FB6Hg13i0ncGo67sPmG3j5ssJtra6U8XSIvKM=;
  b=ky3bJ75+bXCHQMPcUDVnIUk9q8kE97CDmUFGZBOs4t3COELz/O0XIit/
   9+QATM6oR7VpJxtRJcv3gVKNEgUnuKO2ffiz6TwoP/uvT7HqiM9KUgxTM
   4Tfu6OTqgMVI0HboL4UsMqqLDmo8Jdig/hV2yNE0F9TUCLa6dpfVNa/wK
   IQlZsyOahjKp10GUw6tTyBLZuwCx4RK7Rg8/H7oPNd3m94rEXt+NuzL/9
   b4NL3ml9OyiRADZ/iHe/n2+HcPrwkRt49fnfUWae00VIfWwnjWHskBpjp
   QM9mQUDigpTFVPWTEFFfzJ3ZF19//id1NaAWMDYcGVpPpm0pBAhPZBWsv
   A==;
X-CSE-ConnectionGUID: QsL3knLaRq6A8nmQ6t3mOw==
X-CSE-MsgGUID: Tlb01q+mTTuX9ELIeS28RQ==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29497517"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:14:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:50 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:47 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 4/7] ARM: dts: microchip: at91-sama5d27_som1: Align the eeprom nodename
Date: Thu, 4 Jul 2024 18:14:08 +0300
Message-ID: <20240704151411.69558-5-andrei.simion@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
index 95ecb7d040a8..8ac85dac5a96 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
@@ -106,7 +106,7 @@ i2c0: i2c@f8028000 {
 				scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
-				at24@50 {
+				eeprom@50 {
 					compatible = "atmel,24c02";
 					reg = <0x50>;
 					pagesize = <8>;
-- 
2.34.1


