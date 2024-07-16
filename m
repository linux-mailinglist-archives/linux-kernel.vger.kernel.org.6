Return-Path: <linux-kernel+bounces-253660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53738932476
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14381F2405E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D841990D0;
	Tue, 16 Jul 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EKANo6Sm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437713D630;
	Tue, 16 Jul 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127274; cv=none; b=LlzGbFbYarlk7KHWi1J9WTYRxSwYWYEkFxpYCJvgpTHMe/yOGhuIPEPklbzgLHeZciStHNQEJW1g3ucS5hN+xxY21A/B3wZAkR5trTgT8G07zyme2Wyg9HZYc65TKD3MVKVWyYcL990V/CF1/h5yMCsz/JmX49c3I4O3SsRRWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127274; c=relaxed/simple;
	bh=6gdpDGE1/LIdEVfgCRKL8aaj9UTnYSsTvPqQ935Y1Lg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GqAf51GufF+V8ooGSNYkdjAbB9apn0oppRM4TaAPJIlyBrC1K1DW4C2zsplmKnIyHxPJkaOgbPl5fObctW4L5eb3P//j1zhoQD9iLgJnDkJzywUwacyEYBSt619GdsDwt1TLr7YNl5BI28NlcMOQCA0ypKBw2qXp/OvOEI7MZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EKANo6Sm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721127271; x=1752663271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6gdpDGE1/LIdEVfgCRKL8aaj9UTnYSsTvPqQ935Y1Lg=;
  b=EKANo6SmQvF4JHk35ZJAW0nR6/b11Z1UrkpuxpBSta5rck0/fRstzygv
   oslhihr2bJ+GxIxaLrob0nMV1RYJqNmHsq+XgDzPVJoBa0cQiQULPHPFt
   q5Lo0B84XVRnvn4oPpH2OcDOxxJDB9ILY26CW6d+uAYZ6WDamU2qFaGrO
   I6xWejV8hgG/bl9GobC8GdYWnEk/hzbMQkPm5/umn0o5FEjqH+0HlXTlw
   TsZEf9UkDVLIGJus4Id+m5ViR872nC42CLxlMebhIXYi5Feih5UrLQ19Y
   SIJX+84mpXwb5lxYdxTObiF7/yCjSgTA0Y1EkMZ36vIjYmcv9mtQ8lseE
   w==;
X-CSE-ConnectionGUID: /vnhTfboQ6C0iy9Ax+QmOQ==
X-CSE-MsgGUID: SCamelLoSPSu/5eVa//GXg==
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="196700543"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2024 03:54:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jul 2024 03:54:26 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jul 2024 03:54:24 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-riscv@lists.infradead.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, William Qiu
	<william.qiu@starfivetech.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1] riscv: dts: starfive: remove non-existant spi device from jh7110-common.dtsi
Date: Tue, 16 Jul 2024 11:54:00 +0100
Message-ID: <20240716-majesty-antler-d9bedc7fd0af@wendy>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=6gdpDGE1/LIdEVfgCRKL8aaj9UTnYSsTvPqQ935Y1Lg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTAj1CfUt+8dRlTvH4E1GlMZ3FW7LF8/WMJzvr5TyqQvdE c6/pKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwEQe7mH4X6n61TNXbu/6kHdG9nPKrh pWvtOOfPztX2HFvPX/XQ9qRjAyrIj1lV3frCa3KfVnyovg1cn7mPdcDL9QfNKy2DN7b74JAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There is no rohm,dh2228fv on any of supported JH7110 boards - in fact
the dh2228fv almost certainly does not exist as it is not a valid Rohm
part number. Likely a typo by Maxime when adding the device originally,
and should have been bh2228fv, but these boards do not have a bh2228fv
either! Remove it from jh7110-common.dtsi - pretending to have a device
so that the spidev driver will be bound by Linux is not acceptable.

Fixes: 74fb20c8f05d ("riscv: dts: starfive: Add spi node and pins configuration")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Emil Renner Berthing <kernel@esmil.dk>
CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: William Qiu <william.qiu@starfivetech.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 8ff6ea64f048..395436ec0f97 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -346,12 +346,6 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
 	status = "okay";
-
-	spi_dev0: spi@0 {
-		compatible = "rohm,dh2228fv";
-		reg = <0>;
-		spi-max-frequency = <10000000>;
-	};
 };
 
 &sysgpio {
-- 
2.43.2


