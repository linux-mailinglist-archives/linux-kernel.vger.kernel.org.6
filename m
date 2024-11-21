Return-Path: <linux-kernel+bounces-416525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD7C9D4662
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8311F22202
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3F481B3;
	Thu, 21 Nov 2024 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Xi57tlpi"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB12309B2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732161331; cv=none; b=PnBqwnZNUJynYjFdTCn5RHxM5veHEckznBIC5yaEGpSxsT46tyNno6FIYLmxn9g2y87Al+fIjXsIeYWxvtlsI29NYS77lcbEmIR4D+bi+2QyA9AG1nareeSmtjsZPVnJ6dMSeoMTpytyuhEYBLA4oTlFUZlJPp68bXJtwo42IP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732161331; c=relaxed/simple;
	bh=8ZdPbwl61M7NNLaBpphYnWiwmQDRePEwBFPRVKjychA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Svh9t9/xuR4RO0fIFiKpg8U8wviLkJ/+GerbwHxDugSykdAUpybiwh/RFpkAz2PaDwejZn0E6rWxFZ07hrllFj0v8PUCekevQiI51CSkXWjP3s/p7+nHoXhBG3g71ou429DB9PGu99pss7xjdQwRk0YRqGR1lhx3W16Mx7YQHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Xi57tlpi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AL3ss7S3214674
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 20 Nov 2024 19:54:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AL3ss7S3214674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732161296;
	bh=eNpIWAVSPuJ9z3Qxs7EjNS1AfRycIpF54tkvNS9sC08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xi57tlpiBFBOhbnzMJ0jU6+FuQq+DvGWlGmsxODBrLcR0YJXVfXq0KX1tza748eXI
	 uKZTHMZCcgjxEgLUncdytEsm1c1VHFZmT6XPU1QoKn3cl1ztPyqg4ncwukr+PPQAgx
	 vSqnMDViI9t96/Ux2Q7xi/dlT53Q4D34XVqdlmPdol42HRDUWj1koC+isMQ/jeUEPu
	 IuUNvweu8ovU1DuJx1HeQ8GCJQ7abEM1abB2NCIfKKBShxdauSAFeuOEnl08qNaESW
	 ke9lDUsuCJC0e4Z0iy7BmEAq80d3PBqeB/2ANOaBWE82gCrr6WYjq9f62Rd/kNgt9x
	 TNmT2xa8C+/Hw==
Message-ID: <3ff385ea-0b7a-441f-9905-4aad54c7575d@zytor.com>
Date: Wed, 20 Nov 2024 19:54:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/ia32: Normalize any null selector value to 0
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20241120081721.2838905-1-xin@zytor.com>
 <3680972b-1871-4c92-9f61-c28ef7c10a4c@citrix.com>
 <b6f8fb05-057f-4531-b03b-839374ac9dc0@zytor.com>
 <7b819c31-1972-44e0-87c7-1d11ac13f530@citrix.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <7b819c31-1972-44e0-87c7-1d11ac13f530@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/20/2024 11:34 AM, Andrew Cooper wrote:
> On 20/11/2024 7:09 pm, Xin Li wrote:
>> On 11/20/2024 1:33 AM, Andrew Cooper wrote:
>>> Right now, this change is codifying the problem behaviour we were trying
>>> to fix out under FRED.
>>>
>>> Under FRED, if userspace loads e.g. 2 into a selector, it should remain
>>> 2 until userspace changes it to something else.
>>
>> Okay, I will fix it by:
>> 1) For null selector values, do nothing.
>> 2) For non-null selector values, set RPL bits.
>>
>> sounds okay?
> 
> Yeah, that sounds okay.

Actually this is what v1 does:

https://lore.kernel.org/lkml/20230706052231.2183-1-xin3.li@intel.com/

But obviously I need to rewrite the change log.

> 
> The selftest ought to work under FRED, but it was speculative coding.  I
> can't rule out that tweaks might be needed.

The v1 makes the test happy with both IDT and FRED.

Thanks!
     Xin


