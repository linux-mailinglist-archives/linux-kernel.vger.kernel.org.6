Return-Path: <linux-kernel+bounces-324209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E897498A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDA01F21569
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4297DA68;
	Wed, 11 Sep 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZSgFm+O+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/kCTsfY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C2558B7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031634; cv=none; b=rOND8DT0N0Ai6+GSPlnVjziIhITO2a/m0e9q8Lk9DQMg1EpUiYSk+DbVZwQlLvSujpwSlE+0xw72P2/b4CRlYC0+wyiYgKuDxWcF6fz0mH9u+inoEssuNGxXdvpQrRKw1nS2wat6zu3zacltbEhQfjdyN607Ify3srOodL8U2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031634; c=relaxed/simple;
	bh=eWl5OokrWCLk5+ZNm9+QPwTpkCmLx1Qmlf54JGzmflQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gcYDgbI0IaHLXS62PJCu1YrWNHTDdubRYPteeCB9ruHE0i7z4UdauGQ72A2MzMnAOkz3QnwWjhL2oQqgI1BuuF+d4G58zaj/7o6hXQ7B7VT9iHC8SKP1DTp71fgwMzKBrgyWM13XJWhRvxYYR7I3cXQpumQk2pIsl0IHp3uKkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZSgFm+O+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/kCTsfY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+Doq4e/xcT9xXHQDOTyJ76uKwGRsxonwhuTH5qPvAk=;
	b=ZSgFm+O+CqyVdxMB8YR9cIIVdXH1gEJBt1Od++tlWbRrXtniAHe3OvSL1fvB/+rxdPkr1h
	Euh/w+wT+m1oqOVGp5koPYVud+WeFzlYl2FU1qWAw6ZRyrI3mPTRXA7IAS++TrybLRUx50
	Uf3YuM7iEwOFGNj5nnO8gFjCP2acp5ZQMpiivR0qXh9PtUsXg0GlXpUG4lbiih/QZdMgaq
	3z/Uj/tYnqGxMi87HShe8iVlQWxQUToUCpL3mjx5APZMb5+uLabY3bWmE65P4Dby/AWzLe
	9jVX5qhI2koBD34N6MLJBmGWZh7SDR1tHRfqdlYGuseGoe00TPBMFEL/lgheQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+Doq4e/xcT9xXHQDOTyJ76uKwGRsxonwhuTH5qPvAk=;
	b=T/kCTsfY7MMMyUgG3RG7PqyYm+S6IkB+UCUU7TktXO5B/ooZjEkyp6P8JmMiBkdm/OdNCX
	eCO4rIgzsMJjPEDw==
Date: Wed, 11 Sep 2024 07:13:29 +0200
Subject: [PATCH v2 03/15] timers: Update schedule_[hr]timeout*() related
 function descriptions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-3-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

schedule_timeout*() functions do not have proper kernel-doc formatted
function descriptions. schedule_hrtimeout() and schedule_hrtimeout_range()
have a almost identical description.

Add missing function descriptions. Remove copy of function description and
add a pointer to the existing description instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v2: New in v2
---
 kernel/time/sleep_timeout.c | 66 ++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 78b2e7e30b1e..560d17c30aa5 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -110,8 +110,17 @@ signed long __sched schedule_timeout(signed long timeout)
 EXPORT_SYMBOL(schedule_timeout);
 
 /*
- * We can use __set_current_state() here because schedule_timeout() calls
- * schedule() unconditionally.
+ * __set_current_state() can be used in schedule_timeout_*() functions, because
+ * schedule_timeout() calls schedule() unconditionally.
+ */
+
+/**
+ * schedule_timeout_interruptible - sleep until timeout (interruptible)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_INTERRUPTIBLE before starting the timeout.
  */
 signed long __sched schedule_timeout_interruptible(signed long timeout)
 {
@@ -120,6 +129,14 @@ signed long __sched schedule_timeout_interruptible(signed long timeout)
 }
 EXPORT_SYMBOL(schedule_timeout_interruptible);
 
+/**
+ * schedule_timeout_killable - sleep until timeout (killable)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_KILLABLE before starting the timeout.
+ */
 signed long __sched schedule_timeout_killable(signed long timeout)
 {
 	__set_current_state(TASK_KILLABLE);
@@ -127,6 +144,14 @@ signed long __sched schedule_timeout_killable(signed long timeout)
 }
 EXPORT_SYMBOL(schedule_timeout_killable);
 
+/**
+ * schedule_timeout_uninterruptible - sleep until timeout (uninterruptible)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_UNINTERRUPTIBLE before starting the timeout.
+ */
 signed long __sched schedule_timeout_uninterruptible(signed long timeout)
 {
 	__set_current_state(TASK_UNINTERRUPTIBLE);
@@ -134,9 +159,15 @@ signed long __sched schedule_timeout_uninterruptible(signed long timeout)
 }
 EXPORT_SYMBOL(schedule_timeout_uninterruptible);
 
-/*
- * Like schedule_timeout_uninterruptible(), except this task will not contribute
- * to load average.
+/**
+ * schedule_timeout_idle - sleep until timeout (idle)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_IDLE before starting the timeout. It is similar to
+ * schedule_timeout_uninterruptible(), except this task will not contribute to
+ * load average.
  */
 signed long __sched schedule_timeout_idle(signed long timeout)
 {
@@ -151,6 +182,9 @@ EXPORT_SYMBOL(schedule_timeout_idle);
  * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
+ *
+ * Details are explained in schedule_hrtimeout_range() function description as
+ * this function is commonly used.
  */
 int __sched schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 					   const enum hrtimer_mode mode, clockid_t clock_id)
@@ -236,26 +270,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range);
  * @expires:	timeout value (ktime_t)
  * @mode:	timer mode
  *
- * Make the current task sleep until the given expiry time has
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- *
- * Returns: 0 when the timer has expired. If the task was woken before the
- * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
- * by an explicit wakeup, it returns -EINTR.
+ * See schedule_hrtimeout_range() for details. @delta argument of
+ * schedule_hrtimeout_range() is set to 0 and has therefore no impact.
  */
 int __sched schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mode)
 {

-- 
2.39.2


