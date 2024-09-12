Return-Path: <linux-kernel+bounces-326738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CE6976C64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32A61C225F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA931B373C;
	Thu, 12 Sep 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="qoiTykH9"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E21AD24C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152277; cv=none; b=a/e4xDZBcI3ISpUdHK3m7Hp2c3PQ64jvTSgKvi+Pq7sPtjdBas4K5RK24FsoVr5rSyG4ZlkhdmKVtjT7Bb4ULv3GimOKLbbeRUn8gpj2dEqouk949Q3JYWyszlI+2jBC+Q/nSLM+Z77myr12Y6Rwc2ZzDYlT74KkVqUpil6UmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152277; c=relaxed/simple;
	bh=ZDnGDsgiQdqsKaaIMXk3CdAkLoVBQ6ulYHiyP61ZtT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t8aBW3L9vLt6DupPO6WmT9x4P+hw03t0UOdbh20xDD5xMoCtJAquKqNSkwxo4s9sPYUVjHgW3RLXmg2iKuHMbXtGox2aP/6Nmo/ps3ZY254A4Q4XB5VNXBc0efoRXJrlDYI8a/SpOPzYUf/sIplV6PX1XcyNiBRmlj3h5cpFA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=qoiTykH9; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726152271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BVnp3JLR4wewbGfHCbCYjkO7ys/eYGy/6dEiArxWd3A=;
	b=qoiTykH9KVr1fvnSZzA0yU8rvNu6W+bstEaadOqjGVHJwaOp6La+kN0SmC18OZBJJYvSfk
	82E+dxkXsYvs0/lh9CYRubHJ7SFQ1iy+G4stTbDtbvcWFZ7TTlsKUvKl+IYysG8hoI4Wha
	HYZizZ9aNAmDwHLeCcbDGquE+WL3mHTGSfxJUSrnBAPWupmnl3OrkAyN+SOcw2be61TIYI
	mvFD496iWYd1ICXVh9GkJIbzABhjJdBlU2LF9NbVRVkMpK2fXLIgXxWKvbau0Ydts8sfgn
	pStk4eHoiWotgMwtEvdDFzcqfzgyU7/Xr9NZzy2RUDMa6/yu8Wij+nO7eCJckQ==
From: b1n@b1n.io
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: b1n <b1n@b1n.io>
Subject: [PATCH] staging: vt6655: Rename variable apTD0Rings
Date: Thu, 12 Sep 2024 22:44:20 +0800
Message-Id: <20240912144420.71609-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: b1n <b1n@b1n.io>

Rename variable apTD0Rings to ap_td0_rings
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: b1n <b1n@b1n.io>
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
b1n


