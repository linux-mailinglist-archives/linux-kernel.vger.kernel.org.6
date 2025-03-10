Return-Path: <linux-kernel+bounces-554581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89049A59A28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7EC16729E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765822E3E8;
	Mon, 10 Mar 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHgDwGCc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ynUqXJK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C422A1EC;
	Mon, 10 Mar 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621110; cv=none; b=Hc5kG3X+/3sBGfMwkAJLce9nq2+e99MGXn1xwI65L3njsygaT2m41YQyX7OXsuL3SGr5uK8qdnouwnoZUaTH61D46fcK5sEZGljqAQAMftlOQMYsCHB3iGva+a1cqFHc3cxWuJohsAB7tvenzZcI+xhllYMsUPQjGKSgPhEVEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621110; c=relaxed/simple;
	bh=XDyUbPuJlR7DvaGBrt3qErD4QUqtm+gKU3dJEHNsO8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJWa3vc6XiofD7P1rDhxrBly2lIEawIn54Vu5tyCuqLdIPRmFqn5Dn4fYeCEZjze31hLCZMSRZd7QR7uBGXZpVwKWDTtRKVwxcglXRt+glWObDrAoMaZBpOhK+8oBInx8OagtO0czPvih1/7TpTsrGcq+E5dmKqv83NypG5Q9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHgDwGCc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+ynUqXJK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741621107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWGtyVn2rN7EwJ1jRjbcq53aKO4PEHGJxf2rnf/dK+A=;
	b=hHgDwGCcuKwsPSLbHVZabY2lqJEFG+OSQAP7nZgMvxlPZ+WLAe83Kqeer/QtpkbW8XlEW0
	UTqMab7XOYRoz+EIhvpSAI/HylsaWHP8yp7g0Yq5S6cK4GeqNxpOBwrCWlFY1SmUU0590R
	uRNE8zzj5dtsd1yl+bJ72YPoTXeAjfE5uxPiFxTqG0vOQFdGJSPHRO5/4wko7+oq+gAwPS
	uX4sfzIfWLOK1eOtaHbthUqaFVv/Haoeh6O8xXHnFjs0qHWOHdMr2Jq0RjeZ95qOakxA7R
	BMBmVIudePGZlzDEPoITlSaAiiXgO5FulnTKZLRnYJUlrMtq+cuLGrjT09AkUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741621107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWGtyVn2rN7EwJ1jRjbcq53aKO4PEHGJxf2rnf/dK+A=;
	b=+ynUqXJKVKc+5A0HyOUryvQuweOFli6lQ12M2p7tfQ9zK+b2wfhvWvtaVYisyVDhARVY6K
	0bKz+GlCDOO8EzCg==
Date: Mon, 10 Mar 2025 16:38:23 +0100
Subject: [PATCH v2 1/2] usb: core: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250310-restricted-pointers-usb-v2-1-a7598e2d47d1@linutronix.de>
References: <20250310-restricted-pointers-usb-v2-0-a7598e2d47d1@linutronix.de>
In-Reply-To: <20250310-restricted-pointers-usb-v2-0-a7598e2d47d1@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741621105; l=2308;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XDyUbPuJlR7DvaGBrt3qErD4QUqtm+gKU3dJEHNsO8o=;
 b=XwyTBZ+IFHW2x+2jfFgLyYxgRWrzntqxSPvYB8QBT6LMhszb0HlkPr5Xr1r4JEsmzmpv776Yi
 OjC/B+tKP9fDhA3CgfYW9vYHWdAjBPfv/n6+XzI0cESvGwh3agosQTD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is a revert of
commit 2f964780c03b ("USB: core: replace %p with %pK").

When the formatting was changed from %p to %pK that was a security
improvement, as %p would leak raw pointer values to the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
On the other hand, restricted pointers ("%pK") were never meant to be used
through printk(). They can unintentionally still leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch back to regular %p again.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/usb/core/hcd.c | 4 ++--
 drivers/usb/core/urb.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index a75cf1f6d741cf5827b9c4deca3b63013aff6cfe..46026b331267ade29839393b2fb5c0c42e34ab84 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1609,7 +1609,7 @@ int usb_hcd_unlink_urb (struct urb *urb, int status)
 		if (retval == 0)
 			retval = -EINPROGRESS;
 		else if (retval != -EIDRM && retval != -EBUSY)
-			dev_dbg(&udev->dev, "hcd_unlink_urb %pK fail %d\n",
+			dev_dbg(&udev->dev, "hcd_unlink_urb %p fail %d\n",
 					urb, retval);
 		usb_put_dev(udev);
 	}
@@ -1786,7 +1786,7 @@ void usb_hcd_flush_endpoint(struct usb_device *udev,
 		/* kick hcd */
 		unlink1(hcd, urb, -ESHUTDOWN);
 		dev_dbg (hcd->self.controller,
-			"shutdown urb %pK ep%d%s-%s\n",
+			"shutdown urb %p ep%d%s-%s\n",
 			urb, usb_endpoint_num(&ep->desc),
 			is_in ? "in" : "out",
 			usb_ep_type_string(usb_endpoint_type(&ep->desc)));
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 7576920e2d5a3e6c0dfd8bee8fce9d09a55c195c..5e52a35486afbe58bdffd3dfc1eb5964a9471ade 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -376,7 +376,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 	if (!urb || !urb->complete)
 		return -EINVAL;
 	if (urb->hcpriv) {
-		WARN_ONCE(1, "URB %pK submitted while active\n", urb);
+		WARN_ONCE(1, "URB %p submitted while active\n", urb);
 		return -EBUSY;
 	}
 

-- 
2.48.1


