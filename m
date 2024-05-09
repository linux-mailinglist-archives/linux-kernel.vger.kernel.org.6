Return-Path: <linux-kernel+bounces-174489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A568C0F81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991E8281BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41414BFB0;
	Thu,  9 May 2024 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aH/K5NP/"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938B14B088;
	Thu,  9 May 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257152; cv=none; b=L1rD1g5Em+3GfNpVBUKZqdT8YgjLYsSndTMJ+g3r33PE6WC4LN71RtcPQJeAUHpJReieHomD5wAj26BXeUIUnQMzae+vCtetZZxB0DF7B8FeMQFIwjUqV8UoYzvMgqAAIcQfsxeFsITlOGE2UcHy2+fiS1+wbv+cyAWNIJ5sc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257152; c=relaxed/simple;
	bh=liY7xyqJ29EA6WjUap8sIM7syRjEZKuDkchrVqdO63M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2vNjTrIi9Q4a7gqJ5xdaB5mcvE5hmC5RuCIlNfnmmc5ZiEvbOAL2WXgJkMew9vBwKmDe5WP0EGiOdIPDWiAPei+gBi3dBB4om5J669G4gH7nEB8V2EXWxFA0JeHz4lFTecXrMmxFDGb4UqCV97le7ZsMm+MwzP9ChqFUC9B1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aH/K5NP/; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pKxLXBr8aMZgY/cRH4ndqqJPVr8PJOiyb+StxvVtko4=; t=1715257149;
	x=1715689149; b=aH/K5NP/1iXzHxpQ0Uso+OGtXa0qvqd9rgpeFhCo4PuvMjZuO0BgSN6ir67w7
	aCLJTjlWgdoPN3ST34O5eZZqC9VLg5VILKYHQkTLpHCu9A5OMXgJTZCiEzazVttFm+GzbpZq0LArc
	zmVNLJyqdAZjrbRL1b3/ba0Hc4sHEveRhjEpvKeKVX1JargBPcZ+yuZAauey9PI6+2+mqbbWyCiBO
	YJMJ3H7zlJFwaMWKwtSsQ/JBbubB+v/3yj/ZGowRpK2FfeNTc9NksskZxEgbm1rea/rBGHggB8XLo
	VmiklgsKx65RVXqYZ58ruSTI0O7XDaiwHhKcW+yFT78bKKy6gA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s52jp-0002bM-7O; Thu, 09 May 2024 14:19:05 +0200
Message-ID: <3529c128-15f0-47c2-8c36-34a1afb1de79@leemhuis.info>
Date: Thu, 9 May 2024 14:19:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/entry_32: Move CLEAR_CPU_BUFFERS before CR3 switch
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Robert Gill <rtgill82@gmail.com>, antonio.gomez.iglesias@linux.intel.com,
 daniel.sneddon@linux.intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715257149;77bf00c3;
X-HE-SMSGID: 1s52jp-0002bM-7O

On 27.04.24 01:48, Pawan Gupta wrote:
> As the mitigation for MDS and RFDS, CLEAR_CPU_BUFFERS macro executes VERW
> instruction that is used to clear the CPU buffers before returning to user
> space. Currently, VERW is executed after the user CR3 is restored. This
> leads to vm86() to fault because VERW takes a memory operand that is not
> mapped in user page tables when vm86() syscall returns. This is an issue
> with 32-bit kernels only, as 64-bit kernels do not support vm86().
> 
> Move the VERW before the CR3 switch for 32-bit kernels as a workaround.
> This is slightly less secure because there is a possibility that the data
> in the registers may be sensitive, and doesn't get cleared from CPU
> buffers. As 32-bit kernels haven't received some of the other transient
> execution mitigations, this is a reasonable trade-off to ensure that
> vm86() syscall works.
> 
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> Reported-by: Robert Gill <rtgill82@gmail.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Did this fall through the cracks? Just wondering, as from here it looks
like for about two weeks now nothing happened to fix the regression
linked above. But I might have missed something.

Cioa, Thorsten

> ---
>  arch/x86/entry/entry_32.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index d3a814efbff6..1b9c1587f06e 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -837,6 +837,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
>  	jz	.Lsyscall_32_done
>  
>  	STACKLEAK_ERASE
> +	CLEAR_CPU_BUFFERS
>  
>  	/* Opportunistic SYSEXIT */
>  
> @@ -881,7 +882,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
>  	BUG_IF_WRONG_CR3 no_user_check=1
>  	popfl
>  	popl	%eax
> -	CLEAR_CPU_BUFFERS
>  
>  	/*
>  	 * Return back to the vDSO, which will pop ecx and edx.
> @@ -941,6 +941,7 @@ SYM_FUNC_START(entry_INT80_32)
>  	STACKLEAK_ERASE
>  
>  restore_all_switch_stack:
> +	CLEAR_CPU_BUFFERS
>  	SWITCH_TO_ENTRY_STACK
>  	CHECK_AND_APPLY_ESPFIX
>  
> @@ -951,7 +952,6 @@ restore_all_switch_stack:
>  
>  	/* Restore user state */
>  	RESTORE_REGS pop=4			# skip orig_eax/error_code
> -	CLEAR_CPU_BUFFERS
>  .Lirq_return:
>  	/*
>  	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
> 
> ---
> base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
> change-id: 20240426-fix-dosemu-vm86-dd111a01737e
> 
> 

