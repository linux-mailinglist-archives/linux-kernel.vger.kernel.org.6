Return-Path: <linux-kernel+bounces-517698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0747A3846C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C4D7A21C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF221CA16;
	Mon, 17 Feb 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuRG5kb+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CGZQrlDN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210121A452;
	Mon, 17 Feb 2025 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798458; cv=none; b=aSsCXO2xaPVF7vhbTYzmh4HX1sh6vfu34BsIIPao8QUuXOe9fgV3sgy9KCS9Nt7vEPwmGv0jgAViDDT4ZVv+/F3PtiTZAa9M4Y5JROmRl43Pf4zSP9nYuvsM1xSnPGOabAyQIu9bEsR+DsRpDJwDzvt+2Ar27C7jruAvrtDNs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798458; c=relaxed/simple;
	bh=mAVviI4qc5ZOybZnWIvthxIwxrVl/jx7euFyvae59SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rz3hR2hIJBUxjmye8l6qJIi0kA97XBafyVtasp6fT0dlWUnheckZin7JABuGr+2Z7XCgAK5s37dI+3F4tPjDYG4qkGfEToEoT4osYo4VPtbSSafJH+YPJuPsAsYrVas7ooSXH8OuEKEZJdJ67PQFX26we3bokdtRogXL5RGF3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuRG5kb+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CGZQrlDN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739798455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8maJfYkTXgkfcaPc9gQA9AmDtt9BCUs2vbI6e+93ktc=;
	b=ZuRG5kb+fr5GuT9s0jY4lzPP2IFc+gRwMezjWTKcK6K2VDEdIOjiY5SnWpafTdYiS9ttYO
	YB6gDfrNmcNsF3riHZ/ON90blm+R3ffRIk7k1u7Jcc2oIMg6xkX4r+jnQOsEJyLbB8L7km
	a7ycio0aYfDpyBecYQuUFb5Bc2TnThUbzozdZ+ng6R+j2+sLSwSoodhNOiPlD+BH3zbAGb
	yvwgxNy45E1fDTRLu/CFAbZxi+bZnCKWe+42SVUEC4fPE2bZoFWuK/G8rqdMRWpAEBxMVL
	j3E9/HGb4qYjSmGpoHnprucjgE5um7dfGYU42zDsQoOPLiWW1qLb/X0qn3d/fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739798455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8maJfYkTXgkfcaPc9gQA9AmDtt9BCUs2vbI6e+93ktc=;
	b=CGZQrlDNTTNx2cAVBC2ANjwxhLlndS1RNoQguep+h2tDhztm6KMYinB2fcD1zXrB5/iUDv
	vBICjfuReroQfpAQ==
Date: Mon, 17 Feb 2025 14:20:51 +0100
Subject: [PATCH 1/2] usb: core: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-usb-v1-1-78da55158832@linutronix.de>
References: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
In-Reply-To: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739798454; l=1925;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mAVviI4qc5ZOybZnWIvthxIwxrVl/jx7euFyvae59SE=;
 b=/hHZT2J4XirZ3lFZXkgTLIVxF1s1Z4/5CElqeri+JZU1OOXCwq+gUfa26ykEavrQC3B+1t8FI
 f5BFRNRL6EfCCWWTaJ7kJHb7CRmMrXuES6MinUzTa6zqQCilm3KgcM+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

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


