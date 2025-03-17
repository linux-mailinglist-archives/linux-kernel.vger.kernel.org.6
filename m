Return-Path: <linux-kernel+bounces-564557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009ABA65764
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F2B189D335
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5928E17A2EA;
	Mon, 17 Mar 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKaOvtde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C32C9D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227240; cv=none; b=VcMRsz0fMRE7A56L3Fiv0Y60bvYCBE3MGJoqkRTl/6u+/F+9CsPEusS4RTNvpRoMf45H28ayVPUy9Z2JvZp4Tq5LnpU6NnFjDJRSKEMhG25p6Fbar8CLPzboqerRwxdDPYKv/F1d/5M4fqiiJVjQpP7uwCL22UUbtSsVKHMgiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227240; c=relaxed/simple;
	bh=6gCzBdireTSrb2J2K5TYgOMaQEFeUZq4N8TbdhjQzUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lro2I+55k+daHOp2RRQaLo4MB1CuuYtpqtiOTPMF7TNFyLbDrpxB32vOI+TkJixFjYEyZB7t5C7bUQ8Uip7jwPdcKInd+YJ7uuAU7ZMGdeJ3MrwssXkQ1l4lw9q9fXhQtBT8bwyDun9jt4C+Vi9nsNvLx4MBN/nauaYB3q+uiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKaOvtde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB868C4CEE3;
	Mon, 17 Mar 2025 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227240;
	bh=6gCzBdireTSrb2J2K5TYgOMaQEFeUZq4N8TbdhjQzUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKaOvtderv0mRKnIyHN94Xe50MKGc3Na1bhk7ei9JUG5zy2yfXJndNmD73/RzH59O
	 0JlFX/EGA/b0eSKiELoIpZfsY/zZ/L+7D9lRdrkTbZ7EbwRSQDUKFyWPzSfMvOHNDY
	 mUsVu3Vo2jQueI0jHLzEQHSR9ksk8mWaPcXjJfifsHZYsmKOC/0kUd+e6YeidXWSIv
	 oquBJR3HyaHmjQuabsm8bVye/B+Wi20Tb6GZOeLjFzuvNuczah/H8tpgYeqyjMK59s
	 cobZzrCt6QITHVd/6VkAmhpLwQMFbJKnB3Ff+3vAwSVCAFffN/mT/XdDnVl6evNOXQ
	 GgjQmdukBgjRA==
Date: Mon, 17 Mar 2025 16:00:35 +0000
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	maz@kernel.org, rananta@google.com
Subject: Re: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20250317160034.GA12267@willie-the-truck>
References: <20250314160458.GA9438@willie-the-truck>
 <CAHk-=wgiX0q0WCL+SFwVCYtG7JR3=2Rshse-5J3AO2Y4AgT7Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgiX0q0WCL+SFwVCYtG7JR3=2Rshse-5J3AO2Y4AgT7Jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

On Fri, Mar 14, 2025 at 10:34:57AM -1000, Linus Torvalds wrote:
> On Fri, 14 Mar 2025 at 06:05, Will Deacon <will@kernel.org> wrote:
> >
> > Summary in the tag, but the main one is a horrible macro fix for our
> > TLB flushing code which resulted in over-invalidation on the MMU
> > notifier path.
> 
> From a quick look, that macro is still quite broken. Maybe not in ways
> that matter, but still...
> 
> In particular, the 'stride' argument is used multiple times, and
> without parentheses.
> 
> The 'lpa' argument is also used multiple times, and the input to that
> is typically something like kvm_lpa2_is_enabled(), so I think it
> potentially generates lots of pointless duplicate code with that
> BUG_ON() in system_supports_lpa2() -> cpus_have_final_cap().
> 
> Maybe the compiler figures it out. But that macro is bad, bad, bad.
> When it looks like a function, it should act like a function, and not
> evaluate its arguments multiple times.
> 
> The most immediate bug may have been fixed, but not the actual real
> horror of that thing.

Yes, the minimal fix for -rc7 avoids explicitly mutating the macro
arguments but we still have the multiple-evaluation problem you point
out above.

Ideally, this function would be rewritten as a 'static inline' but it
was moved from C code into a macro as part of 360839027a6e ("arm64: tlb:
Refactor the core flush algorithm of __flush_tlb_range") because we need
to propagate the 'op' argument down to the low-level asm where it's
stringified as part of the instruction mnemonic.

I'll have a crack at reworking things to take a 'const char *' instead,
but it won't be for 6.14 as it'll be reasonably invasive.

Will

