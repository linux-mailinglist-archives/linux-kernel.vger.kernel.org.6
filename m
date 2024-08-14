Return-Path: <linux-kernel+bounces-285812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A695130D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F518283485
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CB383A1;
	Wed, 14 Aug 2024 03:21:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A59394
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605712; cv=none; b=bWZXkCHnNwy3653c3eqyIiK30SWH26tjHkooewUR6TJQD6KE6pufGHKXydoFXYt6DG7OR2IWFxJvgj/NDV+0gKP2RNptv6HHxBwKZQZMLMC06mmZZKsaTMnHxJQSTPJSkTGZievARrqcsJ84tStDjGdW0V5A1Tlwvv4hY5cRp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605712; c=relaxed/simple;
	bh=EKYlbfu5feokexzhrIUj+yx5rJK5eP7daBYvPdDtJ2M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uz3yDkwY6MsH6+L5HqSNOaJgcmDi5hlUcjg5QqRYvv3ntjGIl2mjCXbYCjXAk8cqeBU+5pSPD0xW6sM3wFYB7ddmwt++9YgyPMhWySJzjKyUn925Ijd8winTe6wVY7cvodFN3ep4hPRbwM0HosHQ5BohCJKOXtq+DH7wcu4p31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkD631sGRzndtW;
	Wed, 14 Aug 2024 11:20:27 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 894FE1400C9;
	Wed, 14 Aug 2024 11:21:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 Aug
 2024 11:21:47 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/mm: Remove unused nx declarations
Date: Wed, 14 Aug 2024 11:19:22 +0800
Message-ID: <20240814031922.2333198-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit 4763ed4d4552 ("x86, mm: Clean up and simplify NX enablement")
these declarations is unused and can be removed.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/x86/include/asm/pgtable_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 2f321137736c..6f82e75b6149 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -517,8 +517,6 @@ typedef struct page *pgtable_t;
 
 extern pteval_t __supported_pte_mask;
 extern pteval_t __default_kernel_pte_mask;
-extern void set_nx(void);
-extern int nx_enabled;
 
 #define pgprot_writecombine	pgprot_writecombine
 extern pgprot_t pgprot_writecombine(pgprot_t prot);
-- 
2.34.1


