Return-Path: <linux-kernel+bounces-276033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C8948D82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D14A1F24B21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2321BE873;
	Tue,  6 Aug 2024 11:17:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071C13B2AC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943057; cv=none; b=A6nAO4I8OYB76pXTOp9WQ1MeW8fTqFkXIURPv2xIJ+9mL4LJKiXDXRP5/FGYgi3CmMU+iaTgiVJ1/U2So+096B8Ws8B6olpnGphGsarR9qbocj6sU/9LH8oRAoEclzB1EQwiY2j3+f1mebo9QCwlX6tHbJUjsrYioeR1s7DSz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943057; c=relaxed/simple;
	bh=EB0MF5GSgplvWkqPWEy58Lq86UeHzIiGE5DesolODHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h0KNB8plBy51g12a+GyhW/Hxs6hQ33zqcq/IF+Ds6utVIW/1EYlmmV59bCfJHQDKuTnRhG57xEjy/+oYsHqb6xhef0B4NeBKvrg6jO3hpCFbFpA3Uby7tdje7TphI+WnTQoZ/G1Uuf/XusinCtizhCISqSUc9fx+xM3PIwdFu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WdVz60vbwzQnTf;
	Tue,  6 Aug 2024 19:13:06 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B5258180AE3;
	Tue,  6 Aug 2024 19:17:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 6 Aug
 2024 19:17:31 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] powerpc: Fix a config comment typo in asm/percpu.h
Date: Tue, 6 Aug 2024 19:23:45 +0800
Message-ID: <20240806112345.2387969-1-ruanjinjie@huawei.com>
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
 kwepemi100008.china.huawei.com (7.221.188.57)

commit 0db880fc865f ("powerpc: Avoid nmi_enter/nmi_exit in real mode
interrupt.") has a config comment typo, fix it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index 634970ce13c6..c836b16ce30d 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -23,7 +23,7 @@ DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
 		(static_key_enabled(&__percpu_first_chunk_is_paged.key))
 #else
 #define percpu_first_chunk_is_paged	false
-#endif /* CONFIG_PPC64 && CONFIG_SMP */
+#endif /* CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK && CONFIG_SMP */
 
 #include <asm-generic/percpu.h>
 
-- 
2.34.1


