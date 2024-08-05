Return-Path: <linux-kernel+bounces-274764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B4947C69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BEB1C21C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C56770FE;
	Mon,  5 Aug 2024 14:02:54 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E350269
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866573; cv=none; b=dgxxIcxH6qiv408gu1omWmAHzfpFZxqcaC9X8Gods9WfhZu7lnfA7eG2bXOqljef8bQ6MmmWGJMtnk8yI8FwLLT4T8kCZyqlngiqUSRXLKWSk/x1H5kg8NKl001d64IrH1YbB1s2oHZXi/64HYYYyCTDEV21AYWSy+3c2zlPwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866573; c=relaxed/simple;
	bh=NW8+WDKxJI60keZ8KxOJFp3I1F1t5gjxLAB1hoTq4D0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpGKLrHa1y5pjKiCBU9Jil+zR4kqt8fLy4mjqyqVaOxL3aaaofvkNGlapvaTY3o18KXebQhQJnHctkIV/VwktOVTfg0iG8J4lX3e5MjpYgShXL1KWpBTF1vPYIMWPmsTmSfxk6SCLfocqvw3YSgeoGxmXkukeWUPGzuxSj5Cj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WcynG2CWhzyPvk;
	Mon,  5 Aug 2024 22:02:42 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 80A3E1402E0;
	Mon,  5 Aug 2024 22:02:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 5 Aug
 2024 22:02:47 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
	<msalter@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] arm64: mm: Remove unused declaration early_io_map()
Date: Mon, 5 Aug 2024 22:00:38 +0800
Message-ID: <20240805140038.1366033-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit bf4b558eba92 ("arm64: add early_ioremap support") removed the
implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/arm64/include/asm/mmu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 65977c7783c5..fc414cfd337e 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -63,7 +63,6 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
 extern void arm64_memblock_init(void);
 extern void paging_init(void);
 extern void bootmem_init(void);
-extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 				   phys_addr_t size, pgprot_t prot);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
-- 
2.34.1


