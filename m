Return-Path: <linux-kernel+bounces-363950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A799C8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E91F21C16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF9158DD0;
	Mon, 14 Oct 2024 11:28:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8D33C5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905313; cv=none; b=TNa77IeSqSvnEFJmC+uQY4DBlbfzefuMaBrNGRPGckB7oJMBXx70w7tlCwHHgIOpL0i/aEI5mGKg+viGfUOUv+1d6OoHx4zkT/RfIcRjhW61SNy81zPKlilWMNxn7OjElqTouX7nG2dPUZ5bihImIDpUzrcz7BQTG9j7UabOBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905313; c=relaxed/simple;
	bh=Agg8nBeIEW1hcUjNYs9MQxKyJYS51vK85/s61yU0SRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT+IZBbFhrHUjm8tlSZ2EDFrts7EFx1XJhumAfApJc+oq7Ok26sRpDxCBwMXjrCe3FbUFzXEbvZTWcTp/1pDemlYl5TuI1dkVvpvsJWJr/BJp8//6NPuABRkz1fcyRB2mkKeFknUq5Sq6O4vkUHutc9liS+UuSghUjagC4NAObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BC401424;
	Mon, 14 Oct 2024 04:29:00 -0700 (PDT)
Received: from [10.57.86.130] (unknown [10.57.86.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A9D33F51B;
	Mon, 14 Oct 2024 04:28:27 -0700 (PDT)
Message-ID: <dbc8edd9-fa30-4051-b373-6985f41e4900@arm.com>
Date: Mon, 14 Oct 2024 12:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 55/57] arm64: TRAMP_VALIAS is no longer
 compile-time constant
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-55-ryan.roberts@arm.com>
 <CAMj1kXHt9eCoPgJLo0kJ1TuSQ71dpnjB1pLdRO0HiOA3jFNd7w@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXHt9eCoPgJLo0kJ1TuSQ71dpnjB1pLdRO0HiOA3jFNd7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 12:21, Ard Biesheuvel wrote:
> Hi Ryan,
> 
> On Mon, 14 Oct 2024 at 13:02, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> When boot-time page size is in operation, TRAMP_VALIAS is no longer a
>> compile-time constant, because the VA of a fixmap slot depends upon
>> PAGE_SIZE.
>>
>> Let's handle this by instead exporting the slot index,
>> FIX_ENTRY_TRAMP_BEGIN,to assembly, then do the TRAMP_VALIAS calculation
>> per page size and use alternatives to decide which variant to activate.
>>
>> Note that for the tramp_map_kernel case, we are one instruction short of
>> space in the vector to have NOPs for all 3 page size variants. So we do
>> if/else for 16K/64K and branch around it for the 4K case. This saves 2
>> instructions.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  arch/arm64/kernel/asm-offsets.c |  2 +-
>>  arch/arm64/kernel/entry.S       | 50 ++++++++++++++++++++++++++-------
>>  2 files changed, 41 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index f32b8d7f00b2a..c45fa3e281884 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -172,7 +172,7 @@ int main(void)
>>    DEFINE(ARM64_FTR_SYSVAL,     offsetof(struct arm64_ftr_reg, sys_val));
>>    BLANK();
>>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>> -  DEFINE(TRAMP_VALIAS,         TRAMP_VALIAS);
>> +  DEFINE(FIX_ENTRY_TRAMP_BEGIN,        FIX_ENTRY_TRAMP_BEGIN);
>>  #endif
>>  #ifdef CONFIG_ARM_SDE_INTERFACE
>>    DEFINE(SDEI_EVENT_INTREGS,   offsetof(struct sdei_registered_event, interrupted_regs));
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 7ef0e127b149f..ba47dc8672c04 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -101,11 +101,27 @@
>>  .org .Lventry_start\@ + 128    // Did we overflow the ventry slot?
>>         .endm
>>
>> +#define TRAMP_VALIAS(page_shift)       (FIXADDR_TOP - (FIX_ENTRY_TRAMP_BEGIN << (page_shift)))
>> +
>>         .macro  tramp_alias, dst, sym
>> -       .set    .Lalias\@, TRAMP_VALIAS + \sym - .entry.tramp.text
>> -       movz    \dst, :abs_g2_s:.Lalias\@
>> -       movk    \dst, :abs_g1_nc:.Lalias\@
>> -       movk    \dst, :abs_g0_nc:.Lalias\@
>> +alternative_if ARM64_USE_PAGE_SIZE_4K
>> +       .set    .Lalias4k\@, TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) + \sym - .entry.tramp.text
>> +       movz    \dst, :abs_g2_s:.Lalias4k\@
>> +       movk    \dst, :abs_g1_nc:.Lalias4k\@
>> +       movk    \dst, :abs_g0_nc:.Lalias4k\@
>> +alternative_else_nop_endif
>> +alternative_if ARM64_USE_PAGE_SIZE_16K
>> +       .set    .Lalias16k\@, TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) + \sym - .entry.tramp.text
>> +       movz    \dst, :abs_g2_s:.Lalias16k\@
>> +       movk    \dst, :abs_g1_nc:.Lalias16k\@
>> +       movk    \dst, :abs_g0_nc:.Lalias16k\@
>> +alternative_else_nop_endif
>> +alternative_if ARM64_USE_PAGE_SIZE_64K
>> +       .set    .Lalias64k\@, TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) + \sym - .entry.tramp.text
>> +       movz    \dst, :abs_g2_s:.Lalias64k\@
>> +       movk    \dst, :abs_g1_nc:.Lalias64k\@
>> +       movk    \dst, :abs_g0_nc:.Lalias64k\@
>> +alternative_else_nop_endif
> 
> Since you're changing these, might as well drop the middle movk as the
> fixmap is now always in the top 2 GiB of the VA space.
> 
> However, wouldn't it be better to reuse the existing callback
> alternative stuff that Marc added for KVM?

Yes, I agree. Mark suggested the same thing when we were talking the other day
too. I'll definitely use the callbacks for next version, but I didn't want to
hold up the RFC any further - I'd already spent way too much time polishing.

> 
> Same applies below, I reckon.
> 
>>         .endm
>>
>>         /*
>> @@ -627,16 +643,30 @@ SYM_CODE_END(ret_to_user)
>>         bic     \tmp, \tmp, #USER_ASID_FLAG
>>         msr     ttbr1_el1, \tmp
>>  #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
>> -alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
>> +alternative_if_not ARM64_WORKAROUND_QCOM_FALKOR_E1003
>> +       b       .Lskip_falkor_e1003\@
>> +alternative_else_nop_endif
>>         /* ASID already in \tmp[63:48] */
>> -       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS >> 12)
>> -       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS >> 12)
>> -       /* 2MB boundary containing the vectors, so we nobble the walk cache */
>> -       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS & ~(SZ_2M - 1)) >> 12)
>> +alternative_if ARM64_USE_PAGE_SIZE_4K
>> +       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) >> 12)
>> +       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) >> 12)
>> +       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS(ARM64_PAGE_SHIFT_4K) & ~(SZ_2M - 1)) >> 12)
>> +       b       .Lfinish_falkor_e1003\@
>> +alternative_else_nop_endif
>> +alternative_if ARM64_USE_PAGE_SIZE_16K
>> +       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) >> 12)
>> +       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) >> 12)
>> +       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS(ARM64_PAGE_SHIFT_16K) & ~(SZ_2M - 1)) >> 12)
>> +alternative_else /* ARM64_USE_PAGE_SIZE_64K */
>> +       movk    \tmp, #:abs_g2_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) >> 12)
>> +       movk    \tmp, #:abs_g1_nc:(TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) >> 12)
>> +       movk    \tmp, #:abs_g0_nc:((TRAMP_VALIAS(ARM64_PAGE_SHIFT_64K) & ~(SZ_2M - 1)) >> 12)
>> +alternative_endif
>> +.Lfinish_falkor_e1003\@:
>>         isb
>>         tlbi    vae1, \tmp
>>         dsb     nsh
>> -alternative_else_nop_endif
>> +.Lskip_falkor_e1003\@:
>>  #endif /* CONFIG_QCOM_FALKOR_ERRATUM_1003 */
>>         .endm
>>
>> --
>> 2.43.0
>>


