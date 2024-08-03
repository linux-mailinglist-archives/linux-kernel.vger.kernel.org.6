Return-Path: <linux-kernel+bounces-273460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F60946985
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0073EB214E0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7FA13A261;
	Sat,  3 Aug 2024 11:39:20 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331991ABEB3
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722685160; cv=none; b=rLhkP/kFETJarrUG9b0mZdMX+1Qp1hVnKTlASd4KXsdwSdPoOWcGcQCFMOx6gzBD/L1U/s6/2DEUkjXNAGFGumB8QuegHMmxzqilB8FJVbwSYsEIaxhrOJBdsbNZ98lpp3WZ/qXRF8SLJbJBK28/WbRqUY0EKpDLXL09ChoqgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722685160; c=relaxed/simple;
	bh=FiqvYRmeQHXLf6g7zOoZ7lvat+AiLRGjod4931mMrK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNf10B12rTRXpT15HiNPlcxrJlepJ16XKS306RoqIJLLdO7ayYjltnEyWEO9WRcQ4O50wS0q0fqz22d7kLe0OeE1BijoTh77fzKCHVZ9wt50tY8+GXISynCedflNs12XquIOI7JdQ+9zrOOjRcAQxNDAFldT1MTcC49nMEtiwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WbghN3v7sz1L9fj;
	Sat,  3 Aug 2024 19:39:00 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D29A6140154;
	Sat,  3 Aug 2024 19:39:15 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 3 Aug
 2024 19:39:15 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/apic: Remove unused inline function apic_set_eoi_cb()
Date: Sat, 3 Aug 2024 19:37:04 +0800
Message-ID: <20240803113704.246752-1-yuehaibing@huawei.com>
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

Commit 2744a7ce34a7 ("x86/apic: Replace acpi_wake_cpu_handler_update() and
apic_set_eoi_cb()") leave it unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/x86/include/asm/apic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9327eb00e96d..cf45af56d22a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -484,7 +484,6 @@ static inline u64 apic_icr_read(void) { return 0; }
 static inline void apic_icr_write(u32 low, u32 high) { }
 static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
-static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
 static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
 static inline void apic_setup_apic_calls(void) { }
 
-- 
2.34.1


