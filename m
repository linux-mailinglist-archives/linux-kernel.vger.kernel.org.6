Return-Path: <linux-kernel+bounces-369309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A529A1B94
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEF6284E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DD1C2448;
	Thu, 17 Oct 2024 07:22:27 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BD17965E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149747; cv=none; b=mgV1zA8HJz9pLb4ZezN33h7Ghi5MZbWgzSKE11TI1iBR2Vh916liPd6KLZ4DeAmtEBiN/VtfDkpa5QA2b7CaSP7t9rDCEuQfg7debt9rG7jKckGjf7LN1g5XWuoCJL25OWllNgygDxgLcymDshoFTaOsx8lY1Gl34UwdU4B5G6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149747; c=relaxed/simple;
	bh=Xdog5BJH8ppzDBk8cowlGwd3zf7H/WE3XeX06/RCPYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZIxpqDfGwDCKEyoGp/CQtXtCoHijp3fuLZqvOkUz5H7K8dgHZJcuyeiOmV8B8Nhcf2V9aY3RVuOHwGlohsTm9Fsnpdz79rRjEdPFCY5e9ooza+2kUyYeMfDPIgwdOeZPrA4Cp7WWYKbM26lN0BUmS4nfzDyABYUS4saVk1EDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86710bb2a0e1-7011f;
	Thu, 17 Oct 2024 15:22:18 +0800 (CST)
X-RM-TRANSID:2ee86710bb2a0e1-7011f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46710bb1cdd5-799bc;
	Thu, 17 Oct 2024 15:22:18 +0800 (CST)
X-RM-TRANSID:2ee46710bb1cdd5-799bc
From: Ba Jing <bajing@cmss.chinamobile.com>
To: mporter@kernel.crashing.org
Cc: alex.bou9@gmail.com,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] rapidio: rio-access: remove unused macros
Date: Tue, 15 Oct 2024 08:02:07 +0800
Message-Id: <20241015000207.5047-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found these marcos are never referenced
in the code. Just remove them.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/rapidio/rio-access.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/rapidio/rio-access.c b/drivers/rapidio/rio-access.c
index f9e10647f94e..06135dc9a4ce 100644
--- a/drivers/rapidio/rio-access.c
+++ b/drivers/rapidio/rio-access.c
@@ -11,15 +11,6 @@
 
 #include <linux/rio_drv.h>
 
-/*
- *  Wrappers for all RIO configuration access functions.  They just check
- *  alignment and call the low-level functions pointed to by rio_mport->ops.
- */
-
-#define RIO_8_BAD 0
-#define RIO_16_BAD (offset & 1)
-#define RIO_32_BAD (offset & 3)
-
 /**
  * RIO_LOP_READ - Generate rio_local_read_config_* functions
  * @size: Size of configuration space read (8, 16, 32 bits)
-- 
2.33.0




