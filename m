Return-Path: <linux-kernel+bounces-236725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C291E651
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C33B21500
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208C16E87D;
	Mon,  1 Jul 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MPCtIgl5"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1016B75B;
	Mon,  1 Jul 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854055; cv=none; b=iKcLazBlV/lAeetwh8AtLg4fmU2rUcXkO7p8joY95pH+Pu6PGLz5j790tRfU8T+TPrStP1PZkTitHqQsEdUlfjm9gzsN4ED6XkCf3L2NBTS93PrWE4CpEL0ZagBVDq6H06eucKOTErasZKA4n8Qb6PUgrl/Z5QZLOoDEucQaA5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854055; c=relaxed/simple;
	bh=2eM0IWCPfi0UleNKIJSytKfnwXJJDTEI6nnVwtMMiDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqtI62caGKbnxO4nXUfe5rFGCqoEgtQLvUhfYSWNm/hZSBJOBPIXX1bQsVBCgphPciAYf+oRdSbZLgltAxr6H46blibWms0j5rxJpJ5xC8EuNJFcZIMGFB6E1K4B1zSMRmIDDbsHMvBtivSsTNEB46uxb/T+AYJTZbZRtv1/704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MPCtIgl5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 461HDh7s205329
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 1 Jul 2024 10:13:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 461HDh7s205329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719854025;
	bh=Jsm8Jgqufv652gfaChqBGeBgH76qq98qTkYkJqe2wdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MPCtIgl5dncYd3LOeaV8pDR98lLp5gxcut9QCmYY31IrOUfgA0Qy+wXx3i2RbjaMj
	 fn23T6LIVQXU4GaNd/u80M8f/xTM5zxYJGMI8OhwwGdFndWPwretm6hHgMvZgPiv6G
	 Y+lHI+RKYWuG7CK+BmOIyNo5BEsCdZGu/JuT1po9YD3+TSuXqLyippTM1mF4Vjb3Ul
	 l6LC6fmp4JLkbelAGIcz5sONHPxRPwk2Eul499+ksKHRygJ+I2dkgmmWdTunsvBVve
	 eblpiJkKLNurE+BOIynDkaysCXnCbMOt8H8/j5JpUnMFzRJO5ze3iCVHrROrMx/M46
	 zMl/nTW88doIQ==
Message-ID: <37fbf57e-8f3d-447c-acf8-c1485c490b76@zytor.com>
Date: Mon, 1 Jul 2024 10:13:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] KVM: X86: Use common code for PV IPIs in linux
 guest
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
        kan.liang@linux.intel.com, Andi Kleen
 <andi.kleen@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Zeng Guang <guang.zeng@intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
 <20240628201839.673086-12-jacob.jun.pan@linux.intel.com>
 <ca060eaf-0ace-4a8e-af86-a45b6f32340e@zytor.com>
 <20240701093847.3f875868@jacob-builder>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240701093847.3f875868@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/2024 9:38 AM, Jacob Pan wrote:
> 
> On Sat, 29 Jun 2024 11:38:10 -0700, Xin Li <xin@zytor.com> wrote:
> 
>> On 6/28/2024 1:18 PM, Jacob Pan wrote:
>>> Paravirtual apic hooks to enable PV IPIs for KVM if the "send IPI"
>>
>> s/Paravirtual apic/Paravirtualize APIC/
> 
> Paravirtual APIC makes sense to me. This is also the same language used in
> previous commits.

"Paravirtual apic hooks to enable..."

It needs to start with a verb, I can't read it as adj.

> 
> How about:
> 
> "The paravirtual APIC hooks in KVM, some of which are used for sending PV
> IPIs, can reuse common code for ICR preparation. This shared code also
> encompasses NMI-source reporting when in effect."

LGTM.

> 
>>> hypercall is available. Reuse common code for ICR preparation which
>>> covers NMI-source reporting if in effect.
>>
>> I see a lot of "NMI source". Should we use "NMI-source" in all places?
> Not really, here NMI-source is a compound modifier before noun "reporting".
> 
> For other places, hyphen(-) is not needed if it is just a noun. e.g.
> "partial due to unknown NMI sources"
> 
> I will go through the patchset to make sure they are consistent.

Right, make them consistent.


