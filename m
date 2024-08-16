Return-Path: <linux-kernel+bounces-289495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BE9546BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3041F22B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E918D644;
	Fri, 16 Aug 2024 10:24:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C440170A1F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803897; cv=none; b=GHruKKZ/wOkExSrAevS62vroHpy+0GFgiZOyI422LDW6aDGnL8ke3QypDr3FGB7gOnA54BlO9kNnUgRtSlB/bq45jVrwoWaC/SfbrUjvaBK7sHgy+en12bTcVWEQJmTSvEe17juN817DTnO9iePtKHwq7ZLPdySn15bmdniCcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803897; c=relaxed/simple;
	bh=x5YgMC5UBXVlaa2hWtyzc+pNjRe/+J6AcHPCLnlqvKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QSpZAGj2QZAoqCIXR4QBCHj68hpomtcsN18gdFQiTnABtAkcTon9rrLJF5tcaMltRwX9DnAV2IfA7DjFgUcF+31mD41/D8GQ8agRP6hVdMGkeJvIayynSOw2doTH2Dk3Z8CoLnBxFpm04U+dDW1ZLIqhX600zD0Oib/DJnXCJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WldNZ1k30zhXky;
	Fri, 16 Aug 2024 18:22:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 68AC51401E9;
	Fri, 16 Aug 2024 18:24:52 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:24:51 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<yuehaibing@huawei.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86/extable: Remove unused declaration fixup_bug()
Date: Fri, 16 Aug 2024 18:22:19 +0800
Message-ID: <20240816102219.883297-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like entries")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/x86/include/asm/extable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index eeed395c3177..a0e0c6b50155 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -37,7 +37,6 @@ struct pt_regs;
 
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
-extern int fixup_bug(struct pt_regs *regs, int trapnr);
 extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
-- 
2.34.1


