Return-Path: <linux-kernel+bounces-521029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D921A3B2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912A7188D156
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B51C4A13;
	Wed, 19 Feb 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KxGzQ00f"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74351C3029
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951755; cv=none; b=Ms8suKa7fuMlScNVDU2LH3LDZd8o/2SFUDH3kKNvVXTaEbSSwHakgtE7D+MzUm6BM06qes/bCRkkeTaBxGcBOog+BAsnHVAxho5xn6FxrmjrMYgW+y3C++gCIxrbLKIIc0OJ+QA7hBdZN0aA9KZ3jDXHNi420sMFUVbSFnQ6EZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951755; c=relaxed/simple;
	bh=UH32YQGrhQ8zsuamSIzMy12L0Zs1MOTArM5Sj6UWIbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZTX+POiNnQ8Br9asVaa1OBaIA28MLKHWdlH7nQTBb10GiypXgtg+HsPvVCu3Mmhj2PUYxj4AhQv7S0qiqf4CmEsQXnjeo+oF93/ZEGHKdprO1KR9ExXnejISEbBJyO3VXJ229xZI5xxBJ/Ze1DCJXJQz68vqjwixh339rMf41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KxGzQ00f; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51J7tMhO1653376
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Feb 2025 23:55:22 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51J7tMhO1653376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1739951723;
	bh=oDgZq7gWYayOHoGByNh18uQgQ/WetppPuukdDrLGmII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxGzQ00fjj4NMMFTj0STMg35dePQevrF3uI1L3l8h6Ch6qMpUVknic1Pa7Ho6tdpq
	 kJRqyNg9eBE1FumsT2aDoih3OASlw6943L0Ly/+rGM/rqafDgW1aj0bs3zy8wCENvt
	 zaBHeJ99hJLOgGO55gQZngzYR7PomAo6uK5Pi/NMX2DXYxdmqpUxHCG0CMsHNiKfqJ
	 sm/B8BshZR8VdjI7NitHPFbI2uIGRqZA+DaB/DIjEnobALNK0OR3FdCM7I816GCG95
	 6DXEFloZrSATNt1W0lEQjiwwgwO4kQa/U5efLvOr2CuwZ78fZyQbekjuDamfs5cHhD
	 qiInNBCzs0kqg==
Message-ID: <cace0bfa-2de7-431b-9b4d-fd8ca5e7873d@zytor.com>
Date: Tue, 18 Feb 2025 23:55:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] x86/ia32: Leave NULL selector values 0~3 as is
To: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        brgerst@gmail.com, ebiederm@xmission.com
References: <20241126184529.1607334-1-xin@zytor.com>
 <fa3d0093-818d-4592-8415-3c2e287cc3e6@zytor.com>
 <36970ddb-c0d8-43e4-a94e-0d9ea3d55ced@zytor.com>
 <eb5f75e3-0882-4baa-be32-f363a8e411d8@citrix.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <eb5f75e3-0882-4baa-be32-f363a8e411d8@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/2025 6:01 AM, Andrew Cooper wrote:
> On 14/02/2025 6:56 am, Xin Li wrote:
>> On 12/12/2024 10:44 AM, Xin Li wrote:
>>> On 11/26/2024 10:45 AM, Xin Li (Intel) wrote:
>>>> The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
>>>> and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
>>>> GDT, selector values 0~3 all point to the NULL descriptor, thus values
>>>> 0, 1, 2 and 3 are all valid NULL selector values.
>>>>
>>>> When a NULL selector value is to be loaded into a segment register,
>>>> reload_segments() sets its RPL bits.  Later IRET zeros ES, FS, GS, and
>>>> DS segment registers if any of them is found to have any nonzero NULL
>>>> selector value.  The two operations offset each other to actually
>>>> effect
>>>> a nop.
>>>>
>>>> Besides, zeroing of RPL in NULL selector values is an information leak
>>>> in pre-FRED systems as userspace can spot any interrupt/exception by
>>>> loading a nonzero NULL selector, and waiting for it to become zero.
>>>> But there is nothing software can do to prevent it before FRED.
>>>>
>>>> ERETU, the only legit instruction to return to userspace from kernel
>>>> under FRED, by design does NOT zero any segment register to avoid this
>>>> problem behavior.
>>>>
>>>> As such, leave NULL selector values 0~3 as is.
>>>
>>> Hi Andrew,
>>>
>>> Do you have any more comments?
>>
>> Hi Andrew,
>>
>> Are you okay to give a review-by to this patch?
> 
> Apologies.
> 
> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>

Thank you very much!

Thanks!
     Xin


