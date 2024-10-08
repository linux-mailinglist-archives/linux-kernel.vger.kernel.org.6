Return-Path: <linux-kernel+bounces-356183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF2995DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC151F26837
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518E7DA79;
	Wed,  9 Oct 2024 02:16:06 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C117C61;
	Wed,  9 Oct 2024 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440166; cv=none; b=TUAM1YRLBA9rGXvMRodnH8tDl39Fs7F7ivsRe362YDKgqLOB0owyQ5+ikR18vxQ7Qd548Fth0M8nWUd7k8yS0T4tkZ0dklkkt502AT86KUXSkdlOHbOwzk5Oagrzi+fq32teRrW2iEixAjzUSXSJZY3nNtMr9+Xhl8BA+2wcvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440166; c=relaxed/simple;
	bh=45ybUQtIa+XN8SSVxjuGi8n3YCzyHdhDbnAgFxIGg0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHWv/ikmK8z/Lyzb1eYz+6kJaFmeweQOwdtjnEmXAXZn7vN3vO0sCfDOddPW3VoKrYoukAAQwGNybj9pGIiMef3pMe92No/UavfCo0s3erzi/Lg0nr+7xO0tj+I9oHFRthLK2wermo/LNraTx7aZcxQms3v9Y9hVTGBX89eidQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66705e75c014-b68db;
	Wed, 09 Oct 2024 10:15:58 +0800 (CST)
X-RM-TRANSID:2ee66705e75c014-b68db
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26705e74c45c-d34b7;
	Wed, 09 Oct 2024 10:15:58 +0800 (CST)
X-RM-TRANSID:2ee26705e74c45c-d34b7
From: Ba Jing <bajing@cmss.chinamobile.com>
To: James.Bottomley@HansenPartnership.com
Cc: deller@gmx.de,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] parisc: lba_pci: remove unused macro
Date: Tue,  8 Oct 2024 15:26:20 +0800
Message-Id: <20241008072620.38663-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found the macro LBA_MASTER_ABORT_ERROR 
is never referenced in the code. Just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/parisc/lba_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 3fc3765fddaa..5990766b6561 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -277,7 +277,6 @@ static int lba_device_present(u8 bus, u8 dfn, struct lba_device *d)
  *		smart mode as well.
  */
 
-#define LBA_MASTER_ABORT_ERROR 0xc
 #define LBA_FATAL_ERROR 0x10
 
 #define LBA_CFG_MASTER_ABORT_CHECK(d, base, tok, error) {		\
-- 
2.33.0




