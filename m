Return-Path: <linux-kernel+bounces-384384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0EB9B2965
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB5D1C219EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F72076C2;
	Mon, 28 Oct 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJfwxCq0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXFEppkH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFB20697B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100974; cv=none; b=vDCPvEP8S8wNGFBAiATJjrh9XlRIATB+0kBbnxIh6Kf7/ghBDptTvJt5qClZTnW3q4ZbW9FnLMYBCpZMs7lnrfUDaejMA4eXQEUf/kqvRXQmX4Y61ph72/kdVCmTlajkspcr5oEpdJWp2x6QjvUgfGbBcjf/z7LU+KqAekyVrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100974; c=relaxed/simple;
	bh=DCwO148OTmr2+9qrHSHo8hg2kwZqYYBZLcRGJN+PRaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=df6FWcnzEiw0shwoRw2IpW+EnFDdpE6GzSVuNWi7KB0nfHQFmkauEBDkquPDZewJlMjq2EQ2KGLBFrOUMrmnuoFytu4zKWsxaLYggD3RmK9lgYD5Hpa6rZ7rAd4+gR+mDFg2dgExdzT8N4FjuUbQZTqICzdU7BlD44np1t42FWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IJfwxCq0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXFEppkH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ukinf5Kr8oj6nMWExEjL5xi5Kgc0krc384YnlLcY+Wk=;
	b=IJfwxCq0xvbM8mvZ9vcz45NU/kO/71QanZ0j2LW2qDrYTqAAgp1fp4kHM7YKZCiWuB9+SA
	VGNdOJUJECRI9FRyj3mFW5lXYRGJh+WV1QLLfbcSJdedDvXpSUvU2ZJLtYyrj4UfyCeA+w
	gvW4rgo0ISEWTwkc/K8shMoz8HSXdLWyh6zu4cp5sXl3TQ4HDiZrb4ypdo9xsBucPEPESc
	43X3M5FShzP9eBlAucPQnHM0l21S2D8UvLpsL4WhHEHpmJhqNRZ29jWjWaqrS1uzQHBx9r
	a8JjgodkXj2yRaWBOt2xFPCmp12d2+7OSStlkm4ZrRAothMzTMe/AYi33RemMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ukinf5Kr8oj6nMWExEjL5xi5Kgc0krc384YnlLcY+Wk=;
	b=PXFEppkHktgqFggPgOn4rgOU8lnTQ52bCCmHvB0gjQVjNkEzd5wfOe2AvjZ5QjQYLCIQDY
	vrHveWJGYOZ4bqAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 12/12] tracing/timers: Rename hrtimer_init event to hrtimer_setup
Date: Mon, 28 Oct 2024 08:35:56 +0100
Message-Id: <c129c267e9041f65b7ac010d39791489d4b1c5d1.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function hrtimer_init() doesn't exist anymore. It was replaced by
hrtimer_setup().

Thus, rename the hrtimer_init trace event to hrtimer_setup to keep it
consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst           | 4 ++--
 include/trace/events/timer.h             | 4 ++--
 kernel/time/hrtimer.c                    | 4 ++--
 tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 4073ca48af4a..502783e7a9b5 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -3070,7 +3070,7 @@ Notice that we lost the sys_nanosleep.
   # cat set_ftrace_filter
   hrtimer_run_queues
   hrtimer_run_pending
-  hrtimer_init
+  hrtimer_setup
   hrtimer_cancel
   hrtimer_try_to_cancel
   hrtimer_forward
@@ -3108,7 +3108,7 @@ Again, now we want to append.
   # cat set_ftrace_filter
   hrtimer_run_queues
   hrtimer_run_pending
-  hrtimer_init
+  hrtimer_setup
   hrtimer_cancel
   hrtimer_try_to_cancel
   hrtimer_forward
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index f8c906be4cd0..1641ae3e6ca0 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -185,12 +185,12 @@ TRACE_EVENT(timer_base_idle,
 		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
=20
 /**
- * hrtimer_init - called when the hrtimer is initialized
+ * hrtimer_setup - called when the hrtimer is initialized
  * @hrtimer:	pointer to struct hrtimer
  * @clockid:	the hrtimers clock
  * @mode:	the hrtimers mode
  */
-TRACE_EVENT(hrtimer_init,
+TRACE_EVENT(hrtimer_setup,
=20
 	TP_PROTO(struct hrtimer *hrtimer, clockid_t clockid,
 		 enum hrtimer_mode mode),
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 48bd61ee9d50..58118b46f62c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -451,14 +451,14 @@ static inline void debug_hrtimer_deactivate(struct hr=
timer *timer) { }
 static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, e=
num hrtimer_mode mode)
 {
 	debug_hrtimer_init(timer);
-	trace_hrtimer_init(timer, clockid, mode);
+	trace_hrtimer_setup(timer, clockid, mode);
 }
=20
 static inline void debug_setup_on_stack(struct hrtimer *timer, clockid_t c=
lockid,
 					enum hrtimer_mode mode)
 {
 	debug_hrtimer_init_on_stack(timer);
-	trace_hrtimer_init(timer, clockid, mode);
+	trace_hrtimer_setup(timer, clockid, mode);
 }
=20
 static inline void debug_activate(struct hrtimer *timer,
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/sh=
ell/trace_btf_enum.sh
index 5a3b8a5a9b5c..6ac6887d057d 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -6,7 +6,7 @@ err=3D0
 set -e
=20
 syscall=3D"landlock_add_rule"
-non_syscall=3D"timer:hrtimer_init,timer:hrtimer_start"
+non_syscall=3D"timer:hrtimer_setup,timer:hrtimer_start"
=20
 TESTPROG=3D"perf test -w landlock"
=20
--=20
2.39.5


