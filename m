Return-Path: <linux-kernel+bounces-388031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5DD9B5980
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928BC284085
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305EB1917F4;
	Wed, 30 Oct 2024 01:46:33 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED413C69E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252792; cv=none; b=DsBoYLFaJr4HRRBYKHn8BHoD31hDGV6hAeeusrTVYYqStlp+fvRo2jgbfqB+9Ccqt74aUbbgkiOVb0/HK/d6eJhQjk0bOiNLfj94IN/UaqmRQ0qoKm1LJsEcEFru6Tg2/Dh2jfrZYgvigPcuHgNTJ6pK5ZcwYlNdtKKCPGQOgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252792; c=relaxed/simple;
	bh=XC5HNICbv6pmgebkhDml05HvhHBj957/HQO463iP89k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tujp9suaP4o9WwZXhASC7Id3R1jm32mcuTdL66It01zqTyLj0BbpcbqCw7RRjROIURanb6xUh1sdVBMhEdro3+RmPBC79gusAsaxD5mHN9naV6ChiFJQ/Zno8aF22cgx7ekFOcLH2cY3BnGYdcR6HXuK1OkHeDXgsfPJy8YFisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdVGt3WHlz1HLpC;
	Wed, 30 Oct 2024 09:41:58 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 9703D1401E9;
	Wed, 30 Oct 2024 09:46:26 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 09:46:25 +0800
Message-ID: <986c6fc8-b88c-347c-f599-283b34cf34b8@huawei.com>
Date: Wed, 30 Oct 2024 09:46:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] x86: Remove unused _TIF_SINGLESTEP
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<xin3.li@intel.com>, <krisman@collabora.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241030012438.358269-1-ruanjinjie@huawei.com>
 <D75E52D0-2C84-410A-BF59-4E0CDFF67237@zytor.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <D75E52D0-2C84-410A-BF59-4E0CDFF67237@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/30 9:44, H. Peter Anvin wrote:
> On October 29, 2024 6:24:38 PM PDT, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>> Since following commit, _TIF_SINGLESTEP is not used by x86 anymore,
>> remove it.
>>
>> Fixes: 6342adcaa683 ("entry: Ensure trap after single-step on system call return")

This commit, sorry, the message is not so clear.

>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> arch/x86/include/asm/thread_info.h | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
>> index 12da7dfd5ef1..734db7221613 100644
>> --- a/arch/x86/include/asm/thread_info.h
>> +++ b/arch/x86/include/asm/thread_info.h
>> @@ -110,7 +110,6 @@ struct thread_info {
>> #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>> #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>> #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>> -#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>> #define _TIF_SSBD		(1 << TIF_SSBD)
>> #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
>> #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
> 
> "Following commit"?
> 

