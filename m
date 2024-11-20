Return-Path: <linux-kernel+bounces-415357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9A9D34F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E212813F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED4415B115;
	Wed, 20 Nov 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NIwonKLK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3hvmcImj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7472156676
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089646; cv=none; b=Muhnk5DOwxvPMgA6Mph3XKMz4eWHlex6tIlU9y6G20CqQIMQxwSvWw5u8efY+5I8eCJ+lXEGCi3plS02cUjw7AklaEZp5tbXBMta6LPUAQsP/KCBk2xmsvnK6Qdt3I42SaN11dg7DGm4YlJmsQwILNVCYGFdM/5EmZKdW0tYpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089646; c=relaxed/simple;
	bh=uTpKbz+IkTM76YH28qzQWMxZFQDfvjmgRy2CwJIZIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEwaertsh+3M+DPaGw+n0OF9u84LY7vf2xWZOM9pyOSH5Zitu/nz8Oj7R9d3DCcf5i99b9so3sFZEiPMxRI1hZwY+dx66/8mHWVAiaicF85pus2l/3H0tSXqNKamYUeKoMSVZ4YxKDpj3EKBeFnxD+MwRLE8yIbJyNLgLpT+oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NIwonKLK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3hvmcImj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Nov 2024 09:00:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732089642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEVpEjmgQ7bq91VH3hqrRL8uvO6sYBlXdQ5LRcrtgtY=;
	b=NIwonKLKdzP6mKprX9dS12I8bqX4sU7XYj2EGmsC9tdEnYaHuwC2B1JVlJyzUpiVv3GXjN
	IkcZWBE1pGAxIzpafWvXawZpmMjqIqIGNDH670169gORC4i+YXh+t2erXXQ1YwPoVhq5zL
	/FFm4POUHAgdklFtBR/NqZuPKomwM5g/P6fqNYlp9g9VphhrEVidiOr0rCqqNhP3sZeScP
	2xqr8zx8tfTsUMq96ew2CX4CgjKEsm57e17BIpmIIemsk0s7cjlfCIaSiXAress7QiZG2k
	eUIlM2F9GQvJSR1WzjVcaYhTP4SF8Mhw8F0BxUT3wTae0xFKFjgOUR+rhfShdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732089642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEVpEjmgQ7bq91VH3hqrRL8uvO6sYBlXdQ5LRcrtgtY=;
	b=3hvmcImj8Fd5N3x4VP3Mfd/ek5RtfATGqWrXu51ps57Y2oS3zk8p6naVFLv0fMAWlQRaSD
	QxqmKPvjMfFfLcCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
	ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc: Large user copy aware of full:rt:lazy
 preemption
Message-ID: <20241120080041.aNFNqWCz@linutronix.de>
References: <20241116192306.88217-1-sshegde@linux.ibm.com>
 <20241116192306.88217-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241116192306.88217-3-sshegde@linux.ibm.com>

On 2024-11-17 00:53:06 [+0530], Shrikanth Hegde wrote:
> Large user copy_to/from (more than 16 bytes) uses vmx instructions to 
> speed things up. Once the copy is done, it makes sense to try schedule 
> as soon as possible for preemptible kernels. So do this for 
> preempt=full/lazy and rt kernel. 
> 
> Not checking for lazy bit here, since it could lead to unnecessary 
> context switches.
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/lib/vmx-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
> index d491da8d1838..58ed6bd613a6 100644
> --- a/arch/powerpc/lib/vmx-helper.c
> +++ b/arch/powerpc/lib/vmx-helper.c
> @@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
>  	 * set and we are preemptible. The hack here is to schedule a
>  	 * decrementer to fire here and reschedule for us if necessary.
>  	 */
> -	if (IS_ENABLED(CONFIG_PREEMPT) && need_resched())
> +	if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
>  		set_dec(1);

Now looking at this again there is a comment why preempt_enable() is
bad. An interrupt between preempt_enable_no_resched() and set_dec() is
fine because irq-exit would preempt properly? Regular preemption works
again once copy_to_user() is done? So if you copy 1GiB, you are blocked
for that 1GiB?

>  	return 0;
>  }

Sebastian

