Return-Path: <linux-kernel+bounces-401213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563B9C173E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D21C1F2319D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2151D5142;
	Fri,  8 Nov 2024 07:46:22 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586DD1D2239
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051982; cv=none; b=j/S1QUFG0hjZ95pfbEr2pSblbxzUxBLvZUY1gooeATiwzXUpgV9glj8Z0vgQdvqM/3/kAGEsjkaGkDQyLzR/mG4DAP5nyywK7CMP0K8FlZbC0C42nG5FVbp0u5iHQ6Oi9PfhA22mXgrNVcSQR5tPauS88Eaz24oAouJ3bMWxjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051982; c=relaxed/simple;
	bh=VCg2NpwqCAFG9lEC/BCEJRQBB6VWDyXf7AKIG4Hd440=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c2sOSr7lFpsrhoDlY9Bj6Dvu/06kJd7I51Ca4VP4rIXdx6mB3r6UAALnUglWghImNG0MfjgLfTfg9DLz3XzZe9f5lzj3syU9ZvrzVl0Rojp9D4G3/j6rkWSAsOfleGOy87Nkrl8sPF7BuMgPjI18WBE91xW5r1GBe9gR35JZbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4672dc10b992-c1297;
	Fri, 08 Nov 2024 15:43:08 +0800 (CST)
X-RM-TRANSID:2ee4672dc10b992-c1297
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8672dc1027f8-8c5c8;
	Fri, 08 Nov 2024 15:43:08 +0800 (CST)
X-RM-TRANSID:2ee8672dc1027f8-8c5c8
From: guanjing <guanjing@cmss.chinamobile.com>
To: rogerq@kernel.org,
	s-anna@ti.com,
	nm@ti.com,
	horms@kernel.org,
	p-mohan@ti.com
Cc: linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH] fixup for "soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR"
Date: Fri,  8 Nov 2024 13:55:07 +0800
Message-Id: <20241108055507.173622-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 0211cc1e4fbb ("soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 include/linux/pruss_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index c9a31c567e85..29a76a60869c 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -167,7 +167,7 @@ static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
 
 static inline int pruss_cfg_xfr_enable(struct pruss *pruss,
 				       enum pru_type pru_type,
-				       bool enable);
+				       bool enable)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.33.0




