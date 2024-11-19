Return-Path: <linux-kernel+bounces-413970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A379D2131
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8FF28143A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85B1991AF;
	Tue, 19 Nov 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2uA6OU5w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8WrfeKuL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66CB157A67
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003377; cv=none; b=hnLWJYxmz0tIx5ymeYBI8blxbQKA62tKJFHjZLi0VZYnQ4opcYIIPS0bsb3MFMCaLWHL7QjPYMTDHYPblE5zR50k43jSjeG6z2p3VVK2qNZ1oA4yClIY7ENiFefybkm3sH9kvCmVvHBxAATDWifDW/Rx/cG+1N9wa4c6d7doFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003377; c=relaxed/simple;
	bh=iB0Wu8oShhiXJZphEsNLUvafElpDkFAbc/T+pQmvMmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8oTW/X2lE4nKcEtabSE3m/7ZbdNDJxzNic582+SWJO76OnB7EzzyVjjhKbhG0365GeJL31afgQgioHBCIc7ThqTRrMJbXONcdthCZfcW3HGgseW+HF8+RGOdCk4cltFo3x4BG0Y8Vl8sqcKb428QVwSHbc1K2HQfx/A+gLwwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2uA6OU5w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8WrfeKuL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Nov 2024 09:02:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732003374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFza8Q5Jtv6OUgZ69cq5R5UQc3mI2n+Xf++TTy5qpZU=;
	b=2uA6OU5w4YECX/elRymX1Z604jxUfMor7k64FjQXptp1RRqBDLYmF+d+Hdaa+WgmY5qtG1
	eozzxZJDI0vNLA+jq0SqPTEMqIfSDxHTY84BrDeHa3wpEMj7H8RhBnwmqNQVAjq/B8LZgm
	F7EfeDNWY84U0OdTdq0s/Zy2Bk/ldpKZM1cxco5r9nKKqOO7B2Guutd1rZh+yJk+J+4lX4
	R55OEWjGG/erpX1xSCLwAVGYe4neV9usYzcOfbPHZ3Xf0+ZQGW1Y/113IlP0r/Zg+XaQhj
	1zDEucvCU+QeDIX5XuW9IzF6Ech9e6XbFJXkbf2qTSljTOKy0682KBgO28k2yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732003374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFza8Q5Jtv6OUgZ69cq5R5UQc3mI2n+Xf++TTy5qpZU=;
	b=8WrfeKuLT1ruYKoLNfJ0ea+f7qhGLEzNI6VEfv74xhPaXdNzZ1UeGu+dmbUOffIogAE3Tl
	TerefKx10Qk+ReCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/vdso: Remove unused clockmode asm offsets
Message-ID: <20241119090120-5e463ea1-b62e-4dae-ada1-34e5e112bff2@linutronix.de>
References: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
 <173184539749.890800.8297350541963703609.b4-ty@ellerman.id.au>
 <20241118075902-8b0cf2ea-d772-4c05-9b5d-14aba194e649@linutronix.de>
 <877c8zj44h.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c8zj44h.fsf@mpe.ellerman.id.au>

On Tue, Nov 19, 2024 at 02:26:22PM +1100, Michael Ellerman wrote:
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> writes:
> > Hi Michael,
> >
> > On Sun, Nov 17, 2024 at 11:09:57PM +1100, Michael Ellerman wrote:
> >> On Wed, 13 Nov 2024 09:06:58 +0100, Thomas Weiﬂschuh wrote:
> >> > These offsets are not used anymore, delete them.
> >> > 
> >> > 
> >> 
> >> Applied to powerpc/next.
> >> 
> >> [1/1] powerpc/vdso: Remove unused clockmode asm offsets
> >>       https://git.kernel.org/powerpc/c/d7a82238cb8c77d4ed8cc97cd556c5f3e64bc749
> >
> > Thanks!
> >
> > Is there any chance to get this merged as part of topic/vdso?
>  
> I could apply it there, but I don't think it will be necessary, because
> topic/vdso will be empty vs mainline as soon as I send my pull request
> for v6.13.

Ah, I assumed the generic next branch wouldn't make it into 6.13 this
late in the cycle.

> > My vdso rework patches for the 6.14 cycle rely on these removals.
> 
> Assuming you rebase that series onto v6.13-rc1 or later, this commit
> will be included in that base.

Great, thanks!

> But let me know if I'm misunderstanding something.


Thanks,
Thomas

