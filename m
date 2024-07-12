Return-Path: <linux-kernel+bounces-251023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589792FFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7A1283133
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F3176AD4;
	Fri, 12 Jul 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L/YySgvg"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C8E43AA9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806110; cv=none; b=bQtLwud9FWEv/P0DJjJbJIW081s/OhRweY/1aGzRkQsjSHwlTI73GlNW8C2SL6VfXYoHKYCzj075I09ayNvmpjKzn6CV7NQej73EWcMRfmvdN/NVfO/EoM+5x5Lj9kf1s46Wwf7PvORqXfL2y3fv9TpJAS6nfkXRJVpgJmbJD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806110; c=relaxed/simple;
	bh=sOx2tSu8bAAxd9gUAzNhIGOVI80chdfx8Kmj7OkUkO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilso52reLRCduaJUPGOPeu6h6XS0bsyDaF2TidcSMP2U+gFysGwAc9GE1d1BZGOpNO0t8ZAUib5NXSOi6XlzIjnmZ6Xw8AGYxppHY02rr5bWbZYimXLtDZKTj1E3rfV0IvPAToktXkcwkJl7GPFJtu6LV73oEbTjNb88TIa64kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=L/YySgvg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46CHenq0833720
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 12 Jul 2024 10:40:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46CHenq0833720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720806051;
	bh=3UddBCGt69gXwnvB0CfhxeJthTDv9tUqrGz7FvodAc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/YySgvgRGoUVSk4bxDAdYYTzQmVs++/qjN74kRvBkawQ4jO2R0EoXxPteff7PxKG
	 P1IyEjSPRlKhfcTc6QyOFbEDvUJjORY0ChRbqqy7s499ISfuFLwpaSCWMx6l400UGS
	 ysgda1m8Y3/PCGnhUGlHCShOZyZjj3VZhKVx3v50L6X7owkpufUu85JU3+K7+qqkHk
	 fCiHH5Lhmztm/TCG+HL2j53j0Ix0qwfmHUZ6iEUHEbIBdrMxpql5D2OgPxGyDHKA9i
	 AOG0ohWRvdedVhTPGmKcv9y1AB0b1Lxb7dvL64mZaDxYwFiM3cy2Z7ZrWswu9KDgSA
	 0proXA2dtqt0w==
Message-ID: <7fad52e6-83cf-4c17-9b3f-4dfa087f8fc4@zytor.com>
Date: Fri, 12 Jul 2024 10:40:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/fred: Parse cmdline param "fred=" in
 cpu_parse_early_param()
To: Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, houwenlong.hwl@antgroup.com
References: <20240709154048.3543361-1-xin@zytor.com>
 <20240709154048.3543361-2-xin@zytor.com>
 <98b2d56f-767f-4074-a9f2-4d993880e2a5@suse.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <98b2d56f-767f-4074-a9f2-4d993880e2a5@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/2024 11:53 AM, Nikolay Borisov wrote:
> On 9.07.24 г. 18:40 ч., Xin Li (Intel) wrote:

>> @@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
>>       if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
>>           setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
>> +    /* Minimize the gap between FRED is available and available but 
>> disabled. */
>> +    arglen = cmdline_find_option(boot_command_line, "fred", arg, 
>> sizeof(arg));
>> +    if (arglen != 2 || strncmp(arg, "on", 2))
> 
> I'm confused why you keep perverting the calling convention of 
> cmdline_find_option. The doc clearly states:
> 
>      * Returns the position of that @option (starts counting with 1)
>      * or 0 on not found.  @option will only be found if it is found
>      * as an entire word in @cmdline.  For instance, if @option="car"
>      * then a cmdline which contains "cart" will not match.
> 
> You should only care if arglen is non 0, which if it is you check if its 
> value equal 'on', why bother with its starting position?
> 

Well, just look at how it is used in match_option() in
arch/x86/kernel/cpu/bugs.c and arch/x86/kernel/cpu/intel.c.

This is a short version and it will be expanded once we have more
option strings well defined (match_option() should be a common lib
function then).


