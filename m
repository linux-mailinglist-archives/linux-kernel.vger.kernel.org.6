Return-Path: <linux-kernel+bounces-384904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF29B2FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD051282A80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170951DACAF;
	Mon, 28 Oct 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AYg5sqSw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2YWKZo2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CF1D7982
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117973; cv=none; b=apqpVFa/wjAruB4YVYq4R6KNZHNyBEt0OWzayKiEhOqkm66z45Gh38wyP+hwQkLLXDbSjw6WMj0VreLC98bBVrJUOrdyH1D10n4fAhnnGp3n+Oh+HP+x6pqzcREHmxVdIv2Xy0wR5MVdKqOhXstLwJItCg/XXAB8ruvheJAz5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117973; c=relaxed/simple;
	bh=jk2kAjhswdvBih6es6xNEVf85QmUfesQHzKT7xwG7U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYzvd+kiI4LXn/OZ3Bm/P6aZ/hk0Oj998GlbUO4Z1PTOi1L96zn2dXpiTMp3RVWXhBc1PRb+aGnD7wttAlOlzNvxA0VQmQC+xx2otNjir51GUo2JADACqMOtfdXpZP34nBwVd5GD8bvaEDVdFUuQgoikrTHXUrlHXAPQlVscjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AYg5sqSw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2YWKZo2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730117969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FAWWfDjSfgC8ZGoqMvtbJfesZHFbNMw6hYb8tQ1YbY=;
	b=AYg5sqSwo+/at9RqtCPh9BQM79djhDHxQROa1f54zUDxuWhYDvGYR3vYP0kyxsTcgx9BP6
	m4JB7EUFaLz14lOYOZrsta0UfE6r5PDVhhbUyYhZ9QHfXgFDF4OGAojZcJ+6EcriBdXwCb
	a5UOvu3CjlBLVsgZcu5vwH8rpJPPw9F4l4sOs2RUubgJEPMgXJjgxsQqossh1n8HrGGlJP
	9i06UMXPblhWCUe37fE1r7cJkfCBDBtb81s9anxrBfnR+JsXsX7tzNwSmFZbTrHcevfZ40
	TbURT0vo9KNsycblYlkHIp8GdDA8u2yrxiZRVClVjil9VZY0/xI0MfYk+rV9rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730117969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FAWWfDjSfgC8ZGoqMvtbJfesZHFbNMw6hYb8tQ1YbY=;
	b=v2YWKZo2FF/lYPBdN5JOgIuaZNAbrzBiRmqcZQuxJKBAk+GqVx5Ctig8OyBNpkR6BRM4ws
	WIEm+wecYWF7zXAA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH v2 4/4] futex: Allow automatic allocation of process wide futex hash.
Date: Mon, 28 Oct 2024 13:13:58 +0100
Message-ID: <20241028121921.1264150-5-bigeasy@linutronix.de>
In-Reply-To: <20241028121921.1264150-1-bigeasy@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allocate a default futex hash if a task forks its first thread.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h |  6 ++++++
 kernel/fork.c         | 28 ++++++++++++++++++++++++++++
 kernel/futex/core.c   |  5 +++++
 3 files changed, 39 insertions(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index dad50173f70c4..c0f90dda6a295 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -79,6 +79,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t=
 *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
 		     unsigned long arg4, unsigned long arg5);
+int futex_hash_allocate_default(void);
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
@@ -95,6 +96,11 @@ static inline int futex_hash_prctl(unsigned long arg2, u=
nsigned long arg3,
 {
 	return -EINVAL;
 }
+static inline int futex_hash_allocate_default(void)
+{
+	return 0;
+}
+
 #endif
=20
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d2b0a5299bbc..21dccdc8a1f6c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2107,6 +2107,19 @@ static void rv_task_fork(struct task_struct *p)
 #define rv_task_fork(p) do {} while (0)
 #endif
=20
+static bool need_futex_hash_allocate_default(u64 clone_flags)
+{
+	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) !=3D (CLONE_THREAD | CLONE_=
VM))
+		return false;
+	if (!thread_group_leader(current))
+		return false;
+	if (current->signal->nr_threads !=3D 1)
+		return false;
+	if (current->signal->futex_hash_bucket)
+		return false;
+	return true;
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2483,6 +2496,21 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cancel_cgroup;
=20
+	/*
+	 * Allocate a default futex hash for the user process once the first
+	 * thread spawns.
+	 */
+	if (need_futex_hash_allocate_default(clone_flags)) {
+		retval =3D futex_hash_allocate_default();
+		if (retval)
+			goto bad_fork_core_free;
+		/*
+		 * If we fail beyond this point we don't free the allocated
+		 * futex hash map. We assume that another thread will created
+		 * and makes use of it The hash map will be freed once the main
+		 * thread terminates.
+		 */
+	}
 	/*
 	 * From this point on we must avoid any synchronous user-space
 	 * communication until we take the tasklist-lock. In particular, we do
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3ef4cbd5cfa72..8896ade418b4a 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1204,6 +1204,11 @@ static int futex_hash_allocate(unsigned long arg3, u=
nsigned long arg4,
 	return 0;
 }
=20
+int futex_hash_allocate_default(void)
+{
+	return futex_hash_allocate(0, 0, 0);
+}
+
 static int futex_hash_is_shared(unsigned long arg3, unsigned long arg4,
 				unsigned long arg5)
 {
--=20
2.45.2


