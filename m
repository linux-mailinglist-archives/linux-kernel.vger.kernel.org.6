Return-Path: <linux-kernel+bounces-390754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F419B7E24
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B262A1F22550
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6451CB503;
	Thu, 31 Oct 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Js/uY/Ju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jltq/pcM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F01C4617
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387714; cv=none; b=P4oZe3dVAP/TV1nBsWLPUZaJcKFu1N/0/EzUyLAlqjV89uFSuz0Yn1B8goT2t3sWIesUKg/ON62ij4SxYZbPh7FJzEVctciFe17NjxVOLTULochkiXhcjUu7/9b95MYuWuqGRJMVWPR79F2S+Uk3H+dXnTv/t5IAfneBxBQV8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387714; c=relaxed/simple;
	bh=N68WOKPYMnY/Yu8RV+FhMvhsDTbZX6bh/LSorMgTpKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAItLb/xV7KUyQY6fo3I7wbWUrg/9ev3EK1czcikP/HW3NgHGtFUlSsMfuZ3P8+tIZ386nXoOSuuE98WADDvrH8iFmfEx2f15cvP6iiAElek/t9VPG6YSo2VDhc5ZZ8lbBuiuJSfRmJ1yTp5g9HdjkdvvKPMsD30xoNK5Z/rRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Js/uY/Ju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jltq/pcM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agDa32oY8+hApUCXceuPV7IuaqEZ6faXr+Tzf7/xqbg=;
	b=Js/uY/JuQcgzX6xkvPe8TvXsgkqhxfCFt/jyNJe7m4WjLnusf+nyHTFs7q0IxJNk2Nm3Ku
	SXKyIHRjasevJzjcJPiokLofjH5OktMNDqou7AwQxrP7mwPcFlKBC2GnL+VAiZO+dEem8X
	JNFst3rH8vXsLXXU7BtWpCnbxf+8PV2LV72FODDxfW/5M/SzyRnUa222RgJw4Y1XvVJ+Js
	Ph3RYcCytUNtHpUrI5ExX+LTSwDS8NRCr4yFBKmun/jEjyMihldeePtEP5N7tQrBKnXDeP
	Whjrd96rGCeZfOeJPABFYii9XyiNTaazw/WkcMTWgLh71dhPx0cL6FbaynOIGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agDa32oY8+hApUCXceuPV7IuaqEZ6faXr+Tzf7/xqbg=;
	b=jltq/pcMCVo4jfWlAeaqVhIuyFit+CAsi2H+ug4GjnwNN2LOMOtLp5THPCa6ewEnx6AV9g
	Q35tp8HT8joVEPDA==
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
Subject: [RESEND PATCH v2 15/19] hrtimers: Delete hrtimer_init_sleeper_on_stack()
Date: Thu, 31 Oct 2024 16:14:29 +0100
Message-Id: <52549846635c0b3a2abf82101f539efdabcd9778.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_init_sleeper_on_stack() is now unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  3 ---
 kernel/time/hrtimer.c   | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 6e026730e803..4e4f04b3c0c2 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -235,9 +235,6 @@ extern void hrtimer_init_on_stack(struct hrtimer *timer=
, clockid_t which_clock,
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 				   enum hrtimer_restart (*function)(struct hrtimer *),
 				   clockid_t clock_id, enum hrtimer_mode mode);
-extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-					  clockid_t clock_id,
-					  enum hrtimer_mode mode);
 extern void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clo=
ckid_t clock_id,
 					   enum hrtimer_mode mode);
=20
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 69430467a17d..376b8182b72e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2051,20 +2051,6 @@ static void __hrtimer_init_sleeper(struct hrtimer_sl=
eeper *sl,
 	sl->task =3D current;
 }
=20
-/**
- * hrtimer_init_sleeper_on_stack - initialize a sleeper in stack memory
- * @sl:		sleeper to be initialized
- * @clock_id:	the clock to be used
- * @mode:	timer mode abs/rel
- */
-void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
-{
-	debug_init_on_stack(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
-
 /**
  * hrtimer_setup_sleeper_on_stack - initialize a sleeper in stack memory
  * @sl:		sleeper to be initialized
--=20
2.39.5


