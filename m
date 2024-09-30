Return-Path: <linux-kernel+bounces-343862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064BC98A070
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386F61C23745
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB4194AEB;
	Mon, 30 Sep 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="uJEb6wNe"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15D19259B;
	Mon, 30 Sep 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695312; cv=none; b=Y6Khi9xdE8jgSIApvMLd2YiAFqXwGq2+DpMHrl9VhpJnGToqRqXouq24PHvHJhSDp3w0DoT1ytLHuKW6fvYdJkeYoHSBKCQeCuEIwn8pFyMGuN21if8v3NkbV58s07ihyJbaTa+YWvpjccnUyjugPcranYbtNspUer33ivlXRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695312; c=relaxed/simple;
	bh=8SqdP0oYbBhZGytisIrLiV7vT9mzf8JNlgODjaB1GnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uNh0tQJhDYtBN9WCZmRO2DNQyBsCWJpYzg2R9bY4R/PDpRSGTpXZ3KA4gHdVYs+TgwcZ3vZJCesBteiKFf1FQdztgWWBkMj0aSyCGUN6PHy/LMY5Fv1eVgx70PjGUgKeW9dt11sGhmtYAYsDZoP6QNzp6xKoGhkWFg22Zb8UCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=uJEb6wNe; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xojpLKkjIZ8R0HEVeERSoxYd2samFw3lnJ5tiosCbDM=;
  b=uJEb6wNe24nn9GI9hRnR8y0KBCQC1amqBYTDxZNFGo5rdg4E9ZOrYXOs
   fCfX0DekBMZCio7LQvuo2BRHPoQEY300K8uxPw804TBhI6gxkf9FE1+05
   n/TKNseQkp29V1LN1BpSlR9RVC54IXKrWbRW7oLlWVf2abqNEBottgiWP
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956889"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/35] usb: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:04 +0200
Message-Id: <20240930112121.95324-19-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/usb/gadget/config.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/config.c b/drivers/usb/gadget/config.c
index b1f625245713..95f144a54ed9 100644
--- a/drivers/usb/gadget/config.c
+++ b/drivers/usb/gadget/config.c
@@ -57,11 +57,11 @@ EXPORT_SYMBOL_GPL(usb_descriptor_fillbuf);
  * usb_gadget_config_buf - builts a complete configuration descriptor
  * @config: Header for the descriptor, including characteristics such
  *	as power requirements and number of interfaces.
- * @desc: Null-terminated vector of pointers to the descriptors (interface,
- *	endpoint, etc) defining all functions in this device configuration.
  * @buf: Buffer for the resulting configuration descriptor.
  * @length: Length of buffer.  If this is not big enough to hold the
  *	entire configuration descriptor, an error code will be returned.
+ * @desc: Null-terminated vector of pointers to the descriptors (interface,
+ *	endpoint, etc) defining all functions in this device configuration.
  *
  * This copies descriptors into the response buffer, building a descriptor
  * for that configuration.  It returns the buffer length or a negative


