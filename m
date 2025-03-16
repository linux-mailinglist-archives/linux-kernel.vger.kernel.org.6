Return-Path: <linux-kernel+bounces-562995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D6A63581
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E71890F43
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A181A5B9D;
	Sun, 16 Mar 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J34Lj67t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB071A38E4
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126168; cv=none; b=hF0plZxr5PtwbwCmz+KFCqnex8UBtFXJH5LcxgtrK5/xOwcHsaF0AgBVBgAYWh+lYXZdl2TA+Bhb/UWrUagmzqESmBcufJl8ltyHBVEJRP7bMDwibOcQQHKI/T8pUOB6tAm929yuNb43HFjRoNC1OlEdsxtbmgU/nZSfhYG4OE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126168; c=relaxed/simple;
	bh=jBEiq04aZRC6D5x9wyr7YcIEA770RBk60yd9rnWOC64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMcyS+9d04ZkI8iBv7xaYU7Wb/Wnq8hY/iZckhO668fK8uVlccSfRxmknikE/mRBPdVCAISZCkhwxAtrpgMNvpIkFKRwkKULbXy6a+UFOUTZ0aE33bokPTxn1C5qKcLs94jxvnXbN91OeA7HdZSngh1PxWkLonB54Ck2rr5qNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J34Lj67t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CD9C4CEDD;
	Sun, 16 Mar 2025 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742126166;
	bh=jBEiq04aZRC6D5x9wyr7YcIEA770RBk60yd9rnWOC64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J34Lj67te9iGyO9v8a9+4JURMg9DJ9/hY6Kcb+TODMEQA9sPkf/mcLD3+mwqHc/v7
	 W/QRDi92gjkDaRzSXhkSoihK4V5GPk1xGWEsOKtHyUYCE8t+s06wplbFRyeoIcPghd
	 JO4sVmvx6LOgP5mMpWCdq6rcMAkAP9ppTRt2vLwP3U+v55iGw9vNe3kjMwCrieL6yq
	 qxiDvCDEccxfWJ/DPybl+MFFatBXfRSddsVYFtVQrQUmLxnbd7SOfODQp1HuP9UfO4
	 VnNrd1dDScJZz7lJBXzGJRxJlDwER7JD+AbblMniQNxUlGKdC5G4rkPT38dgUA4c5O
	 DVcSfBSF0nlcA==
Date: Sun, 16 Mar 2025 12:56:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/13] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <Z9a8Uign6ZBmWtZQ@gmail.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <Z9YeR20Vua8GQIiW@gmail.com>
 <isd5ptllbyya5rqzyr75w7b6vasnpyomnub22prdegr2jdodrv@75qx5eg5bppn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <isd5ptllbyya5rqzyr75w7b6vasnpyomnub22prdegr2jdodrv@75qx5eg5bppn>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Sun, Mar 16, 2025 at 01:41:43AM +0100, Ingo Molnar wrote:
> > > +config OBJTOOL_WERROR
> > > +	bool "Upgrade objtool warnings to errors"
> > > +	default y
> > > +	depends on OBJTOOL && !COMPILE_TEST
> > > +	help
> > > +	  Fail the build on objtool warnings.
> > 
> > This is *way* too aggressive: objtool false positives are still common, 
> 
> I'm not sure what false positives you'd be referring to, these days the
> vast majority of warnings I see are actual bugs.

I'm not sure we are reading the same kernel log :-)

A simple 'git log arch/x86/' followed by a search for objtool pointed 
to the following recent commits:


  #
  # Included a fix for a false positive:
  #
  4e32645cd8f9 x86/smp: Fix mwait_play_dead() and acpi_processor_ffh_play_dead() noreturn behavior

  #
  # objtool poinpointed a problem that has no runtime effects,
  # ie. it's a functional false positive and breaking the build
  # for *that* would have been excessive:
  #
  73e8079be9e7 x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n


  #
  # Commit works around an objtool false positive found during development:
  #
  b815f6877d80 x86/bhi: Add BHI stubs


  #
  # Commit works around what appears to be a objtool false positive
  # about too aggressive code generation in function prologues:
  # (An issue that does not seem to trigger in practice.)
  #
  4087e16b0331 x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()

I literally tried to find the first *actual* bug that objtool prevented 
and the first 4 appear to be struggles with objtool over false 
positives or non-runtime-bugs.

At least in x86 architecture code a significant percentage of objtool 
warnings isn't bugs - and to be fair that's maybe in part due to the 
lockdep effect: developers notice warnings and prevent them, so only 
traces of false positives trickle into the kernel. But lockdep too 
tries to be rather benign and doesn't crash the kernel, it reports an 
issue and turns itself off.

> > and an 'allmodconfig' should not fail the build IMO.
> 
> In fact it doesn't: allmodconfig sets COMPILE_TEST which prevents
> OBJTOOL_WERROR.

Okay, I missed that bit. But the patch still has a 'default y' that 
causes people who didn't have it to enable it by default, right?

> I've had complaints from people who spent days debugging a broken 
> kernel only to discover it was related to an ignored objtool warning.

Same could be said about an ignored lockdep warnings, right?

As long as OBJTOOL_WERROR doesn't get turned on in the primary 8 build 
modes:

  all{mod|yes|no|def}config

and we don't turn it on via default-y I'm a happy camper.

Thanks,

	Ingo

