Return-Path: <linux-kernel+bounces-526298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED78A3FCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74043167672
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784424BD0E;
	Fri, 21 Feb 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yS0j833G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5SOxPJZo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522E244EAD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157535; cv=none; b=umytcf2JuNpVju37l6Z+ctjxrrkstG445yfOmZq2dsbUm54ptB7kxilkUcCycSTBFpwyEe15m1kbjAeLj9pNBQsg99bUXS8jzM++WqplDIgIya8nPiq0O1C3SjKRGS+NL9/A2/LbtOKsnX8iL97nhjY1T16O1qNuZpr/5EbW/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157535; c=relaxed/simple;
	bh=PcLgvOwEMZu2WWXXvhW1kLYTozf32SUfV/+0RHHzHcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aAlk/K43m7EXdFeUzgQe8bJSQiZe0O621gh157YXnIzgvN9Ml+6wO+IsFWtxXRbk51i3nz+8//ZB4OKca27AfBGF1ZCrSFXL+CHvq+9mpA/0SaG4xtZsa46d5BRexl6nkNOsL2zzgCfYcWSkUu9fYvs8opo/KbOo76DQgEBPdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yS0j833G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5SOxPJZo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 18:05:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740157532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qP11089WK0o09hGO1xWkjS6ayaLWj6Ax9EmoXIsV9wE=;
	b=yS0j833GH5Z/Tbucor33nJ/m4IhdZA/EBwADRIGzsDcrhhkk4y9HlTGROk4hVGT/a7K/xu
	0Elu2crWYQy8OumVp0j2Kze5q+vUcRq1Jw0KQoUOjyTnj4Qn5jxEAFiLyAKeSVNzvYwJU0
	e35TfAsHTlA6sf6dQnLl6pLelNmgHCZBXwbcjV95DOl1Rpws84FnvGmThR3aCmrBMN4uTn
	nsMblxa62Ry0h8facREsf0sf/cIpNtxFXslMkzyP20glYoHpdWqfzfHOtI5QzSgcrQ2U9U
	294Z/EmUKbmkZy8E/PFsSSW0a0gqKgcU2jGO4cNE256ZqVp3S5rOwvHTGOKZzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740157532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qP11089WK0o09hGO1xWkjS6ayaLWj6Ax9EmoXIsV9wE=;
	b=5SOxPJZoVDukFLmf5MV/qacwwOeCtO9CK5T/Vl9qxZF+h20w5PgQzsDE7bjnazthdm6Hd3
	e8XKLx+442HQzMAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] task_work: Consume only item at a time while invoking the
 callbacks.
Message-ID: <20250221170530.L3yMvO0i@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Yi and syzbot managed to hang the task within task_run().

The problem is
 task_work_run() -> __fput() -> perf_release() ->
 perf_event_release_kernel() -> _free_event() ->
 perf_pending_task_sync() -> task_work_cancel() failed ->
 rcuwait_wait_event().

Once task_work_run() is running, the list of callbacks removed from the
task_struct and from this point on task_work_cancel() can't remove any
pending and not yet started work items.

The proposed solution is to remove one item at a time.
Oleg pointed out that this might be problematic if one closes 2.000.000
files at once. While testing this scenario by opening that many files
following by exit() to ensure that all files are closed at once, I did
not observe anything outside of noise.

Consume only one work item at a time. Forward the next work item under
the lock to ensure it is not canceled during the replacement.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Reported-by: "Yi Lai" <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/all/Zx9Losv4YcJowaP%2F@ly-workstation/
Reported-by: syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/673adf75.050a0220.87769.0024.GAE@google.com/
Fixes: c5d93d23a2601 ("perf: Enqueue SIGTRAP always via task_work.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/task_work.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index d1efec571a4a4..7d6c71e9a00a9 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -194,7 +194,7 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
 void task_work_run(void)
 {
 	struct task_struct *task = current;
-	struct callback_head *work, *head, *next;
+	struct callback_head *work, *head;
 
 	for (;;) {
 		/*
@@ -202,17 +202,7 @@ void task_work_run(void)
 		 * work_exited unless the list is empty.
 		 */
 		work = READ_ONCE(task->task_works);
-		do {
-			head = NULL;
-			if (!work) {
-				if (task->flags & PF_EXITING)
-					head = &work_exited;
-				else
-					break;
-			}
-		} while (!try_cmpxchg(&task->task_works, &work, head));
-
-		if (!work)
+		if (!work && !(task->flags & PF_EXITING))
 			break;
 		/*
 		 * Synchronize with task_work_cancel_match(). It can not remove
@@ -220,13 +210,24 @@ void task_work_run(void)
 		 * But it can remove another entry from the ->next list.
 		 */
 		raw_spin_lock_irq(&task->pi_lock);
+		do {
+			head = NULL;
+			if (work) {
+				head = READ_ONCE(work->next);
+			} else {
+				if (task->flags & PF_EXITING)
+					head = &work_exited;
+				else
+					break;
+			}
+		} while (!try_cmpxchg(&task->task_works, &work, head));
 		raw_spin_unlock_irq(&task->pi_lock);
 
-		do {
-			next = work->next;
-			work->func(work);
-			work = next;
+		if (!work)
+			break;
+		work->func(work);
+
+		if (head)
 			cond_resched();
-		} while (work);
 	}
 }
-- 
2.47.2


