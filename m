Return-Path: <linux-kernel+bounces-517699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E55A3847A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C50167927
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAD21CC6F;
	Mon, 17 Feb 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5jB0xJX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mubjWXn7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663D21B1BC;
	Mon, 17 Feb 2025 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798459; cv=none; b=ivWPuymqbqdISshfFEOua8KaY9H2dQ0SsXiF8EzMt2E+Ukc3zGQZkmP/T05DumzFOuwcOVl8kQVf0wdVBFxMKaUjbET55wCoc7e0wnsOvrFNT7+8ZSKse/sBpMZbA7uomlUDfyaVyXCiGDqR12z/54gT054xOOr9EmQM9lbpHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798459; c=relaxed/simple;
	bh=NmTXArkbCsEGtrZw6Htg9wNi1YzBDBTbhT9Se3ioLsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9vFzLjmtbqhzz/Hfi2mqGCCf2ipNSmqqi+V03/7eQXyYQJvGqeT07vsNY5qkiVNbKqiXl7fBdhAue8pzaM77CXcJcA8gt4JpWL0afj7S7XAy/voyHG3ZrgmK5SxwQxAdJoP2rPieOTkQ4Ak9blH58vEMwC7sbBJANgzb+hREBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5jB0xJX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mubjWXn7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739798456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbeb5r83+UPFkm2mU3wjQcSB1vvJRZ9Ts2ZaqiOY/R4=;
	b=d5jB0xJXoTyTwgDgL40gNhL7fZs+btbkLpIzQuu38ljnPA9b8w2LA9NKyfifL3mJAc6Qvp
	pytLIsp+wLaDrsxRG+VuqR+9kGoIEPU/McIAAJzave9ybBFeZfiF7SvbgM8+hdK45EdDA1
	vDDV/yaRJ8BBYDptzZo7G4TzopIKPhVaVW04/M3g7MraDIzgWaTfeRxD/OKt7Gy2/dkUqI
	acYCFbyMEwkKDlq97wNKNSCMIKrElxQZ5ybAcfO8hpJbZTH78k2mgB9tfK1RkNqVWqtqWQ
	wViguwAAJ6gVlzu0oZfvG7m0mT49vsQJ0gY8Umg9WD8zOMnxGUyZcKg4T7h8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739798456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbeb5r83+UPFkm2mU3wjQcSB1vvJRZ9Ts2ZaqiOY/R4=;
	b=mubjWXn7gLl3dddAC7nuohS/Ogk87r44F8Bri2mDA86y1PwASaWyFRvyb9d4TXLF4uOwFq
	980OJgClFJ/NavDw==
Date: Mon, 17 Feb 2025 14:20:52 +0100
Subject: [PATCH 2/2] usb: dwc3: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-usb-v1-2-78da55158832@linutronix.de>
References: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
In-Reply-To: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739798454; l=2152;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NmTXArkbCsEGtrZw6Htg9wNi1YzBDBTbhT9Se3ioLsU=;
 b=DUElj98qKMcAbor1XcE693UU/tdrxjutcIGl4jtddyzHWb5R/Rp2abI+G1ZDv4QsZvtvFvqKW
 Xwl965q69SOCkAFoEEjVju4vIpz3PWYgAn+5cAoqErLd5rY0HeX9UO6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/usb/dwc3/dwc3-st.c | 2 +-
 drivers/usb/dwc3/gadget.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index ef7c43008946e15b72d88aba4941dc52bf0788d7..5d513decaacd22de15825dc061c2747cf09fef07 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -225,7 +225,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 
 	dwc3_data->syscfg_reg_off = res->start;
 
-	dev_vdbg(dev, "glue-logic addr 0x%pK, syscfg-reg offset 0x%x\n",
+	dev_vdbg(dev, "glue-logic addr 0x%p, syscfg-reg offset 0x%x\n",
 		 dwc3_data->glue_base, dwc3_data->syscfg_reg_off);
 
 	struct device_node *child __free(device_node) = of_get_compatible_child(node,
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ddd6b2ce57107cb62c5cec02eae3fe3524164469..7ea1dcd07f02999c913f1520ec05bbcf1a43d8d5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1971,12 +1971,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		return -ESHUTDOWN;
 	}
 
-	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
+	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
 				&req->request, req->dep->name))
 		return -EINVAL;
 
 	if (WARN(req->status < DWC3_REQUEST_STATUS_COMPLETED,
-				"%s: request %pK already in flight\n",
+				"%s: request %p already in flight\n",
 				dep->name, &req->request))
 		return -EINVAL;
 
@@ -2165,7 +2165,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		}
 	}
 
-	dev_err(dwc->dev, "request %pK was not queued to %s\n",
+	dev_err(dwc->dev, "request %p was not queued to %s\n",
 		request, ep->name);
 	ret = -EINVAL;
 out:

-- 
2.48.1


