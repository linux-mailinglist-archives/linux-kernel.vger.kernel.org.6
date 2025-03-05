Return-Path: <linux-kernel+bounces-547200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24545A5041A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75903B0CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF2224EF60;
	Wed,  5 Mar 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxlrXW4v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VV2+R5TF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34A1C8619
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190484; cv=none; b=VzXJL3wXiQQRJAOkjX/M53bzvs8Q/KRtgjqAYZwMzbaqSFFjjj2cI7RUOri7HpJD3Flq/xafoThayiPGIpAkhDUM7PEUVELo+ou7nZcU018vzI56x5XUdXlAqsAMFMLPank+04fc5COCZmBAYpS1mZTvS9DdpkZux6fErpqVeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190484; c=relaxed/simple;
	bh=EJ/5DAxnmS6dAoCnK6vcVRM+5FjKQqXjnncObO0qBjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui0IQk2g9Dv3yXaWBQ+YUtifUHJjI2CgSqXN/I+XBymkXwaoIayK3n3j8yzjzS9pqP+ipduDPR0+TMAHvnnfEWpzfa7tGCfYSRg8qcFPeFoC63gsmDvWQPB4qztjnb77meTJc8r/5Vwz+DcRVNQMasjCZ8raT0c0lePG/TSgf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxlrXW4v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VV2+R5TF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 17:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741190481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlENoghyyvlG4Rh4mv4RHpUCHsgMjx2Ty9fbpCg0AdE=;
	b=TxlrXW4viVU97jLqLPNPCAtAfZ0MU6IaZ+Ktty1ZjEgp75fGNaCbsvIWA2G3W9mz6b13xf
	tm/TLAUGgInCa7UWFYcG5eTU4+gt8n2wwoemzeiVYovuZ5BKz1Tm9x6DE7Xfs5CA51cZvH
	s2g2VMBOnGcVudTp9j2R/KVHEG98KovvsdXtoUvzciCefdq2n+bW45CNZlDlDpHubib6hV
	E4Ko12RSS/mmlr9hvt0IYcVXhhgi0mF6m7OKU4r6yLNkzvDYgXwD9KEGN/JAWPyolKivPl
	k2r59gJXGR/E2M+yQ6kMbskFogrnE3dbinWjlLYGXej87cvNgOdD7zqOrtax4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741190481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlENoghyyvlG4Rh4mv4RHpUCHsgMjx2Ty9fbpCg0AdE=;
	b=VV2+R5TFxshTWxrXN8lx4oSdbUDGcfHLX/doA8oeJu5lHKUJj7okPT4rl+tE4/FfP9Q0lH
	LIfjCURZGbwE74CA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 10/40] x86/cpu: Remove leaf 0x2 parsing loop and add
 helpers
Message-ID: <Z8h1Tl3es-PfxrF1@lx-t490>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-11-darwi@linutronix.de>
 <Z8bHK391zKE4gUEW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8bHK391zKE4gUEW@gmail.com>

Hi Ingo,

On Tue, 04 Mar 2025, Ingo Molnar wrote:
> ...
> * Ahmed S. Darwish <darwi@linutronix.de> wrote:
> > +
> > +#include <linux/types.h>
> > +
> > +#include <asm/cpuid.h>
>
> So that header organization is a bit messy: if <asm/cpuid.h> is
> supposed to be the main header, why is there a <asm/cpuid/types.h>?
>
> I'd suggest we follow the FPU header structure:
>
>   starship:~/tip/arch/x86/include/asm/fpu> ls -l
>   total 48
>   -rw-rw-r-- 1 mingo mingo  5732 Feb 27 19:24 api.h
>   -rw-rw-r-- 1 mingo mingo   671 Feb 26 16:13 regset.h
>   -rw-rw-r-- 1 mingo mingo  2203 Feb 27 13:52 sched.h
>   -rw-rw-r-- 1 mingo mingo  1110 Feb 27 19:24 signal.h
>   -rw-rw-r-- 1 mingo mingo 14741 Feb 27 19:24 types.h
>   -rw-rw-r-- 1 mingo mingo   811 Feb 26 16:13 xcr.h
>   -rw-rw-r-- 1 mingo mingo  4401 Feb 27 23:01 xstate.h
>
> With <asm/cpuid/api.h> being the main header - established via a
> separate preparatory patch.
>
> This followup patch can then add <asm/cpuid/types.h> which will also be
> included in <asm/cpuid/api.h>.
>

Sounds sensible.  Thanks!

FYI, in our CPUID-model patch queue (the one after this), we have
something like:

    <asm/cpuid/>
    │
    ├── leaves.h   CPUID bitfields; auto-generated by x86-cpuid-db
    ├── data.h     Internal data structures for the model
    ├── api.h      The new CPUID-model API
    └── ops.h      The raw CPUID ops [Formerly <asm/cpuid.h>]

So doing this from within this PQ should fit nicely.

> > +
> > +/**
> > + * get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
> > + * @regs:	Output parameter
> > + *
> > + * Get leaf 0x2 register output and store it in @regs.  Invalid byte
> > + * descriptors returned by the hardware will be force set to zero (the
> > + * NULL cache/TLB descriptor) before returning them to the caller.
> > + */
> > +static inline void get_leaf_0x2_regs(union leaf_0x2_regs *regs)
>
> Please prefix all new cpuid API functions and types with cpuid_.
>

ACK.

> > +#define for_each_leaf_0x2_desc(regs, desc)				\
> > +	/* Skip the first byte as it is not a descriptor */		\
> > +	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
>
> The comment line can come before the macro.
>

ACK.

> > +	get_leaf_0x2_regs(&regs);
> > +	for_each_leaf_0x2_desc(regs, desc)
> > +		intel_tlb_lookup(*desc);
>
> Nice interface otherwise.
>

Thanks!
Ahmed

