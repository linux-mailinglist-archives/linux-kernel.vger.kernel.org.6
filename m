Return-Path: <linux-kernel+bounces-206654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55305900C60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E461C22187
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8111314D2B5;
	Fri,  7 Jun 2024 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZIc7YXZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRe6PZMR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE47345D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787868; cv=none; b=X5UK3RKyf8NsS3ymoPGNnUFqPxPtibm7tL8PamjjpY08ICtws3IrRg+D86gEfKp0vPeirA3PwXhSmvUb+ZpLV2dAd4fsyon6pZaxMkNVnm6oAkuWW6Q3BQtS9OJm5J8mHBsQAyYwEX5cq5iahmuyp1x4c8sVz9qJNxw3neVKwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787868; c=relaxed/simple;
	bh=5NiEdg4JDL4wu6MDStxWmcNbtxLlrtUQR2/dFbPhZ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxLZVtGWxomv9VXiBH2lqt8b22IvqjysObdW0t6M7TnpSWjKOt/XNjNzrJv+BehjX7VhTqwvUS4JUTvp4NhFBx6fz22nbegmnD4ZRcFA2n/BRfSwfq8bJ4+qKANGOPIpceqIZPS+HK4Mp54R19CUPL1/okdbDntLwBpQ8GZfYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZIc7YXZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRe6PZMR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Jun 2024 21:17:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717787865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Pz+8KfKB8d44sqvZtkfrnb/HJ1I20+yDp6ymk4PGT8=;
	b=DZIc7YXZ/AdKaxx1yuYGNs8uX1drg+VVYSuqZ3k2bGqveKbsJNhFAsZ/MdIAB8NLknpZX1
	Ry8Bcy84pcctmvkMY79lSnvgyhEElHmd3PtQ7OH3eXWLaBTqq+wESvgGPOt10PiUZ/VR89
	0Iu2YSjFW+bivje0agik23uS5nwX2lvqkFNoQM62qVig1F6M52FsmXPBzQ6wkho6RydmhT
	pehKVy4qvJkFDO5cuqiwbFsQD8PCmCYW3t9MXXmxvwxrQCz4H8AwBCR4YfwnDyUoE9VQ6R
	zjkCEZCmrYaCAmICub5LxbzkR1ziCeIBP8sV9cRJotLMyQ9wLjVRUBgbq1C2rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717787865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Pz+8KfKB8d44sqvZtkfrnb/HJ1I20+yDp6ymk4PGT8=;
	b=VRe6PZMRpAy5DcvMCaWNwCwE6SUWcvfl0HwjzfM1J5+WbgThqJyZWzE7wIubH3bBkZjvig
	riaMVbuaprDMpCBg==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 7/7] riscv: remove limit on the size of read-only section
 for XIP kernel
Message-ID: <20240607191738.YUFQKt3U@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
 <9eea4b61f7b6300def3b6582d8e465ef4207501e.1715286093.git.namcao@linutronix.de>
 <2e092f39-0716-4b73-9268-da9211a4b600@ghiti.fr>
 <20240602073210.w0CKrGlj@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602073210.w0CKrGlj@linutronix.de>

On Sun, Jun 02, 2024 at 09:32:17AM +0200, Nam Cao wrote:
> On Mon, May 27, 2024 at 02:58:14PM +0200, Alexandre Ghiti wrote:
> > > diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> > > index 8c3daa1b0531..01f73f2ffecc 100644
> > > --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> > > +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> > > @@ -65,10 +65,10 @@ SECTIONS
> > >    * From this point, stuff is considered writable and will be copied to RAM
> > >    */
> > >   	__data_loc = ALIGN(PAGE_SIZE);		/* location in file */
> > > -	. = KERNEL_LINK_ADDR + XIP_OFFSET;	/* location in memory */
> > > +	. = ALIGN(SZ_2M);			/* location in memory */
> > 
> > You can't use SZ_2M here since it corresponds to PMD_SIZE for rv64 but on
> > rv32 (which is allowed to use xip kernels), it's 4MB. Use SECTION_ALIGN
> > instead.
> 
> SECTION_ALIGN doesn't work unfortunately. For XIP, SECTION_ALIGN is
> L1_CACHE_BYTES which is 64 bytes, but we need at least PMD_SIZE alignment
> to setup virtual mapping.

Sorry, I think I had tunnel vision. The solution is so obvious.

I will send v2 shortly. Thanks so much for spending time reviewing.

Best regards,
Nam
> 
> Ideally we use PMD_SIZE here, but I can't #include that header file.
> Probably we can refactor the header files so that we can #include the
> header file that PMD_SIZE is in. But I am not sure if it's worth it.
> 
> I'm thinking just go for:
> ifdef CONFIG_64_BIT
> 	. = ALIGN(SZ_2M);
> #else
> 	. = ALIGN(SZ_4M);
> #endif
> 
> Or even simpler, just:
> 	. = ALIGN(SZ_4M);
> 
> As much as I hate magic numbers, I think we can give linker script some
> leeway. Perhaps with an explanation why this alignment is chosen?
> 
> Or do you have a better idea?
> 
> Best regards,
> Nam

