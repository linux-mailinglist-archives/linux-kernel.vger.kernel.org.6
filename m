Return-Path: <linux-kernel+bounces-277212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB65949DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E381D1F22E19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915A29CEC;
	Wed,  7 Aug 2024 02:50:10 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF818D63E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999009; cv=none; b=fqB43yOwp3p+xohTrIL+E99KRPrsUuenN2AtlbH3odbk4e/+CoHgrDt889sfIJNyaZPA/aBBn2VsIR9NVXZQr/mgarSALpE53dhd/aRrh9CpSXg+cvcM42l41U1DhU+PpAzgKTXxNys/CSaH3oC28TuqXftMIMo8WyyfnFFzYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999009; c=relaxed/simple;
	bh=GEe2h9ptlZsPXZkFPyDYsVmYGHSe5o9DPZX4iSKlg6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MR7jBLhwV0iidQ2ybcvBqk4Z31VfX/nZ+RmzMPDjvbE5mqY5KC5CTGqeeObyfBeVS292kgPjbGS3Vcdrsiwtevv9+iC+cCfUDxncrXrD9Alr/ZC09W5g2J1Q/ERn5HVXg7+nJ5uqxm++SWnZ7GeHYsZ7V8EkvpU0SPCEFiokOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wdvfg4WCgz1S78X;
	Wed,  7 Aug 2024 10:45:15 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 80E98180042;
	Wed,  7 Aug 2024 10:49:58 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 Aug
 2024 10:49:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] powerpc: Remove useless config comment in asm/percpu.h
Date: Wed, 7 Aug 2024 10:56:04 +0800
Message-ID: <20240807025604.2817577-1-ruanjinjie@huawei.com>
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
 kwepemi100008.china.huawei.com (7.221.188.57)

commit 0db880fc865f ("powerpc: Avoid nmi_enter/nmi_exit in real mode
interrupt.") has a config comment typo, and the #if/#else/#endif section
is small and doesn't nest additional #ifdefs so the comment is useless
and should be removed completely.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2:
- Remove instead of change the comment.
---
 arch/powerpc/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index 634970ce13c6..ecf5ac70cfae 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -23,7 +23,7 @@ DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
 		(static_key_enabled(&__percpu_first_chunk_is_paged.key))
 #else
 #define percpu_first_chunk_is_paged	false
-#endif /* CONFIG_PPC64 && CONFIG_SMP */
+#endif
 
 #include <asm-generic/percpu.h>
 
-- 
2.34.1


