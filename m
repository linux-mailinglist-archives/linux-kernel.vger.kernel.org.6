Return-Path: <linux-kernel+bounces-266888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A156894090D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02301C22D35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E01741D1;
	Tue, 30 Jul 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=resel.fr header.i=@resel.fr header.b="TtRAGzug"
Received: from mail.resel.fr (mail.resel.fr [89.234.162.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF222338
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.162.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323136; cv=none; b=oDykStkzu/G9BR/v+H/7Qx5T/29W/6ECrJ5OSU7lbR3dwOE6p5gZKb69d+Wmsv85Jz1/rlVyI8A98HA39ZYq4FC+MJY/7j3hyNtdHvdJoqfwwgvhXPg2kRZTk1fCntkxJIhIq/sG3OP6Qg9WtRxWt9y73FEeQY8p9bXbd2sfQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323136; c=relaxed/simple;
	bh=IJIsXeFkd7ITV/hxJnRN9WNCgxBVJvSJ58aDV8Ql/NM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W+R0HmzIsK+MNEpT658IOHIH+LdJnFPTOuyTIXJ3yWZebLzK26mph9aUttfsPXKxXt80yr9i1XYDGfnfxUXqNg+PwyMhAvYDHY2hMFEO5Vn3zF25igTtRKCYBuzMKvcBulkByaV/y/kjaiXwOXs3dUceFhaki/axpDoIxWjLcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resel.fr; spf=pass smtp.mailfrom=resel.fr; dkim=pass (1024-bit key) header.d=resel.fr header.i=@resel.fr header.b=TtRAGzug; arc=none smtp.client-ip=89.234.162.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resel.fr
Received: from amateria.intra.resel.fr (localhost [127.0.0.1])
	by mail.resel.fr (ResEl) with ESMTP id 6B6831203F7;
	Tue, 30 Jul 2024 09:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=resel.fr; h=cc
	:cc:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=mail; bh=J2LpPPo
	fMvpGjD4SSd0beeD9TY0IUQeOzw1sqk+Urdg=; b=TtRAGzugOxTXFSB2Nf/B+dd
	98bFkYwK8bN9VWI0I6hj/4CRZa+4lDH/GSeibD1vUr+X4UbcbbFvRnowNrvy8zCh
	NtMhNV3xTnfETWjSxn4rmi6IB7eWGWgGhTTNfOqqHMUVb3jbT8ru6HWhrVipY4II
	6syh3DxS+Qp6v1oe8ISc=
From: Benjamin Somers <benjamin.somers@resel.fr>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH] staging: rtl8723bs: Fix spacing issues
Date: Tue, 30 Jul 2024 07:05:18 +0000
Message-Id: <20240730070518.2850-1-benjamin.somers@resel.fr>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes superfluous tabs at the beginning of the file and
commented includes

Signed-off-by: Benjamin Somers <benjamin.somers@resel.fr>

---
This is my first patch to the kernel
---
 .../rtl8723bs/include/osdep_service_linux.h   | 72 +++++++++----------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 188ed7e26..2ec54f9e1 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -7,43 +7,41 @@
 #ifndef __OSDEP_LINUX_SERVICE_H_
 #define __OSDEP_LINUX_SERVICE_H_
 
-	#include <linux/spinlock.h>
-	#include <linux/compiler.h>
-	#include <linux/kernel.h>
-	#include <linux/errno.h>
-	#include <linux/init.h>
-	#include <linux/slab.h>
-	#include <linux/module.h>
-	#include <linux/kref.h>
-	/* include <linux/smp_lock.h> */
-	#include <linux/netdevice.h>
-	#include <linux/skbuff.h>
-	#include <linux/uaccess.h>
-	#include <asm/byteorder.h>
-	#include <linux/atomic.h>
-	#include <linux/io.h>
-	#include <linux/sem.h>
-	#include <linux/sched.h>
-	#include <linux/etherdevice.h>
-	#include <linux/wireless.h>
-	#include <net/iw_handler.h>
-	#include <linux/if_arp.h>
-	#include <linux/rtnetlink.h>
-	#include <linux/delay.h>
-	#include <linux/interrupt.h>	/*  for struct tasklet_struct */
-	#include <linux/ip.h>
-	#include <linux/kthread.h>
-	#include <linux/list.h>
-	#include <linux/vmalloc.h>
-
-/* 	#include <linux/ieee80211.h> */
-        #include <net/ieee80211_radiotap.h>
-	#include <net/cfg80211.h>
-
-	struct	__queue	{
-		struct	list_head	queue;
-		spinlock_t	lock;
-	};
+#include <linux/spinlock.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kref.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/uaccess.h>
+#include <asm/byteorder.h>
+#include <linux/atomic.h>
+#include <linux/io.h>
+#include <linux/sem.h>
+#include <linux/sched.h>
+#include <linux/etherdevice.h>
+#include <linux/wireless.h>
+#include <net/iw_handler.h>
+#include <linux/if_arp.h>
+#include <linux/rtnetlink.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>	/*  for struct tasklet_struct */
+#include <linux/ip.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/vmalloc.h>
+
+#include <net/ieee80211_radiotap.h>
+#include <net/cfg80211.h>
+
+struct	__queue	{
+	struct	list_head	queue;
+	spinlock_t	lock;
+};
 
 static inline struct list_head *get_next(struct list_head	*list)
 {
-- 
2.20.1



