Return-Path: <linux-kernel+bounces-540755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D260A4B480
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2875B3AF14A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34C1F12FF;
	Sun,  2 Mar 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BLtC/kFN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqI8fGvS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26A1EE01B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944237; cv=none; b=puaMVPczD63JDJweKXlPmLrSE25DkggGnJwwoQjpS9ueNms/4nV/Q6SnnffthJEi2Ru75R3tkp3C+M0a/2lRlEmo8WweRYiCphm9/ifcwFxdXI7LMedmmBmxT7NX+BNSWEDxmtGEW6MFy+VqXqFcWR/VEpWIVG06UzRe3L9GXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944237; c=relaxed/simple;
	bh=nm3jnHRda4HitifBptAWoGu1b+t/Cc/b1Cs2siInBQM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RholrtO9fkVKz0PoxNntvjz+dADGBtyOaC5DVn5fyLE6pUYhE2wFhn8OxII3FNTH4lt4SzQSk2GnZwyc9X7dAl47TYyoMDvNYVgZcQKFXKd1atYYO4U+SwLDONar5hyBnbfhRkV+araUJYbynlGSfK3j9gsDeOdO9C4v8vjLXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BLtC/kFN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqI8fGvS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.975178175@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5xK/l6LFqn7LeaJQi95qjBpThzZPtBacmbo+Vkd94eA=;
	b=BLtC/kFNkSe8NBPK98ozDVMimkgTCIR+vLD8HkvmdS+TszuPVsmNyWgcUjCl0DOVSifO3l
	0ZQMXk064SAI4aEIpYDaZ27q4YXu/JhGEfBY3qzfFQP8lOJAiv/uMLSYelEPoTdB6rn++s
	badpjVvwkGZ16yw+XwHG346qNaUGBstkPrjeNseKoQOZJWhb3wly4lsnBYs+0ZFFGc704Z
	e0CDyB4INgj80KfOp53UukeOX+xhQAWxn2q/bEVs6DCjnH0yfPexorqspAiN7hCNgdz5oa
	E1yraRJJscxJ2QptUHlYeBVWaLMakATgMnJ8aTaUZC9UZDW0N3iYCL0yXVy2Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5xK/l6LFqn7LeaJQi95qjBpThzZPtBacmbo+Vkd94eA=;
	b=LqI8fGvS5t3EP7sJwvB1OXntTiPoXYeDTaV+qjERry4zAJl/ThY7ci1s5urx6PZOfFYdtO
	h9L6SS5b46LLrWDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 17/17] selftests/timers/posix-timers: Add a test for exact
 allocation mode
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:37:12 +0100 (CET)

The exact timer ID allocation mode is used by CRIU to restore timers with a
given ID. Add a test case for it.

It's skipped on older kernels when the prctl() fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adopt to the ID counter change in the exact mode case
---
 tools/testing/selftests/timers/posix_timers.c |   60 +++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -7,6 +7,7 @@
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
 #define _GNU_SOURCE
+#include <sys/prctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <stdio.h>
@@ -599,14 +600,71 @@ static void check_overrun(int which, con
 			 "check_overrun %s\n", name);
 }
 
+#include <sys/syscall.h>
+
+static int do_timer_create(int *id)
+{
+	return syscall(__NR_timer_create, CLOCK_MONOTONIC, NULL, id);
+}
+
+static int do_timer_delete(int id)
+{
+	return syscall(__NR_timer_delete, id);
+}
+
+static void check_timer_create_exact(void)
+{
+	int id;
+
+	if (prctl(77, 1, 0, 0, 0)) {
+		switch (errno) {
+		case EINVAL:
+			ksft_test_result_skip("check timer create exact, not supported\n");
+			return;
+		default:
+			ksft_test_result_skip("check timer create exact, errno = %d\n", errno);
+			return;
+		}
+	}
+
+	id = 8;
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (prctl(77, 0, 0, 0, 0))
+		fatal_error(NULL, "prctl()");
+
+	if (id != 8) {
+		ksft_test_result_fail("check timer create exact %d != 8\n", id);
+		return;
+	}
+
+	/* Validate that it went back to normal mode and allocates ID 9 */
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (id == 9)
+		ksft_test_result_pass("check timer create exact\n");
+	else
+		ksft_test_result_fail("check timer create exact. Disabling failed.\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(18);
+	ksft_set_plan(19);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
+	check_timer_create_exact();
+
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
 	check_itimer(ITIMER_REAL, "ITIMER_REAL");


