Return-Path: <linux-kernel+bounces-417895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A939D5A61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BEE2817D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3EB18A937;
	Fri, 22 Nov 2024 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cwHfXc5E"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0918A6D8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261881; cv=none; b=pUcUJwThlBdaJniKKFcHDzHAmGLgypN1uV4yNntUx+dvwhuzcLbJaZjERBQv5/FFvQQ2XiYiBrkFWjMAlzsK4sZyRHUy+1MpXvgiXvGGL1NmxP0TRu7r/wSKorngCbUD84bYlysBXJ/DdY0GoCWpKQNxoH8wXiPMvOIles7zxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261881; c=relaxed/simple;
	bh=Pp4vjzI8g2zeRewP2kaq94YshgK8PAaV37b628S2CCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R84qSIDtPqMSpifQz5orOhBaaylKH6Ren5kjQOdUR26HpCzxvg+w6yz1hLKFDtN145luGPw9Bey5711ROFDlmAVE6IWtQe6ZPyNM5Hd/XPUIwwNKI0BHz2WSwGoETjs5nS6ZpJ3lbDY6+5URKScrazIURRq0lxtOkJOpk4IhPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cwHfXc5E; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AM7odLq3734148
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 21 Nov 2024 23:50:40 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AM7odLq3734148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732261841;
	bh=I66Y0ogXe2Y+oLaMEKtiWr5xlXwESFW9B/1yYDglERs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cwHfXc5E0DhXwusjqedDe2eFiC6FuL44xfChPzutUgiY+bi8E5oqUDqlUbqTgY4m3
	 rXtVawFIlLmcdHHeyHbbM041rWNIvUS9jL23eMYB/3ZsKrNsbFckW74gyW2JwqXZUB
	 yuBKUuA1ZIkBa8wsEBxA11AxPzmZeJMriFa08vXqQCRua+YsSS5H5FZwQ23KyUSHSX
	 Yl+S2yewB8Cw2riDXfduvK9y/JzZFODjnleWFY2zzVbdWiOamaUT8Lz74Uq4gMX93F
	 msq6IgrBOi7YmaJ93q13qD+FrNAPfGTTDTvFp34Q2dxwbbbMF8rs7MUroXWI9/BpgX
	 ivAWVmaY3bIwg==
Message-ID: <01a56916-41a1-4229-9786-5334c0c0074e@zytor.com>
Date: Thu, 21 Nov 2024 23:50:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/ia32: Leave NULL selector values 0~3 as is
To: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        brgerst@gmail.com, ebiederm@xmission.com
References: <20241121175446.3481862-1-xin@zytor.com>
 <029284c6-f103-46e0-9acd-9e9e816e7ffb@citrix.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <029284c6-f103-46e0-9acd-9e9e816e7ffb@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/21/2024 11:43 AM, Andrew Cooper wrote:
> On 21/11/2024 5:54 pm, Xin Li (Intel) wrote:
>> As such, leave NULL selector values 0~3 as is.
>>
>> Do the same on 32-bit kernel as well.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> 
> As far as fixing up RPL goes, I think the patch is fine, and probably
> wants to be taken in roughly this form (new minor points below).
> 
> However, the pre-existing code is doing something entirely bizarre,
> which warrants further investigation, and maybe fixes.
> 
>> + * a nonzero NULL selector and waiting for it to drop to zero.
> 
> I know I wrote "drop to zero", but in hindsight, I think "become zero"
> would be better.

Sure.  They both look good to me, but I'm not a native English speaker,
so it doesn't count :-P.

> 
>>    Before FRED
>> + * there is nothing we can do to prevent such an information leak.
>> + *
>> + * ERETU, the only legit instruction to return to userspace from kernel
>> + * under FRED, by design does NOT zero any segment register to avoid this
>> + * problem behavior.
>> + *
>> + * As such, leave NULL selector values 0~3 as is.
>> + */
>> +static inline u16 usrseg(u16 sel)
> 
> I would suggest naming this fixup_rpl() which is a bit clearer as to its
> intent.

The rename makes sense.

> 
> However, I would also recommend u32 (or at least, unsigned int).
> 
> It's absolutely marginal, but you do get better code generation by
> avoiding u16 specifically where possible.
> 
> https://godbolt.org/z/MnnvW461f

Oh, you created a live sample, I appreciate it!

> 
>> +{
>> +	return sel <= 3 ? sel : sel | 3;
>> +}
>> +
>>   #ifdef CONFIG_IA32_EMULATION
>>   #include <asm/unistd_32_ia32.h>
>>   
>> @@ -41,17 +64,17 @@ static inline void reload_segments(struct sigcontext_32 *sc)
>>   	unsigned int cur;
>>   
>>   	savesegment(gs, cur);
>> -	if ((sc->gs | 0x03) != cur)
>> -		load_gs_index(sc->gs | 0x03);
>> +	if (usrseg(sc->gs) != cur)
>> +		load_gs_index(usrseg(sc->gs));
>>   	savesegment(fs, cur);
>> -	if ((sc->fs | 0x03) != cur)
>> -		loadsegment(fs, sc->fs | 0x03);
>> +	if (usrseg(sc->fs) != cur)
>> +		loadsegment(fs, usrseg(sc->fs));
>>   	savesegment(ds, cur);
>> -	if ((sc->ds | 0x03) != cur)
>> -		loadsegment(ds, sc->ds | 0x03);
>> +	if (usrseg(sc->ds) != cur)
>> +		loadsegment(ds, usrseg(sc->ds));
>>   	savesegment(es, cur);
>> -	if ((sc->es | 0x03) != cur)
>> -		loadsegment(es, sc->es | 0x03);
>> +	if (usrseg(sc->es) != cur)
>> +		loadsegment(es, usrseg(sc->es));
>>   }
>>   
>>   #define sigset32_t			compat_sigset_t
>> @@ -113,10 +136,10 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
>>   	 */
>>   	reload_segments(&sc);
> 
> This is the singular caller of reload_segments(), and the comment out of
> context does not match the implementation.
> 
> It probably wants inlining just so all the segment juggling is in one place.

So move the comment (C&P below) above invoking reload_segments(&sc) into
the function definition?

	/*
	 * Reload fs and gs if they have changed in the signal
	 * handler.  This does not handle long fs/gs base changes in
	 * the handler, but does not clobber them at least in the
	 * normal case.
	 */

> 
>>   #else
>> -	loadsegment(gs, sc.gs);
>> -	regs->fs = sc.fs;
>> -	regs->es = sc.es;
>> -	regs->ds = sc.ds;
>> +	loadsegment(gs, usrseg(sc.gs));
>> +	regs->fs = usrseg(sc.fs);
>> +	regs->es = usrseg(sc.es);
>> +	regs->ds = usrseg(sc.ds);
>>   #endif
> 
> Why is GS handled specially?
> 
> Both, 1) Why is regs->gs the only value that doesn't an RPL-adjusted
> value, and 2) why do we need to reload it here?  We need to keep it as
> the per_cpu pointer anyway, and we're going to reload on exit-to-user,
> aren't we?

> Also, why do we have such wildly-different behaviours depending on
> IA32_EMULATION or not?

Maybe because 32-bit exit code skips popping gs?

And 64-bit exit code doesn't load segment registers as 32-bit does.

Thanks!
     Xin

