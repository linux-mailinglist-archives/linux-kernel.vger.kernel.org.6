Return-Path: <linux-kernel+bounces-384259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D509B28D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0819F1F21E17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2A1D6DAA;
	Mon, 28 Oct 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqlkNyij";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RQzvyhP5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0401D0B83
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100639; cv=none; b=eXzYNRksZuBQuZcL3kUzMXaFxkOX9KxzH7lildMoH3dELX0XHuY9ikKCt6FuAYTsPW0je1fN33s2M239xjei29jVmgxqCUK7DjwvsulHhpsEb2uHUw1rSvv8U0jsQPf6xdJ6l1FAQAV07r5rLFPOi9RHipoQHLz5FDFBMOJUN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100639; c=relaxed/simple;
	bh=pMy90q5Jw5JeY3oE9UnrkNMRYmEsCNbK9W/h0grLeRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1WHURT9teEBvelCXaJrDXyO4aYxdYWA/nIJVyNibWVHWuPX2nKwdw+7yyK9HWkFATG/QDm0DJzsFq1eEJ7k5CLJ37IUc2q7qh689+jlf4Zag1I4ktD8TclcSxeu7wsYfHzTwK8BdGAZzySMxCf5tFqPTNBepMFzbg32svm7eZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqlkNyij; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RQzvyhP5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqIZfhlM6JiBAfAU0JkJcw91TW7sTXf1JjNEJjOsuQc=;
	b=AqlkNyijlprPbeaJPQ6tFeig2wgJA6GuzQ26qC+kazTusMa9NbcnvbhWGWOCdw5+vRv4sc
	CrKuoj20PpMwenoIV3NtVbsHPtuNHdbWq+EHZgkZPquVZzI6yN/yQEC6dmdzcrjDq/s2GP
	W1STdxirIeq+Jwd+CiwgO164C6fENPPCJXITpeay6uT8zc22OXu/i4IrhT5FML25YxgTtG
	H4n5TSXPxqCgn2XkUidDFrj19eexUyxHKYhKdME2OvmKybMGogfG2ZjdyTgfZxxCm7Yxik
	rqguIsBM14YrTzv3o96M1t9n+y8HLswAXn1sFcQSkaDTinLDMtxlHbcPQYEeoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqIZfhlM6JiBAfAU0JkJcw91TW7sTXf1JjNEJjOsuQc=;
	b=RQzvyhP54Nl9RFBwLxqHR1PZLvdphkSfprIAF1KbLfAVx7FdQs0RprEjOHBb5gpXZsJKQI
	ZDbvzUxpLczKAPCg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/21] io_uring: Switch to use hrtimer_setup_on_stack()
Date: Mon, 28 Oct 2024 08:29:38 +0100
Message-Id: <b9bb889aa1ba4f57576061e45a751137608e1dea.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced function hrtimer_setup_on_stack(), which will
replace hrtimer_init_on_stack(). In addition to what
hrtimer_init_on_stack() does, this new function also sanity-checks and
initializes the callback function pointer.

Switch to use the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index feb61d68dca6..0842aa3f60e7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2435,13 +2435,14 @@ static int io_cqring_schedule_timeout(struct io_wai=
t_queue *iowq,
 {
 	ktime_t timeout;
=20
-	hrtimer_init_on_stack(&iowq->t, clock_id, HRTIMER_MODE_ABS);
 	if (iowq->min_timeout) {
 		timeout =3D ktime_add_ns(iowq->min_timeout, start_time);
-		iowq->t.function =3D io_cqring_min_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_min_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	} else {
 		timeout =3D iowq->timeout;
-		iowq->t.function =3D io_cqring_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	}
=20
 	hrtimer_set_expires_range_ns(&iowq->t, timeout, 0);
--=20
2.39.5


