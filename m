Return-Path: <linux-kernel+bounces-229309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27132916E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1261F21CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EE172BD4;
	Tue, 25 Jun 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="McAkBl8D"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284814A0B8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333083; cv=none; b=eINOwOmqBFheeon1G6/UelnkWc96JmYvwtmapnWeHYpSe4JrLEqO3zsfcpC52xAjMckJevjS99hVzCV7vFhIdKw4u0jGmZnlxKb7W5MWg/GaMcAbe9n4mRPa3BQr+gfv4KXZbfZinmbsHp/8UXiRt/6/V4MLoFieUfpDhyCKddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333083; c=relaxed/simple;
	bh=EWQpw7Koqt3pHfpydVh4GskFhDD48UNUJFPLIDdBiig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocgMBcd5flGJoDjP1IfQ6xEmLvIkb6DzJjxXepJ6mugDu7CCQlqwMUT3jzHNtBjQqm1y8Lk1Bs8xyaxN2Rb27zFZgUwDz4n6+SHbrhvbf6lu8SLG9FrKb7LKtWlD15DTNWgJP64LQwNBdg3bP5t0sp75AJACeFP8g9i94oE5opY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=McAkBl8D; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45PGUgsX1688982
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Jun 2024 09:30:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45PGUgsX1688982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719333044;
	bh=ohRZuRmXuCMnbSrlqCKHhdDWHJ6qBZLMsfQjHOQ2yi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=McAkBl8DFBOem9sQSndHlxFAIHarS+JoTVvgBvteyMLP2SrfA+DYIXK1FXVopZA3H
	 KhQ1YO0aPwGu8W1Fh6tUZPS78vnoFlhPhAutzdyVEPQOo+x/gSUfWO66lV0kUZ+RYm
	 lPuTB2hR+rZ3jqYlBWI4klatR7VM5bAqmO/3Ap639u8ZwP/IVxN0FO2AyrpAsb9AwO
	 nurMuPrZMPRnwPpczDDop/EBYi63Xw5+131ihJflsDzfYCOEUqHSLdvWEzhV3/urYc
	 oZo5bI6DAQS4ioMigGLMEheeYgGtDud+eeb/AVOcWOs/w+7Qiy8BMWlVEd+fz68hQA
	 60dyo8kVAomrQ==
Message-ID: <49c53a1a-55b2-441e-8ec2-1a2d87a3ccc4@zytor.com>
Date: Tue, 25 Jun 2024 09:30:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
To: Thomas Gleixner <tglx@linutronix.de>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com> <87jzid5hmb.ffs@tglx>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <87jzid5hmb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/2024 5:31 AM, Thomas Gleixner wrote:
> On Tue, Jun 25 2024 at 02:19, Xin Li wrote:
>> On 6/21/2024 6:12 AM, Hou Wenlong wrote:
>>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>>> index d4f24499b256..daee9f7765bc 100644
>>> --- a/arch/x86/include/asm/idtentry.h
>>> +++ b/arch/x86/include/asm/idtentry.h
>>> @@ -470,8 +470,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
>>>    #define sysvec_install(vector, function) {				\
>>>    	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
>>>    		fred_install_sysvec(vector, function);			\
>>> -	else								\
>>> -		idt_install_sysvec(vector, asm_##function);		\
>>
>> empty line, it improves readability.
>>
>> And please put a comment here to explain why this is unconditionally
>> done for IDT.
> 
> Wait. If we need this during early boot, then why don't we enable FRED
> earlier?

Unconditionally call idt_install_sysvec() is still needed, right?

But this sounds a smart move to me!  Because it helps to deal with not
only the initialization order issue, but also the following cases in a
longer term:

1) BIOS enables FRED and keeps it enabled when transferring control to
    Linux.  Then we just need to disable FRED when it is disabled in the
    kernel command line.

2) IDT support is removed from a kernel config thus a kernel binary, say
    a new kernel config CONFIG_X86_IDT is added and set to N.

And we need to:

1) Find a place to enable FRED as early as possible if not yet enabled.

2) Disable FRED when fred=off is in the kernel command line.

Anything I missed?

Thanks!
     Xin

