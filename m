Return-Path: <linux-kernel+bounces-314539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B933396B4B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765E5287A08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556BF1CC167;
	Wed,  4 Sep 2024 08:35:04 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D691CCB4B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438904; cv=none; b=oNtxriNLvayBvW/vpiEMIM/YAonNUPmTWzaxkWorPpbp4urG9wRUN/B6yrRr9/yTLBipVjJGIiGiWlygGegMSihgZ0+cU7CPXpRzqR4eqivFgnhDAVj07IegIlu4i0I5QlC8i2dGAtMhmRyQ/OeRlT3Fh2gW3GIc7oX/sBAZM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438904; c=relaxed/simple;
	bh=Fb+HAj/0/rc13Oz+/lwCLpb0c6ipSymkclzff49pYsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UdwUg7u9GLXwywuxwbaGDr7jK525EQAGUDjgQ+T1Jyc9/Ct0grrpwQ5gQeObiyzV6lNfOfhzZAJW+fYAceBhl4+/VI26U7MyF5dfTCKtk7FZxZBfT5aCFlN3wcp6UtaEg39SEf4a55clxj1pH53xiELyKRcSjymUypf00xYi8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766d81bb272b-e4731;
	Wed, 04 Sep 2024 16:34:58 +0800 (CST)
X-RM-TRANSID:2ee766d81bb272b-e4731
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66d81bb249d-1db7d;
	Wed, 04 Sep 2024 16:34:58 +0800 (CST)
X-RM-TRANSID:2eea66d81bb249d-1db7d
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: fancer.lancer@gmail.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] ntb: idt: Fix the cacography in ntb_hw_idt.c
Date: Wed,  4 Sep 2024 14:54:42 +0800
Message-Id: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The word 'swtich' is wrong, so fix it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 48dfb1a69a77..6fc9dfe82474 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2547,7 +2547,7 @@ static void idt_deinit_dbgfs(struct idt_ntb_dev *ndev)
  */
 
 /*
- * idt_check_setup() - Check whether the IDT PCIe-swtich is properly
+ * idt_check_setup() - Check whether the IDT PCIe-switch is properly
  *		       pre-initialized
  * @pdev:	Pointer to the PCI device descriptor
  *
-- 
2.33.0




