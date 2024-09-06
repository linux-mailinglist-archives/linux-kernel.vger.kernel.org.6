Return-Path: <linux-kernel+bounces-319005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080B96F663
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4A51F25124
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9651CFEC4;
	Fri,  6 Sep 2024 14:12:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA901A270
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631969; cv=none; b=XHfRytZuvKb1AkROZnteeVVVIfBIH24gUJ5aM3Dje59XhRHwbjHzSiTMj9kRJIA9uZlC4KiDx+1Mk3eqRZaiEBQF+5Wf20wcWK+A1KKCtBLH+lngKkWAsuVhfOiKzFeL1msMEXyRCqAMJsu9NFiSwvujJOSjjDl0v8MBNKVjX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631969; c=relaxed/simple;
	bh=OPsG1dADcepY/Vjx6JO7j1+Ec+zmu4FOuFVpiNFhvYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+3SrYzN8sDyhNrzB6dyqw+nQh9gJiv7WlvdSpdiv2uZ6E4z+DynQEZSCDl9Vi5QoEql14ree9mwq5txkyecNGGMSA7NILEL+LP1JBk+x8iLsQnRbaBTvOeT4dp9QhPcLspmic9VKyKz9Ohu8vDx3CCfBxwM5rkjRBAKqDxSXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C074C4CEC4;
	Fri,  6 Sep 2024 14:12:46 +0000 (UTC)
Date: Fri, 6 Sep 2024 10:13:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Borislav Petkov <bp@alien8.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Clark Williams <williams@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, John
 Ogness <john.ogness@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 2/3] arm64: Allow to enable PREEMPT_RT.
Message-ID: <20240906101351.0fef642b@gandalf.local.home>
In-Reply-To: <20240906113050.GB16124@willie-the-truck>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
	<20240906111841.562402-3-bigeasy@linutronix.de>
	<20240906113050.GB16124@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 12:30:51 +0100
Will Deacon <will@kernel.org> wrote:

> Acked-by: Will Deacon <will@kernel.org>
> 
> "Let it rip!"

Woot! Woot!

-- Steve

