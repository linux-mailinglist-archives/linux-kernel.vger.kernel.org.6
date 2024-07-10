Return-Path: <linux-kernel+bounces-246934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D192C90C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584781F23E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397F288DF;
	Wed, 10 Jul 2024 03:17:24 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725517756
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581443; cv=none; b=pL/L17/o55IDk4gwzIWPpuwiPWAmKUavU2gJniW/G5DhxKdSMT9MZtU9LQ/EbbEN24z45bLxzSz2fXzXS9E1UNo/yVHS4MOlyz+YWZxmt9uFK8VYXIh6BbrpwaZS5iUX38fSYpVp6D6mYRmSdBD+MxuTlCFHzjPM08aKnBTgPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581443; c=relaxed/simple;
	bh=f+B9vyXRICQcnPPBFZz0FKR8Lkda0bRSX00rgyqqjaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EWrYz6wlxwg3i0pTmNF+p12m7tPn2bjv+YZxO4RRFvKvdqDZa369Log1PVp+M2DhDQeu6CU5F+Va1l3hfnpFID0kRUiBJfpb3be+iNFrSzfDPynrl55CBbnSiBiOL/pUSDtvgWAxP/l6v1pvlWT8T+toF8Z265if9dDKYZ+srCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAD3_lo1_Y1mLcL3FA--.47376S2;
	Wed, 10 Jul 2024 11:17:09 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: vkoul@kernel.org,
	kishon@kernel.org,
	thomas.richard@bootlin.com,
	rogerq@kernel.org,
	theo.lebrun@bootlin.com,
	c-vankar@ti.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] phy: ti: phy-j721e-wiz: convert comma to semicolon
Date: Wed, 10 Jul 2024 11:16:26 +0800
Message-Id: <20240710031626.2003110-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3_lo1_Y1mLcL3FA--.47376S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrykKFW3Wrg_yoWfAFgEqw
	1j9wnrXrn0y3Wqk3Wjvr13ZFyavrWqvr1DW3WfKFySyryUWw4YvryDZr15WryDZ3Wrur97
	G3W8Zwnxua45AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYiiSDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/phy/ti/phy-j721e-wiz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 7f626c597025..bb16fdfe63df 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1578,8 +1578,8 @@ static int wiz_probe(struct platform_device *pdev)
 
 	phy_reset_dev = &wiz->wiz_phy_reset_dev;
 	phy_reset_dev->dev = dev;
-	phy_reset_dev->ops = &wiz_phy_reset_ops,
-	phy_reset_dev->owner = THIS_MODULE,
+	phy_reset_dev->ops = &wiz_phy_reset_ops;
+	phy_reset_dev->owner = THIS_MODULE;
 	phy_reset_dev->of_node = node;
 	/* Reset for each of the lane and one for the entire SERDES */
 	phy_reset_dev->nr_resets = num_lanes + 1;
-- 
2.25.1


