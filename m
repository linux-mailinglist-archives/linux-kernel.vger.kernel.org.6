Return-Path: <linux-kernel+bounces-318861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7A96F441
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1B31F2492B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03B17C9B;
	Fri,  6 Sep 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiu9Ygcv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l56V+fy7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EE1CB313;
	Fri,  6 Sep 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625532; cv=none; b=NgQrXRro7J4jCqvaE+eWinWLW+pWBH88UWXeINljQMdcl7r/92qjWRHOSad8uaLVowezo5AaOltcCjHXd5deRMaekxmHaiV7oePiWM/undqiq24QdyxPpamwnsCZnjEercUCWFNxhEY7xZk9M+u6JiA6KWxPV7UFulfS+Jom5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625532; c=relaxed/simple;
	bh=+C6ipNRSGJMg4T1Z7D2l1pRQmlxz20cz9JFqPOXbTnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KDuZoLIZf1XNBFFYvs8J4OldvsnR+S0+8dtxf6BpPIocoXjhovLcKnWSU5X5eOwofN1Eq9ZjCiw4L6nyVuaa6EASUVxdhYAcUckX+hhswELfie3BT3tyf55Xs+ssvrWQatbeg+UFzDFbRYW+CqXHoCLJ+vtEHV/J05+dPn5Ksb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiu9Ygcv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l56V+fy7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725625523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nDQ2tLfEofWacJeelfN9WDqgTJPBAbVjNTJ91yu2ScU=;
	b=fiu9YgcvQ0tZkLKHt26AV4XsJxCKhWBX5yIUEX7W2CnbA59NeYD3RsoA9h0ssGw4smeYQi
	Wm08kJEQwWDYiCfidJcWS2fOqSLJAYNfBjGefwJj2PTX5kXgr2BmrzEmR0W+43sxNYDfPg
	bTlkNS4khNOu1Uq+xECY1skADv4aDp9MV8FObqo+tm4mwHQd3SG/ok233CP+MYR0ktZmUi
	diUeUdBEX/mxJCnC9kPpsWcyTWPZPDECKO1tGkwLpVTS08M1pRLQNN5nMv9jI3HLszDrAq
	drir2btwLuWdwYOOxH/FHGQoict2w8D+T7kWnZJFJ8QLAVNfd9zjLsPPn9YOLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725625523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nDQ2tLfEofWacJeelfN9WDqgTJPBAbVjNTJ91yu2ScU=;
	b=l56V+fy7JGi6VBf7jcjNfmTVO6AJZgLa1EiZ24Wqtqr4MZrK4qSJknzF4u8XyZSe0dwGXl
	Y6UHXONp+QVgWNCg==
Date: Fri, 06 Sep 2024 14:25:19 +0200
Subject: [PATCH] of: address: Unify resource bounds overflow checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240906-of-address-overflow-v1-1-19567aaa61da@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAK702mYC/y3MywqDMBCF4VeRWXcgisbWVyldRDPRgWLqTL2A+
 O4G2+V34Pw7KAmTQpPtILSwchwT8lsG3eDGnpB9MhSmKM3DWIwBnfdCqhgXkvCOKxrb5tbX96p
 1NaTnRyjwdlWfr5+FpjnFv//xOE5vlHGRegAAAA==
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725625519; l=3419;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+C6ipNRSGJMg4T1Z7D2l1pRQmlxz20cz9JFqPOXbTnk=;
 b=y7F2X76XFvONA8Uer9mEwzkMbyvs1hsHNSt1jwZ1sitFZcGiEmF6183eS/LtQa5Wb3QZJQMM0
 sJ2GbmGP+L5AthxghUpYFUCsXJBas2GyvF0v8630TNhDJYf00KPSEig
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The members "start" and "end" of struct resource are of type
"resource_size_t" which can be 32bit wide.
Values read from OF however are always 64bit wide.

Refactor the diff overflow checks into a helper function.
Also extend the checks to validate each calculation step.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/of/address.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 7e59283a4472..df854bb427ce 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -198,6 +198,25 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 
 #endif /* CONFIG_PCI */
 
+static int __of_address_resource_bounds(struct resource *r, u64 start, u64 size)
+{
+	u64 end = start;
+
+	if (overflows_type(start, r->start))
+		return -EOVERFLOW;
+	if (size == 0)
+		return -EOVERFLOW;
+	if (check_add_overflow(end, size - 1, &end))
+		return -EOVERFLOW;
+	if (overflows_type(end, r->end))
+		return -EOVERFLOW;
+
+	r->start = start;
+	r->end = end;
+
+	return 0;
+}
+
 /*
  * of_pci_range_to_resource - Create a resource from an of_pci_range
  * @range:	the PCI range that describes the resource
@@ -216,6 +235,7 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 int of_pci_range_to_resource(struct of_pci_range *range,
 			     struct device_node *np, struct resource *res)
 {
+	u64 start;
 	int err;
 	res->flags = range->flags;
 	res->parent = res->child = res->sibling = NULL;
@@ -232,18 +252,11 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 			err = -EINVAL;
 			goto invalid_range;
 		}
-		res->start = port;
+		start = port;
 	} else {
-		if ((sizeof(resource_size_t) < 8) &&
-		    upper_32_bits(range->cpu_addr)) {
-			err = -EINVAL;
-			goto invalid_range;
-		}
-
-		res->start = range->cpu_addr;
+		start = range->cpu_addr;
 	}
-	res->end = res->start + range->size - 1;
-	return 0;
+	return __of_address_resource_bounds(res, start, range->size);
 
 invalid_range:
 	res->start = (resource_size_t)OF_BAD_ADDR;
@@ -259,8 +272,8 @@ EXPORT_SYMBOL(of_pci_range_to_resource);
  * @res:	pointer to a valid resource that will be updated to
  *              reflect the values contained in the range.
  *
- * Returns ENOENT if the entry is not found or EINVAL if the range cannot be
- * converted to resource.
+ * Returns -ENOENT if the entry is not found or -EOVERFLOW if the range
+ * cannot be converted to resource.
  */
 int of_range_to_resource(struct device_node *np, int index, struct resource *res)
 {
@@ -1062,16 +1075,10 @@ static int __of_address_to_resource(struct device_node *dev, int index, int bar_
 	if (of_mmio_is_nonposted(dev))
 		flags |= IORESOURCE_MEM_NONPOSTED;
 
-	if (overflows_type(taddr, r->start))
-		return -EOVERFLOW;
-	r->start = taddr;
-	if (overflows_type(taddr + size - 1, r->end))
-		return -EOVERFLOW;
-	r->end = taddr + size - 1;
 	r->flags = flags;
 	r->name = name ? name : dev->full_name;
 
-	return 0;
+	return __of_address_resource_bounds(r, taddr, size);
 }
 
 /**

---
base-commit: 20e5e74b91e99d57059d783e910d08a65573458f
change-id: 20240906-of-address-overflow-06b16d785ba7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


