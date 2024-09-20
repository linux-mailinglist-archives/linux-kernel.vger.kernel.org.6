Return-Path: <linux-kernel+bounces-334520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A275697D844
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB8E1C22919
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8B4181BA8;
	Fri, 20 Sep 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="HDvKe6O8"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5A17E00B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849274; cv=none; b=ZdciEu/MVjKzG+cIbWc1xSfVvaYe30/2PWGaPJAljK/Zhr5QGMUsOOjPQDUCIjS4BoRXgeJpFkAM9VaNTxxEKd1TViDap47PnOJrc/YiezPqFYMhT91Hf9Ph3zMj8hPL27RnTziQ8ZbfnIkYh2EaSc/ogCV4eDP55wZUZW/tG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849274; c=relaxed/simple;
	bh=10sS86pwP6gHcteFJPgYDUv/YPWBTwZwbZnLN814vYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E65G1mf7s/ynVvUeG473ampd5LczRgkgn0uVXb+lDyKNMAzaGdtr8oAAQFou98X7AomrDg3MEL64awPPd2MsEi3N6lz3XTnUpJx5E5OVsuisrtytaqJBz+bg368d4XKpMg30KhYd3sTNE9eb/IASz3c8JSwN826AzIDJJP/42tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=HDvKe6O8; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726849269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9OorerApR/92ZiWdbVbfYZFIQiGs2U58WETLDI6z3U=;
	b=HDvKe6O845GJU/keyGIr4q/JWvAXQDawnMH7ywM9kzlnh69uYUu4+cOZkbyYHGDh1vQdjb
	vSMnPTdSgKDq9qALkx3NIv/jzMrsutgh0rk/qy99zHtLeSPyhAFxLNa4TFAo2PfHDuOHF2
	6Sv++Z/jK9sv9+IT5HGBVRSFVMILwhW/keYSSi6XA225q79B7gXEoZIC5V3Q0weNG0iVDd
	8XVoEysBmrMO1Ye4dttvj62SuA7wUhnRXf9fvdl28W45gJUWmFaXXwKMSiZ6Cpuxt0xowz
	k4CyY6Sr7s3VGsHQjVMMFfjLQVpcYgcp+DG+y+VsGmc8JofOV8L380ElZRK8MQ==
From: Xingquan Liu <b1n@b1n.io>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH 7/7] staging: vt6655: Rename variable aRD1Ring
Date: Sat, 21 Sep 2024 00:20:25 +0800
Message-Id: <20240920162025.31465-7-b1n@b1n.io>
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

Rename variable aRD1Ring to a_rd1_ring to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c        |  4 ++--
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 712a478aac91..c8b3b16b03c6 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -436,7 +436,7 @@ void card_v_safe_reset_rx(struct vnt_private *priv)
 
 	/* initialize RD index */
 	priv->p_curr_rd[0] = &priv->a_rd0_ring[0];
-	priv->p_curr_rd[1] = &priv->aRD1Ring[0];
+	priv->p_curr_rd[1] = &priv->a_rd1_ring[0];
 
 	/* init state, all RD is chip's */
 	for (uu = 0; uu < priv->opts.rx_descs0; uu++) {
@@ -448,7 +448,7 @@ void card_v_safe_reset_rx(struct vnt_private *priv)
 
 	/* init state, all RD is chip's */
 	for (uu = 0; uu < priv->opts.rx_descs1; uu++) {
-		p_desc = &priv->aRD1Ring[uu];
+		p_desc = &priv->a_rd1_ring[uu];
 		p_desc->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
 		p_desc->rd0.owner = OWNED_BY_NIC;
 		p_desc->rd1.req_count = cpu_to_le16(priv->rx_buf_sz);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 8fd4d972df14..591fcd02ee8e 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -139,7 +139,7 @@ struct vnt_private {
 	struct vnt_tx_desc *ap_td1_rings;
 
 	struct vnt_rx_desc *a_rd0_ring;
-	struct vnt_rx_desc *aRD1Ring;
+	struct vnt_rx_desc *a_rd1_ring;
 	struct vnt_rx_desc *p_curr_rd[TYPE_MAXRD];
 
 	struct vnt_options opts;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 84b8a476d240..eeb2f271ba0b 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -518,7 +518,7 @@ static bool device_init_rings(struct vnt_private *priv)
 	}
 
 	priv->a_rd0_ring = vir_pool;
-	priv->aRD1Ring = vir_pool +
+	priv->a_rd1_ring = vir_pool +
 		priv->opts.rx_descs0 * sizeof(struct vnt_rx_desc);
 
 	priv->rd0_pool_dma = priv->pool_dma;
@@ -650,7 +650,7 @@ static int device_init_rd1_ring(struct vnt_private *priv)
 	/* Init the RD1 ring entries */
 	for (i = 0; i < priv->opts.rx_descs1;
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
-		desc = &priv->aRD1Ring[i];
+		desc = &priv->a_rd1_ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
 		if (!desc->rd_info) {
 			ret = -ENOMEM;
@@ -663,13 +663,13 @@ static int device_init_rd1_ring(struct vnt_private *priv)
 			goto err_free_rd;
 		}
 
-		desc->next = &priv->aRD1Ring[(i + 1) % priv->opts.rx_descs1];
+		desc->next = &priv->a_rd1_ring[(i + 1) % priv->opts.rx_descs1];
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_rx_desc));
 	}
 
 	if (i > 0)
-		priv->aRD1Ring[i - 1].next_desc = cpu_to_le32(priv->rd1_pool_dma);
-	priv->p_curr_rd[1] = &priv->aRD1Ring[0];
+		priv->a_rd1_ring[i - 1].next_desc = cpu_to_le32(priv->rd1_pool_dma);
+	priv->p_curr_rd[1] = &priv->a_rd1_ring[0];
 
 	return 0;
 
@@ -678,7 +678,7 @@ static int device_init_rd1_ring(struct vnt_private *priv)
 
 err_free_desc:
 	while (i--) {
-		desc = &priv->aRD1Ring[i];
+		desc = &priv->a_rd1_ring[i];
 		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
 	}
@@ -703,7 +703,7 @@ static void device_free_rd1_ring(struct vnt_private *priv)
 	int i;
 
 	for (i = 0; i < priv->opts.rx_descs1; i++) {
-		struct vnt_rx_desc *desc = &priv->aRD1Ring[i];
+		struct vnt_rx_desc *desc = &priv->a_rd1_ring[i];
 
 		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
-- 
Xingquan Liu


