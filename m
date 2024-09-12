Return-Path: <linux-kernel+bounces-326931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA74976EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A024028676E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E2154BE4;
	Thu, 12 Sep 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="CnuzJaQY"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B2149C50
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158385; cv=none; b=aYjOWT4kak6PahOfFyxypT6LxCO08Si+9f4sdQE9L6rFhgjRETArbi9EQ0ljGiTkaPMM7AOpa0sCml7w2ui5Ua8E+t/C5N0212ek/zFR/Ntrpdr+FQsQiZyxQ0vRabm5ODxJvGYdxXuOE8qSXYHh1o04d4VDr6fiOs6VBqQtjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158385; c=relaxed/simple;
	bh=XOlhfOgBjnCEoNFa/84+XUC+RHUUiuWLT2P9/z86e7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMo4RRsiPjy/uiCatpLGrl3oG+1YYmwiNAxCbvcjWxwO2jDN+06LYRzz1yRhSRUTFgKQv8RI5DyeBUvcCexUAIRGKeLKvAAZJMezO4eRyyFSE95EGAMAOm21b6bjNNH8i9uzgFUzcu3aas7zRfPv7QMZHu18VP/PStGnWMlL6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=CnuzJaQY; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726158381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0+y4elpumHsIOUNmV4pm7E/L+kXVz2ccq6sUJvDlUQ=;
	b=CnuzJaQY7tMLfe47/qWc0XfkYYtNmlQdnTa8LrSk8ZTDFsK9kQR6g1UPPf5SXhOLpwnnCf
	1cU0SNwIZMRVEEgqEz4cDG8OeTOeUxGwhQdnT2Ic3GP9l31F4OofNYgfaP3C2K+jp636oI
	OKP2gVqe3kMzBRSWymReKnZCuEr5KtzvmJerHJhnQZmgjE/Mz07mX1cX8DDV1N0fvwZw0K
	TYRHF2aLW3lwDCoYEbrBocaRw8+D1+DgIo6ve9tLBJz2XbcYQVmI9BvuGc5HZT1YUSlTHE
	G8FOp1ACKC/YAa4CuSxY2uQXrjO/Bom6CwlC7EGCF2seFkByNBtmNQyXV+Gl6A==
From: Xingquan Liu <b1n@b1n.io>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH v2 2/2] staging: vt6655: Rename variable apTD1Rings
Date: Fri, 13 Sep 2024 00:26:09 +0800
Message-Id: <20240912162609.21517-2-b1n@b1n.io>
In-Reply-To: <20240912162609.21517-1-b1n@b1n.io>
References: <20240912162609.21517-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename variable apTD1Rings to ap_td1_rings
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c        |  6 +++---
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 36bf8cde2e08..6a2e390e9493 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -391,8 +391,8 @@ void card_safe_reset_tx(struct vnt_private *priv)
 	priv->tail_td[0] = &priv->ap_td0_rings[0];
 	priv->apCurrTD[0] = &priv->ap_td0_rings[0];
 
-	priv->tail_td[1] = &priv->apTD1Rings[0];
-	priv->apCurrTD[1] = &priv->apTD1Rings[0];
+	priv->tail_td[1] = &priv->ap_td1_rings[0];
+	priv->apCurrTD[1] = &priv->ap_td1_rings[0];
 
 	for (uu = 0; uu < TYPE_MAXTD; uu++)
 		priv->iTDUsed[uu] = 0;
@@ -403,7 +403,7 @@ void card_safe_reset_tx(struct vnt_private *priv)
 		/* init all Tx Packet pointer to NULL */
 	}
 	for (uu = 0; uu < priv->opts.tx_descs[1]; uu++) {
-		curr_td = &priv->apTD1Rings[uu];
+		curr_td = &priv->ap_td1_rings[uu];
 		curr_td->td0.owner = OWNED_BY_HOST;
 		/* init all Tx Packet pointer to NULL */
 	}
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 32c51d794264..5eaab6b172d3 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -136,7 +136,7 @@ struct vnt_private {
 	struct vnt_tx_desc *tail_td[TYPE_MAXTD];
 
 	struct vnt_tx_desc *ap_td0_rings;
-	struct vnt_tx_desc *apTD1Rings;
+	struct vnt_tx_desc *ap_td1_rings;
 
 	struct vnt_rx_desc *aRD0Ring;
 	struct vnt_rx_desc *aRD1Ring;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index a8dcd8ad3945..bf3ecf720206 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -554,7 +554,7 @@ static bool device_init_rings(struct vnt_private *priv)
 		+ priv->opts.rx_descs0 * sizeof(struct vnt_rx_desc)
 		+ priv->opts.rx_descs1 * sizeof(struct vnt_rx_desc);
 
-	priv->apTD1Rings = vir_pool
+	priv->ap_td1_rings = vir_pool
 		+ priv->opts.rx_descs0 * sizeof(struct vnt_rx_desc)
 		+ priv->opts.rx_descs1 * sizeof(struct vnt_rx_desc)
 		+ priv->opts.tx_descs[0] * sizeof(struct vnt_tx_desc);
@@ -761,7 +761,7 @@ static int device_init_td1_ring(struct vnt_private *priv)
 	curr = priv->td1_pool_dma;
 	for (i = 0; i < priv->opts.tx_descs[1];
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
-		desc = &priv->apTD1Rings[i];
+		desc = &priv->ap_td1_rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
 		if (!desc->td_info) {
 			ret = -ENOMEM;
@@ -771,19 +771,19 @@ static int device_init_td1_ring(struct vnt_private *priv)
 		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
 
-		desc->next = &(priv->apTD1Rings[(i + 1) % priv->opts.tx_descs[1]]);
+		desc->next = &(priv->ap_td1_rings[(i + 1) % priv->opts.tx_descs[1]]);
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_tx_desc));
 	}
 
 	if (i > 0)
-		priv->apTD1Rings[i - 1].next_desc = cpu_to_le32(priv->td1_pool_dma);
-	priv->tail_td[1] = priv->apCurrTD[1] = &priv->apTD1Rings[0];
+		priv->ap_td1_rings[i - 1].next_desc = cpu_to_le32(priv->td1_pool_dma);
+	priv->tail_td[1] = priv->apCurrTD[1] = &priv->ap_td1_rings[0];
 
 	return 0;
 
 err_free_desc:
 	while (i--) {
-		desc = &priv->apTD1Rings[i];
+		desc = &priv->ap_td1_rings[i];
 		kfree(desc->td_info);
 	}
 
@@ -808,7 +808,7 @@ static void device_free_td1_ring(struct vnt_private *priv)
 	int i;
 
 	for (i = 0; i < priv->opts.tx_descs[1]; i++) {
-		struct vnt_tx_desc *desc = &priv->apTD1Rings[i];
+		struct vnt_tx_desc *desc = &priv->ap_td1_rings[i];
 		struct vnt_td_info *td_info = desc->td_info;
 
 		dev_kfree_skb(td_info->skb);
-- 
Xingquan Liu


