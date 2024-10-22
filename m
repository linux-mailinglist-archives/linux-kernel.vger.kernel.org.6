Return-Path: <linux-kernel+bounces-375705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C4B9A99BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECA71C21DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4C13D245;
	Tue, 22 Oct 2024 06:26:02 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EA912CDBF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729578361; cv=none; b=MKt8YdCA4F5ZI/EXCRT2zE67iRIwg0SLA1mzbF0GKLEM3kmpb3+UxLHmU13eUlGVLDEzf8SkvhCroxC28R+CeB93LLkVGa1gMOOsPyV5aa4EL1fZzd77qqSN9IuteUd81e4qdyRLQw9DU8vx0TG0BdRWyJhJbpddMil59WW5Zeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729578361; c=relaxed/simple;
	bh=xTDYuZlIWofK+QvgJQq8okCW0wIYASmGSEZA3Fl4jps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fj34dHuG6sbqUKjUdmXkMmT2L82gv8uDJKl1qr085YSAP1aoWMUrmoDjbDP/8xDxmAfLrfwjNoKZZJk5CiFzmm6araJg9d0mg+cpOFc2pIz3c4GOTY8a1ICfCl4CcltDwraTI9LrfSEm0Cku24mIfkMbQw2zwVS9bUb3vHRghNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16717457181c-2d12b;
	Tue, 22 Oct 2024 14:25:54 +0800 (CST)
X-RM-TRANSID:2ee16717457181c-2d12b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9671745721ce-7de4f;
	Tue, 22 Oct 2024 14:25:54 +0800 (CST)
X-RM-TRANSID:2ee9671745721ce-7de4f
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] eeprom: Fix the cacography in Kconfig
Date: Tue, 22 Oct 2024 14:25:34 +0800
Message-Id: <20241022062534.122428-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'swtich' is wrong, so fix it.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/misc/eeprom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 9df12399b..cb1c4b8e7 100644
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




