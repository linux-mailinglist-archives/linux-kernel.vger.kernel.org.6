Return-Path: <linux-kernel+bounces-416238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D29D425C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44BF1F2275C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62871ADFE8;
	Wed, 20 Nov 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SabLPcUW"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EA158558
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129787; cv=none; b=jmoEKCjIkwylRcs/owMmT7CLV+N67nXvuGocfNzGOpQ5u3/oo8Nc//F3K++evBOiwAnKIMqjrIJaRYI5ljlD4iD8UEybIDEqR/t/8qbTlsVKjDwOVJx6oAN6tkd0QVepHD5e0CohXGpY7xu9dXqn8VZxROKMtQ0nNyBwQFtE1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129787; c=relaxed/simple;
	bh=8Z+8Zlb4fOywu8BWk72aohDsFUVJWvUj7+y551bIxsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YY6UD5LElIxYtp2RFCxiNma+TpSXqHCsuTNR0yScmlpEuKG61eMJx20miAofV4LczC1AQpX5dk94w+19QgADa+0ZYoF0eGozpjxmPc0ToQOiThf6T0ZE8p0Xdp5l2mkYhSi2BQvzZhC+GsJjLtBlYECeZJNiOpiqMYxBiv6YUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SabLPcUW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AKJ99sZ3054835
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 20 Nov 2024 11:09:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AKJ99sZ3054835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732129751;
	bh=jnxIc+H4lsli1hzPoqWgN/b6Ogs3xNRwg78NMrxzwA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SabLPcUWld76K1G7ZE/zm8fgpW8TmvtzuM+Yp9XIU08/0VyM0WL9wocjdpVLFw4mj
	 JNt9k+opp0pcop0iM1Z6Kd3Ln6+firEKPjbUUVxVhuE56b3tByL4yZSed/YN1EyJia
	 HilOH8P5Ij/90kF2jZGRgpwQXvcF6gaBvxGuFCJRDaB2aOX+yjqcQPaszLycv2car7
	 DaKlPhx0f/Cs1r2fnCMehMqEjOyTkWqsBckwv2rlE31DM0UQfxQlg7UVWlpztvzgk1
	 2VsPYjZIaTL9FqfAYOYeNz7ur/sCwdjHLpmI8bcGGs3j/1918Nm4QRauLxqxGk3tWB
	 oiGgknSo6B0iA==
Message-ID: <b6f8fb05-057f-4531-b03b-839374ac9dc0@zytor.com>
Date: Wed, 20 Nov 2024 11:09:09 -0800
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
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <3680972b-1871-4c92-9f61-c28ef7c10a4c@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/20/2024 1:33 AM, Andrew Cooper wrote:
>> The first GDT descriptor is reserved as 'null descriptor'.  As bits 0
>> and 1 of a segment selector, i.e., the DPL bits, are NOT used to index
> 
> That's RPL in segment selector, not DPL.  Same correction is needed in
> the code comments.

Intel SDM says:

• Descriptor privilege level (DPL) field —
   (Bits 13 and 14 in the second doubleword of a segment descriptor.)
   Determines the privilege level of the segment.
• Requested privilege level (RPL) field —
   (Bits 0 and 1 of any segment selector.) Specifies the requested
   privilege level of a segment selector.

I got lost somehow.

> 
>> GDT, selector values 0~3 all point to the null descriptor, thus values
>> 0, 1, 2 and 3 are all valid null selector values.
>>
>> Furthermore IRET zeros ES, FS, GS, and DS segment registers if any of
>> them is found to have any null selector value, essentially making 0 a
>> preferred null selector value.
> 
> Zeroing of RPL in null selectors is an information leak in pre-FRED
> systems.  Userspace can spot any interrupt/exception by loading a
> nonzero NULL selector, and waiting for it to drop to zero.
> 
> Userspace should not be able to do this; Andy and I lobbied for this
> during the design of FRED, and Intel agreed.

I wasn't aware of this, and hpa just told me you're right :)

> 
> Right now, this change is codifying the problem behaviour we were trying
> to fix out under FRED.
> 
> Under FRED, if userspace loads e.g. 2 into a selector, it should remain
> 2 until userspace changes it to something else.

Okay, I will fix it by:
1) For null selector values, do nothing.
2) For non-null selector values, set RPL bits.

sounds okay?

Thanks!
     Xin

