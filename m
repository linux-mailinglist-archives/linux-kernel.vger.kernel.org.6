Return-Path: <linux-kernel+bounces-303651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D615F96130F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F34F1F243FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD121C6F55;
	Tue, 27 Aug 2024 15:40:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089519EEA2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773256; cv=none; b=lXqrCakZyzRkuuhNjzfesJVbsHabR4qKX1xE6BBL6FyJw5+TJW2J8JN7Vf19+DGs9pIMIJv1ozL2kQ8exlTNA/8qx+0eNrRG1pUfaoSrY0Q1KLgJ832/QbQ+nGkgwi/mNYMzFXAxXobQ1I+HT877r9EzRsO0pcDswj5JKnOqaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773256; c=relaxed/simple;
	bh=oYGBCoKRRIt/kZ+cAEXkCxOUhbrC4RpaFm7E1ZgXGMw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EHAtsEUA/EUOUK4kkCfSAsI5aLuPqPRBw2wr266OXD8/dgj+AwTkiQRN7S+y22r7iv8rtTaUxC1PHJMyNPliNtF+wpuPFzLrP0Bu2q8F2jHpNlMDDhSuHz3SafIuYKQ04Cdk18hoHHLJ2vKZhCVItPREZC2ocfss+n+V3tGi4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893EFDA7;
	Tue, 27 Aug 2024 08:41:17 -0700 (PDT)
Received: from [10.34.129.45] (e126645.nice.arm.com [10.34.129.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21653F762;
	Tue, 27 Aug 2024 08:40:46 -0700 (PDT)
Message-ID: <4024c9be-aae9-4248-ab73-813c3c5d790b@arm.com>
Date: Tue, 27 Aug 2024 17:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
To: Yicong Yang <yangyicong@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 mpe@ellerman.id.au, peterz@infradead.org, tglx@linutronix.de,
 sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, yangyicong@hisilicon.com,
 xuwei5@huawei.com, guohanjun@huawei.com
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-5-yangyicong@huawei.com>
Content-Language: en-US
In-Reply-To: <20240806085320.63514-5-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Yicong,

Is it necessary to have an explicit dependency over SMP for arm64 ? Cf.
   commit 4b3dc9679cf7 ("arm64: force CONFIG_SMP=y and remove redundant #ifdefs")

Regards,
Pierre

On 8/6/24 10:53, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Enable HOTPLUG_SMT for SMT control.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   arch/arm64/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..bd3bc2f5e0ec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -238,6 +238,7 @@ config ARM64
>   	select HAVE_KRETPROBES
>   	select HAVE_GENERIC_VDSO
>   	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
> +	select HOTPLUG_SMT if (SMP && HOTPLUG_CPU)
>   	select IRQ_DOMAIN
>   	select IRQ_FORCED_THREADING
>   	select KASAN_VMALLOC if KASAN

