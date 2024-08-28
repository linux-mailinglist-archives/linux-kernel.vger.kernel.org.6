Return-Path: <linux-kernel+bounces-304822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EED962560
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D371F21E02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349616C6A8;
	Wed, 28 Aug 2024 10:59:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C6145323
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842790; cv=none; b=u1u07CQBE1xJCGsfPaQX25jlwXcv4bXzHPH5Rf6rqARjKHrTtXMGPc+vX5Z51XqALRQ+QqKreX5j0AqDpFTix2srOrKrQQ3h3t57xFZ2/2KwZ4j9Fhzd3pexpu9JugkaQ8wdqTPjkM9c9+KaOH1Plct8Iz8El4CAZsVVDYSv/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842790; c=relaxed/simple;
	bh=fQsPLRHaj6rf838QIy7EgUxGGw8+WOi+5W6X2JLxQno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gju2pM0TvPbxoVubXXpH6YMD4awhU1u9D1uFNv9INoMd7dLAPMsfLrpfJsfn6aBmZWnlzs8pJan7NI1mwbkkFVL1erbKJeYvkIJMv39FVKaxeW2WlWdjuGKIYXJZ3adSZ97JAGc/eA8EcVfJ8t/KQj6RjPrw44MIudIiNz3xmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wv1bB0Lr8zfZ2c;
	Wed, 28 Aug 2024 18:57:42 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id E93D3180AE7;
	Wed, 28 Aug 2024 18:59:45 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 18:59:45 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v3 1/6] soc: hisilicon: kunpeng_hccs: Fix a PCC typo
Date: Wed, 28 Aug 2024 18:49:51 +0800
Message-ID: <20240828104956.20214-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240828104956.20214-1-lihuisong@huawei.com>
References: <20240828104956.20214-1-lihuisong@huawei.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


