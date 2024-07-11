Return-Path: <linux-kernel+bounces-249070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D70D92E5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29878B271CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106515958A;
	Thu, 11 Jul 2024 11:10:57 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BEB1607B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696256; cv=none; b=PRmmFLEciWo5J8JkPwNjm39BIQOM2XsX+AmRRQYnKq+wzGsagTn0Kgk3tTh41b4cCLtvAWyk/Hrfh5wAIkFLTNAduAwqVxj8KvDYdcfNY12ZeY6f/puR6xhalufKJndl2x2eJg7GpKYEDG+0/At2b31r5MU60OctX3G4d1KzdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696256; c=relaxed/simple;
	bh=AeEqfduxgfojeGH2SlT5j6HbJixFfIpgTzDL4V9zdM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PxdzykHN4f5G/0AOvF2tcHA84sIgv0uTr/bjy5kEfI3BZHt2iEMqg8Sdi7Szg1KeCyO2/yl3XEAbz7o6vwe+9p7hRACiqE64fGfUjaV9bdSp47R003RxZHRLxr5Du0i+GmRb/b5Mr5vRcNFJBk2zKGMm5TUOfxTG2TbPCX9rdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WKX330h3jz1T5SV;
	Thu, 11 Jul 2024 19:06:07 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EE9ED140361;
	Thu, 11 Jul 2024 19:10:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 19:10:50 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<samitolvanen@google.com>, <debug@rivosinc.com>, <andy.chiu@sifive.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <bjorn@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] riscv: Remove unused _TIF_WORK_MASK
Date: Thu, 11 Jul 2024 19:15:08 +0800
Message-ID: <20240711111508.1373322-1-ruanjinjie@huawei.com>
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
 kwepemi100008.china.huawei.com (7.221.188.57)

Since commit f0bddf50586d ("riscv: entry: Convert to generic entry"),
_TIF_WORK_MASK is no longer used, so remove it.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/include/asm/thread_info.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 5d473343634b..0eead6b7b790 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -111,8 +111,4 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
 
-#define _TIF_WORK_MASK \
-	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
-
 #endif /* _ASM_RISCV_THREAD_INFO_H */
-- 
2.34.1


