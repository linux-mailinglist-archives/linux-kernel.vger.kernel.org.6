Return-Path: <linux-kernel+bounces-421394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A4B9D8B44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F70FB2BF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AEF1B6CE4;
	Mon, 25 Nov 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Foq2NT09"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912B1B6CE7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553832; cv=none; b=TLT8lwivDjsJqSvvPxO2yx/P3fxUk4iNOurqENFUKFmNTaXVZ9ZkutGUeojMHf/gnfsOZ4Ar2NTErBNrQ7kyvPgbygVP4lNDFBMKIKQXr+CEEGHqbi3Ftz95fwC186k3evvo5i86fYQHEsPs66KF+mRekJ/yjTRLX1E4K5ZU3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553832; c=relaxed/simple;
	bh=qOdoQ4zceMbkYxIfBNeSfJgioY+WDRKdemGP3sJjOC0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzH1TE17uuFYtVhFUg2ONR3LeibsF9/8Gyv1rfw4w18jYdS6B0PRGaxtDo3Dq9zq7CGR3N9tkoaLbdPULaLyRjHdysLWy5u0H6U/oXUZzqVfpT/XaT3Ni7sZvK22HuFtdtsC4k5RqVq9/lalUKHBOnqr/pXklrWniWFnILzlBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Foq2NT09; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732553831; x=1764089831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qOdoQ4zceMbkYxIfBNeSfJgioY+WDRKdemGP3sJjOC0=;
  b=Foq2NT09VKPT8wRErMR1CiQ2M90KZY+K2FE6Fod3C90ICHFoq0I/u4GR
   skhBg9p9bGVmV0axeACoAlIsLvJ2CFXehNuogz4YiUOC0omQEkWcqR7uk
   LdYqWdsXLD7Yy0vu+981wJYX/Gwc2gFHmutRbrtsMLf4tQ12OA2Vw329e
   r5aAiAOLmQYnOqnVA4ti8RTzQ6qHJRBu4Fc/i7KxUP+3YuXtitUfQg1Ty
   279IFD0Kugz7WayiLsCiFYYmcWUzh7NWYjvCe5xwkBUZNcOhnOL/QwReO
   7a85F1IiMGeXtUVzAAUC6jSiTHeJKIebGK9uq/XrFS8zZY8Ssfc48jgYo
   w==;
X-CSE-ConnectionGUID: BwadCl3WTMmLeCbh5+QoJg==
X-CSE-MsgGUID: XBLxrodeSNKDCeE0uTKW+g==
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="35261079"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2024 09:57:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Nov 2024 09:56:55 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 25 Nov 2024 09:56:54 -0700
From: <nicolas.ferre@microchip.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Cristian Birsan <cristian.birsan@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: at91: pm: change BU Power Switch to automatic mode
Date: Mon, 25 Nov 2024 17:56:48 +0100
Message-ID: <20241125165648.509162-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Change how the Backup Unit Power is configured and force the
automatic/hardware mode.
This change eliminates the need for software management of the power
switch, ensuring it transitions to the backup power source before
entering low power modes.

This is done in the only locaton where this swich was configured. It's
usually done in the bootloader.

Previously, the loss of the VDDANA (or VDDIN33) power source was not
automatically compensated by an alternative power source. This resulted
in the loss of Backup Unit content, including Backup Self-refresh low
power mode information, OTP emulation configuration, and boot
configuration, for instance.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/mach-at91/pm.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index b9b995f8a36e..05a1547642b6 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -598,7 +598,21 @@ static int at91_suspend_finish(unsigned long val)
 	return 0;
 }
 
-static void at91_pm_switch_ba_to_vbat(void)
+/**
+ * at91_pm_switch_ba_to_auto() - Configure Backup Unit Power Switch
+ * to automatic/hardware mode.
+ *
+ * The Backup Unit Power Switch can be managed either by software or hardware.
+ * Enabling hardware mode allows the automatic transition of power between
+ * VDDANA (or VDDIN33) and VDDBU (or VBAT, respectively), based on the
+ * availability of these power sources.
+ *
+ * If the Backup Unit Power Switch is already in automatic mode, no action is
+ * required. If it is in software-controlled mode, it is switched to automatic
+ * mode to enhance safety and eliminate the need for toggling between power
+ * sources.
+ */
+static void at91_pm_switch_ba_to_auto(void)
 {
 	unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
 	unsigned int val;
@@ -609,24 +623,19 @@ static void at91_pm_switch_ba_to_vbat(void)
 
 	val = readl(soc_pm.data.sfrbu + offset);
 
-	/* Already on VBAT. */
-	if (!(val & soc_pm.sfrbu_regs.pswbu.state))
+	/* Already on auto/hardware. */
+	if (!(val & soc_pm.sfrbu_regs.pswbu.ctrl))
 		return;
 
-	val &= ~soc_pm.sfrbu_regs.pswbu.softsw;
-	val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
+	val &= ~soc_pm.sfrbu_regs.pswbu.ctrl;
+	val |= soc_pm.sfrbu_regs.pswbu.key;
 	writel(val, soc_pm.data.sfrbu + offset);
-
-	/* Wait for update. */
-	val = readl(soc_pm.data.sfrbu + offset);
-	while (val & soc_pm.sfrbu_regs.pswbu.state)
-		val = readl(soc_pm.data.sfrbu + offset);
 }
 
 static void at91_pm_suspend(suspend_state_t state)
 {
 	if (soc_pm.data.mode == AT91_PM_BACKUP) {
-		at91_pm_switch_ba_to_vbat();
+		at91_pm_switch_ba_to_auto();
 
 		cpu_suspend(0, at91_suspend_finish);
 
-- 
2.39.2


