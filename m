Return-Path: <linux-kernel+bounces-287669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27F6952B22
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC7FB211AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DF1C37A8;
	Thu, 15 Aug 2024 08:31:30 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820419D8BA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710689; cv=none; b=mls26yLEY/ANmJULl9SzcSvkhAYdTr3eHaPe092xjyYEhhvR7pYSkE+iRANVLycHzF4MKu8+p2rMJMTEM1bHAZ+xrl4DWtwkBXoB0tjESCkE+bh+hDN1iYYeWGIZWAC8SuRU7MYCtI9wDc7c0svgffMgiCjWYKyt3Cc78px+ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710689; c=relaxed/simple;
	bh=TURzid7Egx2Rtyeood+FVpy8WyKf514+g/1L2ER+5YU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBHbcQ+rLWGmD8gY9WFfIH4GWbLk4KtMA/aaPOrLSQZOyLkb27B/CFIZYtuSyPs11llcmB2tOydE0XtEYUkYQPSVuPohGbseqO8odQTb2pMnIlNT+gnf17IIb9jZcdcBr/eMTaB7u96GcDGsxx5WCwdgjsfeY6siVfopLTiRnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wkys52LTZz20lmp;
	Thu, 15 Aug 2024 16:26:49 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 482411A016C;
	Thu, 15 Aug 2024 16:31:24 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 15 Aug 2024 16:31:23 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <chenxiang66@hisilicon.com>, <hch@lst.de>, <linux-kernel@vger.kernel.org>
CC: <baohua@kernel.org>, <prime.zeng@huawei.com>
Subject: [PATCH] MAINTAINERS: Update the maintainer of dma mapping benchmark
Date: Thu, 15 Aug 2024 16:25:08 +0800
Message-ID: <20240815082508.15722-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Xiang will no longer focus on this and I'll continue to take care
of this benchmark tool. So update the information.

Cc: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..c0976c375f0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6625,7 +6625,7 @@ F:	include/linux/dmaengine.h
 F:	include/linux/of_dma.h
 
 DMA MAPPING BENCHMARK
-M:	Xiang Chen <chenxiang66@hisilicon.com>
+M:	Yicong Yang <yangyicong@hisilicon.com>
 L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
-- 
2.24.0


