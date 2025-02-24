Return-Path: <linux-kernel+bounces-529286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D2A4229B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7941897B65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73A13C3CD;
	Mon, 24 Feb 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TV9fnMs/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="waaf8LNo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4F7CF16
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406036; cv=none; b=ROMCbR2ugVMb/M+GYT2aFmqYPB2Pth3y3f7gxAtBYpqmBn4ixx/mP8is7nwk80sBCjM35X4OAgmPp77dFHwmW5qt4vfKHklLCj1YMtXqGu9wCnE8nppc7decOUUFxNaFJu+vQ3vfWbG1v7sa4IYQfsDXUTOoW/Z4B2T2ckK9xi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406036; c=relaxed/simple;
	bh=mvkAruf77vffQU6OTZenOrzj3FNSVqgc5gcpjU/uTL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3ZFhwxV8tF2lOUALbwWD+ey9wJxgqxYXjcCH7YvJOagQPqD4SrKWVrsVVXxpHmcF8YyMxn/XRCHnULNFd3IMs/s5flzWfxZ5q0Lygbs8/VTTQLnfgPcn3QGvnDhu2AzzMOWOeINn/kqq4CgW9Hlnxtd0SpVWuQbf87CX+R+7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TV9fnMs/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=waaf8LNo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 15:07:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740406031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yi/UGbRIzBeO5oSPUsDf5E1KE9ikPRD3nsEqz8hQd6k=;
	b=TV9fnMs/yr1UwZw94lvVsC8kVLC/rl3eG02N2o8p0HxGUQhixOYga6CENfi0FPn9+ZZzM9
	bCUkCGNxZDBq4xVjbMjb6u9pBjltaOeuLWcBahyKAwc9+55GKbSLhYhGlcKwg2wYc2BzTQ
	9dpY+HG1ojkPse+Sr2HWq5LzSwD8EzwLCVbpOZghvNFy3EVckoad97iHX1jwGwrlg6nSi+
	TTxT4UUp7BhIuDCus0p8zGkEBuuUDybLIIvnAZCqF1MSGcvL7bMdwev9Yme2bjRvnv1fdV
	Q1U4jPlfo/CnMd1dDHvG0kYmYT+nJPylzIsXTw6rjXtzMC+/immYZ/xO4kA/ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740406031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yi/UGbRIzBeO5oSPUsDf5E1KE9ikPRD3nsEqz8hQd6k=;
	b=waaf8LNo5DT7x8hql4NYeB7kUqJ5lsSIuidG+6b5GkUxFcezAf1b6Q5cv4m0eAUyFwS4kp
	BCLVUywKKGc7gJAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: vDSO: Wire up getrandom() vDSO implementation
Message-ID: <20250224150345-46f09b09-3d94-41bf-850c-6188d21750bb@linutronix.de>
References: <20250224122541.65045-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224122541.65045-1-xry111@xry111.site>

Hi!

On Mon, Feb 24, 2025 at 08:25:41PM +0800, Xi Ruoyao wrote:
> Hook up the generic vDSO implementation to the LoongArch vDSO data page

LoongArch?

"to the generic vDSO getrandom implementation"

> by providing the required __arch_chacha20_blocks_nostack,
> __arch_get_k_vdso_rng_data, and getrandom_syscall implementations. Also
> wire up the selftests.
> 
> The benchmark result:
> 
> 	vdso: 25000000 times in 2.560024913 seconds
> 	libc: 25000000 times in 40.960524767 seconds
> 	syscall: 25000000 times in 40.380651864 seconds
> 
> 	vdso: 25000000 x 256 times in 171.830655321 seconds
> 	libc: 25000000 x 256 times in 2913.107080132 seconds
> 	syscall: 25000000 x 256 times in 2692.084323377 seconds
> 
> Note that it depends on Thomas Weißschuh's vDSO generic data storage
> implementation (now in the timers/vdso branch of tip).

The note should be below a "---" line, so it doesn't end up in the commit.

> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/riscv/Kconfig                            |   1 +
>  arch/riscv/include/asm/vdso/getrandom.h       |  30 +++
>  arch/riscv/kernel/vdso/Makefile               |   7 +-
>  arch/riscv/kernel/vdso/getrandom.c            |  10 +
>  arch/riscv/kernel/vdso/vdso.lds.S             |   1 +
>  arch/riscv/kernel/vdso/vgetrandom-chacha.S    | 244 ++++++++++++++++++
>  .../selftests/vDSO/vgetrandom-chacha.S        |   2 +
>  7 files changed, 294 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/vdso/getrandom.h
>  create mode 100644 arch/riscv/kernel/vdso/getrandom.c
>  create mode 100644 arch/riscv/kernel/vdso/vgetrandom-chacha.S
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index aa8ea53186c0..6fdd63e15fb4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -213,6 +213,7 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select UACCESS_MEMCPY if !MMU
> +	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO

Broken alphabetical ordering.

>  	select USER_STACKTRACE_SUPPORT
>  	select ZONE_DMA32 if 64BIT

<snip>

