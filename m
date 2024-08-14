Return-Path: <linux-kernel+bounces-286426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF3E951AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F111F235B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8531B0123;
	Wed, 14 Aug 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NRzbzD5Z"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066C1A00F3;
	Wed, 14 Aug 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638524; cv=none; b=X+aN0zZnK03ADbHVzOMBUgrdPVZPHlMK9IX1IJ6/ICLbpQ5kFPT4qJGq5cZu/NQyzw0ngjjVJdVwClO99EDdJNZ6xr0G3sej1/TmfuY3H39NK9Qo1GM6Mig1OjW/NdQ8OlXOSCCeGwvndkdQLEgnGIysf3+cxsw0cYwlx69YSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638524; c=relaxed/simple;
	bh=nlRWEKYANxfhouyrfMwuggtzkjUrrXPCMyOMXbxUAP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gK842QeABHOG9/gJup4O1EOTHyRBlogznPsK6uq+J3TnT7ud5Tp6ci+FSPa7Mizfx9hv2tuqIS79m4Kptd9gHnb4VCoRs9rcDFMuYeirFmx0L8jVMZ1NVWDE5F6RDalaLI+rZ0BqauGD1RY6FudC9F6Rv8exWL1oiUmnf0wsSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NRzbzD5Z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723638522; x=1755174522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nlRWEKYANxfhouyrfMwuggtzkjUrrXPCMyOMXbxUAP0=;
  b=NRzbzD5ZmoilaU80y2n+HmqkZQTaSC+JLVpGDLaIpqAWsfABsA18JhUV
   fMDCMa9Z0BduNxaqPmTp0pZPb68vAb7+kqOOcV7sId/AYn+7esuesItbS
   KNR8HqB7kl80jMTsDjDElbmhzxxZCX6cPtfzTL04iheMwGOcKrqTPDORS
   dheUILXhQNEmavVAoBW9hV9emI3ava6pC5XLcZLNSTrTo03aMA05BNXYx
   xQ2q/s1LC3I5qbwi2alguh5aQW+B706zLmU7SsU7qO4mB9tBbDuMtmYpR
   I6HaZqXeeY7XDlilHLR3g2U1ie6VqE2eBBUkOIJxJcYC/06eNVu4oDksg
   w==;
X-CSE-ConnectionGUID: jMfuv37ZSuaTHONLM3a8Iw==
X-CSE-MsgGUID: HxZoIHuhTTO/xf2mjeGdEQ==
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="31152274"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 05:28:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 05:28:38 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 05:28:36 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <cristian.birsan@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 0/5] Cosmetic Work for ARM/Microchip (AT91)
Date: Wed, 14 Aug 2024 15:26:28 +0300
Message-ID: <20240814122633.198562-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch set proposes to:
- clean up coding style errors reported by checkpatch.pl
- align the nodename and sub nodename according to the devicetree
specification even with their binding.

Andrei Simion (5):
  ARM: dts: microchip: Clean up spacing and indentation
  ARM: dts: microchip: Rename the eeprom nodename
  ARM: dts: microchip: Rename the pmic node
  ARM: dts: microchip: Rename the usb node
  ARM: dts: microchip: Rename LED sub nodes name

 arch/arm/boot/dts/microchip/aks-cdu.dts          | 12 ++++++------
 arch/arm/boot/dts/microchip/animeo_ip.dts        | 10 +++++-----
 arch/arm/boot/dts/microchip/at91-ariag25.dts     |  4 ++--
 arch/arm/boot/dts/microchip/at91-ariettag25.dts  |  6 +++---
 .../boot/dts/microchip/at91-cosino_mega2560.dts  |  8 ++++----
 arch/arm/boot/dts/microchip/at91-dvk_som60.dts   |  6 +++---
 .../boot/dts/microchip/at91-dvk_su60_somc.dtsi   |  6 +++---
 arch/arm/boot/dts/microchip/at91-foxg20.dts      |  4 ++--
 arch/arm/boot/dts/microchip/at91-gatwick.dts     |  4 ++--
 arch/arm/boot/dts/microchip/at91-kizbox.dts      |  2 +-
 .../boot/dts/microchip/at91-kizbox2-common.dtsi  |  6 +++---
 arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts  |  6 +++---
 .../dts/microchip/at91-kizboxmini-common.dtsi    |  4 ++--
 .../boot/dts/microchip/at91-kizboxmini-mb.dts    |  2 +-
 arch/arm/boot/dts/microchip/at91-lmu5000.dts     |  4 ++--
 .../boot/dts/microchip/at91-nattis-2-natte-2.dts |  2 +-
 arch/arm/boot/dts/microchip/at91-q5xr5.dts       |  4 ++--
 arch/arm/boot/dts/microchip/at91-qil_a9260.dts   |  4 ++--
 arch/arm/boot/dts/microchip/at91-sam9_l9260.dts  |  2 +-
 .../dts/microchip/at91-sam9x60_curiosity.dts     |  6 +++---
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts   | 12 ++++++------
 .../boot/dts/microchip/at91-sama5d27_som1.dtsi   |  2 +-
 .../boot/dts/microchip/at91-sama5d27_som1_ek.dts | 14 +++++++-------
 .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi |  2 +-
 .../dts/microchip/at91-sama5d27_wlsom1_ek.dts    |  6 +++---
 .../dts/microchip/at91-sama5d29_curiosity.dts    |  8 ++++----
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 16 ++++++++--------
 .../boot/dts/microchip/at91-sama5d2_ptc_ek.dts   |  8 ++++----
 .../boot/dts/microchip/at91-sama5d2_xplained.dts |  8 ++++----
 arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts |  6 +++---
 .../dts/microchip/at91-sama5d3_ksz9477_evb.dts   |  2 +-
 .../boot/dts/microchip/at91-sama5d3_xplained.dts |  8 ++++----
 .../boot/dts/microchip/at91-sama5d4_ma5d4evk.dts |  6 +++---
 .../boot/dts/microchip/at91-sama5d4_xplained.dts |  6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d4ek.dts   |  6 +++---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts   |  2 +-
 arch/arm/boot/dts/microchip/at91-som60.dtsi      |  4 ++--
 arch/arm/boot/dts/microchip/at91-tse850-3.dts    |  6 +++---
 arch/arm/boot/dts/microchip/at91-vinco.dts       |  6 +++---
 arch/arm/boot/dts/microchip/at91-wb45n.dts       |  2 +-
 arch/arm/boot/dts/microchip/at91-wb45n.dtsi      |  4 ++--
 arch/arm/boot/dts/microchip/at91-wb50n.dts       |  6 +++---
 arch/arm/boot/dts/microchip/at91-wb50n.dtsi      |  4 ++--
 arch/arm/boot/dts/microchip/at91rm9200.dtsi      |  4 ++--
 arch/arm/boot/dts/microchip/at91rm9200ek.dts     | 10 +++++-----
 arch/arm/boot/dts/microchip/at91sam9260.dtsi     |  4 ++--
 arch/arm/boot/dts/microchip/at91sam9260ek.dts    | 10 +++++-----
 arch/arm/boot/dts/microchip/at91sam9261.dtsi     |  4 ++--
 arch/arm/boot/dts/microchip/at91sam9261ek.dts    | 10 +++++-----
 arch/arm/boot/dts/microchip/at91sam9263.dtsi     |  4 ++--
 arch/arm/boot/dts/microchip/at91sam9263ek.dts    | 12 ++++++------
 arch/arm/boot/dts/microchip/at91sam9g20ek.dts    |  4 ++--
 .../boot/dts/microchip/at91sam9g20ek_common.dtsi |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi     |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9n12.dtsi     |  4 ++--
 arch/arm/boot/dts/microchip/at91sam9n12ek.dts    |  4 ++--
 arch/arm/boot/dts/microchip/at91sam9rl.dtsi      |  2 +-
 arch/arm/boot/dts/microchip/at91sam9rlek.dts     |  2 +-
 arch/arm/boot/dts/microchip/at91sam9x5.dtsi      |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi    |  6 +++---
 arch/arm/boot/dts/microchip/ethernut5.dts        |  4 ++--
 arch/arm/boot/dts/microchip/evk-pro3.dts         |  4 ++--
 arch/arm/boot/dts/microchip/mpa1600.dts          |  2 +-
 arch/arm/boot/dts/microchip/pm9g45.dts           |  4 ++--
 arch/arm/boot/dts/microchip/sam9x60.dtsi         |  6 +++---
 arch/arm/boot/dts/microchip/sama5d2.dtsi         |  6 +++---
 arch/arm/boot/dts/microchip/sama5d3.dtsi         |  6 +++---
 arch/arm/boot/dts/microchip/sama5d34ek.dts       |  2 +-
 arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi  |  2 +-
 arch/arm/boot/dts/microchip/sama5d3xmb.dtsi      |  6 +++---
 arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi  |  2 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi         |  6 +++---
 arch/arm/boot/dts/microchip/tny_a9263.dts        |  2 +-
 .../arm/boot/dts/microchip/usb_a9260_common.dtsi |  4 ++--
 arch/arm/boot/dts/microchip/usb_a9263.dts        |  4 ++--
 76 files changed, 205 insertions(+), 205 deletions(-)


base-commit: 320eb81df4f6c1a1814fd02ebb4ba41eb80a3c7e
-- 
2.34.1


