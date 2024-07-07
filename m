Return-Path: <linux-kernel+bounces-243691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066092994D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8170D1C209B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89C262A02;
	Sun,  7 Jul 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GeN9N21T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qD6iHGJi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287915674D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376845; cv=none; b=eoeo1Ye49FcbJUrOAwgOrENy9FGbJsA9DmCn3mF+AUdKsCtbf7yjVLNBERpkexT5mnZvDMqqxuNYushJ4heBWU/A2dBlDbJRcwJqESBy8SGLKR8XBL6TtK+1+00MXJnTa+VQVwK0qBGuL2aQrHNsiAoYGut5jH9rVyDptJcFEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376845; c=relaxed/simple;
	bh=O9aW3qkZVgSNXVCbCcuQNGZYQfnkUcvgTZ5q1x+8rFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+wRLDxmH/opp0h5VzL+t84h5XDp0HrZjAKYQm7eOwsG5ouxCCQfs+3mJr5YYcSBpNbgWiB4pOdOO9K/aJVxfuoeFSakUvQiP9t39PnXExe+KyO0hWxPzCbNO5yssjMeulKyhmgSwlnTNz9torWbcjN25O6CUSXCw/ylx/FqFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GeN9N21T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qD6iHGJi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 7 Jul 2024 20:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720376841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3AdbKsKINe9yu2ZBpPq85eLROlYQ2SMJgf9Olj43RQ=;
	b=GeN9N21T/2EDPgz2wcSKn7uVZnC2kJMMU33LtWBQIoBxioF4NpLKK9EluBqfvWmyMvfx5T
	fklaTkAjevPfjRSSRbqNJX6bRbf8pURWjKLjd7OBvroC+3l3bG7mkwpyp6jHJI5/IrLrjl
	qHwxhcUhA7md/ITvGA6aPhckBjQJmZ5oNOjGXa4k2l3X9K0AaC4McXh7Kl0kRWObMfJCpZ
	RzElxqR8RoVsr3TI1WeRgwlCfbp2dZuUTk+8zg5gCnh5VHV3EgViI+mEuHFenRkrTYIjQu
	1onfI6fUv9PjzDe6lRH1tGxWKg3AKDuFpyIBOUp3tcEGjiRN9gehnpQVQRaMOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720376841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3AdbKsKINe9yu2ZBpPq85eLROlYQ2SMJgf9Olj43RQ=;
	b=qD6iHGJijutmP+XASaeb2zKYkioG8mu2oI5vgEd8JdRpoX6ej5HbvIMfm+sPVTciXtm9AT
	GskjYGTbghw86LDg==
From: Nam Cao <namcao@linutronix.de>
To: zhengyan <zhengyan@asrmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	maz@kernel.org, paul.walmsley@sifive.com, qiaozhou@asrmicro.com,
	samuel.holland@sifive.com, tglx@linutronix.de,
	Drew Barbier <drew@sifive.com>
Subject: Re: [PATCH v2] irqchip/sifive-plic: ensure interrupt is enable
 before EOI
Message-ID: <20240707182715.L_REw7VC@linutronix.de>
References: <69174a28eff44ad1b069887aa514971e@exch03.asrmicro.com>
 <20240624113523.23-1-zhengyan@asrmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624113523.23-1-zhengyan@asrmicro.com>

On Mon, Jun 24, 2024 at 11:35:23AM +0000, zhengyan wrote:
> RISC-V PLIC cannot "end-of-interrupt" (EOI) disabled interrupts, as
> explained in the description of Interrupt Completion in the PLIC spec:
> "The PLIC signals it has completed executing an interrupt handler by
>  writing the interrupt ID it received from the claim to the claim/complete
>  register. The PLIC does not check whether the completion ID is the same
>  as the last claim ID for that target. If the completion ID does not match
>  an interrupt source that *is currently enabled* for the target, the
>  completion is silently ignored."
> 
>  Commit 9c92006b896c ("irqchip/sifive-plic: Enable interrupt if needed
>  before EOI")
>  ensured that EOI is enable when irqd IRQD_IRQ_DISABLED is set, before
>  EOI
> 
>  Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
>  ensured that EOI is successful by enabling interrupt first, before EOI.
> 
>  Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
>  operations") removed the interrupt enabling code from the previous
>  commit, because it assumes that interrupt should already be enabled at the
>  point of EOI.
> 
> However, here still miss a corner case that if SMP is enabled. When
> someone needs to set affinity from a cpu to another the original cpu
> when handle the EOI meanwhile the IE is disabled by plic_set_affinity
> 
> For example, broadcast tick is working,
> cpu0 is about to response, cpu1 is the next.
> 1. cpu0 responses the timer irq, read the claim REG, do timer isr event.
> 2. during the timer isr it will set next event
> tick_broadcast_set_event -> irq_set_affinity->xxx->
> plic_set_affinity -> plic_irq_enable
> 3. in plic_set_affinity disable cpu0's IE and enable cpu1'IE
> 4. cpu0 do the write claim to finish this irq, while cpu0's IE is disabled,
> left an active state in plic.
> 
> So this patch ensure that won't happened
> 
> Signed-off-by: zhengyan <zhengyan@asrmicro.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9e22f7e378f5..815ce8aa28f1 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -149,8 +149,10 @@ static void plic_irq_mask(struct irq_data *d)
>  static void plic_irq_eoi(struct irq_data *d)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +	void __iomem *reg = handler->enable_base + (d->hwirq / 32) * sizeof(u32);
> +	u32 hwirq_mask = 1 << (d->hwirq % 32);
>  
> -	if (unlikely(irqd_irq_disabled(d))) {
> +	if (unlikely((readl(reg) & hwirq_mask) == 0)) {
>  		plic_toggle(handler, d->hwirq, 1);
>  		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>  		plic_toggle(handler, d->hwirq, 0);

I think this patch is fine.

But, I don't like reading hardware registers in the interrupt hot path. It
may slow things down. Also this patch doesn't allow moving the if condition
out of this plic_irq_eoi() function into the enabling function (I have been
thinking about doing that for some time, but too lazy to get to it).

I *may* have something better.

From the specification:
"The PLIC signals it has completed executing an interrupt handler by
writing the interrupt ID it received from the claim to the claim/complete
register. The PLIC **does not check** whether the completion ID is the same
as the last claim ID for that target. If the completion ID does not match
an interrupt source that is currently enabled for the target, the
completion is silently ignored."

Note what I "highlighed": the irq number written back does not have to
match the irq number last claimed for the CPU. If I interpret this
correctly, this means *any* claim/complete register can be used to complete
the interrupt.

So, my idea: since irq affinity setting still leaves at least 1 CPU with
the interrupt enabled; the claim/complete register for that enabled CPU can
be used for completing interrupt (instead of the original one used for
claiming). This would avoid some hardware register access in the hot path.
Also allows another optimization of moving the if condition out of the EOI
function.

Something like the patch below. To apply this one cleanly, another patch
must be applied first:
https://lore.kernel.org/linux-riscv/20240703072659.1427616-1-namcao@linutronix.de/

What I am still a bit unsure about is whether my interpretation of the
specification is correct. The patch works for my Visionfive 2 board, so the
question is whether this patch is relying on "undefined behavior", or this
is really what the spec means. Drew Barbier <drew@sifive.com> seems to be
the one who wrote that. Do you mind confirming my interpretation?

Best regards,
Nam

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f30bdb94ceeb..117ff9f1c982 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -69,6 +69,7 @@ struct plic_priv {
 	void __iomem *regs;
 	unsigned long plic_quirks;
 	unsigned int nr_irqs;
+	void __iomem **complete;
 	unsigned long *prio_save;
 };
 
@@ -149,13 +150,14 @@ static void plic_irq_mask(struct irq_data *d)
 static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	if (unlikely(irqd_irq_disabled(d))) {
 		plic_toggle(handler, d->hwirq, 1);
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+		writel(d->hwirq, priv->complete[d->hwirq]);
 		plic_toggle(handler, d->hwirq, 0);
 	} else {
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+		writel(d->hwirq, priv->complete[d->hwirq]);
 	}
 }
 
@@ -164,6 +166,7 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+	struct plic_handler *handler;
 	struct cpumask new_mask;
 
 	cpumask_and(&new_mask, mask_val, &priv->lmask);
@@ -180,6 +183,9 @@ static int plic_set_affinity(struct irq_data *d,
 	if (!irqd_irq_disabled(d))
 		plic_irq_enable(d);
 
+	handler = per_cpu_ptr(&plic_handlers, cpumask_first(&new_mask));
+	priv->complete[d->hwirq] = handler->hart_base + CONTEXT_CLAIM;
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
@@ -516,6 +522,10 @@ static int plic_probe(struct platform_device *pdev)
 	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
 		return -ENOMEM;
+	
+	priv->complete = devm_kcalloc(dev, 1 + nr_irqs, sizeof(*priv->complete), GFP_KERNEL);
+	if (!priv->complete)
+		return -ENOMEM;
 
 	for (i = 0; i < nr_contexts; i++) {
 		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
@@ -577,6 +587,12 @@ static int plic_probe(struct platform_device *pdev)
 			writel(1, priv->regs + PRIORITY_BASE +
 				  hwirq * PRIORITY_PER_ID);
 		}
+
+		if (!nr_handlers) {
+			for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+				priv->complete[hwirq] = handler->hart_base + CONTEXT_CLAIM;
+		}
+
 		nr_handlers++;
 	}
 

