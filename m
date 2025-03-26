Return-Path: <linux-kernel+bounces-576449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE92DA70F85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D3E188E542
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0B1624C2;
	Wed, 26 Mar 2025 03:29:03 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249482E403
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959743; cv=none; b=IVeVjFbsxzN6kZY0g7lPy1YXL6FEQQRK+VHHmU1ke5o5dauptCdFou4agYOUwzqPJevFtahz4CyXG8WNYowwlZITWagfkfYsgrngDCnPJ/ZBqu8NvC9Pqi+YY+6gbD/YOBQCjoZi2OsL3qD6Cc23oDT+qub0bb6h1My5QThfql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959743; c=relaxed/simple;
	bh=VF5kMr+54On2JaAuBXNCqmULSNug5vjAXAIEf6ay4Fw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=mv4lTwdLHZCONKdU/kjmXLci5Pk/LQPYjYHbWU9OHwaSPl1v9du7cKFRkfdJWim7Bzy9lLzKYbA3HvlK4I8qaR9sonJog0rJQ3oeXILc9MlIAQYhDnt4wpDht0kJG+bo6WBkrAY+dtZtDT5ZpPyHSDtM6mEO3uz2GL/t8fRyCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZMshJ29Lhz4x5pF;
	Wed, 26 Mar 2025 11:28:48 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52Q3SVtj005168;
	Wed, 26 Mar 2025 11:28:31 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Mar 2025 11:28:32 +0800 (CST)
Date: Wed, 26 Mar 2025 11:28:32 +0800 (CST)
X-Zmail-TransId: 2afa67e37460ffffffffb70-6671d
X-Mailer: Zmail v1.0
Message-ID: <20250326112832566Q2WLuyrWbd2LGE9CCGxKB@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tglx@linutronix.de>
Cc: <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB4ODYvc21wYm9vdDogUmVtb3ZlIGR1cGxpY2F0ZSBpbmNsdWRlIG9mIGFzbS9zcGVjLWN0cmwuaA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52Q3SVtj005168
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E37470.003/4ZMshJ29Lhz4x5pF

From: Feng Wei <feng.wei8@zte.com.cn>

The header file <asm/spec-ctrl.h> is included twice in smpboot.c.
This is harmless due to include guards, but redundant. Remove the duplicate
inclusion to clean up the code.

Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
arch/x86/kernel/smpboot.c | 1 -
1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d6cf1e23c2a3..1dd0299da294 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -89,7 +89,6 @@
#include <asm/hw_irq.h>
#include <asm/stackprotector.h>
#include <asm/sev.h>
-#include <asm/spec-ctrl.h>

/* representing HT siblings of each logical CPU */
DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
--
2.25.1

