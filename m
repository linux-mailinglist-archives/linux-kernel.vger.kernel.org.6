Return-Path: <linux-kernel+bounces-384273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2A99B28DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6801F220A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D391DA2FD;
	Mon, 28 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fhZWZlYu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhqgYewx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174B192B7A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100744; cv=none; b=X2zAcBxuVQPMXj4/9X+SklhFqjkrd4UaKIU5mg1BMGCAeFLK3jq15VFb9kH+xSQRK0f91/ubXkW2Ym3snmrFSpRMuBnlyK6m2ifFmkpnsUsMKlXpdIVdbpFFR1HFAEWhHVrnYTPmOWi1uM8EWYjsliW1yezuLXwZ7lfZHeoN5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100744; c=relaxed/simple;
	bh=x/4qqfVZz8UK+7KJkSqM+6cSCvj9XzwqFHCDwY0R5l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIbj+33op1Z3aw+fBTFyMTnpExTGcjq0+kapEPhyEh7FLMFeL/Ed23evojxakSkvrLi/BKrlOX8XeILmXYZxK38/dJ1HJcqFxOpaeObvNn2CSJi4wjFxIWzwkKGq+Nd95IPeKLDfE00N7nAJroreuMbIu5SjI+V1e0bsUoZoRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fhZWZlYu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhqgYewx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j53Dvajnc3k7LMWT3g6jXPZAJLgmsTlqEmPEo0TGLY8=;
	b=fhZWZlYuXxwL5Wwq7pmwzRxInjpbDdJqB+qIKKPs+Vn8IyHuavyD3q83QkvWlpnKXNvUa/
	Mz9XJbf3zGe8tcqvM2fJZRybekwSdaGZCMiVkLq9kyKa4U0OQQ2qxd6hZEW39F+Y1VTB7x
	9H81adToqXk/Zj+GSSBBiC6EuiIeOzT2TSkGYLTcbcEy2ye/7qjUIL4UcNQQtjW0gmkcuG
	46hl0vTqXQvRNgH9zggaejPAOFeJ7T4lrdFq/9Y9MzfETzjXkJLrDXw3oamGbMUysxAqt3
	vQT8W3c4f6AVnGlqjKEG7im1espBMr8OyNuIlt9woLTY9EzUU/T1q0Tpeny5vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j53Dvajnc3k7LMWT3g6jXPZAJLgmsTlqEmPEo0TGLY8=;
	b=bhqgYewxRk1yV6kitieJ0jaIMDOiSvImIOoUT39AguG1eyaEaj15CLAfmcdAxkCzpkRWu6
	RHX3hQjeGXfSOoBA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 12/31] s390/ap_bus: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:45 +0100
Message-Id: <868e70867e5f24da86e36aff6240b1fd9696436f.1729864823.git.namcao@linutronix.de>
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
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 60cea6c24349..98beb2656c3f 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -2327,8 +2327,7 @@ static inline int __init ap_async_init(void)
 	 */
 	if (MACHINE_IS_VM)
 		poll_high_timeout =3D 1500000;
-	hrtimer_init(&ap_poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ap_poll_timer.function =3D ap_poll_timeout;
+	hrtimer_setup(&ap_poll_timer, ap_poll_timeout, CLOCK_MONOTONIC, HRTIMER_M=
ODE_ABS);
=20
 	queue_work(system_long_wq, &ap_scan_bus_work);
=20
--=20
2.39.5


