Return-Path: <linux-kernel+bounces-344653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428ED98AC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E024E1F221D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EBC198E93;
	Mon, 30 Sep 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuZwlS3s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfZ7E+oz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5365466B;
	Mon, 30 Sep 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722167; cv=none; b=U4+ce4B89PaHVq47AFKqWBJkgrjgwNUKz+/fHM7VeTDrVYzw7SAqoe1zu8WE5a1GWeV4Z5KZpNn1glq0fMqktqzaHbzPCfh5l76qKMsir8jKZRUnsv2+d/ZFDBilLS6Au/uuPuo3j34t5JR/bjP+VJu6kDgU/ERa6pBPNffcan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722167; c=relaxed/simple;
	bh=HSmTiEIHSSrt+pS0buo+96bzFnIJWuKdbQE9PNvqMkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkWGKRTUdtgt37/QrBpi9fo/ZWhjexkZcftXEhUXzitnNniYA2nMNtcT4hDsgwMw6K3EltXB56LPLk8M505waeEX2V/vXfdaoDoQGn7jC9P+mTKXN0d+wEQw3EI5h6+9TRhnmyc45of7DHE3dtDVlFyUj953EcLWpIShJg+X6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuZwlS3s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfZ7E+oz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Sep 2024 20:49:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727722163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7AAxiOEhyu5e/1DUPmIOTyp81qWXAG4oUsFN+Oio24=;
	b=yuZwlS3sPoHFJ+2hTFpyde1A+HsoirGLBrEcDPyl5w2Z79zs/lj/I4wYmsEOrihI7HqO6e
	iTw4/17/D4dp/tVNlJXTL0QQI0UIlihWW2IMcgZrksxnjVSRtzyXBMEczJmjIRPvWwdnDW
	6feqpRsjM0pGoOssRJgk8VW/hOWVMsKXWNyoNytvTk6SPI3o+cH8R60aBVYxD6slzznO5C
	1Gk037DVx2lwimsbw4/v9E6k8z8ITNISS0l7fkg1cGc7MaQDoam70HPtVdXRUFxIEQE5Qv
	JwpoEwth6uDYGA2dscz1JbIUHL1jDXbUb9JyBIPCBkgP2o2Y35Q1uxlN4kgRFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727722163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c7AAxiOEhyu5e/1DUPmIOTyp81qWXAG4oUsFN+Oio24=;
	b=VfZ7E+oz3kV51WXN26q0oGFgwD/VUbH98UU2auREQA+xODa1DiNqVufbDKJ8zrzCEp6P9J
	p4wP4PsrpKxyDJBg==
From: Nam Cao <namcao@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: Fix typo MIMPLID -> MIMPID
Message-ID: <20240930184915.vFs7xT1l@linutronix.de>
References: <20240925142532.31808-1-namcao@linutronix.de>
 <87h6a3fw74.fsf@trenco.lwn.net>
 <20240929153305.m8IHY_7l@linutronix.de>
 <87ldzab8np.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldzab8np.fsf@trenco.lwn.net>

On Sun, Sep 29, 2024 at 12:46:02PM -0600, Jonathan Corbet wrote:
> Nam Cao <namcao@linutronix.de> writes:
> 
> > On Wed, Sep 25, 2024 at 12:02:39PM -0600, Jonathan Corbet wrote:
> >> Nam Cao <namcao@linutronix.de> writes:
> >> 
> >> > The macro that is really defined is RISCV_HWPROBE_KEY_MIMPID, not
> >> > RISCV_HWPROBE_KEY_MIMPLID (difference is the 'L').
> >> >
> >> > Also, the riscv privileged specification names the register "mimpid", not
> >> > "mimplid".
> >> >
> >> > Correct these typos.
> >> >
> >> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> >> > ---
> >> > ask me how I found out..
> >> >
> >> >  Documentation/arch/riscv/hwprobe.rst | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> >> > index 85b709257918..fb0affa61eb9 100644
> >> > --- a/Documentation/arch/riscv/hwprobe.rst
> >> > +++ b/Documentation/arch/riscv/hwprobe.rst
> >> > @@ -51,7 +51,7 @@ The following keys are defined:
> >> >  * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
> >> >    defined by the RISC-V privileged architecture specification.
> >> >  
> >> > -* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
> >> > +* :c:macro:`RISCV_HWPROBE_KEY_MIMPID`: Contains the value of ``mimpid``, as
> >> >    defined by the RISC-V privileged architecture specification.
> >> 
> >> You should be able to just say RISCV_HWPROBE_KEY_MIMPID() without the
> >> :c:macro: markup and have the right thing happen.
> >
> > My .rst knowledge is limited, so I probably miss something obvious, but I
> > couldn't get that to work.
> 
> It's not RST as such, it's an extension that we've added for th ekernel
> build. 
> 
> > Do you mean something like below? The brackets do not seem to do anything
> > and get treated as plain text.
> >
> > Sorry but you probably need to show me what to do exactly :(
> >
> > Best regards,
> > Nam
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > index 85b709257918..4b4b4ef0e0f9 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -51,7 +51,7 @@ The following keys are defined:
> >  * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
> >    defined by the RISC-V privileged architecture specification.
> >  
> > -* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
> > +* `RISCV_HWPROBE_KEY_MIMPID()`: Contains the value of ``mimpid``, as
> >    defined by the RISC-V privileged architecture specification.
> 
> Try it without the `backquotes`.

Also doesn't work :(

I digged around a bit, and I think for the thing you mentioned to work,
parse_headers.pl needs to be use on the header file (hwprobe.h in this
case), right? And only Documentation/userspace-api/media/ supports that
script at the moment.

Best regards,
Nam

