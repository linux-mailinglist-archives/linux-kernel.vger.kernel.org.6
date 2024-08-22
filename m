Return-Path: <linux-kernel+bounces-297376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC895B70F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1629D1C21A64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CFF1C942C;
	Thu, 22 Aug 2024 13:45:17 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4121C693
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334317; cv=none; b=QXKSYhVnPycKt3DLVHpi8px51jfJ+etVYKF3M4LQR1JJyBH0c2xsl7G4+w+5+aceqKOMH3qyIma0A7DlHjfMNbcZthyZB7YdOa4ZdBG4n1Z33xSC7KmKKOEdsjHHEdUwSaj7sgnsKpgW3RYe88TlVG4HNujxbmAoUOhYa6uUdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334317; c=relaxed/simple;
	bh=G5NK35LcoObdjMF8sqVgrYJzk1MnzqV7CuY5vewliuM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4+N7EGaevWng8tmnFTo+5iqAQ/nXskUG6IDwXaWLgMuNAIaI1QzNNrVwwn/4k0xS7A6xr1NXtrEH+aibtCLehaKjomN2PMRfHKapfdeTXviDvlCsH+Fq7SiAD7RTEGEgBWJnNoVC62OBL/0c+uDwoSStKCl7sZ20gkJednm8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqPTn2Z5tz69Mn;
	Thu, 22 Aug 2024 21:40:29 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AAE141800D4;
	Thu, 22 Aug 2024 21:45:12 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 21:45:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
	<james.clark@linaro.org>, <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] coresight: Remove unused declaration get_etm_config()
Date: Thu, 22 Aug 2024 21:42:25 +0800
Message-ID: <20240822134225.3738847-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 1925a470ce69 ("coresight: etm3x: splitting struct etm_drvdata")
declar this but never implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/hwtracing/coresight/coresight-etm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index e02c3ea972c9..e1deddb6873e 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -283,7 +283,6 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
 extern const struct attribute_group *coresight_etm_groups[];
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
-struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
 int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
 void etm_release_trace_id(struct etm_drvdata *drvdata);
 #endif
-- 
2.34.1


