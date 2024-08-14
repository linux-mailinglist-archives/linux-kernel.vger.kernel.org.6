Return-Path: <linux-kernel+bounces-285810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918EE951309
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54394286D48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699B3A29F;
	Wed, 14 Aug 2024 03:19:06 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93438DCD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605546; cv=none; b=FjhpKmpkleu59zrzr4/dT8ylU7b85BC8NDlx46g62uuglXVvwZW2Q7OumoMjEg6khicoSS1aHmllDQGXpLaSlTg5rIDnITYTLNjtXfZqaeaUbsrRsfIfeCvpszeXPFqQr9ChSeoQbaXyj38LhOkeVoMRlcLRNPwOwsHBSw/F7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605546; c=relaxed/simple;
	bh=7H/gjouQMCW6LagU34ERSfk9dOCxivS3Qy8vwpsTmxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MHpezz+2+WGch0CDHjsqV60pBzp82XY73EIDhRWYMr2pgWMLY18qyzW9GUYZ9+evt+jCcw2v8Qe1A9B91WpV+bcjeg4XjpweUpj72rVZBXgxNxLJwpHzb3UZGdjSdAjzBUcdEMy3wj8V0tRaPDMPD7TE2gQEFjJVrw1blWFkS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WkD2G0qf1z1xv5g;
	Wed, 14 Aug 2024 11:17:10 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 639F61A016C;
	Wed, 14 Aug 2024 11:19:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 Aug
 2024 11:19:00 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <steve.wahl@hpe.com>, <justin.ernst@hpe.com>, <kyle.meyer@hpe.com>,
	<dimitri.sivanich@hpe.com>, <russ.anderson@hpe.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <yuehaibing@huawei.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86/apic: Remove unused declaration uv_irq_2_mmr_info()
Date: Wed, 14 Aug 2024 11:16:36 +0800
Message-ID: <20240814031636.1304772-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 43fe1abc18a2 ("x86/uv: Use hierarchical irqdomain to manage UV interrupts")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/x86/include/asm/uv/uv_irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv_irq.h b/arch/x86/include/asm/uv/uv_irq.h
index d6b17c760622..1876b5edd142 100644
--- a/arch/x86/include/asm/uv/uv_irq.h
+++ b/arch/x86/include/asm/uv/uv_irq.h
@@ -31,7 +31,6 @@ enum {
 	UV_AFFINITY_CPU
 };
 
-extern int uv_irq_2_mmr_info(int, unsigned long *, int *);
 extern int uv_setup_irq(char *, int, int, unsigned long, int);
 extern void uv_teardown_irq(unsigned int);
 
-- 
2.34.1


