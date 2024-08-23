Return-Path: <linux-kernel+bounces-298188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269FF95C3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CDE28386A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C30376E9;
	Fri, 23 Aug 2024 03:20:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADD1EA73
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383259; cv=none; b=b4GG06HWx9qqzMuhe4vMysUmqeRXdPUZk5xEVscsg1mBxIIJ7KuRx5McJ7eOxhgYwiot5n0PrYmkH/fHQx1nNs2sh51sWHTbeAaDY9oaYZ/azOIACPzJcTD1lMy1Pppu9v/iJYaxx0kcuWleQO7azxx4yFo+ATwpJ5OVzCEtAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383259; c=relaxed/simple;
	bh=xFld2XANYg1SoIuinqG0Ia4HuAFY1eEwy1O0JaJLiTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHY3LwnnSzy4bNtTqmFoqBl8TjZhB5/qHjVx8sx1xzgZLnexPs2kB6QCiU7KsvFcuxmm100HEq8QPGpUkwQQL0M/HI51ygYmQ+vRxXs2U2Y0crExXbxA+4u/PtKTTE75xUabE/BBlJOouAhDTqAYd0Pteh7JRU3id6wrZiEF914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wqlgc5dpLzyQH2;
	Fri, 23 Aug 2024 11:20:12 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 40D4A14011F;
	Fri, 23 Aug 2024 11:20:54 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:20:53 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 1/6] soc: hisilicon: kunpeng_hccs: Fix a PCC typo
Date: Fri, 23 Aug 2024 11:10:54 +0800
Message-ID: <20240823031059.32579-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240823031059.32579-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240823031059.32579-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Fix a PCC typo.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index e882a61636ec..c4a57328f22a 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -144,7 +144,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 
 	pcc_chan = pcc_mbox_request_channel(cl, hdev->chan_id);
 	if (IS_ERR(pcc_chan)) {
-		dev_err(dev, "PPC channel request failed.\n");
+		dev_err(dev, "PCC channel request failed.\n");
 		rc = -ENODEV;
 		goto out;
 	}
-- 
2.22.0


