Return-Path: <linux-kernel+bounces-256073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FD69348AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2641F22278
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46C97605E;
	Thu, 18 Jul 2024 07:20:51 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F16F079
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287251; cv=none; b=gM6+YqG9XUGf+rE/xBUuVuddQ1cdb4m37AzEncBOTmXwjFtrE89Ng4lICIAKqh8N19cxXgy+q6Yzr22N4h8aWOXcodMcfcx0vIYE/h9J4jsCWtEBiYtFZzyrEp4DpQ9YFzhp/ZWz2em/2A5G50YMmZpanLS+Lh6J+0OdFpe3Z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287251; c=relaxed/simple;
	bh=9r6phBL6mPm+oCeYTda17z0h3jkD6loV46niqytSIXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGksWai32Jx9T68nWlQgyomcd/JHZM3bT8hohT2/1E1XKgc8hhcloz/LciqfkhAswAmLwn89eWMfnquikWbomOuZEXONjM1PlLNwO/Q/Tcj5ZzCZk8ngW2x1Ssb9XO4fMkT/ZCODCe+AAiRG4Q/bqsD6hUQrCZmpcQC19NgYC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WPkd63RzQzQmB5;
	Thu, 18 Jul 2024 15:16:42 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id E51C51400D1;
	Thu, 18 Jul 2024 15:20:46 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:20:46 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 1/5] soc: hisilicon: kunpeng_hccs: fix a PCC typo
Date: Thu, 18 Jul 2024 15:11:30 +0800
Message-ID: <20240718071134.31155-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240718071134.31155-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)

This patch fix a PCC typo.

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


