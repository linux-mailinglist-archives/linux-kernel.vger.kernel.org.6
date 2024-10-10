Return-Path: <linux-kernel+bounces-358633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A869981C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5961C24472
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24221BBBE4;
	Thu, 10 Oct 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbLzXC0Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhnbZ+GF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70EBE6F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551551; cv=none; b=aa3lU4dITNC3f257iFCDl0F8l03taPOyq93iVfnQoXdi5uQZK34aZ0yPiH1eB/4TO3HA9qNfimNEqtIzRIFKWXJQDm5+zyZM14lEMP+q4BmlJnKMYE0UY6tbi8+mEMmQEgX+kijq62Tv0FfDdoIiWAGTLx8AfUfQiGGKwqRzNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551551; c=relaxed/simple;
	bh=LSKVmkXpP5GXmWjHNG72Tg6s7mGs2ymCpdDE52Zim/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY/dOJ9ouG+Ty9bJevTh5O2SWV/hH49zV3Vf9Bltjghbo7yQkeHOnjuYqXpcvBQSe54ZjRsRK1Va/cfb/80OR7UMq5GmofQnwJjtu42TZn5+7xML+grKp5ufePMAxSiN51LkxoyMvqql5jTOLkbOwixHG8dbSnAyERCKUG6kazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbLzXC0Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhnbZ+GF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 11:12:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728551547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9WvqSSuYngn3X8rooA70RyvWXYKx86qbC9FBxuI7Xw=;
	b=LbLzXC0YXMyWzsBumaCTMWHZ/56y8B/zeoF8uML7fGq2ZQQP+yMhFykhySr/gC6VkgO0y1
	B4juL1gyKX7KfSrl90xPE8t7/P1W4GPxHOTt4omAhnzlQdSzo+eWeZn1XjFzoPK8OGQ7Qa
	U3pCRH/8T0DBJW2FIHlofLDwNlbJ+ttss2a5XjnKaev9RYxNt4IvcLgnzMmb6ESu/SFdGa
	Bpvr5eIenVnajVUxFEnqXhDrUvV48B7+1cwwmU2rL4HHEY6jvX1cfzqxBRETTJWzrLohut
	okG9tWgFseXy4HK2bST0Uafusd1/iASAFAE/wUgacOJP6oAZFPY+gu8SVcle2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728551547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9WvqSSuYngn3X8rooA70RyvWXYKx86qbC9FBxuI7Xw=;
	b=rhnbZ+GFZTsNP1JMG0bcENLcS/PXk6kQ9VYiZwjF7VweMLYCZluTySEF+7ZQcy8CeS+tyB
	MSihMSUEStHx3aDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Jason@zx2c4.com
Subject: Re: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
Message-ID: <20241010110927-9688b27e-6048-48ac-a908-5b80ba8da63e@linutronix.de>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>
 <20241010101449-007991a0-f7c7-4f76-a6cc-413c474b9219@linutronix.de>
 <0a3d0813-e44f-45be-8b9a-957c75aa26cb@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a3d0813-e44f-45be-8b9a-957c75aa26cb@csgroup.eu>

On Thu, Oct 10, 2024 at 11:00:15AM +0200, Christophe Leroy wrote:
> Hi Thomas,
> 
> Le 10/10/2024 à 10:20, Thomas Weißschuh a écrit :
> > On Wed, Oct 02, 2024 at 10:39:29AM +0200, Christophe Leroy wrote:
> > > VDSO time functions do not call any other function, so they don't
> > > need to save/restore LR. However, retrieving the address of VDSO data
> > > page requires using LR hence saving then restoring it, which can be
> > > heavy on some CPUs. On the other hand, VDSO functions on powerpc are
> > > not standard functions and require a wrapper function to call C VDSO
> > > functions. And that wrapper has to save and restore LR in order to
> > > call the C VDSO function, so retrieving VDSO data page address in that
> > > wrapper doesn't require additional save/restore of LR.
> > > 
> > > For random VDSO functions it is a bit different. Because the function
> > > calls __arch_chacha20_blocks_nostack(), it saves and restores LR.
> > > Retrieving VDSO data page address can then be done there without
> > > additional save/restore of LR.
> > > 
> > > So lets implement __arch_get_vdso_rng_data() and simplify the wrapper.
> > > 
> > > It starts paving the way for the day powerpc will implement a more
> > > standard ABI for VDSO functions.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >   arch/powerpc/include/asm/vdso/getrandom.h | 15 +++++++++++++--
> > >   arch/powerpc/kernel/asm-offsets.c         |  1 -
> > >   arch/powerpc/kernel/vdso/getrandom.S      |  1 -
> > >   arch/powerpc/kernel/vdso/vgetrandom.c     |  4 ++--
> > >   4 files changed, 15 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
> > > index 501d6bb14e8a..4302e7c67aa5 100644
> > > --- a/arch/powerpc/include/asm/vdso/getrandom.h
> > > +++ b/arch/powerpc/include/asm/vdso/getrandom.h
> > > @@ -7,6 +7,8 @@
> > >   #ifndef __ASSEMBLY__
> > > +#include <asm/vdso_datapage.h>
> > > +
> > >   static __always_inline int do_syscall_3(const unsigned long _r0, const unsigned long _r3,
> > >   					const unsigned long _r4, const unsigned long _r5)
> > >   {
> > > @@ -43,11 +45,20 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
> > >   static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> > >   {
> > > -	return NULL;
> > > +	struct vdso_arch_data *data;
> > > +
> > > +	asm(
> > > +		"	bcl	20, 31, .+4\n"
> > > +		"0:	mflr	%0\n"
> > > +		"	addis	%0, %0, (_vdso_datapage - 0b)@ha\n"
> > > +		"	addi	%0, %0, (_vdso_datapage - 0b)@l\n"
> > > +	: "=r" (data) :: "lr");
> > > +
> > > +	return &data->rng_data;
> > >   }
> > 
> > Did you also try something like this:
> > 
> > extern struct vdso_arch_data _vdso_datapage __attribute__((visibility("hidden")));
> > 
> > static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> > {
> >         return &_vdso_datapage.rng_data;
> > }
> > 
> > Not knowing much about ppc asm the resulting assembly looks simpler.
> > And it would be more in line with what other archs are doing.
> 
> Did you build it ?

Yes, I couldn't have looked at the asm otherwise.

> I get :
> 
>   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
>   VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
> arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not
> supported
> make[2]: *** [arch/powerpc/kernel/vdso/Makefile:75:
> arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1

I forgot to enable CONFIG_COMPAT.
It's only broken for the 32 bit case.

> Current solution gives:
> 
>   24:	42 9f 00 05 	bcl     20,4*cr7+so,28 <__c_kernel_getrandom+0x28>
>   28:	7e a8 02 a6 	mflr    r21
>   2c:	3e b5 00 00 	addis   r21,r21,0
> 			2e: R_PPC_REL16_HA	_vdso_datapage+0x6
>   30:	3a b5 00 00 	addi    r21,r21,0
> 			32: R_PPC_REL16_LO	_vdso_datapage+0xa
> 
> 
> Your solution gives:
> 
>   60:	3e e0 00 00 	lis     r23,0
> 			62: R_PPC_ADDR16_HA	_vdso_datapage
>   64:	3a f7 00 00 	addi    r23,r23,0
> 			66: R_PPC_ADDR16_LO	_vdso_datapage
> 
> 
> So yes your solution looks simpler, but relies on absolute addresses set up
> through dynamic relocation which is not possible because different processes
> map the same VDSO datapage at different addresses.

Due to visibility("hidden"), the compiler should not emit absolute
references but PC-relative ones.
This is how it works for most other architectures, see
include/vdso/datapage.h.

I'll try to see why this doesn't work for ppc32.


Thomas

