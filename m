Return-Path: <linux-kernel+bounces-417910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A89D5A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0CB2317B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F68818891F;
	Fri, 22 Nov 2024 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ePQpQUfa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4F22075;
	Fri, 22 Nov 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262752; cv=none; b=Cls3+K7Yjx0Uqz5wTPQknMy99u63zGTt2FBtABXkpoffumXcoSJTfeHfkITb8H/zw+uS7bADme97eKcgUFxQCoTaOo7p38qiNJqoJKyRE82sxAhgLNSUrHRamnRwUqOorW1kys36uOoYqH5iQC3FlAYKOJBqGfWuaxDfSVjTeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262752; c=relaxed/simple;
	bh=hux5Q8X2nef5Bcrui5OWpPRB1gIDoQFhpk4nkDN3EWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=izvBSRLzeQB16STVJ+tgDEsQc/EHzcUHMsNwWrrggh14D93qARsAvNnNX2kCuWq6MT1Fk+5/SHqpGDQKFJ2qt8x+AFsCQedBjagLum7DL4RdONW8Jwqi0RcUhfzvTfT4DQY6FLO5lpbNcIiYITImJYD4YB1NZnqcErRjIdbOQ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ePQpQUfa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732262752; x=1763798752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hux5Q8X2nef5Bcrui5OWpPRB1gIDoQFhpk4nkDN3EWQ=;
  b=ePQpQUfa65rVB6tJ5D55GvGfuGAz2gTDC0rivil7v7/ZNaZZZ8qkx7uQ
   8b2mc8I04FxhGOfLMV7BcPAi4pNCVSP6eUYvIbujP7wJIyfNYMRpQdoHM
   KCrSWhcgzXHZ9uIvBQtbz/jfLINk6XkVHjZwfh1ixddeHwMPM6FSi0JxF
   uOuWj8vOiq0u9LG9uGwHs+VcIWw6e26Pkq1JCwor4ebo0KYabnmHAly1Y
   KpiVRoKy+U1V8QzxU8f2g3n/dvQqO08SewY66eYExbJJYrQjeEDgZ3Vb+
   Yx+y8mzrRjkAAbzMhpkiQLHFbPbDpjOa0fdOKHytXBLSK8O0PKmTK5lGX
   A==;
X-CSE-ConnectionGUID: seBZEJAOQsKqub7xMw7SQA==
X-CSE-MsgGUID: oX8kSjsmThqCFdMRVuwI9Q==
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="34661804"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2024 01:05:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Nov 2024 01:05:42 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 22 Nov 2024 01:05:40 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 0/2] Add power monitor support on sam9x75-curiosity board
Date: Fri, 22 Nov 2024 10:05:21 +0200
Message-ID: <20241122080523.3941-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds power monitor support and moves i2c address/size to dtsi.

[root@SAM9X75 ~]$ lsiio
Device 001: pac1934
Device 000: f804c000.adc
Trigger 000: f804c000.adc-dev0-external_rising

[root@SAM9X75 ~]$ awk -f pac1934.awk
VDD3V3 current:   15.7075 mA, voltage: 3298.34 mV
VDDOUT4 current:    8.436 mA, voltage: 1205.08 mV
VDDCORE current:  121.237 mA, voltage: 1250 mV
VDDIODDR current: 34.3125 mA, voltage: 1354.49 mV

Mihai Sain (2):
  ARM: dts: microchip: sam9x7: Move i2c address/size to dtsi
  ARM: dts: microchip: sam9x75_curiosity: Add power monitor support

 .../dts/microchip/at91-sam9x75_curiosity.dts  | 54 ++++++++++++++++++-
 arch/arm/boot/dts/microchip/sam9x7.dtsi       | 26 +++++++++
 2 files changed, 78 insertions(+), 2 deletions(-)


base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
-- 
2.47.0


