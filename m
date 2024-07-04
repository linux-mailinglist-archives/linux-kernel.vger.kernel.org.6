Return-Path: <linux-kernel+bounces-241327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0639279C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B44288E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6A1B1210;
	Thu,  4 Jul 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cAOJtcOf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E71AED21;
	Thu,  4 Jul 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106121; cv=none; b=iz2yOzGLQr7ZqOyrPyv99HNP6612st9yaPk8I8R7evAa9TbY9TcmMtuknuk2AjsYW4kRpEC1lBTTnvxab0Cv7zjaLhhZjy9wXcDqWYJNTrbZ3BanAGR5b6hlChsrGcSZ/yxd/UZisW9zmJ7/IE91FpTzBE4TYtDKTzH5pYA6A88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106121; c=relaxed/simple;
	bh=teQu9XqtE2HYAap6Y39EqTk/RP3UnpI7PRNpFzZI37E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0HRCxKM0YIksCZe3SJkIpPy4W7JS/9HSAWUdggqK2YZND/DL4tHNN+bU0gzb1GsV0b9XVKwrHyOQw+RhVTCZoRp6waSsqtt1qf+1DkEUgvtLpjlEffNUWIE7ZiIQpO/EMr8ldPTntnyPMAYUtuM8Krtcem8ST9c8lI7ukdR7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cAOJtcOf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106120; x=1751642120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=teQu9XqtE2HYAap6Y39EqTk/RP3UnpI7PRNpFzZI37E=;
  b=cAOJtcOfnFLy8RqYON8ofRymhxKzVkQZkSx+7Xqfyqc4Nh8Djit05v1P
   Uzj4oW7nKSCRpF5m5wP9Z2+Bo+oiHO0LkRkmc2aLLOjIXUoUOV9JjqET+
   j+i0xbE8k1XtQFv//vs67KoCaXqufxL54YH4nzswRjirxm7t2adypcbmD
   TaEeE3bb9YTtEAlcP4nfGMqTUFpwZ0AqcvDbZE5WU4oBBrFFy49/MWF0X
   RL5cVtQDXWfugrPenb/2dRQtJPmhJWKcALpyA48F3eCCW4z8ujYYqaKEU
   XTrGCUc7AYn7HYnD9JkYZ7FE29GGigk8jpnSedF9J4yWupu0y0K3O0OW1
   g==;
X-CSE-ConnectionGUID: AG9CbHu1SyK4bl//9sKdNw==
X-CSE-MsgGUID: yoSnzec4QTaz9FSzizjebQ==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29497533"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:15:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:59 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:56 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 7/7] ARM: dts: microchip: at91sam9263ek: Align the eeprom nodename
Date: Thu, 4 Jul 2024 18:14:11 +0300
Message-ID: <20240704151411.69558-8-andrei.simion@microchip.com>
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
 arch/arm/boot/dts/microchip/at91sam9263ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
index ce8baff6a9f4..bad7dbecba3c 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
@@ -253,7 +253,7 @@ button-right-click {
 	i2c-gpio-0 {
 		status = "okay";
 
-		24c512@50 {
+		eeprom@50 {
 			compatible = "atmel,24c512";
 			reg = <0x50>;
 			pagesize = <128>;
-- 
2.34.1


