Return-Path: <linux-kernel+bounces-410426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D32B9CDB78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E042832FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263518E750;
	Fri, 15 Nov 2024 09:22:40 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7F186295
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662560; cv=none; b=gIWFLnjfyTO6RWhQfQp9bZlQuPfTQYQi0OY2H4lyHhuPlFc/A4MLgtO/gdiNDWhO/4KZrRVwXEQgxQCiRRbOowyvyrBh5yc60H2QR8RXrpeitoD0bVQjHWyfrxxJnbbR4HVTRH+05vd5da2iN+sDc3czQzWnOBmeYYLGdkhb5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662560; c=relaxed/simple;
	bh=6ByCyMOMgJx8D+jmwctbBGWt3ri3RV66FIe/7mkoPLo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=c5WcAqxjV0XuPjEU8CyCjmBWDh6XaND0+xdnpf18v2RAnRUPm2GCjnik3Hq/Xi1Krt/RCVpp1HeiFwIaCFhe67SIGceP+ZKsLm1Fhcfhw95oRFyJDG/+rM8AwNjdnBh7nZFlfr0WDwKxK2L51oLJCTndVW4XPsKt9XVrcVmJX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5673712d8b99-2bbaf;
	Fri, 15 Nov 2024 17:22:33 +0800 (CST)
X-RM-TRANSID:2ee5673712d8b99-2bbaf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea673712d773c-f4007;
	Fri, 15 Nov 2024 17:22:32 +0800 (CST)
X-RM-TRANSID:2eea673712d773c-f4007
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	W_Armin@gmx.de,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] eeprom: Fix the cacography in Kconfig
Date: Fri, 15 Nov 2024 01:22:30 -0800
Message-Id: <20241115092230.7051-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The word 'swtich' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/misc/eeprom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 9df12399bda3..cb1c4b8e7fd3 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -97,11 +97,11 @@ config EEPROM_DIGSY_MTC_CFG
 	  If unsure, say N.
 
 config EEPROM_IDT_89HPESX
-	tristate "IDT 89HPESx PCIe-swtiches EEPROM / CSR support"
+	tristate "IDT 89HPESx PCIe-switches EEPROM / CSR support"
 	depends on I2C && SYSFS
 	help
 	  Enable this driver to get read/write access to EEPROM / CSRs
-	  over IDT PCIe-swtich i2c-slave interface.
+	  over IDT PCIe-switch i2c-slave interface.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called idt_89hpesx.
-- 
2.17.1




