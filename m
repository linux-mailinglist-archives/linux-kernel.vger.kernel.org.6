Return-Path: <linux-kernel+bounces-334519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EE97D843
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C84B25362
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0CD185921;
	Fri, 20 Sep 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="q1n50KsH"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A317E00B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849269; cv=none; b=W6HDVU385ni/CRNKVM8q22Ee4ReJ+VmtP11KUvPKPaX5uQAJD3B/SDKyMHUPowIsEmxiUpSCeufOw6LxqBJ3i6Eh0F3NbfNyYq5cY+rUnqFRWM8a0yKtYLA8U5aCMtcde1yZYHSXHI42rJgaHPTpHXXxXl5fS6BXHyEJAUmsQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849269; c=relaxed/simple;
	bh=D6J//nNYMezubeXFMxVAHUlyuml5UV63IgSxbu7ezcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaHr9PpKdyXGXhRwVEkBWXWUfw0vRkAao1IPC3+wIavBtvTzXc3xA0oYn8g5uyxyLoHEjFSDgt5++6eRBx5FwDZknE7k+aNZq58d/SZnGFfIhpWi3bG3OVMIVDeCbi6gLcjbw94nTlIX8dp8Hv74di6Xol4Dp2M6fXH6cv8z2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=q1n50KsH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726849265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2iOXoTicq7i1RkqeVmgKj+fsbg8G2r0wOpknT9Hx3M=;
	b=q1n50KsHouXYPpI+t1N4W5zit3vjROuZN899SHLNdao5JWdTOTBLN6SSlFbcZ1L7iuSYdy
	9trXi7htTESK8jEi+eT/CRZJfo/mbZgIAg/Nq5OX6JbBRtBUhvJcnPhscaBUNbbpq185fg
	aUBpoQwW2d6xowlX+vanRNP9t2tI0WuToc9yOb7oEIxpwio4TrrVAfLfSlnhE4yMQVsHKU
	egkv4jbPEGN4tlwfNTi+2DUEY/LfwaQAt/+SU6knIT8PXbWNUaVuMYxhhgRtthvEZKjVek
	zIAhheO7TQVwJDzoZ18knT07XAl3gvwTA7sNMW/8ZqKlceHTTiv2T+DoKztTDw==
From: Xingquan Liu <b1n@b1n.io>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH 6/7] staging: vt6655: Rename variable aRD0Ring
Date: Sat, 21 Sep 2024 00:20:24 +0800
Message-Id: <20240920162025.31465-6-b1n@b1n.io>
In-Reply-To: <20240920162025.31465-1-b1n@b1n.io>
References: <20240920162025.31465-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename variable aRD0Ring to a_rd0_ring to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c        |  4 ++--
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c | 16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 58b9bd451a54..712a478aac91 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -435,12 +435,12 @@ void card_v_safe_reset_rx(struct vnt_private *priv)
 	struct vnt_rx_desc *p_desc;
 
 	/* initialize RD index */
-	priv->p_curr_rd[0] = &priv->aRD0Ring[0];
+	priv->p_curr_rd[0] = &priv->a_rd0_ring[0];
 	priv->p_curr_rd[1] = &priv->aRD1Ring[0];
 
 	/* init state, all RD is chip's */
 	for (uu = 0; uu < priv->opts.rx_descs0; uu++) {
-		p_desc = &priv->aRD0Ring[uu];
+		p_desc = &priv->a_rd0_ring[uu];
 		p_desc->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
 		p_desc->rd0.owner = OWNED_BY_NIC;
 		p_desc->rd1.req_count = cpu_to_le16(priv->rx_buf_sz);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index b89cd4707b86..8fd4d972df14 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -138,7 +138,7 @@ struct vnt_private {
 	struct vnt_tx_desc *ap_td0_rings;
 	struct vnt_tx_desc *ap_td1_rings;
 
-	struct vnt_rx_desc *aRD0Ring;
+	struct vnt_rx_desc *a_rd0_ring;
 	struct vnt_rx_desc *aRD1Ring;
 	struct vnt_rx_desc *p_curr_rd[TYPE_MAXRD];
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index caee5f90edb8..84b8a476d240 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -517,7 +517,7 @@ static bool device_init_rings(struct vnt_private *priv)
 		return false;
 	}
 
-	priv->aRD0Ring = vir_pool;
+	priv->a_rd0_ring = vir_pool;
 	priv->aRD1Ring = vir_pool +
 		priv->opts.rx_descs0 * sizeof(struct vnt_rx_desc);
 
@@ -584,7 +584,7 @@ static void device_free_rings(struct vnt_private *priv)
 			  priv->opts.rx_descs1 * sizeof(struct vnt_rx_desc) +
 			  priv->opts.tx_descs[0] * sizeof(struct vnt_tx_desc) +
 			  priv->opts.tx_descs[1] * sizeof(struct vnt_tx_desc),
-			  priv->aRD0Ring, priv->pool_dma);
+			  priv->a_rd0_ring, priv->pool_dma);
 
 	dma_free_coherent(&priv->pcid->dev,
 			  priv->opts.tx_descs[0] * PKT_BUF_SZ +
@@ -604,7 +604,7 @@ static int device_init_rd0_ring(struct vnt_private *priv)
 	/* Init the RD0 ring entries */
 	for (i = 0; i < priv->opts.rx_descs0;
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
-		desc = &priv->aRD0Ring[i];
+		desc = &priv->a_rd0_ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
 		if (!desc->rd_info) {
 			ret = -ENOMEM;
@@ -617,13 +617,13 @@ static int device_init_rd0_ring(struct vnt_private *priv)
 			goto err_free_rd;
 		}
 
-		desc->next = &priv->aRD0Ring[(i + 1) % priv->opts.rx_descs0];
+		desc->next = &priv->a_rd0_ring[(i + 1) % priv->opts.rx_descs0];
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_rx_desc));
 	}
 
 	if (i > 0)
-		priv->aRD0Ring[i - 1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
-	priv->p_curr_rd[0] = &priv->aRD0Ring[0];
+		priv->a_rd0_ring[i - 1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
+	priv->p_curr_rd[0] = &priv->a_rd0_ring[0];
 
 	return 0;
 
@@ -632,7 +632,7 @@ static int device_init_rd0_ring(struct vnt_private *priv)
 
 err_free_desc:
 	while (i--) {
-		desc = &priv->aRD0Ring[i];
+		desc = &priv->a_rd0_ring[i];
 		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
 	}
@@ -691,7 +691,7 @@ static void device_free_rd0_ring(struct vnt_private *priv)
 	int i;
 
 	for (i = 0; i < priv->opts.rx_descs0; i++) {
-		struct vnt_rx_desc *desc = &priv->aRD0Ring[i];
+		struct vnt_rx_desc *desc = &priv->a_rd0_ring[i];
 
 		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
-- 
Xingquan Liu


