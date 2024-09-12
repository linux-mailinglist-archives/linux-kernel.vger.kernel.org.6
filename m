Return-Path: <linux-kernel+bounces-326772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E789B976CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420E2B21E82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F901B1509;
	Thu, 12 Sep 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="dzHeF4s2"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD021B9826
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152766; cv=none; b=ph2RC1mFq233/PwH8/k6DujJs/BnvfN6NOfNB/Py6pF0XTT3P8Sqj+skuw8B+twJU81yxDnvy51dJXfU1s8cvA1h8jQgITR/JyFg4wkGcO+uimvRK3RJviWAM7ZaYv37Fltr0RNmIOFATSUeTnPV1isEMa3RoQeucxmyD4cM1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152766; c=relaxed/simple;
	bh=ikpNBFzF+ec1oGEsXdclhHbI5wA2hTAchVDv0fZP+M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lJ47/cTVcKpfxfiqjJ8DK9DAYL7swXiatA2wtb4IbzFtAI3rVTpqhwpAA+EfCCTzr4VicJl17XomgHaufv1SUa4HcBGKzE7LHU01IhIjeorQSl8qGLMA7zUTgFOrJyEJBSt+Tenpv66vys8j5fUq/ioHZ9KwiLwf0ZMVBMW0qJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=dzHeF4s2; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726152762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wAjctIG7kmDFkmelUoNBFSAnPu/SWGm8tJMOA/n57SI=;
	b=dzHeF4s2PdFu3AXBucE6iaAPTTNri1RuhEkYJJbVVYrydtAQuzz7dy+Ve4Hbl8LSaiBFnd
	vqE5yvdP3oPgSnAAE/oq4BJ5KEu6aU+m0HC8KdklbcgCga9E9mY6zysP33AQS9AT8Xy4yV
	FlFcny4TSzwK848ryMbUSbJca3dxkvmkYXknIbDL4ePLbBmkPJ/w7UlQIvE0Lk5K/zxIna
	GVuFVn4jGr+IBvEQewiNuggUeRfCXn/jWWBt1K2o7ACEKtWIOk3NY6Jt60efddcl9GZ3Yk
	2dgXNcrqwI2efcy5K/rGP+y7fRZCU/NZbhTaIyUne4S2wgcVkQJkDJitbUoE7A==
From: b1n@b1n.io
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH] staging: vt6655: Rename variable apTD0Rings
Date: Thu, 12 Sep 2024 22:52:34 +0800
Message-Id: <20240912145234.75499-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xingquan Liu <b1n@b1n.io>

Rename variable apTD0Rings to ap_td0_rings
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c        |  6 +++---
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 688c870d89bc..36bf8cde2e08 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -388,8 +388,8 @@ void card_safe_reset_tx(struct vnt_private *priv)
 	struct vnt_tx_desc *curr_td;
 
 	/* initialize TD index */
-	priv->tail_td[0] = &priv->apTD0Rings[0];
-	priv->apCurrTD[0] = &priv->apTD0Rings[0];
+	priv->tail_td[0] = &priv->ap_td0_rings[0];
+	priv->apCurrTD[0] = &priv->ap_td0_rings[0];
 
 	priv->tail_td[1] = &priv->apTD1Rings[0];
 	priv->apCurrTD[1] = &priv->apTD1Rings[0];
@@ -398,7 +398,7 @@ void card_safe_reset_tx(struct vnt_private *priv)
 		priv->iTDUsed[uu] = 0;
 
 	for (uu = 0; uu < priv->opts.tx_descs[0]; uu++) {
-		curr_td = &priv->apTD0Rings[uu];
+		curr_td = &priv->ap_td0_rings[uu];
 		curr_td->td0.owner = OWNED_BY_HOST;
 		/* init all Tx Packet pointer to NULL */
 	}
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 32d9cbd55222..32c51d794264 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -135,7 +135,7 @@ struct vnt_private {
 	struct vnt_tx_desc *apCurrTD[TYPE_MAXTD];
 	struct vnt_tx_desc *tail_td[TYPE_MAXTD];
 
-	struct vnt_tx_desc *apTD0Rings;
+	struct vnt_tx_desc *ap_td0_rings;
 	struct vnt_tx_desc *apTD1Rings;
 
 	struct vnt_rx_desc *aRD0Ring;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 9ea647aefd60..a8dcd8ad3945 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -550,7 +550,7 @@ static bool device_init_rings(struct vnt_private *priv)
 		priv->opts.tx_descs[0] * sizeof(struct vnt_tx_desc);
 
 	/* vir_pool: pvoid type */
-	priv->apTD0Rings = vir_pool
+	priv->ap_td0_rings = vir_pool
 		+ priv->opts.rx_descs0 * sizeof(struct vnt_rx_desc)
 		+ priv->opts.rx_descs1 * sizeof(struct vnt_rx_desc);
 
@@ -720,7 +720,7 @@ static int device_init_td0_ring(struct vnt_private *priv)
 	curr = priv->td0_pool_dma;
 	for (i = 0; i < priv->opts.tx_descs[0];
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
-		desc = &priv->apTD0Rings[i];
+		desc = &priv->ap_td0_rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
 		if (!desc->td_info) {
 			ret = -ENOMEM;
@@ -730,20 +730,20 @@ static int device_init_td0_ring(struct vnt_private *priv)
 		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
 
-		desc->next = &(priv->apTD0Rings[(i + 1) % priv->opts.tx_descs[0]]);
+		desc->next = &(priv->ap_td0_rings[(i + 1) % priv->opts.tx_descs[0]]);
 		desc->next_desc = cpu_to_le32(curr +
 					      sizeof(struct vnt_tx_desc));
 	}
 
 	if (i > 0)
-		priv->apTD0Rings[i - 1].next_desc = cpu_to_le32(priv->td0_pool_dma);
-	priv->tail_td[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
+		priv->ap_td0_rings[i - 1].next_desc = cpu_to_le32(priv->td0_pool_dma);
+	priv->tail_td[0] = priv->apCurrTD[0] = &priv->ap_td0_rings[0];
 
 	return 0;
 
 err_free_desc:
 	while (i--) {
-		desc = &priv->apTD0Rings[i];
+		desc = &priv->ap_td0_rings[i];
 		kfree(desc->td_info);
 	}
 
@@ -795,7 +795,7 @@ static void device_free_td0_ring(struct vnt_private *priv)
 	int i;
 
 	for (i = 0; i < priv->opts.tx_descs[0]; i++) {
-		struct vnt_tx_desc *desc = &priv->apTD0Rings[i];
+		struct vnt_tx_desc *desc = &priv->ap_td0_rings[i];
 		struct vnt_td_info *td_info = desc->td_info;
 
 		dev_kfree_skb(td_info->skb);
-- 
Xingquan Liu


