Return-Path: <linux-kernel+bounces-384378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD099B295F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE41F24462
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A742206E78;
	Mon, 28 Oct 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0gOLLNG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R3EULiDO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5D206072
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100971; cv=none; b=g8RmX1doV5RH2p3tlR8vwKrS1C2djdamuZG/MLldEkQ5REutDuX1tJyM8NE/DDaew/2iCqHSTQGTC24p9Q9LZcLSsHr6pRp74QnbIlq32xok53g0wvWynP+RbqVyzGzcq3wJFmF9kZi8ix0uUKt9oTcpqRz9E7zrGaE8takY94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100971; c=relaxed/simple;
	bh=2UDRB+DB72XW631dGsLP3idfcAnZcDJ9QRhr4KgfRuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qstt2JXgA64E8MZ6ATDhGcUI92tSOrbQF5cN1/14kfkqmZmFxCVF+TikI12aS8B3xVCDyE7QMFGLzRJj5fHyqEeN7NqUCN/Oe3rQ0+1ZFFNgiUoR2oeW6byGlzv2xGfDYWnqDEooOaW3rUUUbEOp1hL/z7WJGzjCYGo1LnYP/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0gOLLNG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R3EULiDO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brGIOxwdxz5vA8K9AE1BJ5tkwgKwUCSeWC3lJ3ltj+I=;
	b=z0gOLLNG8Y/izECVEioQM8ciRDxFkcZGpXgnmGcnqjEI9TnDySk9Vzx7q969RdpzIzXDIn
	Dy11j+yry6T1jBmul+ahriWKKC5suwI7XElvar2WR1ZbVyX2kk3L37ehTywq+Vl4tJjpKx
	0t/xSSqFKBQBdF2ZD9pitCJxhb2tGBI6seFLsrCg6gedOYTei8MzlIIT+EbyzVC1tzaYLq
	NHyNYNhTBwVdRD5Yj1lOUC6LuotzJ41M8uWw/QNxvFXMTZUN7JoykpJtSywRHov+FU1Iqi
	YdHLG/UVwNrmTZEdz/nfU0SJOWh+cmODarrGg4UHjyQ61DVGOwhkwjV9ie46nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brGIOxwdxz5vA8K9AE1BJ5tkwgKwUCSeWC3lJ3ltj+I=;
	b=R3EULiDO79A8I0AHQawIvGmecD9CpOS0BTjrIfxbNySHg5/1IsLCTCy7NhX8FbRLNgq70p
	G/S5HGZmraGVfOBw==
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
Subject: [PATCH 05/12] io_uring: Use helper function hrtimer_update_function()
Date: Mon, 28 Oct 2024 08:35:49 +0100
Message-Id: <e8fbdf7bd54e2fd7f17c1d5ec75914787df7f96b.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a new helper function hrtimer_update_function() to change the
hrtimer's callback function, which also performs additional runtime check
that it is safe to change the callback.

Use the helper function instead of accessing 'function' directly.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 0842aa3f60e7..5a3c2d647467 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2423,7 +2423,7 @@ static enum hrtimer_restart io_cqring_min_timer_wakeu=
p(struct hrtimer *timer)
 			goto out_wake;
 	}
=20
-	iowq->t.function =3D io_cqring_timer_wakeup;
+	hrtimer_update_function(&iowq->t, io_cqring_timer_wakeup);
 	hrtimer_set_expires(timer, iowq->timeout);
 	return HRTIMER_RESTART;
 out_wake:
--=20
2.39.5


