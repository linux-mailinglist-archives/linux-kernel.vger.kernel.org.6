Return-Path: <linux-kernel+bounces-384287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702679B28EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E62F1C2145C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E41DDC1C;
	Mon, 28 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H80daaLM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAMF1zq5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4821DA636
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100748; cv=none; b=kEywhHE4C6UjtAO9ildkgHKzCe/NCFicwYnUdswAZceiUCs0AtHYa0iqSZ6WYy8j66Sip60VhH730xf7l04WDVDhT7eALgUzm8uNEhZ2bFv2X56LLVgKelo6MwaU+fkPBtVkQFoiyYYZV2mMg4VFtrxzpHOnEHphNFDn/8FlVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100748; c=relaxed/simple;
	bh=1D5djsJJhUbyC6s770KVGASKS1s8lM7wTCs0rej2u0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mz0QOdP0aSGUW7d8zCPLB8IYYKwUPxdBPr1uO6bG90jY1PhI1+8mAVZ6Ep6VrFnc/qF49KxiPdcJZGCAEdwnh9hnJaAi1PkgqMfMWoB11mcj6hm+7dqrm7Zh0gV44ukIr+z6op4NAg4M2UTgUxW6rMM4AknwGDmQmN9Tt6EjRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H80daaLM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAMF1zq5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0xFF/M4ax0EfZBXafrdTX12jJ2L1U8cGyCeiGxsanQ=;
	b=H80daaLM7mEqTF8x+CdJpXKtEy+G5CefxNveCLTe3bXQglh69geVpE2hv3DRQAKTPFysnk
	IDrKliLP8J1Rs498xpCeEZe59k5u7QJU9uedCRypRs0HsTkGk435wOf1tCqTgkspZFFiNf
	FY+ifFdSiiylatr92aBgG2zDwYyP88rZrn6EoZdHRk10H4logSHoT1+6JWhx5v4kBg38cj
	6RuSwi05Hm9/f0DJPT1MtT8kJ96QWBPSl01+QWx+DDG3ekexyyhrBSjGDc3e4Auj5mCa+1
	ntYMm8VQL3Q0o85lQKSauZtY+jlriDv5gfvmPOm6j4kq9z/iCJZ/AK/oPfwTDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0xFF/M4ax0EfZBXafrdTX12jJ2L1U8cGyCeiGxsanQ=;
	b=uAMF1zq5lmUiPnt+9EBZ4VdommVw9YB4CvnYbQ+DK6Sub+7ImgEP6Hhus/ygrzSRWtNrK2
	73/SI2wFcXyASvCw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 23/31] watchdog: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:56 +0100
Message-Id: <4d05966faebbf507b050f2f42d01b9f81f65a7f5.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
---
 drivers/watchdog/softdog.c                     | 8 +++-----
 drivers/watchdog/watchdog_dev.c                | 4 ++--
 drivers/watchdog/watchdog_hrtimer_pretimeout.c | 4 ++--
 kernel/watchdog.c                              | 3 +--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 7a1096265f18..0820e35ad2e3 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -187,14 +187,12 @@ static int __init softdog_init(void)
 	watchdog_set_nowayout(&softdog_dev, nowayout);
 	watchdog_stop_on_reboot(&softdog_dev);
=20
-	hrtimer_init(&softdog_ticktock, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	softdog_ticktock.function =3D softdog_fire;
+	hrtimer_setup(&softdog_ticktock, softdog_fire, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
=20
 	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)) {
 		softdog_info.options |=3D WDIOF_PRETIMEOUT;
-		hrtimer_init(&softdog_preticktock, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		softdog_preticktock.function =3D softdog_pretimeout;
+		hrtimer_setup(&softdog_preticktock, softdog_pretimeout, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	if (soft_active_on_boot)
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index 4190cb800cc4..8f59f66c61bf 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1051,8 +1051,8 @@ static int watchdog_cdev_register(struct watchdog_dev=
ice *wdd)
 	}
=20
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
-	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	wd_data->timer.function =3D watchdog_timer_expired;
+	hrtimer_setup(&wd_data->timer, watchdog_timer_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
 	watchdog_hrtimer_pretimeout_init(wdd);
=20
 	if (wdd->id =3D=3D 0) {
diff --git a/drivers/watchdog/watchdog_hrtimer_pretimeout.c b/drivers/watch=
dog/watchdog_hrtimer_pretimeout.c
index 940b53718a91..fbc7eecd8b20 100644
--- a/drivers/watchdog/watchdog_hrtimer_pretimeout.c
+++ b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
@@ -23,8 +23,8 @@ void watchdog_hrtimer_pretimeout_init(struct watchdog_dev=
ice *wdd)
 {
 	struct watchdog_core_data *wd_data =3D wdd->wd_data;
=20
-	hrtimer_init(&wd_data->pretimeout_timer, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
-	wd_data->pretimeout_timer.function =3D watchdog_hrtimer_pretimeout;
+	hrtimer_setup(&wd_data->pretimeout_timer, watchdog_hrtimer_pretimeout, CL=
OCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
=20
 void watchdog_hrtimer_pretimeout_start(struct watchdog_device *wdd)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 262691ba62b7..46d0852683de 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -789,8 +789,7 @@ static void watchdog_enable(unsigned int cpu)
 	 * Start the timer first to prevent the hardlockup watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	hrtimer->function =3D watchdog_timer_fn;
+	hrtimer_setup(hrtimer, watchdog_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL_HARD);
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
 		      HRTIMER_MODE_REL_PINNED_HARD);
=20
--=20
2.39.5


