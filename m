Return-Path: <linux-kernel+bounces-547489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE8A50A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C516D74C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77F2512E1;
	Wed,  5 Mar 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SgMLAOeu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6VyKqvs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84716DC12
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200010; cv=none; b=JrAJoK7alZ++WQ/a4b1W56+NKsMygkfNqBmedZB/rHfK39k1rwXYvdLpHoTaYalAXNDkk6tJeqWixcD0JCK8dMZINY297hc25rWd/2/iNow0GJQcA7S0Kev0hg9mlrVvV7bHIQjZSLKTWFc/952lF1QWiKZFA/aaQ9CovtkzKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200010; c=relaxed/simple;
	bh=gSMpPA0TIIxQ3blykXeB9xfOuMai0QErK15kUrCXu0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqZ+Q9K1TNHpnv0jmcHbWcS/ltPtSVVmokvws+qtJ+zauRQz/0NjU2n/LHQLa+7/FfvN/gT6ESflNR3IWINRFK2DoYhHCW7D+/OXQNwgvqu5hbUJjD/iYmMiJuq/FHtoxWCP0PoDgKhdMlKEhO2pjOvt4sHfmb0zp3nCrJgTh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SgMLAOeu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6VyKqvs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 19:40:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741200007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dL8pYYKQ8uhBd/hZVxX+rpZGFPEGdQWosVgCP1BGE00=;
	b=SgMLAOeu03vdaBJJxV3NOv4NZr7eXcBZyZGQC0abRpkOXwjqTkOyZ+LuILoul22gdAlhND
	8VvkBonzmHjh3uVl32foOhMDtufWJ6cwHVuGALq5tXB21GbG0GX7wK+iXXUspzIpTkNdtX
	H1HNVZyhvIri5k/4VADhpTWYK1eBsyGw/1SbjmM2sMGGGXfPJp0u8jxFrCLnuvSTWWJOjB
	hHRFGS7zKfcWO4EAxGVC6se79iJ8mHjupB8sQlk60WUS+qBNB7O02qxpPqKs81fyXF/R1q
	zDuASsOVpl93CVEUbi7mV53SbcIKBszL1qPHW1i/HBGsxf2h6fu8aBwuQ1lqzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741200007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dL8pYYKQ8uhBd/hZVxX+rpZGFPEGdQWosVgCP1BGE00=;
	b=w6VyKqvsMCb4+vs3pjRLGMN6w0DE4irVdY0fiYxI77mhhKgaRn3raA6OZJfEy5+plVuh5c
	qn6yBWjIsmHKkqBw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 37/40] x86/cacheinfo: Extract out cache self-snoop
 checks
Message-ID: <Z8iahUTYuq0gVXmP@lx-t490>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-38-darwi@linutronix.de>
 <01367a6b-8eeb-417e-9a66-e7a64d518319@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01367a6b-8eeb-417e-9a66-e7a64d518319@citrix.com>

Hi Andrew,

On Tue, 04 Mar 2025, Andrew Cooper wrote:
>
> On 04/03/2025 8:51 am, Ahmed S. Darwish wrote:
> > The logic of not doing a cache flush if the CPU declares cache self
> > snooping support is repeated across the x86/cacheinfo code.  Extract it
> > into its own function.
> >
> > Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
>
> I know you're just refactoring code, but the SDM has basically reverted
> this statement about it being safe to skip WBINVD based on SELFSNOOP.
>

Still, thanks a lot for sharing :)

> It turns out not to be safe in cases where the underlying physical
> memory changes from cacheable to unchangeable.  By skipping the WBINVD
> as part of changing the memory type, you end up with spurious writebacks
> at a later point when the memory is expected to be UC.  Apparently this
> is a problem for CLX devices, hence the change in the SDM.

While writing that refactoring patch, I indeed noticed that there is an
errata list of CPUs where X86_FEATURE_SELFSNOOP is force disabled, thus
ensuring WBINVD is never skipped:

    static void check_memory_type_self_snoop_errata(...)
    {
     	switch (c->x86_vfm) {
     	case INTEL_CORE_YONAH:
     	case INTEL_CORE2_MEROM:
     	case INTEL_CORE2_MEROM_L:
     	case INTEL_CORE2_PENRYN:
     	case INTEL_CORE2_DUNNINGTON:
     	case INTEL_NEHALEM:
     	case INTEL_NEHALEM_G:
     	case INTEL_NEHALEM_EP:
     	case INTEL_NEHALEM_EX:
     	case INTEL_WESTMERE:
     	case INTEL_WESTMERE_EP:
     	case INTEL_SANDYBRIDGE:
     		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
     	}
    }

That's why I added "CPUs without known erratas" in the comments:

    /*
     * Cache flushing is the most time-consuming step when programming
     * the MTRRs.  On many Intel CPUs without known erratas, it can be
     * skipped if the CPU declares cache self-snooping support.
     */
    static void maybe_flush_caches(void)
    {
           if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
                   wbinvd();
    }

But, interestingly, CLX devices (intel-family.h CASCADELAKE_X /
SKYLAKE_X) are not part of the kernel's Self Snoop errata list above.

@Thomas, @Ingo, any ideas?

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

