Return-Path: <linux-kernel+bounces-429101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EFF9E1765
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA8B284F45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5541DF26C;
	Tue,  3 Dec 2024 09:26:58 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB653F8F7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218017; cv=none; b=XdYsqqnl4+h/tMKU2FVMsPTp1+XE//ANK7MmV81/EX3xiDUONXpD35dRsXwkNcHEjB2bftUvd+5ZkPDljITGPZoLLD4/E1iq0hEk5xrw/WtwbIS3T1YQYZ3sSZ86n68OpzV7ZPxTxWK3il9U7MeBFcf4pbdRufmwt1Nu+sQ1LoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218017; c=relaxed/simple;
	bh=6ByCyMOMgJx8D+jmwctbBGWt3ri3RV66FIe/7mkoPLo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ym3IbCVxU5QjpUptFFh6cdKu0UDxD8f/p99N2Es1zAzjPHwPv84qVu4jsyRCpVIYPckEUTx5VYNlDaMrqEl175FtHPumHK6EqW3IO8DG8J9j728LAwodbM8LkFNMG8l1o5NsEeiNnD/DE1v7yNxu6pgmZTLqnvIB0xZa+ejlkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6674eced5367-90c38;
	Tue, 03 Dec 2024 17:26:46 +0800 (CST)
X-RM-TRANSID:2ee6674eced5367-90c38
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7674eced4fa8-26986;
	Tue, 03 Dec 2024 17:26:45 +0800 (CST)
X-RM-TRANSID:2ee7674eced4fa8-26986
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND] eeprom: Fix the cacography in Kconfig
Date: Tue,  3 Dec 2024 01:26:44 -0800
Message-Id: <20241203092644.7718-1-zhujun2@cmss.chinamobile.com>
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




