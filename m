Return-Path: <linux-kernel+bounces-316522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952496D0B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E10287CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C38D156C49;
	Thu,  5 Sep 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2UhqnQJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="InRPQ1rX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CD1925A4;
	Thu,  5 Sep 2024 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522380; cv=none; b=aTWL1tqJUNE9j+eL1XZbPbcqFugq4ocfB/N68v/rKf0GqffeF/kwcb2jFbdrpKwL+BW4zaWuyENum621biBzKwOoY15+bjmqk+P3dtTfe69hdt5pVMjLPGqRpxQZh1JoOtAHSPIhu55txvG/lsc07FMq3ZGz7Gs56aAqmF+l8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522380; c=relaxed/simple;
	bh=TmUzoCdbSCV5aEd205SdY6LquMO5Z/Fn+tyF86fSqs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oFv2+B+f9Vo7gIUwIM9syiP7pYpByoDw2DqU30tlnytdrTh5dbsXQJQAW4y1EXOZXsLYhcV3t3u81H9MSGN/iF94GBBVUkoAva2wpimBH1uMOfIGB0HiVe8YTUKLiPFk+6NLejarepIEzr+nBKzpssDUyRPmn3npqvu4P8DMRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2UhqnQJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=InRPQ1rX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725522377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6LKL0/QK0gIRCRpoCTVqV6rP//YYB+U0+zsnqyQITdE=;
	b=j2UhqnQJlycxYUAh6wsgJW1ktRrcFZotSdxspZNWSa/fEXrOkFPWAvEDqDdzL9r9SN06kB
	KKKNq/o6MNqzxTtJ1OfjB1HjYS6hic0yQpF9qE2scvRcjmx85H+GyKpWoxqPpVrVNsFQb9
	IqSx7IJ7wtpoZXT4OjX8sQr/kQOAExwwy3lmOmyplH69Vss2P4CkusNdKmXvJbOY9iIRU/
	Dsh7uqYdAizHddZC5G5ZmNrHj3eRfnal7YdTKnTdD30hMty/cEde+XzuOsmcNPh3fvKrNa
	1OW/iYbZm91Lg4H6Mp67Bl3kgdiawD+dqkFs9qizcmjHxwTwvHXv1BI3vSBmGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725522377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6LKL0/QK0gIRCRpoCTVqV6rP//YYB+U0+zsnqyQITdE=;
	b=InRPQ1rX1p/vBfDxvBM+Pn7c0nxhWWvKST3DbNUv6MboLdEwgH9vPBFxzi3Qa3Lp8T0tLA
	yy+M2jmU85QbNzAg==
Date: Thu, 05 Sep 2024 09:46:01 +0200
Subject: [PATCH] of: address: Report error on resource bounds overflow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240905-of-resource-overflow-v1-1-0cd8bb92cc1f@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALlh2WYC/4WNQQ6CMBBFr0JmbU1bagRX3MOwwDLIJKRjplAxh
 LtbuYD5q/eT//4GEYUwwq3YQDBRJA4ZzKkAP3bhiYr6zGC1dbrWTvGgBCMv4lFxQhkmfqvyWmF
 nTI++ekCevgQHWg/tvc08UpxZPsdLMr/2jzAZlWNr72zVXZwum4nCMgsHWs89Qrvv+xcPhO1Cv
 AAAAA==
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725522376; l=1705;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TmUzoCdbSCV5aEd205SdY6LquMO5Z/Fn+tyF86fSqs4=;
 b=adSGxAt5d+2qrZkScnuspwFpVFKGXk9lMuyLtyDlsJU0CWD0z19c40UnUsOXHbIA8dgiE4omP
 agV4RNJa72kCUQdgwMytMVsWX/Pga4ZhYauIO1fO3VVZl7gyoW+y/kJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The members "start" and "end" of struct resource are of type
"resource_size_t" which can be 32bit wide.
Values read from OF however are always 64bit wide.
Avoid silently truncating the value and instead return an error value.

This can happen on real systems when the DT was created for a
PAE-enabled kernel and a non-PAE kernel is actually running.
For example with an arm defconfig and "qemu-system-arm -M virt".

Link: https://bugs.launchpad.net/qemu/+bug/1790975
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 drivers/of/address.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index d669ce25b5f9..7e59283a4472 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1061,7 +1062,11 @@ static int __of_address_to_resource(struct device_node *dev, int index, int bar_
 	if (of_mmio_is_nonposted(dev))
 		flags |= IORESOURCE_MEM_NONPOSTED;
 
+	if (overflows_type(taddr, r->start))
+		return -EOVERFLOW;
 	r->start = taddr;
+	if (overflows_type(taddr + size - 1, r->end))
+		return -EOVERFLOW;
 	r->end = taddr + size - 1;
 	r->flags = flags;
 	r->name = name ? name : dev->full_name;

---
base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
change-id: 20240904-of-resource-overflow-378ea11dec8b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


