Return-Path: <linux-kernel+bounces-183501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F38C99E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB41C28193C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69B1BC41;
	Mon, 20 May 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IHPcsPjX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB881C6A0;
	Mon, 20 May 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194146; cv=none; b=c4ZQuR4qpW/t5eZrdO5YYILfHf6lbba0T67NiHeX93zTv5R9Tt17FMKhVHsnOYT6prRg3I5bLtCWY4MXY77h2aYBMkbcvrXsdRNraz9Y7QjJHE1ZBj421XONUUTVoNVmkxZ3rZnC0onlM/Dhk5rYrWMj1Us6/znZIexXKffWRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194146; c=relaxed/simple;
	bh=3JczJcGfj53wdZ/jePes5M9y0/qIzKmsixfB1tGSndA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iEnFDb46pC4xWJa2txfxp1YYlu8eWQsd//uvQPt+Op03s1RntmVNQLoSG+BGSG6DjTe+8LxGkDxREQN9QRtYhMwRqn0CarOktIliBBK0S0D5Vf47cANewNBHJiI/ulyanlwZ7tFoKxs3zcTRlutiaU4EbLsXoYcoZieCgAyT35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IHPcsPjX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=dpZt6/Fkp6cxSrkFSrKcy3qvvymahFE/nlsFRXFz8oo=; b=IHPcsPjXdZVdyEsUSG0KgQGlU3
	FH9erA1GmVZuG4RGyjZqvkb5FKg8LwSxvysjdg8a1kOx7kuGbY73hOznZcdeHxRhnbc/z3Op9DDmj
	9QpdDlW5tJo04MBjsoaubEGcvbKPwOzkrLGADWbi/CIcEVimMOI9V9vcHwm1sS9BHynbh4mkqU2R9
	PSpIWPC3RAIgIUAvi+Ugc4DNkeGVWpb6kpPJxQRNWBmTEKO6jkzcn2/1Mp8ULl3p+YpB31DPGJQc4
	vSCUCqM4Gh5kO9leuk21HSn7x5QA2jHmqcuE9fiZb1wIKSBJPn7oypp/mnU2gHHKiS5SqMKuLDdLe
	8OBEWz3Q==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8yUc-0000000FpGq-26qt;
	Mon, 20 May 2024 08:35:38 +0000
Message-ID: <d8c56e37-38c6-454e-81be-a574b42c83be@infradead.org>
Date: Mon, 20 May 2024 17:35:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Geoff Levand <geoff@infradead.org>
Subject: Re: CVE-2023-52665: powerpc/ps3_defconfig: Disable
 PPC64_BIG_ENDIAN_ELF_ABI_V2
To: Michael Ellerman <mpe@ellerman.id.au>, cve@kernel.org,
 linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
References: <2024051725-CVE-2023-52665-1d6f@gregkh>
 <87zfslufoo.fsf@mail.lhotse>
Content-Language: en-US
In-Reply-To: <87zfslufoo.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 16:04, Michael Ellerman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> Description
>> ===========
>>
>> In the Linux kernel, the following vulnerability has been resolved:
>>
>> powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2
>>
>> Commit 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian
>> builds"), merged in Linux-6.5-rc1 changes the calling ABI in a way
>> that is incompatible with the current code for the PS3's LV1 hypervisor
>> calls.
>>
>> This change just adds the line '# CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not set'
>> to the ps3_defconfig file so that the PPC64_ELF_ABI_V1 is used.
>>
>> Fixes run time errors like these:
>>
>>   BUG: Kernel NULL pointer dereference at 0x00000000
>>   Faulting instruction address: 0xc000000000047cf0
>>   Oops: Kernel access of bad area, sig: 11 [#1]
>>   Call Trace:
>>   [c0000000023039e0] [c00000000100ebfc] ps3_create_spu+0xc4/0x2b0 (unreliable)
>>   [c000000002303ab0] [c00000000100d4c4] create_spu+0xcc/0x3c4
>>   [c000000002303b40] [c00000000100eae4] ps3_enumerate_spus+0xa4/0xf8
>>
>> The Linux kernel CVE team has assigned CVE-2023-52665 to this issue.
> 
> IMHO this doesn't warrant a CVE. The crash mentioned above happens at
> boot, so the system is not vulnerable it's just broken :)

As Greg says, with PPC64_BIG_ENDIAN_ELF_ABI_V2 enabled the system won't
boot, so there is no chance of a vulnerability.

-Geoff


