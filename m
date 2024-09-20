Return-Path: <linux-kernel+bounces-334515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB6797D83E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E710B24FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2DE18309C;
	Fri, 20 Sep 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="g+7BDsnR"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99717F389
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849255; cv=none; b=hzwcLtkpm+QPEAlGVvRvzFqlCE1W8lZk4adYnuu/qmgHVrYeoSVVKcxV2rA7dSEukA2jeHhjIeZnZ3eADkq4hjI6uXdr1Do+gCuW1XW9VYevl8pvOgMnhKz1yJeoEKnqBG+1ltO64C00ho93UbGzG5f8Ya4LON/pVGdtUaVf3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849255; c=relaxed/simple;
	bh=ReP7bPvyxsIHwRgUUNVDhe+jcBgbfIJxlE+AWOIyw0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8i32voHZvq+lKdV1ZurtDdR1C6ztpHQ0ojGKxwaqawPe4oeR+t/EHLidlE7eBHkSrnA2wj4sivSH7N0IVFTL56OGmixUZ5DA4hhfJk26E6Q15O5AEruu3q3+dezfSsEuwp2vvpC6HmRY5A8G6gF3BIHbc9UYJvmPz/rXuPbqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=g+7BDsnR; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726849251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OINO0LMyOEid72R/yD6xRnPx8rEFumU7YEYwC1tWXYU=;
	b=g+7BDsnRieIClLhdQEKwYPjn4Euqxki2kZfdCxyLCkT3cdJplYevM3bI5HS6ShpE5UyrGg
	E8HYbn8KRP6VKAL6L17E6Qsaz/oOQ2cpdJZqU4fIGKhoKZBUkbbJpNOOUWUVoqA5H6+f0B
	kJxoL0FG7U9oCuuIuRGs7KuB/T9zxbkf4mQ6pHq97zStt44pvjMaZrSqn17imJuEJhoVm1
	99p9vz3+xQprCQER1teJht++yHS2CxP8+Wq5D07rk70348uDqWzYKu8KNFcluWgl5Y4xI/
	WQ53fc26pf/j8MW3otfk0hX840IMqbZtlPMvizNQsznZXKwg01aJ8H7HiLR8Xg==
From: Xingquan Liu <b1n@b1n.io>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH 2/7] staging: vt6655: Rename variable iTDUsed
Date: Sat, 21 Sep 2024 00:20:20 +0800
Message-Id: <20240920162025.31465-2-b1n@b1n.io>
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

Rename variable iTDUsed to i_td_used to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/device.h      | 4 ++--
 drivers/staging/vt6655/device_main.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 3b7284a23479..cda8ad4b3513 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -395,7 +395,7 @@ void card_safe_reset_tx(struct vnt_private *priv)
 	priv->ap_curr_td[1] = &priv->ap_td1_rings[0];
 
 	for (uu = 0; uu < TYPE_MAXTD; uu++)
-		priv->iTDUsed[uu] = 0;
+		priv->i_td_used[uu] = 0;
 
 	for (uu = 0; uu < priv->opts.tx_descs[0]; uu++) {
 		curr_td = &priv->ap_td0_rings[uu];
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index f4e14c65b1a8..57a396ad4d72 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -70,7 +70,7 @@
 
 /* BUILD OBJ mode */
 
-#define	AVAIL_TD(p, q)	((p)->opts.tx_descs[(q)] - ((p)->iTDUsed[(q)]))
+#define	AVAIL_TD(p, q)	((p)->opts.tx_descs[(q)] - ((p)->i_td_used[(q)]))
 
 /* 0:11A 1:11B 2:11G */
 #define BB_TYPE_11A    0
@@ -130,7 +130,7 @@ struct vnt_private {
 
 	spinlock_t                  lock;
 
-	volatile int                iTDUsed[TYPE_MAXTD];
+	volatile int                i_td_used[TYPE_MAXTD];
 
 	struct vnt_tx_desc *ap_curr_td[TYPE_MAXTD];
 	struct vnt_tx_desc *tail_td[TYPE_MAXTD];
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 052ebe0095a5..53e3aae29a59 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -969,7 +969,7 @@ static int device_tx_srv(struct vnt_private *priv, unsigned int idx)
 	unsigned char byTsr0;
 	unsigned char byTsr1;
 
-	for (desc = priv->tail_td[idx]; priv->iTDUsed[idx] > 0; desc = desc->next) {
+	for (desc = priv->tail_td[idx]; priv->i_td_used[idx] > 0; desc = desc->next) {
 		if (desc->td0.owner == OWNED_BY_NIC)
 			break;
 		if (works++ > 15)
@@ -1003,7 +1003,7 @@ static int device_tx_srv(struct vnt_private *priv, unsigned int idx)
 			vnt_int_report_rate(priv, desc->td_info, byTsr0, byTsr1);
 
 			device_free_tx_buf(priv, desc);
-			priv->iTDUsed[idx]--;
+			priv->i_td_used[idx]--;
 		}
 	}
 
@@ -1270,7 +1270,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	else
 		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_TXDMACTL0);
 
-	priv->iTDUsed[dma_idx]++;
+	priv->i_td_used[dma_idx]++;
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-- 
Xingquan Liu


