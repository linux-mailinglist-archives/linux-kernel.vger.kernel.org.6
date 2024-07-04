Return-Path: <linux-kernel+bounces-241324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E539279C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017EC1C2415C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD31B0132;
	Thu,  4 Jul 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eIQtObw4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5B1B11E1;
	Thu,  4 Jul 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106103; cv=none; b=TyhH+RBKUK4kMEd2yxKCVbv4HRGc21Oi57FGgxVhLSf46OKMSRbKWWLM/Itdsagyz4sq2pZhSJww5xdoa6cE69I1O5p+QvCay+LqKuOa/0as/oSaAH050A4cdBWrg+xKIDp5ZJhZaPcPpS+Ew6Y0pwaInjZ6MRYv2owPYS0Mv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106103; c=relaxed/simple;
	bh=eLiOsBN961ZrV78b/shkCSUBotwPrn/lguHRvEpoYpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZwmjwVKpCmvz1HmnUPrvw0nD7FxrPG2RTebmgSep3iQ+pGHlrKw2U9ZIwM1ZrktSL5k9yh1zmCSMlNh9kmwwGVl0cayKT++9QikP8JQojjo488H2ysCkF4wvgO9O7Pwa5c3FKju7NOae8CpJ+pxON0uOB9MYxt63+bYBX4yAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eIQtObw4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106100; x=1751642100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLiOsBN961ZrV78b/shkCSUBotwPrn/lguHRvEpoYpU=;
  b=eIQtObw4lhSO5rMps5kloeQc8uvskfZD1zN2k4lfpfo6m8qdf2n4ZAQe
   RAdXH+/bXoGQCPjr8PcFM6rhelVLylP7LpfIkAbFag5JT20J4yrJ2/Pr0
   ecbe69P6ZtmwTnUOtzhB1uBTULCnuzBWxyiX/GWL8LEiO6wo1o5fOZmrU
   di+iKhyw4RxRmFTkDmG6ryIUeULhZUa5ZEbL7dWxJwwaC3rIu/Wn4Dq5/
   gRKM50sMDNwOZSC8IhkmA/KFAj5+CZtUJU3R6JuZe5KSuE2dRpHU96UkY
   JpnXfdHv3x/8/web9AWs18MF6iFm0iAnKTvkzaLvfzR6EUxf3sRephDwg
   w==;
X-CSE-ConnectionGUID: QsL3knLaRq6A8nmQ6t3mOw==
X-CSE-MsgGUID: xX/9OzW1QY6/Jtrl453Apw==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29497516"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:14:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:47 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:44 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 3/7] ARM: dts: microchip: at91-sama5d34ek: Align the eeprom nodename
Date: Thu, 4 Jul 2024 18:14:07 +0300
Message-ID: <20240704151411.69558-4-andrei.simion@microchip.com>
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
 arch/arm/boot/dts/microchip/sama5d34ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/sama5d34ek.dts b/arch/arm/boot/dts/microchip/sama5d34ek.dts
index bffd61397cb5..18943b873fff 100644
--- a/arch/arm/boot/dts/microchip/sama5d34ek.dts
+++ b/arch/arm/boot/dts/microchip/sama5d34ek.dts
@@ -36,7 +36,7 @@ i2c0: i2c@f0014000 {
 			i2c1: i2c@f0018000 {
 				status = "okay";
 
-				24c256@50 {
+				eeprom@50 {
 					compatible = "atmel,24c256";
 					reg = <0x50>;
 					pagesize = <64>;
-- 
2.34.1


