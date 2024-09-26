Return-Path: <linux-kernel+bounces-339812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C5986AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE8BB20D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31417B514;
	Thu, 26 Sep 2024 02:16:11 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E4175D53
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727316971; cv=none; b=ME38w2ojbZ+RyDw5HMnOYW9hga6hL7bx1+kf0/jqXqcKXSXFBTqJYWBuF7ABVJOfycUan5iRRn76V0WZoEyz8qI9jNjLEazbaKXHajqNQvKLvBcAhtAK1FoyGPxxlpSTXB33XRAIDzgGVYZGQ6EYwT1qsAhptOUdcMe4rgfaQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727316971; c=relaxed/simple;
	bh=FDzYbjk3yqF+YjjFeGBKtj51p0ETpQmwdyfhHAZQ4CM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wd2d2jntKqhIXyLu5BB1wiZhrHOjwtAfoK2kaMlLeqlojYgZ+a+KwnBYLYvZB19aSrKNW2MmzaTiAw3ytEPrqomNzsUHS+nI1oNdK5XZSTix/RCnGvbZmfEVDBuqF9jC6VQArPKG2GFNAb0XGFI8hFlrB1TAm0jWEUYhMi2axO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XDccJ0vC8z1T7tm;
	Thu, 26 Sep 2024 10:14:40 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id E9CD8140258;
	Thu, 26 Sep 2024 10:16:05 +0800 (CST)
Received: from huawei.com (7.223.141.1) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 10:16:04 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tejun Heo
	<tj@kernel.org>, David Vernet <void@manifault.com>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH 1/2] sched/ext: Fix unmatch trailing comment of CONFIG_EXT_GROUP_SCHED
Date: Thu, 26 Sep 2024 10:15:04 +0800
Message-ID: <20240926021506.340636-2-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240926021506.340636-1-zhangqiao22@huawei.com>
References: <20240926021506.340636-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200007.china.huawei.com (7.202.181.34)

The #endif trailing comment of CONFIG_EXT_GROUP_SCHED is unmatched, so fix
it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9ee5a9a261cc..66aaca9efa0c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -588,7 +588,7 @@ struct sched_ext_ops {
 	 * Update @tg's weight to @weight.
 	 */
 	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
-#endif	/* CONFIG_CGROUPS */
+#endif	/* CONFIG_EXT_GROUP_SCHED */
 
 	/*
 	 * All online ops must come before ops.cpu_online().
-- 
2.33.0


