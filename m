Return-Path: <linux-kernel+bounces-272833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A59461AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC01F21623
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3238166F04;
	Fri,  2 Aug 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWYgpnxf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rK66vc4p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CAC1537DA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615345; cv=none; b=hHTVVKay+Kd5FrkCsH4auYLVqqa78qFNHeV71cSEsuk2e+W+BbkHgMEuoCEhgB5dJXvDtjN9uVnHNV++d58oNt8fK2WknyIv8DuuaYD9oWcLjMldK354+wHJXDF9umvalrrkpeEQ3TTGFIpVPW2hDyfSAlcG2YAmGmjpwYv4exA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615345; c=relaxed/simple;
	bh=q1nyCI9+/a85UsWDuTd9B4jBeh4y7VZxEQ9MkGP9QuU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gygZ16FQJFpJB+L8CVguuXEGo7rDYtdZ905/tBBkF5ePZPnSKET3+uQE5hY+lIygT4LDZZqj7KeiD9+oAXCooKaE7b5R1xxp5yddLUZRLhkZlA/qwcWzNi9T6vOUs5wslH9n0Mc6aeNBhczk0pkPxF97pHUHYKk3oAuElqTi6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWYgpnxf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rK66vc4p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.402005874@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+O+7pwggQzEjLaphpw3Ohc+YFDfRA7SuEbINblJ/VjA=;
	b=jWYgpnxffi6/osyZdgcRt6uHyQWK3chulNzOZniz+2FsXnTDERcfOtlTclS8UpJa4L4j9Y
	nBtEjXtCDrzZYaxQlkhGYDRIWnvuNHJM5oIRkscCb39zGhY70y6Ngre3rLEY+KyN+UXvmt
	21G7r1zGZzMoK6fMAS6RTPlkciCzukTQhOn0NOjOmcvU+pieQ0L6u6zJExqEsGzhxHgXdb
	3q7SheLvr+rs7XeZa2wWnnQGKeM+r64dMPzPOw/UMKCW7Ty35BSfF8DcnTB4snIYuE9ImZ
	u1Cy6zr0tjEbk2Bqs2Q+8JvWurvainue8SNdllrbsssN7kMhcn1yVPOhoYfxeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+O+7pwggQzEjLaphpw3Ohc+YFDfRA7SuEbINblJ/VjA=;
	b=rK66vc4pZb2Flkw5VKwsJdccTelYemHIVx0bXK4hX594Gh0hmI8EcZbl32bE0sKmd6SYMa
	DEqo2lkIgflfcuCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 03/15] x86/ioapic: Cleanup structs
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:37 +0200 (CEST)

Make them conforming to the TIP coding style guide.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -86,8 +86,8 @@ static unsigned int ioapic_dynirq_base;
 static int ioapic_initialized;
 
 struct irq_pin_list {
-	struct list_head list;
-	int apic, pin;
+	struct list_head	list;
+	int			apic, pin;
 };
 
 struct mp_chip_data {
@@ -96,7 +96,7 @@ struct mp_chip_data {
 	bool				is_level;
 	bool				active_low;
 	bool				isa_irq;
-	u32 count;
+	u32				count;
 };
 
 struct mp_ioapic_gsi {
@@ -105,21 +105,17 @@ struct mp_ioapic_gsi {
 };
 
 static struct ioapic {
-	/*
-	 * # of IRQ routing registers
-	 */
-	int nr_registers;
-	/*
-	 * Saved state during suspend/resume, or while enabling intr-remap.
-	 */
-	struct IO_APIC_route_entry *saved_registers;
+	/* # of IRQ routing registers */
+	int				nr_registers;
+	/* Saved state during suspend/resume, or while enabling intr-remap. */
+	struct IO_APIC_route_entry	*saved_registers;
 	/* I/O APIC config */
-	struct mpc_ioapic mp_config;
+	struct mpc_ioapic		mp_config;
 	/* IO APIC gsi routing info */
-	struct mp_ioapic_gsi  gsi_config;
-	struct ioapic_domain_cfg irqdomain_cfg;
-	struct irq_domain *irqdomain;
-	struct resource *iomem_res;
+	struct mp_ioapic_gsi		gsi_config;
+	struct ioapic_domain_cfg	irqdomain_cfg;
+	struct irq_domain		*irqdomain;
+	struct resource			*iomem_res;
 } ioapics[MAX_IO_APICS];
 
 #define mpc_ioapic_ver(ioapic_idx)	ioapics[ioapic_idx].mp_config.apicver
@@ -2431,8 +2427,8 @@ static void ioapic_resume(void)
 }
 
 static struct syscore_ops ioapic_syscore_ops = {
-	.suspend = save_ioapic_entries,
-	.resume = ioapic_resume,
+	.suspend	= save_ioapic_entries,
+	.resume		= ioapic_resume,
 };
 
 static int __init ioapic_init_ops(void)


