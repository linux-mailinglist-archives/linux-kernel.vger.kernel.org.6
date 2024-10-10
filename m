Return-Path: <linux-kernel+bounces-358515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24741998046
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49401F25541
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A61C8FDB;
	Thu, 10 Oct 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKqGn/cN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p224maLW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216461C3F0B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548443; cv=none; b=eMZmnwho7k4jYBnE0/suxMsIVYWkZqda4E0Cu26g1XJCjKpYf/oTLWsTsq7B0+9AKnkqhqKs8JoweTe63dPNpAi9C+D2VL7d6L5wK5RNJtS81sfIpqk43qe+QT7SS4I9KmJMKkxpMFU9VCpx6DAktsMd+W2ZcFij6JPCRHvxwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548443; c=relaxed/simple;
	bh=qVog0+3bxtT9GuYHmVkPPRBLbR7jC5PDUmb72DQk6Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVR6tCFKLcCyH0F/vm7Db7MPE9nqYNUNWN8ZuQsldU8lP7qFUHg69ICpQ+6xkbqVYXZpoOl0Ctt1WfovqOa7B0d55MmhDge938irjHNzqeHHoV0bbuMI5SWePNESBEJWcahwnbdSuJIkqBI/PItLpXJLhBiLs5j/jzxPOK2jFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MKqGn/cN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p224maLW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 10:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728548439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0yRJLGN3GR4SU4+Zvv9xJN2+/rKp9fff/+IHuEcpTo=;
	b=MKqGn/cNC6Zyq+zH/xAufz8hNQY8ZecCg9s01h/mG/99zJ1ScQ8Qtlsy17qf5zsGj48NIi
	QUmfDfYfMBbpmE3dqHHVRUyHKolg+FYVRqEDtOIBin0HbYcuau2ICNUhga4X/4D6f5oJXm
	7IAFIbW8QatOI1/KRKyr60PbzCA09HgYIUA6wf+GfQy+IAoUOmYWwvvpJBq6/cw4thU/oO
	vm3WvItem5bNmlXJm85bWkmluJYlL8AQS0oBKgj81inPMGJpNhSKKk+u3P+ue4d3OXC5WC
	vbWbMJIgTOZGHb9slJmc6uzZO0tFcGIfXrDmsnvffA9UMVGjVNOfoDZFMRPwKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728548439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0yRJLGN3GR4SU4+Zvv9xJN2+/rKp9fff/+IHuEcpTo=;
	b=p224maLWJCwIJWR2SmTdxzsy/veWfEa0cZGiCeqqM9jkquJMrxXc6jxLj6qjYJVAln6UwD
	bjJGtiYHoUKQF+Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Jason@zx2c4.com
Subject: Re: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
Message-ID: <20241010101449-007991a0-f7c7-4f76-a6cc-413c474b9219@linutronix.de>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>

On Wed, Oct 02, 2024 at 10:39:29AM +0200, Christophe Leroy wrote:
> VDSO time functions do not call any other function, so they don't
> need to save/restore LR. However, retrieving the address of VDSO data
> page requires using LR hence saving then restoring it, which can be
> heavy on some CPUs. On the other hand, VDSO functions on powerpc are
> not standard functions and require a wrapper function to call C VDSO
> functions. And that wrapper has to save and restore LR in order to
> call the C VDSO function, so retrieving VDSO data page address in that
> wrapper doesn't require additional save/restore of LR.
> 
> For random VDSO functions it is a bit different. Because the function
> calls __arch_chacha20_blocks_nostack(), it saves and restores LR.
> Retrieving VDSO data page address can then be done there without
> additional save/restore of LR.
> 
> So lets implement __arch_get_vdso_rng_data() and simplify the wrapper.
> 
> It starts paving the way for the day powerpc will implement a more
> standard ABI for VDSO functions.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/vdso/getrandom.h | 15 +++++++++++++--
>  arch/powerpc/kernel/asm-offsets.c         |  1 -
>  arch/powerpc/kernel/vdso/getrandom.S      |  1 -
>  arch/powerpc/kernel/vdso/vgetrandom.c     |  4 ++--
>  4 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
> index 501d6bb14e8a..4302e7c67aa5 100644
> --- a/arch/powerpc/include/asm/vdso/getrandom.h
> +++ b/arch/powerpc/include/asm/vdso/getrandom.h
> @@ -7,6 +7,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/vdso_datapage.h>
> +
>  static __always_inline int do_syscall_3(const unsigned long _r0, const unsigned long _r3,
>  					const unsigned long _r4, const unsigned long _r5)
>  {
> @@ -43,11 +45,20 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
>  
>  static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
>  {
> -	return NULL;
> +	struct vdso_arch_data *data;
> +
> +	asm(
> +		"	bcl	20, 31, .+4\n"
> +		"0:	mflr	%0\n"
> +		"	addis	%0, %0, (_vdso_datapage - 0b)@ha\n"
> +		"	addi	%0, %0, (_vdso_datapage - 0b)@l\n"
> +	: "=r" (data) :: "lr");
> +
> +	return &data->rng_data;
>  }

Did you also try something like this:

extern struct vdso_arch_data _vdso_datapage __attribute__((visibility("hidden")));

static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
{
       return &_vdso_datapage.rng_data;
}

Not knowing much about ppc asm the resulting assembly looks simpler.
And it would be more in line with what other archs are doing.

> [..]

