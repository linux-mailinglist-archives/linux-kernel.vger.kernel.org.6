Return-Path: <linux-kernel+bounces-274786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B4A947CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0441F2205D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CB139CFF;
	Mon,  5 Aug 2024 14:18:39 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D039FD8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867519; cv=none; b=uHXBDAzEnT26k4kJjgFqZPBKRi0ciBoWBFv/UMtzGbu7mpOdzavNsfhek/O/NKdsSoY+wG2+00ocIDE/HDpN8W08B1bzmG/YCfeyr/Nhxyzhf7dmHzYPZIKCxVsbP9lUaS58E8XduWURk85DMUHbSDh6Wn2Y7DHJDZsowNlNMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867519; c=relaxed/simple;
	bh=JJ3xBdq9/0oY5u3TWmOjL7hB9km1VWBDCpcEzdocyT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WA9riQ9h/Kcb3vgTO8+KCBo7hLvlgHrqGC2Td//d/uIHAvfQzUreOX9XP0uH5LLOHwwsAt45xd+610kDFhHTUi2Hzbx/Pmm4GumC30Ak3322qBZtMO+FCH+i2szkr1Qn0h2lR9oy4DOxmMP/rn2kXQnoShWWITOexKydmN3wUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wcz6C0SfkzncWy;
	Mon,  5 Aug 2024 22:17:23 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BCC1180105;
	Mon,  5 Aug 2024 22:18:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 5 Aug
 2024 22:18:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bsingharora@gmail.com>, <yuehaibing@huawei.com>,
	<akpm@linux-foundation.org>, <j.granados@samsung.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] delayacct: Remove unused declaration __delayacct_tsk_exit()
Date: Mon, 5 Aug 2024 22:16:22 +0800
Message-ID: <20240805141622.1788183-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 35df17c57cec ("[PATCH] task delay accounting fixes") removed the
implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/delayacct.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6639f48dac36..d359849356f4 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -69,7 +69,6 @@ extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
 
 extern void __delayacct_tsk_init(struct task_struct *);
-extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(struct task_struct *);
 extern int delayacct_add_tsk(struct taskstats *, struct task_struct *);
-- 
2.34.1


