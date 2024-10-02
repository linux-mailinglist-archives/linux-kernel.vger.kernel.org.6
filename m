Return-Path: <linux-kernel+bounces-347484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7598D34C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F97E280CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A2194A73;
	Wed,  2 Oct 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UpD0Uve5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E41D52B;
	Wed,  2 Oct 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872282; cv=none; b=C8tpxXfiMDaw0kIxHbAO8VDB+mpRC4kOgmKWEb9qnmktSqO6AAVaDSWYYLUBHl+N2yyEx10oFrLKg9UbtJ0R/FYT0eH5GmE0uPaX2pyD7vEzn5q+VSkSrAjFQynoM4wPPAAsSQkOSHREs56aERxVzEqS78at5i1HrBhks5up/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872282; c=relaxed/simple;
	bh=My2Zzn0sOOinoFVOcRjTYtx7KfC0Pg7q0KDSuV30GFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rtSDNTOx1u8gC2KqeHtpj9Pw7wi4Y7TlY0wjytvhx2eUTuIK0mhA2uIIS+6xaq5mHfc2fZvJVf18meLxZ8solqJCUhfJgumC+sSaysv4t+tkgfgzZ7suZArN0fHb+cuz9DR1FuPjbHnhbOFvr9uAiNxSjmnNXAD3Rwp+4oIY9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UpD0Uve5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727872279; x=1759408279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=My2Zzn0sOOinoFVOcRjTYtx7KfC0Pg7q0KDSuV30GFA=;
  b=UpD0Uve5vAJiFt/H4pNLVOb7EAyzeF68zpgI3L7jyvV8zK0zkZreCS5z
   pMIIgTwOz1Agokj3SoMOglVLhj9qVv6GZ0Lufw8FXsY9dVkcLLlD4vTWy
   aG2KaLz6pY2o7oY6OPWv8Um9D/U+KuEfiGhn4uKJAuJUcwp663JL20qgF
   cOnKYelXACQiU7DMO0GBua3+m2riYJj03WU7iTSM+RXUjW+uBJDqL3BUx
   m3RwlQHhKQiXFzy760MqcsbdLnipBQR9VD7fVrOK3mNPlmIPSFHj9htFT
   nMSiLjabzPWlkMUqu3at7PrOKEtIlWAlTq6xgMzpBUpzl/sxRIKX4ioQL
   w==;
X-CSE-ConnectionGUID: gsXlODJpTSiMie2QZcRNiA==
X-CSE-MsgGUID: mbZ1E0RzRACHgJSrfyeTTw==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="33109838"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 05:31:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 05:30:57 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 2 Oct 2024 05:30:55 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v3 0/3] Cosmetic Work for ARM/Microchip (AT91)
Date: Wed, 2 Oct 2024 15:30:08 +0300
Message-ID: <20241002123010.111028-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series updates node names and labels in the Microchip ARM DTS
files to align with Device Tree specificatios

changelog:
v2 -> v3:
- squash ARM: dts: microchip: aks-cdu: Add label for LED sub nodes

v1 -> v2:
- drop patch : Rename the usb node
- add patch : ARM: dts: microchip: aks-cdu: Add label for LED sub nodes

Andrei Simion (4):
  ARM: dts: microchip: Rename the eeprom nodename
  ARM: dts: microchip: Rename the pmic node
  ARM: dts: microchip: Rename LED sub nodes name

 arch/arm/boot/dts/microchip/aks-cdu.dts              | 12 ++++++++----
 arch/arm/boot/dts/microchip/animeo_ip.dts            |  8 ++++----
 arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi |  2 +-
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts       |  6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi  |  2 +-
 .../arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi |  2 +-
 .../boot/dts/microchip/at91-sama5d29_curiosity.dts   |  2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts     |  2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts  |  2 +-
 .../arm/boot/dts/microchip/at91-sama5d2_xplained.dts |  2 +-
 .../arm/boot/dts/microchip/at91-sama5d3_xplained.dts |  2 +-
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts       |  2 +-
 arch/arm/boot/dts/microchip/at91rm9200ek.dts         |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9260ek.dts        |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9261ek.dts        |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9263ek.dts        |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9g20ek.dts        |  4 ++--
 .../arm/boot/dts/microchip/at91sam9g20ek_common.dtsi |  2 +-
 arch/arm/boot/dts/microchip/sama5d34ek.dts           |  2 +-
 arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi      |  2 +-
 20 files changed, 41 insertions(+), 37 deletions(-)


base-commit: fe21733536749bb1b31c9c84e0b8d2ab8d82ce13
-- 
2.34.1


