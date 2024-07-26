Return-Path: <linux-kernel+bounces-262918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F293CEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F73B22C70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7C15666F;
	Fri, 26 Jul 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ymPae4IM"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A124C99
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978156; cv=none; b=AE8AlM3PgcV81fV/mHGaZkFEM5hL3TJfM1liq+xmPk2tMCJViT5GAcRT5j9EmyZ8ufDYkthyefZP4I6Uy+38wLms3+/hbBUQJ6TFMIaxVzU9rSZK84pWO8i08arOF4resf+giOGgCD7ir/psA/GIgIkERhGeuM7IyFvm2HcDMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978156; c=relaxed/simple;
	bh=KKYhkLtw8opEU/hc/3YlGOLKLb1HB4gg0TtcyKdAl04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWCGxc7oSbhJeYzyHPmBOiLQNYgmzF9egRhdtRd3SmxGk0hUF+DXOjVm+vqX+EOxWsJTLjHgrxZepFay1X7wihjLmcdsLruPLv7BdHU1xdjGWyIMmWNjrj6TOI5qF/zcBVmZp2bSahLiIoQ/481/pq5d8rI69m8zph27rQPSw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ymPae4IM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721978146; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7VKGy79paXg48aja/yidbCIb0qH7CVFAy9m4UNQfoJs=;
	b=ymPae4IMVkK0SuWp8ghpxXr4wYBrt0Z6dHsz7Vb8JAs63WDhUOye/2qEgNJ97uFhvNQmHXSw8Hh17b9WWJyPld3LHpI9+WgOxcjwQVHZNZMTaKOvuFXWmfuCssVCzwxE5+fgR5m+gTxKFFaThiwAXkdidg9zn04yxXTSSpdv7AQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WBKxul4_1721978145;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WBKxul4_1721978145)
          by smtp.aliyun-inc.com;
          Fri, 26 Jul 2024 15:15:45 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: arve@android.com,
	tkjos@android.com
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH-next] binder_alloc:  Add missing kernel-doc function comments
Date: Fri, 26 Jul 2024 15:15:44 +0800
Message-Id: <20240726071544.77167-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc function comments to enhance code readability and
maintainability in accordance with the kernel coding standards.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9579
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/android/binder_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b00961944ab1..3dcc2c03539b 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1047,6 +1047,7 @@ void binder_alloc_vma_close(struct binder_alloc *alloc)
 /**
  * binder_alloc_free_page() - shrinker callback to free pages
  * @item:   item to free
+ * @lru:    controlling LRU
  * @lock:   lock protecting the item
  * @cb_arg: callback argument
  *
-- 
2.32.0.3.g01195cf9f


