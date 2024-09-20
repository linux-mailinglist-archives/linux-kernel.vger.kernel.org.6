Return-Path: <linux-kernel+bounces-334513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781C697D83A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384CB280A74
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E217E012;
	Fri, 20 Sep 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="hstKdxjx"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22FB14A093
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849251; cv=none; b=tCUf1k1XbOj7xSg3jVslmyMxSSt5Ze6g1ZmnHRBUF2S7AXVCokV+IoGRlrgsWqcxELnbRpOWR6xz1IzRPxogMnzQnf2BwaOG+OpDPnGfc0nKcMn8um1J+WMrILTozVvkuXV+wBNmp/Ke09cV4OA+RP9M4TobI/qOxqTUj7jbEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849251; c=relaxed/simple;
	bh=KbffuDWtaDaDyNW5iznCSswDCRp9Uv6aNg57bWYIYZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDt+jL7AlvEmFLfu/BBdqZmbpoE8wd6pgU7ueNJ9V22RiRD8xdWKzx40g/H6VI9ffky93ZAl28nR+oFf7gahArxGfurIJB8aUMQlq7HIHlKP7KGtREvhTBpCAvFwVMYBTI/IbHpdYKZtrSmjB9VPm/VXIIhqxmAVXgxZ9uXjOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=hstKdxjx; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726849246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+3FciQk28R59Ar460zvDDhuQNYfCrj4RJAVz18nhP7A=;
	b=hstKdxjxdykAxyXGNKDNUXDwfaAznATj5vB2DnqocsowPzROnBdaV5kpwUNP26kSRylo6J
	rmQGsw7rKTREtJI1goa6T8ED4dyu+Cd6sjm8L/y4aWtSkwWv2yTzzbh9jonYTVAcfqTtFT
	kjUpzKZ6ON6bu0Wkl/pG9b6Smsw2DLrOyK1+DjS2s+0/klQzq2X6APzM74RxPSai2YiRYJ
	hv0vdo6YkfVNtjfKgEVZNk1DEeOyJgFvBFg1I6zAiP2qsD1J/PNncsI5nybx3M14CvqnQE
	vwO3n2jPFmk2sHGBPR+aOyMqiRUS+oQqYaA1+AbHoggzJ3BYc4hoIJ5F+oRPEg==
From: Xingquan Liu <b1n@b1n.io>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH 1/7] staging: vt6655: Rename variable apCurrTD
Date: Sat, 21 Sep 2024 00:20:19 +0800
Message-Id: <20240920162025.31465-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename variable apCurrTD to ap_curr_td to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c        | 4 ++--
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 6a2e390e9493..3b7284a23479 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -389,10 +389,10 @@ void card_safe_reset_tx(struct vnt_private *priv)
 
 	/* initialize TD index */
 	priv->tail_td[0] = &priv->ap_td0_rings[0];
-	priv->apCurrTD[0] = &priv->ap_td0_rings[0];
+	priv->ap_curr_td[0] = &priv->ap_td0_rings[0];
 
 	priv->tail_td[1] = &priv->ap_td1_rings[0];
-	priv->apCurrTD[1] = &priv->ap_td1_rings[0];
+	priv->ap_curr_td[1] = &priv->ap_td1_rings[0];
 
 	for (uu = 0; uu < TYPE_MAXTD; uu++)
 		priv->iTDUsed[uu] = 0;
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 5eaab6b172d3..f4e14c65b1a8 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -132,7 +132,7 @@ struct vnt_private {
 
 	volatile int                iTDUsed[TYPE_MAXTD];
 
-	struct vnt_tx_desc *apCurrTD[TYPE_MAXTD];
+	struct vnt_tx_desc *ap_curr_td[TYPE_MAXTD];
 	struct vnt_tx_desc *tail_td[TYPE_MAXTD];
 
 	struct vnt_tx_desc *ap_td0_rings;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index bf3ecf720206..052ebe0095a5 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -737,7 +737,7 @@ static int device_init_td0_ring(struct vnt_private *priv)
 
 	if (i > 0)
 		priv->ap_td0_rings[i - 1].next_desc = cpu_to_le32(priv->td0_pool_dma);
-	priv->tail_td[0] = priv->apCurrTD[0] = &priv->ap_td0_rings[0];
+	priv->tail_td[0] = priv->ap_curr_td[0] = &priv->ap_td0_rings[0];
 
 	return 0;
 
@@ -777,7 +777,7 @@ static int device_init_td1_ring(struct vnt_private *priv)
 
 	if (i > 0)
 		priv->ap_td1_rings[i - 1].next_desc = cpu_to_le32(priv->td1_pool_dma);
-	priv->tail_td[1] = priv->apCurrTD[1] = &priv->ap_td1_rings[0];
+	priv->tail_td[1] = priv->ap_curr_td[1] = &priv->ap_td1_rings[0];
 
 	return 0;
 
@@ -1235,7 +1235,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 		return -ENOMEM;
 	}
 
-	head_td = priv->apCurrTD[dma_idx];
+	head_td = priv->ap_curr_td[dma_idx];
 
 	head_td->td1.tcr = 0;
 
@@ -1244,7 +1244,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (dma_idx == TYPE_AC0DMA)
 		head_td->td_info->flags = TD_FLAGS_NETIF_SKB;
 
-	priv->apCurrTD[dma_idx] = head_td->next;
+	priv->ap_curr_td[dma_idx] = head_td->next;
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-- 
Xingquan Liu


