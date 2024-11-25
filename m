Return-Path: <linux-kernel+bounces-420615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412979D7D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4123F1627FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97A192B8A;
	Mon, 25 Nov 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjF+E8bb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03940192589;
	Mon, 25 Nov 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524342; cv=none; b=SV023uIjOpCxpq3onO7LWiQ+MvrWw4zKZMnvbMRNFkXbNJP18s+aqaDEl3lUy+yj0nOMxODqPghNLtds8+q5IIb7fP45oO4T4f+go+ZA3wKZoXf4YnBDDyUlcjIRTUaicaEqvuHiUmF0BVsf9W4V3Kl6rYjR1xsQLSNB8QnZtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524342; c=relaxed/simple;
	bh=MlYKTlgCk2VqWlaL2lOdbiVgFlYs7XmruCBEZzL/bRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMaZ4q7MG6esgssO/JgAT1chofZW4oPJGO+Z9RcmmDeve+31wzSFrUc4+ih3psJvgsamquYpyd5qGABD4od4Tlag88BoWDZ9jU03ARFgteirwYZqjUjw6bkD0XfTBlPK5gcQCxZvpKHT5iVLtGiv1jetNzrcWzq+vADiJX5JiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjF+E8bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ED1C4CED7;
	Mon, 25 Nov 2024 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732524341;
	bh=MlYKTlgCk2VqWlaL2lOdbiVgFlYs7XmruCBEZzL/bRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjF+E8bbnPUiq8PTeqpMXuBMWJBUfqcXfJfYA3cvwr5EtMQ2gbhMxkld6OohC2Hpg
	 Yh49NchUw9qjiucYbn8j5At8tRANyf8bu5SNKGh2lEtZ/+5GNbyKNY0fMGI4Db8TkD
	 UaOV+KWx4Wze8PZwLWeTo1pB10HaR9tRYe6fgET8ZW2C3gSzHBijo+H7WWwu9eII9A
	 x6CdyC9N19pc4IEuBjqyrkAADAXT14bOnS8KPbxK0yqAMhYMgpEyoNO7P1OQzH1Sim
	 JzeFOYKgl6LjwZw/RRhJB9xrMb5LuRMnAmkrA+/+JR87ET4fgDELMpqtN1Fvx2alOl
	 y4CuLCqJAAI5Q==
Date: Mon, 25 Nov 2024 09:45:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Cloud Hsu <cloudhsu@google.com>, Chris Koch <chrisko@google.com>
Subject: Re: [PATCH v1 1/1] x86/Documentation: Update algo in init_size
 description of boot protocol
Message-ID: <Z0Q5MIjy0yx6jyNq@gmail.com>
References: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com>
 <d2dfc0a4-d9dc-4dd2-a669-097dcf3491b5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2dfc0a4-d9dc-4dd2-a669-097dcf3491b5@infradead.org>


* Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi Andy,
> 
> On 11/25/24 12:31 AM, Andy Shevchenko wrote:
> > The init_size description of boot protocol has an example of the runtime
> > start address for the compressed bzImage. For non-relocatable kernel
> > it relies on the pref_address value (if not 0), but for relocatable case
> > only pays respect to the load_addres and kernel_alignment, and it is
> > inaccurate for the latter. Boot loader must consider the pref_address
> > as the Linux kernel relocates to it before being decompressed as nicely
> > described in the commit 43b1d3e68ee7 message.
> > 
> > Due to this inaccuracy some of the bootloaders (*) made a mistake in
> > the calculations and if kernel image is big enough, this may lead to
> > unbootable configurations.
> > 
> > *)
> >   In particular, kexec-tools missed that and resently got a couple of
> >   changes which will be part of v2.0.30 release. For the record,
> >   the 43b1d3e68ee7 fixed only kernel kexec implementation and also missed
> >   to update the init_size description.
> > 
> > While at it, make an example C-like looking as it's done elsewhere in
> > the document and fix indentation, so the syntax highliting will work
> > properly in some editors (vim).
> > 
> > Fixes: 43b1d3e68ee7 ("kexec: Allocate kernel above bzImage's pref_address")
> > Fixes: d297366ba692 ("x86: document new bzImage fields")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  Documentation/arch/x86/boot.rst | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> > index 4fd492cb4970..01f08d94e8df 100644
> > --- a/Documentation/arch/x86/boot.rst
> > +++ b/Documentation/arch/x86/boot.rst
> > @@ -896,10 +896,19 @@ Offset/size:	0x260/4
> >  
> >    The kernel runtime start address is determined by the following algorithm::
> >  
> > -	if (relocatable_kernel)
> > -	runtime_start = align_up(load_address, kernel_alignment)
> > -	else
> > -	runtime_start = pref_address
> > +    if ( relocatable_kernel ) {
> > +      if ( load_address < pref_address )
> 
> What's up with the extra spaces around ( and ) ... and inconsistent with
> the lines below?

Also, even pseudocode should follow the kernel's coding style and use 
tabs in particular - which it already does in (some...) other places of 
this document, such as the 'Sample Boot Configuration' chapter.

Thanks,

	Ingo

