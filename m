Return-Path: <linux-kernel+bounces-384268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130439B28DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4491B1C214DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D3192D67;
	Mon, 28 Oct 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QM2/1ZS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0RCEJo/I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E761917EE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100741; cv=none; b=GpgOj/gd0Zavq+yKnmmmHOGlBoH+ZEMdQaLX7laly0/BhKp4mtXT2GPCyc4yMlIsMCO3ydxorqwOT26UWgRpHdECVPSFcBLXgFaJKJvQWGBfva0K4GuQlMk1CZSCUmSaikFzkc4WPEiMFevHqffdKqoYUQNRHT7Zy7iFG99+s+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100741; c=relaxed/simple;
	bh=MwzPzekW1pA6NFxBLFP/Gi3ei4i2eOHMAczQbNbiveE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3CM187PqaiDi7AWnnbpUHFPCTUOvezBjGSUspABNNza7q/CtsCDfqiaytNZtMvRdV/p9Hav0R3axXFHkX1+bG9pCExjIbFt58xxtQ5RwNfvv2xanH38Ku65Wz3pEwm0Hzy4duWPjFO5S/K9DpjpGS8tzMV1nUanr1SH2efd2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QM2/1ZS1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0RCEJo/I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk8eiXQqU2Ur609erj6dwbyMBjwzv45Z/TfJvpEb3Cs=;
	b=QM2/1ZS1RjHztD8baiAh+oEZABOEXoqzfSqmx16Prk1sbRXe+p3XLzU0uYX12eIMZ1yZ/3
	f5+e8y1UIwLDr7q6DPtaGsZSptFx2c7VQ5buOF8l+yVEUh69eN2OHC4dwY1tPJE/lnacC4
	J0yFNrkEQIuiP60X3JS0maayipEMAxWJMQ94GcRXrx9UiBzcoWa1q7BIbALdy4ACU/S0Dm
	mY1/aIBaOBLjYD7gU62fmpfO6fPouUaYE1oJaV0LlsRr746g+E3/upzXAN+RRg0v5Sneyi
	mJN2a6jviyMkDJk6MveNyrg4uEsRBq0q03lu4Q7/ysQVlMxZDJXC/8rLWsrXLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk8eiXQqU2Ur609erj6dwbyMBjwzv45Z/TfJvpEb3Cs=;
	b=0RCEJo/IoC5mEMd8GNxzz7ONQbDUJiAEiQYLduM+rGc93OZyOUoLpeaH8TCgi7pC5UlZ0x
	FoaJN+QUrElW6cBg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 04/31] KVM: x86: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:37 +0100
Message-Id: <8774212e6c10c550743219e00738492eb379227c.1729864823.git.namcao@linutronix.de>
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
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c     | 3 +--
 arch/x86/kvm/i8254.c      | 3 +--
 arch/x86/kvm/lapic.c      | 5 ++---
 arch/x86/kvm/vmx/nested.c | 5 ++---
 arch/x86/kvm/xen.c        | 5 ++---
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4f0a94346d00..19ea425a7264 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -952,8 +952,7 @@ static void stimer_init(struct kvm_vcpu_hv_stimer *stim=
er, int timer_index)
 {
 	memset(stimer, 0, sizeof(*stimer));
 	stimer->index =3D timer_index;
-	hrtimer_init(&stimer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	stimer->timer.function =3D stimer_timer_callback;
+	hrtimer_setup(&stimer->timer, stimer_timer_callback, CLOCK_MONOTONIC, HRT=
IMER_MODE_ABS);
 	stimer_prepare_msg(stimer);
 }
=20
diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index cd57a517d04a..9342442e9650 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -690,8 +690,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 fla=
gs)
 	pit->kvm =3D kvm;
=20
 	pit_state =3D &pit->pit_state;
-	hrtimer_init(&pit_state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	pit_state->timer.function =3D pit_timer_fn;
+	hrtimer_setup(&pit_state->timer, pit_timer_fn, CLOCK_MONOTONIC, HRTIMER_M=
ODE_ABS);
=20
 	pit_state->irq_ack_notifier.gsi =3D 0;
 	pit_state->irq_ack_notifier.irq_acked =3D kvm_pit_ack_irq;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 2098dc689088..1cfcd9125ffb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2887,9 +2887,8 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
=20
 	apic->nr_lvt_entries =3D kvm_apic_calc_nr_lvt_entries(vcpu);
=20
-	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_HARD);
-	apic->lapic_timer.timer.function =3D apic_timer_fn;
+	hrtimer_setup(&apic->lapic_timer.timer, apic_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 	if (lapic_timer_advance)
 		apic->lapic_timer.timer_advance_ns =3D LAPIC_TIMER_ADVANCE_NS_INIT;
=20
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a8e7bc04d9bf..c8cdf2ef00aa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5279,9 +5279,8 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	if (enable_shadow_vmcs && !alloc_shadow_vmcs(vcpu))
 		goto out_shadow_vmcs;
=20
-	hrtimer_init(&vmx->nested.preemption_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_PINNED);
-	vmx->nested.preemption_timer.function =3D vmx_preemption_timer_fn;
+	hrtimer_setup(&vmx->nested.preemption_timer, vmx_preemption_timer_fn, CLO=
CK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED);
=20
 	vmx->nested.vpid02 =3D allocate_vpid();
=20
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index c386fbe6b58d..73e85b1ebb08 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -265,9 +265,8 @@ static void kvm_xen_stop_timer(struct kvm_vcpu *vcpu)
=20
 static void kvm_xen_init_timer(struct kvm_vcpu *vcpu)
 {
-	hrtimer_init(&vcpu->arch.xen.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_HARD);
-	vcpu->arch.xen.timer.function =3D xen_timer_callback;
+	hrtimer_setup(&vcpu->arch.xen.timer, xen_timer_callback, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 }
=20
 static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
--=20
2.39.5


