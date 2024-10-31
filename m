Return-Path: <linux-kernel+bounces-390758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8909B7E28
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEBE1C21A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A71CCEF0;
	Thu, 31 Oct 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/xG8kr+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D2pvWG87"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249E1CB307
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387717; cv=none; b=rm97Gnr8qTW1hg5SjNHxaFuuNKJiiGHGo5iN2l/cl0J+lYBYj2qHKscM/FtIlVXJy/vRELt3WrPN7N00WQtjppx7+t3XsHP7DlX9doKlzw5i00/1swT/NbQAGxjGQIGRIByKDbKrxH0N3syYMPEX97Bf9SNThYs8SzII3XyXXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387717; c=relaxed/simple;
	bh=fAmxbllysH9EcW872wKMtTlLhbFGHlUzSTQmmo+32mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIWyk9asLFeTO3rcM8+rMyQWYe+BSUK0QZ5r5cDKPbgFL0zRlJnosGP9X06jKjGWT33baSuxTN1LIOLvfQ6faqCIwFlFYg92RQpN6zz3Y4D6eJwnHFo/Ox9ZjtjGRyiRlaUc13L2jaxQthU3MNSyh0pkTa5xL1c6zrAk18LSCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/xG8kr+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D2pvWG87; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyamRs/0EaIVuqQPB5WehumUy+LlGp/xnGmtDyoDFVM=;
	b=D/xG8kr+UzsvOcpBfyWcjyng7sjzcG0K9EcKPyWNMvYeG261TZrnXlHKGVEei6kOb1mF9g
	hrf9gXxIuOMPQRKyOSOVUxjL11yKt4rbweVKNokjzjIFnwVrW+5V2Cc/vuOAZ2fL4CTsCZ
	iccJSgXg8Wtx8tp/N4FoCAyHAXDn9cSBwesyyv6Qh0is6BA1IN5r8JG47+fdncBCpv5tHD
	GZtOfPE9YAEKqjwvnlpEVYJp8uihxzJnF3hTylqAqj47IkbIXhyap9W9XpR7hXpPj9b7ak
	gR3um/D30x2wY5n+dA4mfvE6H1WXu7ybo7KKtsESP+2NzirZT49CCRQmUMs5Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyamRs/0EaIVuqQPB5WehumUy+LlGp/xnGmtDyoDFVM=;
	b=D2pvWG87LT2hKQ4zyhtS4dnMNig7h3FvWA2cslB8Pl369L5ZejnCak3vfTJBRhReZzEGAU
	wlIlMFS825QVE4Aw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 19/19] hrtimers: Delete hrtimer_init_on_stack()
Date: Thu, 31 Oct 2024 16:14:33 +0100
Message-Id: <510ce0d2944c4a382ea51e51d03dcfb73ba0f4f7.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_init_on_stack() is now unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  2 --
 kernel/time/hrtimer.c   | 17 -----------------
 2 files changed, 19 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4e4f04b3c0c2..7ef5f7ef31a9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -230,8 +230,6 @@ extern void hrtimer_init(struct hrtimer *timer, clockid=
_t which_clock,
 			 enum hrtimer_mode mode);
 extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fu=
nction)(struct hrtimer *),
 			  clockid_t clock_id, enum hrtimer_mode mode);
-extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
-				  enum hrtimer_mode mode);
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 				   enum hrtimer_restart (*function)(struct hrtimer *),
 				   clockid_t clock_id, enum hrtimer_mode mode);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 376b8182b72e..55e9ffbcd49a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1629,23 +1629,6 @@ void hrtimer_setup(struct hrtimer *timer, enum hrtim=
er_restart (*function)(struc
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);
=20
-/**
- * hrtimer_init_on_stack - initialize a timer in stack memory
- * @timer:	The timer to be initialized
- * @clock_id:	The clock to be used
- * @mode:       The timer mode
- *
- * Similar to hrtimer_init(), except that this one must be used if struct =
hrtimer is in stack
- * memory.
- */
-void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
-{
-	debug_init_on_stack(timer, clock_id, mode);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
-
 /**
  * hrtimer_setup_on_stack - initialize a timer on stack memory
  * @timer:	The timer to be initialized
--=20
2.39.5


