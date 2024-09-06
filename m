Return-Path: <linux-kernel+bounces-319027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4096F6A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52213B21608
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962661D04B6;
	Fri,  6 Sep 2024 14:26:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBFD1C7B9B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632797; cv=none; b=hNq0qKIG59mx9mPMDZyus0I92aZDSJlzDddN36I3q4FrWgFZEPZT8meFdRIdpCHNrRCWo5KF6f7lfZgaSMMvFBluuBWS0DDJ17b3xfdUSCrsMhFD0EHUD1zCOOcl+3yN37AYZAqpmAyRMe0hJycHhjSQU5nqRiKjMez/vjy5LgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632797; c=relaxed/simple;
	bh=F4y2He1YIui1adjE5+pCswrIKa0N1YfFjGMhhQ7dn9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/Tz6G+zOI2VAdbjaKiOqiNf2C9hE7cY/XvCpJwFkv3J6G8Iovh2UJYfmJdypyMgwfgY8LSa/JRdHjh8OWvEom6d/Vwc7ExfvdELVMCe7WkHbtUsUfhnKwjUG6bpqIdrOvPky20dq/Cw0+mCSgVBg+fpUhp7+qRaRg2xvPtY3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0dp11cClz9sRs;
	Fri,  6 Sep 2024 16:26:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3VYKC4BIXjqc; Fri,  6 Sep 2024 16:26:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0dp10qrzz9sRr;
	Fri,  6 Sep 2024 16:26:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CE838B778;
	Fri,  6 Sep 2024 16:26:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id zRHVVnzg8rQx; Fri,  6 Sep 2024 16:26:32 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A024F8B764;
	Fri,  6 Sep 2024 16:26:32 +0200 (CEST)
Message-ID: <795db5f1-c266-4fb3-a51b-c2b3745d334b@csgroup.eu>
Date: Fri, 6 Sep 2024 16:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Fixup for 3279be36b671 ("powerpc/vdso: Wire up
 getrandom() vDSO implementation on VDSO32")
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrei Vagin <avagin@gmail.com>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
 <ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu>
 <ZtsMpcV7iLYoytdJ@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtsMpcV7iLYoytdJ@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/09/2024 à 16:07, Jason A. Donenfeld a écrit :
> On Fri, Sep 06, 2024 at 10:33:44AM +0200, Christophe Leroy wrote:
>> Use the new get_realdatapage macro instead of get_datapage
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/kernel/vdso/getrandom.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
>> index a957cd2b2b03..f3bbf931931c 100644
>> --- a/arch/powerpc/kernel/vdso/getrandom.S
>> +++ b/arch/powerpc/kernel/vdso/getrandom.S
>> @@ -31,7 +31,7 @@
>>   	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
>>     .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
>>   #endif
>> -	get_datapage	r8
>> +	get_realdatapage	r8, r11
>>   	addi		r8, r8, VDSO_RNG_DATA_OFFSET
>>   	bl		CFUNC(DOTSYM(\funct))
>>   	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> 
> I tested that this is working as intended on powerpc, powerpc64, and
> powerpc64le. Thanks for writing the patch so quickly.

You are welcome.

And thanks for playing up with it while I was sleeping and getting ideas 
too.

Did you learn powerpc assembly during the night or did you know it already ?

At the end I ended up with something which I think is simple enough for 
a backport to stable.

On the long run I wonder if we should try to find a more generic 
solution for getrandom instead of requiring each architecture to handle 
it. On gettimeofday the selection of the right page is embeded in the 
generic part, see for instance :

static __maybe_unused __kernel_old_time_t
__cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
{
	__kernel_old_time_t t;

	if (IS_ENABLED(CONFIG_TIME_NS) &&
	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
		vd = __arch_get_timens_vdso_data(vd);

	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);

	if (time)
		*time = t;

	return t;
}

and powerpc just provides:

static __always_inline
const struct vdso_data *__arch_get_timens_vdso_data(const struct 
vdso_data *vd)
{
	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
}


I know it may not be that simple for getrandom but its probably worth 
trying.

Or another solution could be to put random data in a third page that is 
always at the same place regardless of timens ?

Christophe

