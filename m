Return-Path: <linux-kernel+bounces-287682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E89952B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69F528311F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA41AB519;
	Thu, 15 Aug 2024 08:48:00 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5B19AD8E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711680; cv=none; b=GHlN7BtlCUplG2fNz2BzpO8Q2LvqafZ6yVC+YaCEmx10LQaHHV9sJdg3Iw2PtAuhvjooAyyPl1CWM9PiOWmYXFaVAlUG/9a14hMiWX9Vsuc8ZKEELv72I3c5gfgQkjt/08dlRQZV0kQVPlDHKVnM14x1czLacKj4gE9rMH9fULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711680; c=relaxed/simple;
	bh=b5h0H+TbmDorO827YGVAMIgw1/eouvVnZo0hwm3Vjls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hqNkN3JAfmChevoEn7Ty4ll1ugzTGWPa8qVl1kHlLSMOJZ9qnIyofdvHD70iwKRyzFd8xJ6+braUj+90oYSjPZQkpy650KWUx1D9Qk2Kry8nA/t/CkmXIHA4d0i4lPKez/GeN1H1sLyC/cX6onl6JjwJ+Q2pCgD639Jt9JgnKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WkzCl25ggz1S7vp;
	Thu, 15 Aug 2024 16:42:59 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C9D48180019;
	Thu, 15 Aug 2024 16:47:52 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 16:47:52 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] sched/deadline: Remove unused inline functions
Date: Thu, 15 Aug 2024 16:45:24 +0800
Message-ID: <20240815084524.4156827-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 5fe7765997b1 ("sched/deadline: Make dl_rq->pushable_dl_tasks update
drive dl_rq->overloaded") leave this unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 kernel/sched/deadline.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c5f1cc753a31..d0c974bea9a9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -745,16 +745,6 @@ void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
 }
 
-static inline
-void inc_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-}
-
-static inline
-void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-}
-
 static inline void deadline_queue_push_tasks(struct rq *rq)
 {
 }
-- 
2.34.1


