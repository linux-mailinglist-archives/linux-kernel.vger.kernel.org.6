Return-Path: <linux-kernel+bounces-281846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E84894DC05
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0610EB2161B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAD91514DC;
	Sat, 10 Aug 2024 09:38:56 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C81D555
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282736; cv=none; b=TDJ+NiEupmtozyGkgO6lzfe65gC+vVt0ARLPVFiiBcSBXkEmwlO4FgxefOtonYX8koecwdVJWjJe/dwN4Z6dWzxx9aEm5cCP/te6EJ8ncV/dfPdt9NAC2F64boXgH4ACsNi4iiR2LD2no8CbGghUHv2alBgzAV4w2mQt1lnse+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282736; c=relaxed/simple;
	bh=UZd6c404VOORgzoc62eafZAY0wJbawFWD9/3pzFJb4w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFThVF550WdtVwkRMlukobjSHqucxCHCqzST2JIYuQKRQkHUc6vMw3OnAFMbbOxyzWgtdU4iNX/tLIQbx2bafi7BEYbHeOKBA1D7R5T5loLbqmSlfGmvKuArpkkI0vbIKo/SRxvmfDtN+yn9NRsJ1OeTL2HpQ5VC0mldmJU8hN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WgwbK09nFzQnrm;
	Sat, 10 Aug 2024 17:34:21 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id F2B49140135;
	Sat, 10 Aug 2024 17:38:50 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 10 Aug
 2024 17:38:50 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/apic: Remove unused extern declarations
Date: Sat, 10 Aug 2024 17:36:10 +0800
Message-ID: <20240810093610.2586665-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 517234446c1a ("x86/apic: Get rid of get_physical_broadcast()")
removed get_physical_broadcast() but leave the declaration. And
commit 79c9a17c16e9 ("x86/apic/32: Decrapify the def_bigsmp mechanism")
leave generic_bigsmp_probe() declaration. Commit d8666cf78020 ("x86/apic:
Sanitize APIC ID range validation") leave default_apic_id_valid() declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/x86/include/asm/apic.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9dd22ee27117..d48c03e947d3 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -127,8 +127,6 @@ static inline bool apic_is_x2apic_enabled(void)
 
 extern void enable_IR_x2apic(void);
 
-extern int get_physical_broadcast(void);
-
 extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
@@ -516,8 +514,6 @@ static inline bool is_vector_pending(unsigned int vector)
 #define TRAMPOLINE_PHYS_LOW		0x467
 #define TRAMPOLINE_PHYS_HIGH		0x469
 
-extern void generic_bigsmp_probe(void);
-
 #ifdef CONFIG_X86_LOCAL_APIC
 
 #include <asm/smp.h>
@@ -540,8 +536,6 @@ static inline int default_acpi_madt_oem_check(char *a, char *b) { return 0; }
 static inline void x86_64_probe_apic(void) { }
 #endif
 
-extern int default_apic_id_valid(u32 apicid);
-
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
-- 
2.34.1


