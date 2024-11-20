Return-Path: <linux-kernel+bounces-415713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036EE9D3A30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10771F213EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047819F464;
	Wed, 20 Nov 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVOIzkRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF631170A3D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104268; cv=none; b=lwDVsPyIrwn9Z5eakaWOooXA4Ksv3uMB4NfILhauJHxuvVOaMzV0edLF/Ih2jK+JTP0fXPqW8w7BhGH0wAruHqxgvNLkuk8tbTo5iY4NXAoL8fh2n5bfYF3pee240dXR/6hAtnr+HjZFInAs4DDnL0xZ/C7zATESPAPKtAFC398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104268; c=relaxed/simple;
	bh=tXY4P7j8dFSf8vQ01eu+iHfCfxA8kdOhf//xm1+pOCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqy1N63ihkN6vyJ/TYblxtrMvCbEd0hZXvJdkR5egUletkDTzXPbiLdEYGSq81oWrxNhMKTW7iZwY89ZUh+0WG3h1Ig0dhgH18GEN8u9bMEpm+IqDOk+JiYW8C6zt4C5OokRFYjjZfbMttmK9c1+IYq4N6os0spHwrbH0x0MD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVOIzkRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48811C4CECD;
	Wed, 20 Nov 2024 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732104267;
	bh=tXY4P7j8dFSf8vQ01eu+iHfCfxA8kdOhf//xm1+pOCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVOIzkRxJEqxd1iuOOLB2fMg700MO/lZFIiYcFvfUcFwysW6Ur4wbigXYBi4pybhe
	 6r95+q9WQlYWcMwrI27GDfvbZ4k53FnKkomU1NMzaQNofstdztAf+NGnrvb05ahFjS
	 9IgtYHSUwiSjUeS4z6wh1GNrV4bClumbNKTPrL5VBXxVvqnke4hd4MYz1PF7B2GqVp
	 lvrBln8un6tq6kNy+X20NgcNJjSheOvCb8/K+vJdHKS7fgB7m7AvAD3PqSHOtmXWlw
	 gA68bpRzEp1BSIS2HJyqFyQHgvACU2CSKuqwrsjDjwi+7VFa8hW2Fszk3nyadVXiW6
	 iSjQZ50qZO4mQ==
Date: Wed, 20 Nov 2024 13:04:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT pull] timers/core for v6.13-rc1
Message-ID: <Zz3QRpWq2alIhA7j@gmail.com>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
 <173195758632.1896928.11371209657780930206.tglx@xen13>
 <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
 <20241120094001.GBZz2ucZDr1F08zton@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120094001.GBZz2ucZDr1F08zton@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Nov 19, 2024 at 04:33:45PM -0800, Linus Torvalds wrote:
>
> > Bah. Except the vfs tree didn't take it as a shared branch, but 
> > instead cherry-picked the commits and as a result they are 
> > duplicate and caused a (trivial) merge conflict.
> 
> Yeah, we were looking at that last night with tglx and he sent me a 
> resolution (see below) and looking at your tree now, it all looks 
> correct.

So there were two conflicts: one caused by the VFS evil rebase, which 
caused a duplication of two functions within timekeeping.c.

The other conflict was an interaction with the locking tree due to 
overlapping changes, which I resolved in tip:core/merge a couple of 
weeks ago for -next:

  commit 8446247e3ddaf3b173ef96131793bab3f567bd96
  Merge: 2d4cdd3ab714 183ec5f26b2f
  Author: Ingo Molnar <mingo@kernel.org>
  Date:   Wed Nov 6 13:58:08 2024 +0100

    Merge branch 'locking/core' into core/merge, to resolve conflict
    
     Conflicts:
            kernel/time/timekeeping.c
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

AFAICT we resolved it in the same way, the only difference is that 
Linus added one more newline for readability.

So we are all good!

Thanks,

	Ingo

