Return-Path: <linux-kernel+bounces-241320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4659279B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2941928655E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D61B1204;
	Thu,  4 Jul 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GMJ9YPEJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967241AED55;
	Thu,  4 Jul 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106100; cv=none; b=CX53oF6wg2WhRRZCmzginL2BUV8UnMYbOhWd5IsCxjvU6IlvGqZJrfZcLKhfQKBFZpQHu4vbGOvHwBJMbCsFH4/I9ok7uj0TD1vu8gUKRDUB93ef4xsVef4TyXdBXTCul6UeLPiYOSH1g74wnugRVUbPEkbZJtJcijhbWtyfdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106100; c=relaxed/simple;
	bh=n03wDCvXM92XTDf9U5mj020XVXdBf5n8TY7CUvk3uTg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0iYlshDLmX49K6saqTJud4hRZ5CSkFq1AJSnwY7YqwLxVl41LdrKT8HfhIR0Cy7HKXH9Y6dpoaPOVzcY7+XyPA1u3x/j5n0UZloOl4gtBgqp0R6ewYjEtMbcDP6W073Y5WZpMcf8ADIzJLajW7nS70idQN3UCSZ86qgzE0Umm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GMJ9YPEJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720106098; x=1751642098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n03wDCvXM92XTDf9U5mj020XVXdBf5n8TY7CUvk3uTg=;
  b=GMJ9YPEJaHWbAfgZJ/u7Bb08p/7w+lxgbFznOydSbhLtj3maM1wVv+jy
   Wyf04rlBRCYOJqcjslGz1kKIWGUBLc2Xh637fq3lRLmsJ8e9Pwyp1ASLW
   1yuNNBs1bu9r7nbYSqyYf5r30gOg0c62NufqX22Cx8rD3J2izXJ3xIh3b
   hq1W006xAtTlNcYNTDKFz49LYHRaf0ie3WnTqYeYVAMdMEbBNiqBwnBv1
   uHU5SDXfQl1MgdDswrBI2S4CUITn4nCjOXjpWoqbMuTZoYzhf7lnovvhF
   L1+CqQfkpEdOViQ4WtS/p3VTBDcZri2xVdiVhOXK5JtgxkMZ6Y9kBaRxL
   w==;
X-CSE-ConnectionGUID: QsL3knLaRq6A8nmQ6t3mOw==
X-CSE-MsgGUID: HORkfyXQQliBaZQyZIVpYw==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="29497510"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 08:14:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 08:14:38 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 08:14:35 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 0/7] Update the eeprom nodename following device tree specification
Date: Thu, 4 Jul 2024 18:14:04 +0300
Message-ID: <20240704151411.69558-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Change the nodename for each eeprom according to device tree specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
and according to the format specified in at24.yaml

Andrei Simion (7):
  ARM: dts: microchip: at91-sama5d2_xplained: Align the eeprom nodename
  ARM: dts: microchip: at91-sama5d2_ptc_ek: Align the eeprom nodename
  ARM: dts: microchip: at91-sama5d34ek: Align the eeprom nodename
  ARM: dts: microchip: at91-sama5d27_som1: Align the eeprom nodename
  ARM: dts: microchip: at91sam9g20ek_common: Align the eeprom nodename
  ARM: dts: microchip: at91sam9260ek: Align the eeprom nodename
  ARM: dts: microchip: at91sam9263ek: Align the eeprom nodename

 arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi   | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts   | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts | 2 +-
 arch/arm/boot/dts/microchip/at91sam9260ek.dts         | 2 +-
 arch/arm/boot/dts/microchip/at91sam9263ek.dts         | 2 +-
 arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi | 2 +-
 arch/arm/boot/dts/microchip/sama5d34ek.dts            | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)


base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
-- 
2.34.1


