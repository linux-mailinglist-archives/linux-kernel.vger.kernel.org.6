Return-Path: <linux-kernel+bounces-279574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600194BF23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A340A1F2257F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2C18E756;
	Thu,  8 Aug 2024 14:08:34 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9B18C90C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126113; cv=none; b=aUo3FaGe4JaYzo+P8AoiXeayKZhKWd8kyk7F1u7l/7ZkKP9mla0cmo5mRkN3VufojaCgXpd67qvg+0NOoLhKgN4vquOZVrNhzcij7PUHyJZaEaxqh3IsuFhxD1cI5yCYOXlatrMMDxX5p0INipYOFG+jo5lUkum4vbfZD8r3vv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126113; c=relaxed/simple;
	bh=ftysCDxdrnWKxwFrSTDJOz3hoaatgTbR/7+r+kDiN+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D7+NK7OQJ6x8/cYHT95e6bsByiI2KqdXSU8TTLdR2spV4oOayBTsT8cOOxX3Teg1knmDTP414PIA6VQ+rv9tILth0dFXYxJLNFxMvIVjR7zDNfowYxC1qJpQAdr3lWHOg+hVk08cQ+Hn3XknVOoteSCPEszDkQBUSSS2/rqNabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WfpkT1Vhgz1xv13;
	Thu,  8 Aug 2024 22:06:41 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 06C481A016C;
	Thu,  8 Aug 2024 22:08:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 Aug
 2024 22:08:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<jgg@ziepe.ca>, <baolu.lu@linux.intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] iommu: Remove unused declaration iommu_sva_unbind_gpasid()
Date: Thu, 8 Aug 2024 22:06:19 +0800
Message-ID: <20240808140619.2498535-1-yuehaibing@huawei.com>
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

Commit 0c9f17877891 ("iommu: Remove guest pasid related interfaces and definitions")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d47f2c33311..04cbdae0052e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -795,8 +795,6 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
-extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
-- 
2.34.1


