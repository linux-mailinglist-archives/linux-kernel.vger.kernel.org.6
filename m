Return-Path: <linux-kernel+bounces-554582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E726A59A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5511887FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9D22E3F0;
	Mon, 10 Mar 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogurQhMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lO0UrGtg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305E2206BE;
	Mon, 10 Mar 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621110; cv=none; b=Qvz2AgUM5uHikFqh8Hj4w7/FAM8OX1PRuSv8kvUwGuGlDCMuGK3qwXwKuPaaFDspKv6U0GTRjNJSpoN7sWM9g/hB/Ln2fv0A3rewmW4wy40jMK4OS3KQRV6Ndl8PJFuhQTwN4I1aKIMg5Q474fYIrOAXGK9hxJKcpjqAidPTkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621110; c=relaxed/simple;
	bh=Nu0N+dD6APuQdLDWm6wIHVPj7WkCuoQLnQ5wWO5nfTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0OP8rVnGxgLTz0PAl/UHs6Kv7wD/yaHDdw7PC8zbsNJ9mFYO8o18S8pYvjrMFesheRJCIB0KdfT2mDz/sSE7YXe9JIelMH/5YiPQqAs3ke/Kb8LPPqDVaKpJIMY3wGVXeJynb9OInlgyyuWW1LIyH3Z5Xyd92vGz+lLYLcXO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogurQhMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lO0UrGtg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741621107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K14g7P5Sc0PtDGYG0K97zMcD1wLmc9SWms5AZ+7zf6U=;
	b=ogurQhMQelGRkCIAZJ4P6n1THgbSalyU4S35z+WCTF4GYkCYuWeG9rs9xK1P4mXavCpDFa
	VW9mPenIxwXWRlRofe8qSx1Y0rJuNziCufpEe8WQKocoii89Z7lg3hLWfPX2BIzP59lmxl
	kcZer8d/acvYycW3BcBYCKwvZanzCVeeYq5QVDzU5m6xiHcefzSOFRqDUvKcOl2CfyZTOC
	m+s+iLLh7V3n4lzP3RQW6uq3sqLj/g91wsX6BhznLyYR+8C5wf6H9TyUDUqHHs+otaA6+w
	DUNl4e+52esp+3xVjECU4H5jmtsjjE19ZDRQQ8JNjuPeGKiVjMFj4Q/vaBTFpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741621107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K14g7P5Sc0PtDGYG0K97zMcD1wLmc9SWms5AZ+7zf6U=;
	b=lO0UrGtguucyRqXXsvhFDCbU594/VCO662mMwOebhwaT29nXqgsBBpk49QdHSZTXI6p+Ci
	8sfOZnwHR0STmkBA==
Date: Mon, 10 Mar 2025 16:38:24 +0100
Subject: [PATCH v2 2/2] usb: dwc3: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250310-restricted-pointers-usb-v2-2-a7598e2d47d1@linutronix.de>
References: <20250310-restricted-pointers-usb-v2-0-a7598e2d47d1@linutronix.de>
In-Reply-To: <20250310-restricted-pointers-usb-v2-0-a7598e2d47d1@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741621105; l=2586;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Nu0N+dD6APuQdLDWm6wIHVPj7WkCuoQLnQ5wWO5nfTM=;
 b=tlLMau6RpGLelX0xHjgc05oEUAK1+WfYuqDerDGMsQPeFxlMW2j6X66HABJ8+rbIsoPILb4Im
 /iIEGCY7TfJCBMLMNmThhuP9ukor1R55YOrlhka4s+6tBm0+GQ+Madc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is a revert of
commit 04fb365c453e ("usb: dwc3: replace %p with %pK")

When the formatting was changed from %p to %pK that was a security
improvement, as %p would leak raw pointer values to the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
On the other hand, restricted pointers ("%pK") were never meant to be used
through printk(). They can unintentionally still leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch back to regular %p again.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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
index 89a4dc8ebf948244a719f21cbbcce565cc1d8610..9a1ec31b6ab46077d3635d1bff3fa5b362bdd9ba 100644
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


