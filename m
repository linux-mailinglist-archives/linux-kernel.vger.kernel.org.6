Return-Path: <linux-kernel+bounces-183507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A78C99F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD156281D66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE31C2A5;
	Mon, 20 May 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIDKClm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0112B77;
	Mon, 20 May 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195123; cv=none; b=sEVKglwSCyPHbUPrun/4E7WL8t2zu4CZ1TB01/bYiJrrBrGguNgte3AXIvp2oSE/zf2+GdW8ROBBZwr21U2zRvY2ZZ4H64Q3EauHt/Fu5b4Vb+QI4Gof2+bUPbFocOA4CR6DfCxMJ/siRZr/R4F97BG66NoVEzRQm5AYcusadAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195123; c=relaxed/simple;
	bh=ro960X3e20upNBUjUYoFEnRv+4KXio+MC2IjI+Aqv9Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGfJaQRKx1dAIxQv8cZFXuxv16ddK7tD34EWUIVd+bGo4fG0QfdzE9DavOOnoK+4LEucoJBC/Xq/GFbd3jExGSAMm99m0sIxrceVI0pIIIdXZkCmuBdw19rYLBkDCxhNg7vfwz5M4mqKtVZJy3kuNwU4vASou0jTDgeb4+9GeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIDKClm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBF0C2BD10;
	Mon, 20 May 2024 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716195123;
	bh=ro960X3e20upNBUjUYoFEnRv+4KXio+MC2IjI+Aqv9Y=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=QIDKClm1khuMLocQL9kNqU9oglKl+OAtpXbCamWCbGQvO94gdIrj79AgToS90VC1j
	 stU0VH4A0+elCIkbFwti9DkT96D1PLC58PrmdEH/VHTUpNlx8yWXwfIST49lkcdvDg
	 sicS/2z3ic0Qu2gg/CXGlqit+K+S0Mx06YCmo644=
Date: Mon, 20 May 2024 10:52:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geoff Levand <geoff@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: CVE-2023-52665: powerpc/ps3_defconfig: Disable
 PPC64_BIG_ENDIAN_ELF_ABI_V2
Message-ID: <2024052016-footnote-smelting-842e@gregkh>
References: <2024051725-CVE-2023-52665-1d6f@gregkh>
 <87zfslufoo.fsf@mail.lhotse>
 <d8c56e37-38c6-454e-81be-a574b42c83be@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c56e37-38c6-454e-81be-a574b42c83be@infradead.org>

On Mon, May 20, 2024 at 05:35:32PM +0900, Geoff Levand wrote:
> On 5/20/24 16:04, Michael Ellerman wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> Description
> >> ===========
> >>
> >> In the Linux kernel, the following vulnerability has been resolved:
> >>
> >> powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2
> >>
> >> Commit 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian
> >> builds"), merged in Linux-6.5-rc1 changes the calling ABI in a way
> >> that is incompatible with the current code for the PS3's LV1 hypervisor
> >> calls.
> >>
> >> This change just adds the line '# CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not set'
> >> to the ps3_defconfig file so that the PPC64_ELF_ABI_V1 is used.
> >>
> >> Fixes run time errors like these:
> >>
> >>   BUG: Kernel NULL pointer dereference at 0x00000000
> >>   Faulting instruction address: 0xc000000000047cf0
> >>   Oops: Kernel access of bad area, sig: 11 [#1]
> >>   Call Trace:
> >>   [c0000000023039e0] [c00000000100ebfc] ps3_create_spu+0xc4/0x2b0 (unreliable)
> >>   [c000000002303ab0] [c00000000100d4c4] create_spu+0xcc/0x3c4
> >>   [c000000002303b40] [c00000000100eae4] ps3_enumerate_spus+0xa4/0xf8
> >>
> >> The Linux kernel CVE team has assigned CVE-2023-52665 to this issue.
> > 
> > IMHO this doesn't warrant a CVE. The crash mentioned above happens at
> > boot, so the system is not vulnerable it's just broken :)
> 
> As Greg says, with PPC64_BIG_ENDIAN_ELF_ABI_V2 enabled the system won't
> boot, so there is no chance of a vulnerability.

The definition of "vulnerability" from CVE.org is:
	An instance of one or more weaknesses in a Product that can be
	exploited, causing a negative impact to confidentiality, integrity, or
	availability; a set of conditions or behaviors that allows the
	violation of an explicit or implicit security policy.

Having a system that does not boot is a "negative impact to
availability", which is why this was selected for a CVE.  I.e. if a new
kernel update has this problem in it, it would not allow the system to
boot correctly.

But, if the maintainer of the subsystem thinks this should not be
assigned a CVE because of this fix, we'll be glad to revoke it.

Michael, still want this revoked?

thanks,

greg k-h

