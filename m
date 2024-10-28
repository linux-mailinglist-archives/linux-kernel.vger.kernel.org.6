Return-Path: <linux-kernel+bounces-384375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2679B295C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1481F23BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26320607E;
	Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34/XkFd+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8pJhW/U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792D190660
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100969; cv=none; b=dYQJ9sKiZZBTawoQKwLVy/QhjFK+7vIvYvIZO5aDf6GHyK0icCI36oVGAo5qHDZGr8MHFqkPTHtDD+CPRbZYX4yPx6BirmFvEPxYzX+3eQkyf7llAIhpQV8KOFVxDeWBo7RKb6a6iAvOJrW0jXWwedd65JUZ0zhT3N53slGoJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100969; c=relaxed/simple;
	bh=KikKFLZqaa9ycKVeV+0nyckQjJ6PXSzbyoR+NC//ZcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbX4zMaTv2oaKK3nENhTwFP1/Mm4rt0ZXmXfUbX666MS0w5mLDaQiltQ4UCbCGsPLJRLxg80wwWdq8l5Y0BUB+DlIKcFSm6lGMeoWoL5BRZZMwW1aHTg7o+GmarEF9xwWOfVRa0e9v3xDXd3s2RbZwKaSQgk2KXMMFQppnuA0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34/XkFd+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E8pJhW/U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87KJS+Yd7dmWBG2TJWh52GT7rKaHpnvi/1NPPdJ2+sQ=;
	b=34/XkFd+BH4tScQhAkmEf89QYaQ5lWvQ3PPKfTj4EH361c05IPeiW9kOHtxxLCmxabPd8J
	sUWjjH2VxzVEWQw+ciPkRcYgDMJgBeBeaJSAXcFdpi7VAbpeXGVi1+w5djcsLYan7IpsuH
	ThXCdW3iRESbOb6/Z8MMVsnYeoo/zxeFbyzrsmAhBGqtOI2z9vnkU8JatixnSgyz38+tLR
	7O1g1bGkLt4qtFX74CW1D3dDgmuRi9fYN+hcqj/ddmgRiNJAjAtfiIQNRbk8n2KW8qkrcn
	l7WgHst0kQz4guXSN/R2h05zz1xfz0zpKUuV9x5Eb3UFXsUTIUm5GpGwguU/XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87KJS+Yd7dmWBG2TJWh52GT7rKaHpnvi/1NPPdJ2+sQ=;
	b=E8pJhW/UzdYpXY1vwk17DZgCAcEv+b+uySvE1Qfy8wGAq149sYQEcUs0PD/VAOdQAFAjxc
	l4zenc9fRTlZuiAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 03/12] hrtimers: Merge __hrtimer_init() into __hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:47 +0100
Message-Id: <a0d5c377cefab999ef81c3b11b55e76ffeb4e114.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__hrtimer_init() is only called by __hrtimer_setup(), therefore simplify by
merging __hrtimer_init()'s code into __hrtimer_setup().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 45225fdf7cd2..cf362d93a323 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1540,8 +1540,9 @@ static enum hrtimer_restart hrtimer_dummy_timeout(str=
uct hrtimer *unused)
 	return HRTIMER_NORESTART;
 }
=20
-static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	bool softtimer =3D !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
@@ -1574,13 +1575,6 @@ static void __hrtimer_init(struct hrtimer *timer, cl=
ockid_t clock_id,
 	timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);
 	timer->base =3D &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
-}
-
-static void __hrtimer_setup(struct hrtimer *timer,
-			    enum hrtimer_restart (*function)(struct hrtimer *),
-			    clockid_t clock_id, enum hrtimer_mode mode)
-{
-	__hrtimer_init(timer, clock_id, mode);
=20
 	if (WARN_ON_ONCE(!function))
 		timer->function =3D hrtimer_dummy_timeout;
--=20
2.39.5


