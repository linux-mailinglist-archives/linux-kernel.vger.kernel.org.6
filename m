Return-Path: <linux-kernel+bounces-243132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFF929246
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B446EB222C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E903482F6;
	Sat,  6 Jul 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MiZwUbwQ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F31804F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720258274; cv=none; b=ALzjb7Upm2qmddQxE9loK/9sFWnBx7Vo5+zT1vHhPZzZVTO77P3pA+FH5F5CV/zTXRM2v96K5nEX7T+JBIuU4JOmisGjK3SHdDWAzYO0IstTWUyRCzeM9iJfxxxtMJUdI6C75Yp4AqdHAN41MBlGGh2uTgJ+3WK9lIvwsP6wq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720258274; c=relaxed/simple;
	bh=JqxDCg2+VEXh7cznyrk8ch9DupyREqiMrk3U5f/c33I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVsVtN1Ls8mktYKJ2gVJHZIeVNRbFgSqEYv66/SaOwbp84U2w48vw4EmUl3NfDUYjK5Ud0Bf7VkcrgGibkzX7U8Y+7GUe8jokNY0GSuoHbGqLL3zmdGgMX16Ii9474m+J24oD6fIFvHhZeEVS7Buy7CwnGgWF95+f7/UecOlUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MiZwUbwQ; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9skvF
	UluA3dnDF5CkZEF2S63rntFhUmiVAVYNdNFY6U=; b=MiZwUbwQSBAEkIM77rC8I
	XgoEReOT9f1/ekiMtitLL6UGq3AZ1SdalUVVY2aNwSwX/4CLpjelLDnwvssD1x5f
	svfzGqV4d56Qc+rDu1iyZtkgYJSHRE0bTDWjRQSAjPQG0QCEgLfIXGsAIEqlaIZW
	+xlM0CBf54uexPQz2ikjyo=
Received: from localhost.localdomain (unknown [113.247.47.60])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnz9rHCIlmVNDqAQ--.16563S2;
	Sat, 06 Jul 2024 17:05:11 +0800 (CST)
From: Bing Huang <huangbing775@126.com>
To: dietmar.eggemann@arm.com
Cc: rostedt@goodmis.org,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	vincent.guittot@linaro.org
Subject: [PATCH] sched/fair: Remove stale buddies comment for last and skip
Date: Sat,  6 Jul 2024 17:05:11 +0800
Message-Id: <20240706090511.48818-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz9rHCIlmVNDqAQ--.16563S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4fKFW3AFW5Ww4DXw17trb_yoWfZFg_C3
	sYgwn5G340yr1agrW7Gw4fWr9Yqay8KFyrZ3Z8tFZ7ta4Iqr98JFyrCFyfGr93Gwn2kFs8
	GFn5Was2gF18GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbNJ53UUUUU==
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbiEAQUr2VLcRhnLQABsj

From: Bing Huang <huangbing@kylinos.cn>

commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") has removed last and
skip. Modify the comment accordingly.

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
---
 kernel/sched/fair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..383582f87def 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5466,8 +5466,6 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
  * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq)
-- 
2.25.1


