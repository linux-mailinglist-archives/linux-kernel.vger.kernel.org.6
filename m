Return-Path: <linux-kernel+bounces-388007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE629B591E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BA11C22EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143C1494DB;
	Wed, 30 Oct 2024 01:27:34 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A0142E7C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251654; cv=none; b=Kf72J8cWjMFeyQY94fMpT8heS8nMBSTKIyNobTgmXeLCugOej5r2Ro72kg9DHfuvWDM/1gGqhDy0gSyuwlGXx8bfE9AfnIpFPj4rXBoHh0nr8FMwYNPEDhNxfn+sIjnL4f9Qy16gcq9BPGsLyrJYrwxgWLJWOd09tplqKl+ycaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251654; c=relaxed/simple;
	bh=VXjTSmpa35j95jRHzL3JtFZVPcnX8EbOQoLeiASouaQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mcw4yEe1mje1cXqQ48RuDNU0r16W1FCGlSTqzgPAJOUXUF2fSWQuT7offO/HddBy+EBwFtWpa2Rsuz2l1ogGIuDa+vMdOdmUO1o9MJ2Xh+mbhkCt/2u5/Niwyy/xgPhLxu4tuLIM+y+83AXoZcu10DmjioPW/pX6/t9RdskuV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XdTx16sBBz20qyQ;
	Wed, 30 Oct 2024 09:26:29 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id D2BA31402E1;
	Wed, 30 Oct 2024 09:27:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Oct
 2024 09:27:28 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <hejinyang@loongson.cn>,
	<yangtiezhu@loongson.cn>, <jiaxun.yang@flygoat.com>,
	<loongarch@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] LoongArch: Remove unused _TIF_SINGLESTEP
Date: Wed, 30 Oct 2024 09:26:58 +0800
Message-ID: <20241030012658.358931-1-ruanjinjie@huawei.com>
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
 kwepemg200008.china.huawei.com (7.202.181.35)

Since following commit, _TIF_SINGLESTEP is not used by LoongArch,
remove it.

Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index 8bf0e6f51546..11184d723ef9 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -101,7 +101,6 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define _TIF_32BIT_REGS		(1<<TIF_32BIT_REGS)
 #define _TIF_32BIT_ADDR		(1<<TIF_32BIT_ADDR)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
-#define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_LSX_CTX_LIVE	(1<<TIF_LSX_CTX_LIVE)
 #define _TIF_LASX_CTX_LIVE	(1<<TIF_LASX_CTX_LIVE)
 #define _TIF_USEDLBT		(1<<TIF_USEDLBT)
-- 
2.34.1


