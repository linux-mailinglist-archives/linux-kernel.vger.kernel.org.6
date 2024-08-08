Return-Path: <linux-kernel+bounces-279122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99F94B92F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA1A1C20B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188351898EE;
	Thu,  8 Aug 2024 08:43:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2918950C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106637; cv=none; b=R1be8WgLgYG4TedyHJ2zVuVCwGCqFeKACWx1iTfvBEQTPK92/sOOVIefqgfArgU/Iv+i3RzRin96saWSVaVN5bg0lTrqDuJ18F2Q8KXX4cef36tQ4NF0M+rD8brlWGagpJKvFY6RZ0E0gEGPA1aSNjuidI1njjEkXGRHM95A92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106637; c=relaxed/simple;
	bh=qo++UNNfeDbosIDCC4iEzFlrN236i9lwLZfzJolxfVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I4uZSdb7qUNBBAnsK3ii91ivAGKXYAef3glNu6RhMpUi4r19c+p7FuE1G35gBtAYGcM7fc+2JKTHdD730VJfMpL46qprpZw1EmPneYpZ4yRSUFTV64JxNdBCiVNY0ys67nIX2pBxW4fepmdqbYB6q5w2rjPmqnHc+3jzFb72CMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WfgSj6xZ9z20l7Q;
	Thu,  8 Aug 2024 16:39:17 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DFDE180042;
	Thu,  8 Aug 2024 16:43:45 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 16:43:44 +0800
Message-ID: <dc4ea241-310d-4606-9c01-aae5956f672d@huawei.com>
Date: Thu, 8 Aug 2024 16:43:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
Content-Language: en-US
To: Harith George <mail2hgg@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus
 Walleij <linus.walleij@linaro.org>, Russell King
	<rmk+kernel@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
	<harith.g@alifsemi.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
 <c11ba413-89f6-46b4-8d59-96306c9f1f14@huawei.com>
 <52518ac5-53bb-4c70-ba99-4314593129dc@gmail.com>
 <2812367a-49ad-4c88-8844-8f8493b15bbd@huawei.com>
 <a65d0b09-466d-415f-9bd0-cbc5ff3539e7@gmail.com>
 <2083af75-e2d8-42b9-8fa6-f5b7496671bd@app.fastmail.com>
 <44ffc9bc-f14e-4576-94fe-189c1f672444@gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <44ffc9bc-f14e-4576-94fe-189c1f672444@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500010.china.huawei.com (7.202.181.71)



On 2024/8/7 23:48, Harith George wrote:
> 
> 
> On 07-08-2024 21:11, Arnd Bergmann wrote:
>> On Wed, Aug 7, 2024, at 17:36, Harith George wrote:
>>> On 07-08-2024 20:52, liuyuntao (F) wrote:
>>>> Thanks, I reproduce the link error with toolchain
>>>> gcc version 9.3.0
>>>> GNU ld (GNU Binutils) 2.33.1
>>>>
>>>> with same gcc version, just upgrading ld version to 2.36.1, it does not
>>>> segfault and build completes. there should be bugs in low version of 
>>>> ld,
>>>> and the ".reloc  .text, R_ARM_NONE, ." triggers that.
>>>>
>>> Thanks for confirming.
>>>
>>> I guess we need to add something like
>>> #if !CONFIG_CC_IS_GCC || CONFIG_LD_VERSION >= 23600
>>> around the entry-armv.S changes and maybe select
>>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION in arch/arm/Kconfig only if the same
>>> conditions are met ??
>>
>> I think it makes most sense to have a minimum LD
>> version as a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION.
>> Are you sure that 2.36 is the first one that works, and it's
>> not just 2.33 specifically that is broken?
>>
>> If so, we could use
>>
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -117,7 +117,7 @@ config ARM
>>          select HAVE_KERNEL_XZ
>>          select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && 
>> !CPU_V7M && !CPU_32v3
>>          select HAVE_KRETPROBES if HAVE_KPROBES
>> -       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>> +       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 
>> 23600 || LD_IS_LLD)
>>          select HAVE_MOD_ARCH_SPECIFIC
>>          select HAVE_NMI
>>          select HAVE_OPTPROBES if !THUMB2_KERNEL
>>
> The select alone may not be enough. Wont the changes in 
> arch/arm/kernel/entry-armv.S still result in LD Segfaults even if the 
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION flag is not set in .config for older 
> toolchains?
> 

Yes, that is it.
apply this patch, it should sovle the build issue with older version GUN ld.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54b2bb817a7f..173159e93c99 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -117,7 +117,7 @@ config ARM
  	select HAVE_KERNEL_XZ
  	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
  	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || 
LD_IS_LLD)
  	select HAVE_MOD_ARCH_SPECIFIC
  	select HAVE_NMI
  	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index f01d23a220e6..cd443faf8645 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -29,6 +29,12 @@
  #include "entry-header.S"
  #include <asm/probes.h>

+#ifdef CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+#define RELOC_TEXT_NONE (.reloc  .text, R_ARM_NONE, .)
+#else
+#define RELOC_TEXT_NONE
+#endif
+
  /*
   * Interrupt handling.
   */
@@ -1065,7 +1071,7 @@ vector_addrexcptn:
  	.globl	vector_fiq

  	.section .vectors, "ax", %progbits
-	.reloc  .text, R_ARM_NONE, .
+	RELOC_TEXT_NONE
  	W(b)	vector_rst
  	W(b)	vector_und
  ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_swi		)
@@ -1079,7 +1085,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, .L__vector_swi		)

  #ifdef CONFIG_HARDEN_BRANCH_HISTORY
  	.section .vectors.bhb.loop8, "ax", %progbits
-	.reloc  .text, R_ARM_NONE, .
+	RELOC_TEXT_NONE
  	W(b)	vector_rst
  	W(b)	vector_bhb_loop8_und
  ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_loop8_swi	)
@@ -1092,7 +1098,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, 
.L__vector_bhb_loop8_swi	)
  	W(b)	vector_bhb_loop8_fiq

  	.section .vectors.bhb.bpiall, "ax", %progbits
-	.reloc  .text, R_ARM_NONE, .
+	RELOC_TEXT_NONE
  	W(b)	vector_rst
  	W(b)	vector_bhb_bpiall_und
  ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_bpiall_swi	)

> Thanks,
> Warm Regards,
> Harith
>>
>> binutils only takes a few seconds to build from source, so
>> you could just try all version from 2.25 (the oldest supported)
>> to 2.36) to see which ones work.
>>
>>         Arnd
> 

