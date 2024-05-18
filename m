Return-Path: <linux-kernel+bounces-182767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88BB8C8F82
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 05:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F841F2205D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A05C96;
	Sat, 18 May 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="WENIuJj/"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AE1FBA
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716003684; cv=none; b=j+ALVLXyOE1ojn1xg/qbhnppYeFT7lvWDTs72ngCrfMaojKj1He6RmDuum4/PaEVlO4aSm00LUqryCT1abRiCZSZn+WG0G9wZlp4BDKYgIpTj+JRr8LID1s5vyzZQ4qPg0+UETli7OSbrcwLDLe933o5dpLGDlpDE7cieBHt3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716003684; c=relaxed/simple;
	bh=164N/WwtxnSVUZkS6K8y4sw+fwyM5GlrNucfAmS06fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5mLVhbO5WMOTE+a0B9o03PVqnbVmKh/t6rxSnHV51ur8YkO1Avdc5VtovG578Z7ey7ZiMTLmN790ATtzpINOwIzyICGxv67YSwRz1icopmzK1LytR7t1VXrYUzFYb6NZkulbBqsAReBRMS7Qc4liGqXM90Ek2O7N/KbWHzzmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=WENIuJj/; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716003678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ubBRvLZp8rewt/xkDpvLy7GWRXEow8xsujDo199KHU=;
	b=WENIuJj/YXcKEi4kz6nEU7g+zESvAbhk3zTLBwUdv/uDETPmGXqgrKI6NNOj4c+G58BpXd
	3oN26gFOGsl3CzU+DZO9Tv1i71Tl9yXrLu3sBJM+QQdHg+Tz/N0FyOLzrzd9dk5DW6C26k
	nqiwM5Fd+HBcfQLFldSySPJMQ0PGNLR++bnxrbMhl2FrVWU2dgN80dpFAw/fjRCMxON7Pl
	TBuSMjtzJE1fHxln1/H6XbpFBXhq8q1lNs8RF4z/ifEcQlzXbDfGpj+Rq9d+CmGVQ1VffO
	ztMYpKYvwp6DX2nubhc97sOtnaMq3SyLNUgPq0uRJp8G92vtx1IOmWg5WwS1bg==
X-Envelope-To: miquel.raynal@bootlin.com
X-Envelope-To: richard@nod.at
X-Envelope-To: vigneshr@ti.com
X-Envelope-To: heiko@sntech.de
X-Envelope-To: sfr@canb.auug.org.au
X-Envelope-To: linux-mtd@lists.infradead.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: rockchip: reject NVDDR timings when checked
Date: Sat, 18 May 2024 00:31:13 -0300
Message-ID: <20240518033923.5577-2-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

setup_interface first gets called with a negative "target" value
NAND_DATA_IFACE_CHECK_ONLY, in which case an error is expected
if the controller driver does not support the timing mode (NVDDR).

Signed-off-by: Val Packett <val@packett.cool>
---
Hello everyone, first Linux patch from a long time FreeBSD person :)

This was required to get the NAND controller to attach on the random
old RK3066 tablet I'm bringing up mainline on.
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 7baaef69d..555804476 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -420,13 +420,13 @@ static int rk_nfc_setup_interface(struct nand_chip *chip, int target,
 	u32 rate, tc2rw, trwpw, trw2c;
 	u32 temp;
 
-	if (target < 0)
-		return 0;
-
 	timings = nand_get_sdr_timings(conf);
 	if (IS_ERR(timings))
 		return -EOPNOTSUPP;
 
+	if (target < 0)
+		return 0;
+
 	if (IS_ERR(nfc->nfc_clk))
 		rate = clk_get_rate(nfc->ahb_clk);
 	else
-- 
2.45.0


