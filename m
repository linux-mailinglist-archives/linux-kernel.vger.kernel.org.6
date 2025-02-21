Return-Path: <linux-kernel+bounces-525657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF72A3F2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404F27AB55B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD12054F3;
	Fri, 21 Feb 2025 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTMwZ2pE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nRqg4o8P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3692AE89
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136810; cv=none; b=IhFy55N63Aww7T2bhcboNR6zT96aV4SmYmlVAQB/AUtJoOUOvVUZn39TmQRAG4ugi49RawdSEYOeORSSSXOdAgoBXVAl1il9MwJacDFYEdYBj6NproDAELstOFfF86OOaaJcWm3QgjG2xvgooDi1OoKmuP4m7ry5QzumZiD6hZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136810; c=relaxed/simple;
	bh=Zs/d2vDsaHOydRQloDM0Apsnrf4WcI+sOh/pNUPQ0og=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qGWrn7eOLNOSbj6FQrnAxSQVEoTE1cahvhR09tqBF0v6VIKWNqoiqnRPQKlvhvjBelJ/54J7WEglcjqtkhHFjqBi4jXE/4hh6V+wYnqnQHKYShNxXWW5JK23UI5Dmw3WaakppxYbt2zOXMo76GTTP7hsI8WiziKWIiE4FJDiWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTMwZ2pE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nRqg4o8P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 12:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740136804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KujPIjH9LY/zrE+t5wTUY7ZTSvsuaHnXOJ6VjHT+vJE=;
	b=eTMwZ2pEiLfG9WQMZ8onftwlqQ9xgRqb4bAsZTmmCe+9nQGW/wqd/SQLxJajpKfpbZojPF
	FGh7tP8pNrrOpidKrVchkclLDlCaWKvk/+7UNeCwYn23o/97+0F1PH1+Ex7kaypf1Bbe7M
	VMkiqBOqcb+1y7wD0p1rYucJm8tJhdZdX+uTBYV5/2icyIKasLbMvjN6AFtxvK8Y8eHrZq
	0JboiRbEQp82JQcBTdybjVoMihFnSbgxwv7hIV62zICTUJRANM8zQPCJS1cAEBbq3Hf68u
	4t9TRfCZP6Mvr6CSEP77Yaa8ry3DXcJk5u1mVC9vI9xKldP8KpXqDfpQmwdCJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740136804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KujPIjH9LY/zrE+t5wTUY7ZTSvsuaHnXOJ6VjHT+vJE=;
	b=nRqg4o8PdyON6BrDgB5w+sgX1i1fF3XqmCn39H5gwkF87e8DTbQ34DNUo0lZJTIrZn9Y5b
	83T0kfIWlBnF0aCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: open list <linux-kernel@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] workqueue: Always use wq_select_unbound_cpu() for
 WORK_CPU_UNBOUND.
Message-ID: <20250221112003.1dSuoGyc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

If the user did not specify a CPU while enqueuing a work item then
WORK_CPU_UNBOUND is passed. In this case, for WQ_UNBOUND a CPU is
selected based on wq_unbound_cpumask while the local CPU is preferred.
For !WQ_UNBOUND the local CPU is selected.
For NOHZ_FULL system with isolated CPU wq_unbound_cpumask is set to the
not isolated (housekeeping) CPUs. This leads to different behaviour if a
work item is scheduled on an isolated CPU where
	schedule_delayed_work(, 1);

will move the timer to the housekeeping CPU and then schedule the work
there (on the housekeeping CPU) while
	schedule_delayed_work(, 0);

will schedule the work item on the isolated CPU.

The documentation says WQ_UNBOUND prefers the local CPU. It can
preferer the local CPU if it is part of wq_unbound_cpumask.

Restrict WORK_CPU_UNBOUND to wq_unbound_cpumask via
wq_select_unbound_cpu().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfe030b443e27..134d9550538aa 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2261,12 +2261,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	rcu_read_lock();
 retry:
 	/* pwq which will be used unless @work is executing elsewhere */
-	if (req_cpu == WORK_CPU_UNBOUND) {
-		if (wq->flags & WQ_UNBOUND)
-			cpu = wq_select_unbound_cpu(raw_smp_processor_id());
-		else
-			cpu = raw_smp_processor_id();
-	}
+	if (req_cpu == WORK_CPU_UNBOUND)
+		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
 
 	pwq = rcu_dereference(*per_cpu_ptr(wq->cpu_pwq, cpu));
 	pool = pwq->pool;
-- 
2.47.2


