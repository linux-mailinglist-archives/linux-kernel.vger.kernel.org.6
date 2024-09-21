Return-Path: <linux-kernel+bounces-339819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A38986AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7607F1C20984
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27AF153BC1;
	Thu, 26 Sep 2024 02:34:33 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619BA1BC2A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318073; cv=none; b=B4tYCHBC7shO1lK2l16JNVw6fRboMXx4j4/LAb9BOGBCE0xAEjXcORAP6/4pLqwJmYwgGrzXba5b+EPYu62IM7Xqnp2Lz30vab+DxmDmeCuFEV/71amSFJTNy90RZNQFXogLXRXdMoRKhkvq2Uuh0ZSsLquZkvjBblVTgLc3oAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318073; c=relaxed/simple;
	bh=GDv+8Ibq17xHJN2IvdwHK4tBjBZ0XN3QH77OjQWknHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RI4ucu8N+JyLUFIZz2+VNdQoLuzWdeXcyJQiNP4tPeEWPE040bp/lVenXTZ3I85s6gMwTTPX3Z0ptMYhPY8kCbSsVd2LdoONGw8f2DnvrS/cmy37+p0+jhxXz5BhdRhzmCsGkUYQk6iCwABF/Z453QEpQ9qjArmmn5SH8cM2YJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566f4c831925-92929;
	Thu, 26 Sep 2024 10:34:26 +0800 (CST)
X-RM-TRANSID:2ee566f4c831925-92929
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866f4c82a102-ecad8;
	Thu, 26 Sep 2024 10:34:25 +0800 (CST)
X-RM-TRANSID:2ee866f4c82a102-ecad8
From: liujing <liujing@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	W_Armin@gmx.de,
	jdelvare@suse.de,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] eeprom: fix spelling of switch
Date: Sat, 21 Sep 2024 21:41:28 +0800
Message-Id: <20240921134128.16870-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

---
V1-V2: fix title description, move cacography to spelling

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
2.27.0




