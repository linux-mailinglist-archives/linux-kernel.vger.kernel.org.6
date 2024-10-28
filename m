Return-Path: <linux-kernel+bounces-384270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269639B28DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1611C2042B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5931D9688;
	Mon, 28 Oct 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="julUtZR+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Brgh6lIr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347551922F9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100743; cv=none; b=NOYfLaqgzfFUrCYfFlyuRZ2Z9Qaxgt3uEmz+49grCdzFFgLUePQbZkb2uSHBwgDhHaAFBzpcfxfMTyClmVOwL8p1sCeZVDAJRue/KqwhyF76fWV/Mq8R64jKwNNRLVlLJseNA8l95MUlb+SsahE2y+3e0tBlaUciXt8ottybYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100743; c=relaxed/simple;
	bh=CqHN/CevzE2KWFjgA9NTQe5jdoRTX+hW3VuxFLg85S0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dH/2fh0a9Luqea5yOTzeUJDkZF1QaJ+4uW3CcYUj2xI2wXzguljVydjCn7koBiM37yO2YW73OmTku2OJjyBvq/m/ANeB8L+QpJ6Pr7qzBqGOlpk8FLFMI6N4Fnldv3FbNyjUKb2Bcxl8Yb04Lf2mGMPKPprPs5ewc0AC+s63lE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=julUtZR+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Brgh6lIr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guF/UA1hI0xHq7jYGgwI8l3WfvemyIeIMX1G1unXY0c=;
	b=julUtZR+gSME1hVuTKca3rZxMOkEvSY79YvA9ipymWVPxFoZbpi0O990iZcTz8a/p+cD/O
	7H+hZz2geb//twUWEfuKEcWxeI+Qw6P7+M2wlNTxLqJv1qBChfOEGC61ZvjliKdMNqCkSG
	ZehBCO+am5j5M8gFNPAO4/utONaBGoz/lJnNLnSlRBWLgWQdKwH6/wvwA003rhCmgqhcl+
	iYxvERiPkzg3+fGSPijOicV47RErgLHZaykJlemR5IZESagTDNzMoaAebz9aSbzOB6MPuk
	pAcw8unKmGXbKPrC0FT44wM3oQdlm5stj5lxdwU4CV8kt8msbyyTisQJk8kPsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guF/UA1hI0xHq7jYGgwI8l3WfvemyIeIMX1G1unXY0c=;
	b=Brgh6lIrKuJFwFSWD1mdlPUr/I1I5ow7+C9iRyIs4Q2c0ubRHMs/isb6XnO1Vcou9Xjb4G
	8TYHTYfYp/k4ShAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 06/31] LoongArch: KVM: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:39 +0100
Message-Id: <f48000a47233c0c8b907492758bbd9c7494e467f.1729864823.git.namcao@linutronix.de>
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
Cc: Huacai Chen <chenhuacai@kernel.org>
---
 arch/loongarch/kvm/vcpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 0697b1064251..eada16d2532c 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1457,8 +1457,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.vpid =3D 0;
 	vcpu->arch.flush_gpa =3D INVALID_GPA;
=20
-	hrtimer_init(&vcpu->arch.swtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNE=
D);
-	vcpu->arch.swtimer.function =3D kvm_swtimer_wakeup;
+	hrtimer_setup(&vcpu->arch.swtimer, kvm_swtimer_wakeup, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED);
=20
 	vcpu->arch.handle_exit =3D kvm_handle_exit;
 	vcpu->arch.guest_eentry =3D (unsigned long)kvm_loongarch_ops->exc_entry;
--=20
2.39.5


