Return-Path: <linux-kernel+bounces-281848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF494DC0B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69F91C210F8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB041514E2;
	Sat, 10 Aug 2024 09:42:09 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4B142E77
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282928; cv=none; b=LLnKFJk4AfAvjEcBC1SJTIFUMI/Jjgi4OSlyrrfkBoGtyeZB9D9ztFEn4P7mLQTV5zS43KN5h/GHdEZPbWZQFNCCQMG1+XYYzErWJLPMFBpn092hqonZbA3T+WiUTOY4ACf+nQg3WqrXwlmxiqKllwP2Tdrx9F6hgdFLRt0rifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282928; c=relaxed/simple;
	bh=lCbyeai1XbAJ46/lceRL3JOFDyGcKvL03YJ3rJBMadk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lnFtQ8cjbQ7aiXZjwFxk6IJWIeXfpdJot1jLn6mSY5VBw+Ztne/CtrfiYUHkmSr0cwDcBdQ3lBOQjgqNB55fl5/do24k7BTMo8rjw7woem9YKdWpOz0JKMql8wLjV1OmPCgSv5B0ou+4KwzVvmlvbsapK3jpNjn/xSOmX/3vmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wgwkf2Z6PzpT25;
	Sat, 10 Aug 2024 17:40:42 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EF40A180100;
	Sat, 10 Aug 2024 17:41:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 10 Aug
 2024 17:41:56 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
	<mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] arm64/sve: Remove unused declaration read_smcr_features()
Date: Sat, 10 Aug 2024 17:39:44 +0800
Message-ID: <20240810093944.2587809-1-yuehaibing@huawei.com>
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

Commit 391208485c3a ("arm64/sve: Remove SMCR pseudo register from cpufeature code")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/arm64/include/asm/fpsimd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index bc69ac368d73..f2a84efc3618 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -155,8 +155,6 @@ extern void cpu_enable_sme2(const struct arm64_cpu_capabilities *__unused);
 extern void cpu_enable_fa64(const struct arm64_cpu_capabilities *__unused);
 extern void cpu_enable_fpmr(const struct arm64_cpu_capabilities *__unused);
 
-extern u64 read_smcr_features(void);
-
 /*
  * Helpers to translate bit indices in sve_vq_map to VQ values (and
  * vice versa).  This allows find_next_bit() to be used to find the
-- 
2.34.1


