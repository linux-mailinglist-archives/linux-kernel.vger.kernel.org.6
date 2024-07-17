Return-Path: <linux-kernel+bounces-255163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24786933CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF96B23212
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDD17F51A;
	Wed, 17 Jul 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aYMqEPM0"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC841C63
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219150; cv=none; b=cNT01O3bpR/LsErbo59OorekewlCk+n9pPwnI//qM96wJXKzmi5oA0bPQ2wqjblNyBYhmJcCdyUVILxgwKDmY43kS1Ng5M25miQlLo620ci9z07uo8bCWtBrg1vnTRQL+ra0Hye4wcNuw0Va5Fmxnj8+nauuMHZoRFrR93iOTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219150; c=relaxed/simple;
	bh=DyWBqg339bg72zxwJbHJCbcztuxzaQlfx2e38U0c7Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P0/yP4NUgPG/GwyxGzCdxp85XnebCqsxN+EiSVvsB3mFFzzB1Hcu70/DFshu8NXi1QxOH2atxr8OKsgJY07JOKPsoSPCaICXLHrQShrYVmiMflgCZFRpcXFRyY82qjhY6D6F1iwqxBJre8QUT4dAoEZgEWP06pcDXzggGR9mqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aYMqEPM0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA77020009;
	Wed, 17 Jul 2024 12:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721219140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zb0KMl77KZ+SrN2joOepz7XxRQ9pV2HZqkRQ4KWk+ts=;
	b=aYMqEPM0Rh/TR+nCh3XZ+DNa7vLh37OVF3wbOkHgUNMHUqmR8ITeBxFkuOrFrBw75FlYsZ
	XdGwAZayPsaKmw/Vh9uw+cAAVq3j2rmR4/OLH+E+HXFHfZJk6zY7/+d45sZ31QcFQ97W60
	o7va2O+i8d7dQpkZL0W/UHeS6HgJ8S8Sfmky+15ur7NfxDUtpFyCMlRvAaza1DleU/R6pW
	6wHSorCulG4Un0nXK4sDSPGf6P21IL9s8dvqT5eOJpXxy0hEr3v9QDRGsIKG6xkV6rSGtx
	zuHDzfX86an3rqms3q2zPb1LxbVoRvIR8zklhwh2WoLZ9Oo7zeLw8uXUXHFdJQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 17 Jul 2024 14:25:20 +0200
Subject: [PATCH] irqchip/irq-pic32-evic: add missing 'static' to internal
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240717-irq-pic32-evic-fix-build-static-v1-1-5129085589c6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAC+4l2YC/x2NSwqAMAwFryJZG2hrpehVxEWtUQPip1URxLsbX
 M5jmPdAosiUoM4eiHRx4nUR0HkGYfLLSMi9MBhlrHLaIccdNw6FQbEDDnxjd/LcYzr8IYO1Q9X
 5wrlSaZDKFkmc/6Fp3/cDYghXg3EAAAA=
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Fix build error reported by gcc 12:

  drivers/irqchip/irq-pic32-evic.c:164:5: error: no previous prototype for ‘pic32_irq_domain_xlate’ [-Werror=missing-prototypes]
    164 | int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
        |     ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/irqchip/irq-pic32-evic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index 1d9bb28d13e5..277240325cbc 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -161,9 +161,9 @@ static int pic32_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return ret;
 }
 
-int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-			   const u32 *intspec, unsigned int intsize,
-			   irq_hw_number_t *out_hwirq, unsigned int *out_type)
+static int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+				  const u32 *intspec, unsigned int intsize,
+				  irq_hw_number_t *out_hwirq, unsigned int *out_type)
 {
 	struct evic_chip_data *priv = d->host_data;
 

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240717-irq-pic32-evic-fix-build-static-44f9ba377501

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


