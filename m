Return-Path: <linux-kernel+bounces-559717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC30A5F882
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE701189B3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295BB2690F7;
	Thu, 13 Mar 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LcWs1qo/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z/AqjbRo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586D2690F2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876292; cv=none; b=GfdP1Fuyu5cw7Kx0QMH+ZRPrw1fY51D+lefA64mhlRvEDwKKgqnpz418gP+WDVm2Rfh4n28ie45XSA26l0Q4BHsfkRi7rLO+FGd5ZUqPMh4Vrhpp9d+RNd5TnG5J7nugpnJbIbUb0WxmgA7clfEEZA886Adkb7d3rMGS1ANwaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876292; c=relaxed/simple;
	bh=/n7UFatUWhhDG6gWk2aqwLzi8C71lUdmuy1s5219+V0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=f+RHPWaMj+BkUt2szrW0GCHoKrqlJ4GcG8y3XOxrDwxLygyUODqKCt4ubki1c66822E1vTBQ/+yNqD1BkxgqRWJuF/afcs/LdnLW74I65tbRMrJJJ0aMjbRkG09FG0GSDcnurfeC5jD71LvVoCmch2IuO6PTsuPmDQZgsxjwFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LcWs1qo/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z/AqjbRo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313142524.388478168@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741876289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9K3rlwZ6R2wtcFYBYUF2pVbOdk2NEUcnH+sSO8N4g8k=;
	b=LcWs1qo/7WUfowKYc3icjlFFzgWCcLR6KXL+tDhu2X3UtOSVU2zJLhEesGT7xML6m5gkc+
	rQdIhETQOv/tJesYFWAPSF3OlG6B5sBVxEFiOUqxJb2uNUD+LayuMPYwraf7bMNRPQq1pl
	aZPUniN3DMnNLsC/3C5HJE+TcVj7wBbp3XByY7ScZaSxmr7oe0YaRMjBEviv5HZV8UNmx/
	Y44JF6vO2G8Ujdw8Ahnj9a0t5UNDyrtTq1w7ElQwmgKorn1WMkRYta03eYPG5XZUNHP3+d
	2oZgPdo+5cW/9w4ws6/r6FZVfbwyie8lGrkOdXa+2+C/h0yZmfq6nEMp7MR6ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741876289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9K3rlwZ6R2wtcFYBYUF2pVbOdk2NEUcnH+sSO8N4g8k=;
	b=z/AqjbRoEdwztgh4byLUaTe9lyrxpbgumk8BtxfzdYH+EkjJ+g4PBYQbPkSp0CC58+BtMn
	bHFXWJ2IYWm0oKCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Talel Shenhar <talel@amazon.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Guo Ren <guoren@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [patch 7/7] genirq/generic-chip: Remove unused lock wrappers
References: <20250313142404.896902416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 15:31:28 +0100 (CET)

All users are converted to lock guards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |   20 --------------------
 1 file changed, 20 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1219,26 +1219,6 @@ static inline struct irq_chip_type *irq_
 
 #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
 
-static inline void irq_gc_lock(struct irq_chip_generic *gc)
-{
-	raw_spin_lock(&gc->lock);
-}
-
-static inline void irq_gc_unlock(struct irq_chip_generic *gc)
-{
-	raw_spin_unlock(&gc->lock);
-}
-
-/*
- * The irqsave variants are for usage in non interrupt code. Do not use
- * them in irq_chip callbacks. Use irq_gc_lock() instead.
- */
-#define irq_gc_lock_irqsave(gc, flags)	\
-	raw_spin_lock_irqsave(&(gc)->lock, flags)
-
-#define irq_gc_unlock_irqrestore(gc, flags)	\
-	raw_spin_unlock_irqrestore(&(gc)->lock, flags)
-
 static inline void irq_reg_writel(struct irq_chip_generic *gc,
 				  u32 val, int reg_offset)
 {


