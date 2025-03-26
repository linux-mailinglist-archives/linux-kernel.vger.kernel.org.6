Return-Path: <linux-kernel+bounces-576521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F248DA71058
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C75B174743
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83317B505;
	Wed, 26 Mar 2025 06:07:38 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F531161310
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969258; cv=none; b=J1fFolAKrGyW2vtKXvh47iZkfebWjK/I/q+6V6pL+H1bnv4x14ynvpEBnaOCk071oMve+SM5iy+Rj6/TnRwb8Fydw89qqz1EUTZ2uco48kkwC8IRs8ODGj2kvaCjzzxAKN5S/VeEft5WBsH923S8mn/HI9Ye+lYLsS2Rt55MeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969258; c=relaxed/simple;
	bh=9zek6A7dy74N8jecgCUdvtJWXqlteld6jCIUs9vp8Vs=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=T+W5JdT7SN5nFpQFipBoZdSNZ6DeN9TWJExhxAflD4Ob2ZNsRfyNRYWBAIl2QYXbp06TUp/UtFpMtY56XN+ABlMDS3M2XwhtGrJY0MYkP9Sz9sIdaeA1GglYf4PyL0906tqWY4yUXkR3VOA5nIs58HAXi8yUaEd3LeiAR8ihFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZMxCJ3b7Kz8R048;
	Wed, 26 Mar 2025 14:07:24 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52Q674KT051150;
	Wed, 26 Mar 2025 14:07:04 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Mar 2025 14:07:06 +0800 (CST)
Date: Wed, 26 Mar 2025 14:07:06 +0800 (CST)
X-Zmail-TransId: 2afc67e3998a1d5-28cc0
X-Mailer: Zmail v1.0
Message-ID: <20250326140706565JjKrEqMj_k5dCy15Ru2jP@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <shao.mingyin@zte.com.cn>
Cc: <tglx@linutronix.de>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0geDg2L3NtcGJvb3Q6IFJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZSBvZiBhc20vc3BlYy1jdHJsLmg=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52Q674KT051150
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E3999C.001/4ZMxCJ3b7Kz8R048

>From: Feng Wei <feng.wei8@zte.com.cn>
>
>The header file <asm/spec-ctrl.h> is included twice in smpboot.c.
>This is harmless due to include guards, but redundant. Remove the duplicate
>inclusion to clean up the code.
>
>Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
>Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
>---
>arch/x86/kernel/smpboot.c | 1 -
>1 file changed, 1 deletion(-)
>
>diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>index d6cf1e23c2a3..1dd0299da294 100644
>--- a/arch/x86/kernel/smpboot.c
>+++ b/arch/x86/kernel/smpboot.c
>@@ -89,7 +89,6 @@
>#include <asm/hw_irq.h>
>#include <asm/stackprotector.h>
>#include <asm/sev.h>
>-#include <asm/spec-ctrl.h>
>
>/* representing HT siblings of each logical CPU */
>DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
>--
>2.25.1
>
Tested, it's ok.

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

