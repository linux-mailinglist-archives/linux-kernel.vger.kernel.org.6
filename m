Return-Path: <linux-kernel+bounces-334517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695B97D841
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA34B24941
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B818184535;
	Fri, 20 Sep 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="Dkk7kAD+"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF5183CDD
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849261; cv=none; b=ORgoG4St7sadDsV8tEGabeZrM3HzYwRW5AzysyiP9/gfvshyG/+0kDK8X70npguHGtJmQwkV89HC5cmzxc3j8Fc3yxtGq0A17MN20S17bepoXDRLyTvaq2XqkZ3gTaRa0/t3/EXIgFCA+B9kFuHH9Yc9ldyWD5GyqU9O8vVdu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849261; c=relaxed/simple;
	bh=HBafI4eV/72rPcypHF5eS1ktZOwMeolb1Bb9u4GmuQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1ktGQNYaIEFSVuXpASExj/XY4xSpRHabgOSkT6CsjJymmowB4rZHJ96IwnpwWqGfhfaiFeLqqlQdRhFCe2cud5WdHDOHGrTiJPsIWI2lwZQPoFDDgJBEs2PcYcWGpgJprVc9+8gjccnCq3OfNKXHvtVQbAUHqFau8UqmIzEfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=Dkk7kAD+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1726849257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaGQByIrbw1V5FnGBSnk3HmvF2YJC7RTzTxqj3t+Lbc=;
	b=Dkk7kAD+xbbwwQhg5mPd9743LV2qTHetAA0mUzc8brItmLMVVhGRxd9wfE/gBrSg9FaHao
	7Z9r6m9sfcgS5yPkUTzna9juuY0I8p3gHrclHaQNOX8MzdKHuiK+OYAxo1IJ7j4VZgqlAu
	zKnoG90uJu1/A9EFkxWJaFPviBGXWHa5h/8n5dYHfScR8ewMEAKsQS7Lz+klUC31Z4PIdB
	fttKjqecdAICtoSr4NEjqjNR9MkDr74uGd7mUDkdIb2pjRJg1z/UEogABFg6g2YAf+YZlu
	CY4RvgxgfJ/ATwiIcK3TGjnTZdD67xzG7fMhf9IAdpzyUYetBKrskbREtHGEBQ==
From: Xingquan Liu <b1n@b1n.io>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH 4/7] staging: vt6655: Rename variable pDesc
Date: Sat, 21 Sep 2024 00:20:22 +0800
Message-Id: <20240920162025.31465-4-b1n@b1n.io>
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

Rename variable pDesc to p_desc to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 drivers/staging/vt6655/card.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index e25073e013cf..9a546aaf1ad5 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -432,7 +432,7 @@ void card_safe_reset_tx(struct vnt_private *priv)
 void card_v_safe_reset_rx(struct vnt_private *priv)
 {
 	unsigned int uu;
-	struct vnt_rx_desc *pDesc;
+	struct vnt_rx_desc *p_desc;
 
 	/* initialize RD index */
 	priv->pCurrRD[0] = &priv->aRD0Ring[0];
@@ -440,18 +440,18 @@ void card_v_safe_reset_rx(struct vnt_private *priv)
 
 	/* init state, all RD is chip's */
 	for (uu = 0; uu < priv->opts.rx_descs0; uu++) {
-		pDesc = &priv->aRD0Ring[uu];
-		pDesc->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
-		pDesc->rd0.owner = OWNED_BY_NIC;
-		pDesc->rd1.req_count = cpu_to_le16(priv->rx_buf_sz);
+		p_desc = &priv->aRD0Ring[uu];
+		p_desc->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
+		p_desc->rd0.owner = OWNED_BY_NIC;
+		p_desc->rd1.req_count = cpu_to_le16(priv->rx_buf_sz);
 	}
 
 	/* init state, all RD is chip's */
 	for (uu = 0; uu < priv->opts.rx_descs1; uu++) {
-		pDesc = &priv->aRD1Ring[uu];
-		pDesc->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
-		pDesc->rd0.owner = OWNED_BY_NIC;
-		pDesc->rd1.req_count = cpu_to_le16(priv->rx_buf_sz);
+		p_desc = &priv->aRD1Ring[uu];
+		p_desc->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
+		p_desc->rd0.owner = OWNED_BY_NIC;
+		p_desc->rd1.req_count = cpu_to_le16(priv->rx_buf_sz);
 	}
 
 	/* set perPkt mode */
-- 
Xingquan Liu


