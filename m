Return-Path: <linux-kernel+bounces-326081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E129D976254
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC71C22B57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40A18BC27;
	Thu, 12 Sep 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cKy0UJ8x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VuO8wooh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0610FF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125248; cv=none; b=iW0fQHHXoFdCFNPLB3gid1sj0PRtYyBlmuPsmpKQlCTG4mnJaf+1HX5j9EZD0u0qEyWUuXfuSiA3O/+eIr/0fZ+zrSxCUJ2Pc3X+GkrGQnA36DApjrCzJASTdvWo6V79fufbXtN7a+bc6kNCmxj15c4ho3R5K5HwayTKnQumCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125248; c=relaxed/simple;
	bh=SjU1eoFadyoK7K7SgDbZ2qGYnI+TpM13Yt6F4ubhqds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6dBoMI0xBt2d/KD+dRW0qNSfbcnrTbJLq81RvnI4yiXRAnfrz/AiDRJa39K3XwomvH65i952IOdj41rmd2+4WmwVL8muxcG3i6p2U2MyLzMu9TIWc9JClXvhupqlzf7VywM2I1bWhiIvlHynLof2qhJpXpIWTkvTxBfm0jyzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKy0UJ8x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuO8wooh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Sep 2024 09:14:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726125245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SjU1eoFadyoK7K7SgDbZ2qGYnI+TpM13Yt6F4ubhqds=;
	b=cKy0UJ8xegmPpZzYKtRC+nAEUxVNWfAn+HCNCnbTbHrmuNkF8V5a8xbxQODKWpEk5d/38Q
	D/jypsSEd99y6SIVBD10pxNbKYA1MwTjcWkT9UygAk+dtavsILlUor5uysEvmJr9m+ydUM
	wq2SgMsADzIUghnY8Is2AbVxhso0/3f6E4+fYMa+ieEl7FyC3PwPHneHXphli/gYsTMvVW
	Ud2KqGOeygpg0Sehawso++4wougPKyUlYP5BNN0zn+7JPaORDeR424J0hTPpXBFdZjSL02
	/hHXUREdsDdhGABDRW3uab9N9SYjXyxFYCBIY+bmsmOUEYzB/79/7KFutWKIqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726125245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SjU1eoFadyoK7K7SgDbZ2qGYnI+TpM13Yt6F4ubhqds=;
	b=VuO8woohehugrOAZS6ZtfomWw3Jj5sA25GDEv820Gl2RxE2kI9odY1bQoy9BLEItzHpzpG
	pAWJswQ69ItU4aAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Clark Williams <williams@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/3] Allow to enable PREEMPT_RT.
Message-ID: <20240912071403.KMVCGTA2@linutronix.de>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
 <f9070564-4672-4aee-8e63-c9ca9d985f4b@aosc.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9070564-4672-4aee-8e63-c9ca9d985f4b@aosc.io>

On 2024-09-10 10:39:45 [+0800], Mingcong Bai wrote:
> Hi Sebastian,
Hi Mingcong,

> Congratulations, it's been a long time coming!
thank you.

> I'm wondering, for the architectures not included in the enablement this
> time, do we have a readiness checklist/guide for maintainers to refer to?

I don't think there is. The plain PREEMPT should work. Then need to
follow the checklist for forced-threaded interrupts. Generic code such
as GENERIC_ENTRY makes things easier but at least
HAVE_POSIX_CPU_TIMERS_TASK_WORK is needed with kvm enabled if my memory
serves me right. Everything else is part of generic code.

> Thanks in advance.
> Best Regards,
> Mingcong Bai

Sebastian

