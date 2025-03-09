Return-Path: <linux-kernel+bounces-552939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A0A58140
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F267316A58B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5416F265;
	Sun,  9 Mar 2025 06:56:23 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF02BCF5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503383; cv=none; b=rNYRnPjR7aOJpAXKrUUb7tDFz2rugXwUho+sI0x7mQxHj6s9Qt7LyYqiH5zu/u1X2zMXOUPtMXVZlC8RjasUSfGJo+B/tBNojbae8chbtyQfGscUzM2+ZyIPpvrwxdD6Ra8HkBt+8ypmrYBcAR7VHkcIzghSS2Vs6CtKN4TuGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503383; c=relaxed/simple;
	bh=RTIMe2Tpw3sYL8DYRnnkOonJO8wgIJfp151KZhvQ2kI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S5J0DsrUUjaCwzno5DDWhfmBWtlT6wu4WuB7LacXiqa3ePz0YY8MoIWdUzkmepsGtKA66Rx2GI1TJppRKkN8jOaI+KA+rwICd18P60g7aCDSzq3UZZPTerLMViubAPGSO3v2GW6+iw6S2Kfx0yEt0Y/vvoOzfg0arkpV4pLNVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z9W646yHbz17Nk1;
	Sun,  9 Mar 2025 14:56:44 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B7FB14037C;
	Sun,  9 Mar 2025 14:56:10 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 9 Mar
 2025 14:56:10 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <yuehaibing@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] arm64/fpsimd: Remove unused declaration fpsimd_kvm_prepare()
Date: Sun, 9 Mar 2025 15:07:23 +0800
Message-ID: <20250309070723.1390958-1-yuehaibing@huawei.com>
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
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit fbc7e61195e2 ("KVM: arm64: Unconditionally save+flush host
FPSIMD/SVE/SME state") removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 arch/arm64/include/asm/fpsimd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index f2a84efc3618..564bc09b3e06 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -80,7 +80,6 @@ extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
-extern void fpsimd_kvm_prepare(void);
 
 struct cpu_fp_state {
 	struct user_fpsimd_state *st;
-- 
2.34.1


