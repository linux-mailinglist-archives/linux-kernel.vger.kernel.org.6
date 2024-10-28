Return-Path: <linux-kernel+bounces-384272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831B9B28E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76B21F22040
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2481DA61B;
	Mon, 28 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cyk7bb4O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6X4Odxek"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F727192B61
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100743; cv=none; b=BBqyT83yamfAFTVjvX7ZIa4OZlLmuMEkj+UNVk/DYK7/+LBgnPokRdrr+NGIbPj/UNt1Vta6xyrTf4NV684meb6VLqKJq6a3+D9Nv3BsZ7/hI2qrwVk4ploOOLbq7eOpXVf7GI0YSGwt7ykbJ94Fmb+0VAbey6oZpQyy1F//9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100743; c=relaxed/simple;
	bh=HHvpS2gHaoYjWnehOnpADwDP4ZmwbW8a7d6jUtoNHGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJm/bdzYnseWbjO98F1GYEzC6WnUwJMgrGh0PYmLN8IVLOm1JWVVlFPksAHVU6hwa3ffLqmryjskZBotVP3FGPW3zFmAelpiYHK7JANCKDJiRjtkdN5pxLxjsoLezecpdVx1JMnyFRfXBqQCAB7cpQljgpTYz2AwMshwKagi/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cyk7bb4O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6X4Odxek; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DJ0btonr8jZwahcv7pasP/jPhkqMfKmuRiG8N2yMAM=;
	b=Cyk7bb4O4uAwf7Fm1LS0LOOWz+/WLmihltLHliXwLGz0I94aE7mZrMr7i742dS89LMt0pb
	+DyUjFtw6pVi5cfUtu71+snGuU/34DrAI2xJK3bhOgit8fYZ4K2s+XyQ9L9K/Cvorb9eMz
	8xnAskomsTniPoJO10+ZrTduIjCJCyxy+qBl48p3xhMVOsVukPWgJi1h9Mj3fg/nKTP3N1
	/lhU7XYJzfWR4HQ+etEqSYVgHiV56l4+0rZpuPiilDTqpQYFbM4rUkD6BqpuCTyEE5KE/t
	c0C0fX01yYRb8OI3eadjRb2nVm+WNmmAHy/87rk3VMnhmg0ZKAvX9Avqcc48Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DJ0btonr8jZwahcv7pasP/jPhkqMfKmuRiG8N2yMAM=;
	b=6X4OdxekgQzCedoVSwVGUrNMvb5M7RScE3G/cfyX6bBOC0KgJQUuCLTRRKQmh+sJK1IKlc
	huur2BeHF6K9bHDw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH 07/31] riscv: kvm: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:40 +0100
Message-Id: <888e7cbae0d492fc284f94113f7fad081a77138f.1729864823.git.namcao@linutronix.de>
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
Cc: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/vcpu_timer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 75486b25ac45..74b78b0346df 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -248,18 +248,19 @@ int kvm_riscv_vcpu_timer_init(struct kvm_vcpu *vcpu)
 	if (t->init_done)
 		return -EINVAL;
=20
-	hrtimer_init(&t->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	t->init_done =3D true;
 	t->next_set =3D false;
=20
 	/* Enable sstc for every vcpu if available in hardware */
 	if (riscv_isa_extension_available(NULL, SSTC)) {
 		t->sstc_enabled =3D true;
-		t->hrt.function =3D kvm_riscv_vcpu_vstimer_expired;
+		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_vstimer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 		t->timer_next_event =3D kvm_riscv_vcpu_update_vstimecmp;
 	} else {
 		t->sstc_enabled =3D false;
-		t->hrt.function =3D kvm_riscv_vcpu_hrtimer_expired;
+		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_hrtimer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 		t->timer_next_event =3D kvm_riscv_vcpu_update_hrtimer;
 	}
=20
--=20
2.39.5


