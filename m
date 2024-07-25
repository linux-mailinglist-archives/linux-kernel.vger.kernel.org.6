Return-Path: <linux-kernel+bounces-261931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDC93BDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D2E282CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266381741EF;
	Thu, 25 Jul 2024 08:28:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02E1741D4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896098; cv=none; b=j5TDyVMtdLAODk5PwOucFC89mDg5yYIPbXZGVbAu1n1diGNO3c2sK9Lw1g6mY8BFXcSibHz+/cgiNUI+rt4QaAs6iCPOQhAwPqZh4VPTLHTFXZrHPUtR5VwwtNRPUuLL/DT1Xi6b7B/zzq0lMD+4zrfEyNRBW6RQnHSs53NayaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896098; c=relaxed/simple;
	bh=m/5oyNFBeGSMgnq8+CO1KwF1Intf+nAv+Mdp6SrVKE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGYQlDet2O2McqK6sPMmXnSVb4nwI8EwgIhVfZ6o0tOu0Dy3t215y8GpPsH3l76zhJ9vGyMWuLZw79SweAt03yZBHk6aF+5kyN8wmcei3jyMWW6j+tHQvThDc/hKNgG9WM6nWNW5lJ2cb5OuvbHPIJG8FqSqR5M1H1dnxSdwKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85FDC1007;
	Thu, 25 Jul 2024 01:28:40 -0700 (PDT)
Received: from [10.162.40.19] (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31C863F73F;
	Thu, 25 Jul 2024 01:28:12 -0700 (PDT)
Message-ID: <55f28eae-3883-4364-9b7e-3bf7645c0d5c@arm.com>
Date: Thu, 25 Jul 2024 13:58:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip: Replace compared GIC version with
 ID_AA64PFR0_EL1_GIC_V4P1
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Gleixner
 <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20240724054623.667595-1-anshuman.khandual@arm.com>
 <867cda3lhr.wl-maz@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <867cda3lhr.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/24 20:06, Marc Zyngier wrote:
> On Wed, 24 Jul 2024 06:46:23 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Replace open encoding for GIC version code with ID_AA64PFR0_EL1_GIC_V4P1 in
>> gic_cpuif_has_vsgi().
> 
> Please fix the subject format to say "irqchip/gic-v4.1".

Sure, will change as suggested.

> 
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Applies after the following patch that fixes the given field in tools sysreg.
>>
>> https://lore.kernel.org/all/20240718215532.616447-1-rananta@google.com/
>>
>>  drivers/irqchip/irq-gic-v4.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
>> index ca32ac19d284..58c28895f8c4 100644
>> --- a/drivers/irqchip/irq-gic-v4.c
>> +++ b/drivers/irqchip/irq-gic-v4.c
>> @@ -97,7 +97,7 @@ bool gic_cpuif_has_vsgi(void)
>>  
>>  	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_EL1_GIC_SHIFT);
>>  
>> -	return fld >= 0x3;
>> +	return fld >= ID_AA64PFR0_EL1_GIC_V4P1;
>>  }
>>  #else
>>  bool gic_cpuif_has_vsgi(void)
> 
> Please repost this *once* the dependent patch is actually merged, so
> that we don't have to think of the dependencies.

Sure, will do that.

> 
> With that:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.
> 

