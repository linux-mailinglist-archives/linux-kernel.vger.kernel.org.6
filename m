Return-Path: <linux-kernel+bounces-421609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B565E9D8D88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA54B26B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50111C3F34;
	Mon, 25 Nov 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2roEM6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0526F06D;
	Mon, 25 Nov 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567424; cv=none; b=EgP1MAf17NakHrd0Q3CKJisU2lGbrumRl9lHCKX7b0wIwp3EscHLl+UNiOy5YjsDbCfPoHd/m1IeF62yLrdqtnV+CgP7qrJRdBXyZV6BuRjLiwqj7RyFtIStyUzgy3EJPY177lV41RjInr4tGWxru53zRo6Y/PfjK/ELIe8c3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567424; c=relaxed/simple;
	bh=fvmkebYzUrZ0aCkkEPQAaefl3tpc2uAxgxtpEuWjDg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfh/nKaLsV/iOA6ti3XRWb+e4wOyzKlc2rXlnJvmqIaIMRUR8JW1IsSCvql1grHvq6yPe58yNWmIVynr27IJP/i0x5QZmP7bH2+h+ad54uTwEQN2AcuXVTvIvrsETHbuiZAgE8wkscCNhl5vE24Ix/LgMSac0Lc5n+ma89ItfhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2roEM6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99608C4CECE;
	Mon, 25 Nov 2024 20:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732567423;
	bh=fvmkebYzUrZ0aCkkEPQAaefl3tpc2uAxgxtpEuWjDg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2roEM6EI+EIEd6c5S5HccSFbSKBCKnTmiwPW30YWynCXtq2jIE6nbJ7DJ0i/DBCS
	 LHui0dwH25+V93RTbp8ygQXdMsc7IQnkvddQ/Vaf67SBeDXVG/L2RPUbMW8WXREX9w
	 Q4wWV+9Nolq50PD5+Wl34EKrwFDiah7UHXMm6081rLjg3RLFzUklCGOY3UYm6rTYFl
	 ZbdRCz9yqW24vsHwZ3Nxc/sX0IUOj0sZiHKBhyIv5g3h852tactH8gzPawZAzMgzwQ
	 Mt/z5O7oJxXQw6yL+qV8fwwjoP6rlOeASJrLVwK6XripXAGQqXh3YVRH4exf4JtrPn
	 kRZqkclTOn3eA==
Date: Mon, 25 Nov 2024 21:43:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Cloud Hsu <cloudhsu@google.com>, Chris Koch <chrisko@google.com>
Subject: Re: [PATCH v1 1/1] x86/Documentation: Update algo in init_size
 description of boot protocol
Message-ID: <Z0TheZLKzwqnoZfE@gmail.com>
References: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com>
 <d2dfc0a4-d9dc-4dd2-a669-097dcf3491b5@infradead.org>
 <Z0Q5MIjy0yx6jyNq@gmail.com>
 <Z0RVgdhYu17lINZz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0RVgdhYu17lINZz@smile.fi.intel.com>


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Nov 25, 2024 at 09:45:36AM +0100, Ingo Molnar wrote:
> > * Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 11/25/24 12:31 AM, Andy Shevchenko wrote:
> 
> ...
> 
> > > > -	if (relocatable_kernel)
> > > > -	runtime_start = align_up(load_address, kernel_alignment)
> > > > -	else
> > > > -	runtime_start = pref_address
> > > > +    if ( relocatable_kernel ) {
> > > > +      if ( load_address < pref_address )
> > > 
> > > What's up with the extra spaces around ( and ) ... and inconsistent with
> > > the lines below?
> 
> I can remove them. This file has a lot of inconsistencies it seems...

Feel free to send a followup patch that fixes up all of those other 
details and harmonizes the style. Quality of the boot protocol 
documentation demonstrably matters quite a bit in functional terms as 
well ...

> 
> > Also, even pseudocode should follow the kernel's coding style and use 
> > tabs in particular - which it already does in (some...) other places of 
> > this document, such as the 'Sample Boot Configuration' chapter.
> 
> The problem is that reStructuredText syntax requires that indentation.
> I may follow the rules after the rST requirements, though.

That's a good solution - thank you!

	Ingo

