Return-Path: <linux-kernel+bounces-251367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F0930412
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823AE1C22D24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2344D44C7B;
	Sat, 13 Jul 2024 06:13:45 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48738F9C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720851224; cv=none; b=ZvFLE5BHLGki2li6+G+fE/hjAmRj/2sv7XLLHoen9lR59x2QxNGUTV5VV4TsPVqbOYF60zSlNcZC8VUykOG9/nE9RYV/bHiQGFWH+MInSeKV+QqR5iuW46tTIceSUQbPLEC9JW1f1BDYZL/Yf92AZCi/TuBTlTllH5zMT29jOzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720851224; c=relaxed/simple;
	bh=OmWu9roJ8Ekx1OC9ld+LTwlVUjG9XH4xD1JTTUre6so=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QojWPi6xGTrUFOjfeggOv3+l2Pi4pWKOSgWzh6tajKinhUQQUg3I1UuxfPK5svWTO7ANykNd5kDlwdk1BoJ/BHKxSdqFzU1Nt+fHnEuHeplZC+LYiW3FvH2Np022wwYI/cz4D0Jgvk/7SFdE5qgOhl8j19IK+cqkWc+rnAeEyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WLdM41LmHzxSSL;
	Sat, 13 Jul 2024 14:08:48 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 96642180088;
	Sat, 13 Jul 2024 14:13:34 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 13 Jul
 2024 14:13:34 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6.10-rc1 4/4] arm_mpam: Fix typo about mbw_min controls
Date: Sat, 13 Jul 2024 14:09:44 +0800
Message-ID: <20240713060944.2725647-5-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240713060944.2725647-1-zengheng4@huawei.com>
References: <20240713060944.2725647-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Correct the judgment condition about mbw_min default value.

Fixes: 099f47353bc5 ("arm_mpam: Generate a configuration for min controls")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 9acac8a22573..64a1f1767a68 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -1483,7 +1483,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	}
 
 	if (mpam_has_feature(mpam_feat_mbw_min, rprops)) {
-		if (mpam_has_feature(mpam_feat_mbw_max, cfg))
+		if (mpam_has_feature(mpam_feat_mbw_min, cfg))
 			mpam_write_partsel_reg(msc, MBW_MIN, cfg->mbw_min);
 		else
 			mpam_write_partsel_reg(msc, MBW_MIN, 0);
-- 
2.25.1


