Return-Path: <linux-kernel+bounces-276198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07CC948FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D196F1C235C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9341C57B3;
	Tue,  6 Aug 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hiepdJHM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC31BF311;
	Tue,  6 Aug 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949279; cv=none; b=uGnQcbBcB9l/8CqugnKXW1MFyFxUq3pvicDR2IvKA5p5QCi2doX2rZz+A7R2r7poFR0hbZkqr7Y9+7mZuWAUfzlxP7cv+t7sNGm1h5CxefXVnFA3+mIq4Tmbk9/qka3474XnamnAYrWtPju+/rEv+FKjZjYBRTAyjO4+Nejd/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949279; c=relaxed/simple;
	bh=rkmgOQl8py7qDrXITLdHSVEmk/LLPYkUA7Pt/ny9N3g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lTvEzYmvniyfsbmL23l1anxdVcEo6t8ucbHuthGj22Sr9e0Be2nYNGwyRvJ6iTV1ANhDdDK1VhGHpZD/rQtnpr12n0ma6Hwzf2wPOmECB59gWMwb34uYfFrt87z5Njb2hAay7NVrH0jVLztdDZN5IoDsXewwcrE4VBymOsbSWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hiepdJHM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722949275; x=1754485275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rkmgOQl8py7qDrXITLdHSVEmk/LLPYkUA7Pt/ny9N3g=;
  b=hiepdJHMH2ZaXhRA8CK1J6PbKNLQQpsM8gXfN8FwPLIYXIRxINo201b/
   603NJGxAFc2dxQ+KGcCEdBGw/lH457lFNgTKM9sB5OlGNeW9Y+5pp0n5j
   HujqA6/zJFGw7HxkALfVtHgy8hK7KZsaAOI5y91+NOB6lPcOwy7Eg2Mar
   IBqwuIXm5NBPp2c850D/MABwMP9fUZfZ4VPxDeekIrkB4xLcSRss/vRW2
   CrRdw30grN12UuMH0NPO+Lv9+2ILM9wbY1KYY+BlsBCttLOWMTYAb4Lz8
   A4IUSn+neoqOU8oTFKWqo7B7Nid3Ap5IWmJ7aAQYukq48oIMeM6Le8P8C
   Q==;
X-CSE-ConnectionGUID: 35PzH48ZQt27K00Yyxlz1w==
X-CSE-MsgGUID: k16G+AKURLKjaYeL/9QOog==
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="197573430"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 06:01:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Aug 2024 06:01:01 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Aug 2024 06:01:00 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <linux-usb@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>, <gregkh@linuxfoundation.org>,
	<b-liu@ti.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1] usb: musb: poll ID pin status in dual-role mode in mpfs glue layer
Date: Tue, 6 Aug 2024 14:14:07 +0100
Message-ID: <20240806131407.1542306-1-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Similar to other platforms using the MUSB driver, PolarFire SoC lacks
an ID pin interrupt event, preventing several OTG-critical status
change events from being exposed. We need to rely on polling to detect
USB attach events for the dual-role port.

The otg state machine implementation is based on Texas Instruments
DA8xx/OMAP-L1x glue layer.

This has been tested on BeagleV-Fire with couple of devices in host mode
and with the Ethernet gadget driver in peripheral mode, in a wide
variety of plug orders.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 drivers/usb/musb/mpfs.c | 160 ++++++++++++++++++++++++++++++++++------
 1 file changed, 136 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
index 29c7e5cdb230..00e13214aa76 100644
--- a/drivers/usb/musb/mpfs.c
+++ b/drivers/usb/musb/mpfs.c
@@ -49,30 +49,6 @@ static const struct musb_hdrc_config mpfs_musb_hdrc_config = {
 	.ram_bits = MPFS_MUSB_RAM_BITS,
 };
 
-static irqreturn_t mpfs_musb_interrupt(int irq, void *__hci)
-{
-	unsigned long flags;
-	irqreturn_t ret = IRQ_NONE;
-	struct musb *musb = __hci;
-
-	spin_lock_irqsave(&musb->lock, flags);
-
-	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
-	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
-	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
-
-	if (musb->int_usb || musb->int_tx || musb->int_rx) {
-		musb_writeb(musb->mregs, MUSB_INTRUSB, musb->int_usb);
-		musb_writew(musb->mregs, MUSB_INTRTX, musb->int_tx);
-		musb_writew(musb->mregs, MUSB_INTRRX, musb->int_rx);
-		ret = musb_interrupt(musb);
-	}
-
-	spin_unlock_irqrestore(&musb->lock, flags);
-
-	return ret;
-}
-
 static void mpfs_musb_set_vbus(struct musb *musb, int is_on)
 {
 	u8 devctl;
@@ -111,6 +87,129 @@ static void mpfs_musb_set_vbus(struct musb *musb, int is_on)
 		musb_readb(musb->mregs, MUSB_DEVCTL));
 }
 
+#define	POLL_SECONDS	2
+
+static void otg_timer(struct timer_list *t)
+{
+	struct musb		*musb = from_timer(musb, t, dev_timer);
+	void __iomem		*mregs = musb->mregs;
+	u8			devctl;
+	unsigned long		flags;
+
+	/*
+	 * We poll because PolarFire SoC won't expose several OTG-critical
+	 * status change events (from the transceiver) otherwise.
+	 */
+	devctl = musb_readb(mregs, MUSB_DEVCTL);
+	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
+		usb_otg_state_string(musb->xceiv->otg->state));
+
+	spin_lock_irqsave(&musb->lock, flags);
+	switch (musb->xceiv->otg->state) {
+	case OTG_STATE_A_WAIT_BCON:
+		devctl &= ~MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+
+		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+		if (devctl & MUSB_DEVCTL_BDEVICE) {
+			musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+			MUSB_DEV_MODE(musb);
+			mod_timer(&musb->dev_timer, jiffies + POLL_SECONDS * HZ);
+		} else {
+			musb->xceiv->otg->state = OTG_STATE_A_IDLE;
+			MUSB_HST_MODE(musb);
+		}
+		break;
+	case OTG_STATE_A_WAIT_VFALL:
+		if (devctl & MUSB_DEVCTL_VBUS) {
+			mod_timer(&musb->dev_timer, jiffies + POLL_SECONDS * HZ);
+			break;
+		}
+		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
+		break;
+	case OTG_STATE_B_IDLE:
+		/*
+		 * There's no ID-changed IRQ, so we have no good way to tell
+		 * when to switch to the A-Default state machine (by setting
+		 * the DEVCTL.Session bit).
+		 *
+		 * Workaround:  whenever we're in B_IDLE, try setting the
+		 * session flag every few seconds.  If it works, ID was
+		 * grounded and we're now in the A-Default state machine.
+		 *
+		 * NOTE: setting the session flag is _supposed_ to trigger
+		 * SRP but clearly it doesn't.
+		 */
+		musb_writeb(mregs, MUSB_DEVCTL, devctl | MUSB_DEVCTL_SESSION);
+		devctl = musb_readb(mregs, MUSB_DEVCTL);
+		if (devctl & MUSB_DEVCTL_BDEVICE)
+			mod_timer(&musb->dev_timer, jiffies + POLL_SECONDS * HZ);
+		else
+			musb->xceiv->otg->state = OTG_STATE_A_IDLE;
+		break;
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(&musb->lock, flags);
+}
+
+static void __maybe_unused mpfs_musb_try_idle(struct musb *musb, unsigned long timeout)
+{
+	static unsigned long last_timer;
+
+	if (timeout == 0)
+		timeout = jiffies + msecs_to_jiffies(3);
+
+	/* Never idle if active, or when VBUS timeout is not set as host */
+	if (musb->is_active || (musb->a_wait_bcon == 0 &&
+				musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON)) {
+		dev_dbg(musb->controller, "%s active, deleting timer\n",
+			usb_otg_state_string(musb->xceiv->otg->state));
+		del_timer(&musb->dev_timer);
+		last_timer = jiffies;
+		return;
+	}
+
+	if (time_after(last_timer, timeout) && timer_pending(&musb->dev_timer)) {
+		dev_dbg(musb->controller, "Longer idle timer already pending, ignoring...\n");
+		return;
+	}
+	last_timer = timeout;
+
+	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
+		usb_otg_state_string(musb->xceiv->otg->state),
+		jiffies_to_msecs(timeout - jiffies));
+	mod_timer(&musb->dev_timer, timeout);
+}
+
+static irqreturn_t mpfs_musb_interrupt(int irq, void *__hci)
+{
+	unsigned long flags;
+	irqreturn_t ret = IRQ_NONE;
+	struct musb *musb = __hci;
+
+	spin_lock_irqsave(&musb->lock, flags);
+
+	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
+	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
+	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
+
+	if (musb->int_usb || musb->int_tx || musb->int_rx) {
+		musb_writeb(musb->mregs, MUSB_INTRUSB, musb->int_usb);
+		musb_writew(musb->mregs, MUSB_INTRTX, musb->int_tx);
+		musb_writew(musb->mregs, MUSB_INTRRX, musb->int_rx);
+		ret = musb_interrupt(musb);
+	}
+
+	/* Poll for ID change */
+	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE)
+		mod_timer(&musb->dev_timer, jiffies + POLL_SECONDS * HZ);
+
+	spin_unlock_irqrestore(&musb->lock, flags);
+
+	return ret;
+}
+
 static int mpfs_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
@@ -121,6 +220,8 @@ static int mpfs_musb_init(struct musb *musb)
 		return PTR_ERR(musb->xceiv);
 	}
 
+	timer_setup(&musb->dev_timer, otg_timer, 0);
+
 	musb->dyn_fifo = true;
 	musb->isr = mpfs_musb_interrupt;
 
@@ -129,13 +230,24 @@ static int mpfs_musb_init(struct musb *musb)
 	return 0;
 }
 
+static int mpfs_musb_exit(struct musb *musb)
+{
+	del_timer_sync(&musb->dev_timer);
+
+	return 0;
+}
+
 static const struct musb_platform_ops mpfs_ops = {
 	.quirks		= MUSB_DMA_INVENTRA,
 	.init		= mpfs_musb_init,
+	.exit		= mpfs_musb_exit,
 	.fifo_mode	= 2,
 #ifdef CONFIG_USB_INVENTRA_DMA
 	.dma_init	= musbhs_dma_controller_create,
 	.dma_exit	= musbhs_dma_controller_destroy,
+#endif
+#ifndef CONFIG_USB_MUSB_HOST
+	.try_idle	= mpfs_musb_try_idle,
 #endif
 	.set_vbus	= mpfs_musb_set_vbus
 };
-- 
2.34.1


