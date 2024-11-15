Return-Path: <linux-kernel+bounces-410127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467229CD4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7B0281C04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE362D7BF;
	Fri, 15 Nov 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iHEa2ssg"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ABF1E522
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633491; cv=none; b=M6XSSd66E0PdVyA/V8a0iQHg6vmASf/rFCdCv8udaBLEgPOaqI4Mqkqs22HZTqLqMZ0qH5CZUMPbMrfqmOb78LorXAzIhpWhtNmZSuYNQ5qqy0+ZBzlZQCFLzXvqy5lH186vvybP6T1FPhwrHn6vD6Nx3UO8t1emXvunuJlT81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633491; c=relaxed/simple;
	bh=7naN72fRIgtRIFVTKTM3f4BRwV7AhFR2uCGK557hYzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3FvYtw1MwfZbdSYsvgrF86gX4sHxjLdLsj0rQ4nYemkyy78FirSjqFn2jcu8/Annx6lV17uBozPRF7gRhyoHBZyrWTkC8+mzYXtZqS19aojMpXlNochpkuN/XL47nGR6KATg6edIZTzywdV1Yu8bqR9hbKgZ30u6f/CJNDVFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iHEa2ssg; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=L+WB7
	D96BqBlwO2qcLOn+YdHWdvyPRnaokgid1v0Uas=; b=iHEa2ssgAxJ7Qd01ltZKe
	mtd/UV/CH5wfT/kYhX8y38fvUpKX4e+8ypKWF1G+pnwr2XYs6u0zR2vriCtRpPvw
	qdSOeNvpTLKjNd6tHuTa6VJHKy8kV+SpikD7d2IWE5pYQoQNdSIHeNesRNwzO78H
	FQC6yLVAgMHkjbxLz6yr+s=
Received: from localhost.localdomain (unknown [123.53.36.205])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHb9I6oTZnBcOYBg--.41458S2;
	Fri, 15 Nov 2024 09:17:46 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com
Cc: zhaomengmeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] sched_ext: Replace scx_next_task_picked() with switch_class() in comment
Date: Fri, 15 Nov 2024 09:17:09 +0800
Message-ID: <20241115011709.1022217-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHb9I6oTZnBcOYBg--.41458S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWUZF17KF18ZFy8Cr1kGrg_yoW8JFWkpF
	Z8Ww4UG3WkA3W2gayfZrn5u3WY9wsaq3Wagryvvwsakr1Ygr1jqw1aqFnFqrW8XrW0yr12
	vr429342ywnFv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnZ2fUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimgqYd2c2nisshwAAsw

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

scx_next_task_picked() has been replaced with siwtch_class(), but comment
is still referencing old one, so replace it.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0036696e7063..9f9bc2930658 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2759,7 +2759,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * If the previous sched_class for the current CPU was not SCX,
 		 * notify the BPF scheduler that it again has control of the
 		 * core. This callback complements ->cpu_release(), which is
-		 * emitted in scx_next_task_picked().
+		 * emitted in switch_class().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
 			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, cpu_of(rq), NULL);
@@ -6091,7 +6091,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		if (cpu != cpu_of(this_rq)) {
 			/*
 			 * Pairs with smp_store_release() issued by this CPU in
-			 * scx_next_task_picked() on the resched path.
+			 * switch_class() on the resched path.
 			 *
 			 * We busy-wait here to guarantee that no other task can
 			 * be scheduled on our core before the target CPU has
-- 
2.43.0


