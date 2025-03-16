Return-Path: <linux-kernel+bounces-562809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E8CA63339
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D3C188E97E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC711B808;
	Sun, 16 Mar 2025 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghn35b8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5C9454
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742089797; cv=none; b=MHx8GA9vtLsMvgC6xtmYDzHRDNu8vjWnitqcsUsQ7w8NHVOuLALdwsoy/2nBfQWzO5YvLGkv7rXhd6UY8KPH55InLh2izuTi0IzeJCh3t37cb73r5FovUVgI461TIPLFqqFYV2o8OaAsscce44IkAwDJD6idplXauLV82fFAwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742089797; c=relaxed/simple;
	bh=CCUMyA+yIuFEqyur5P/UkvfKkKN4SzIYkw9k7koQDOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT0f7RDblBXcCYTEchuiL7VLYT2+qs8oxq4Nk78EunUwKo0XiMDcjIa8n9SYveO97aDFkJEpugGgQr2auOiPPUrM6gUcfszpx9QjM/AYvf53Ie8OS7RhPnUztDO68J2D6lQxO9qOvq0jIjxXwIDlXNnyp5PIDIEsWFNevJlQjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghn35b8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BD0C4CEE5;
	Sun, 16 Mar 2025 01:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742089797;
	bh=CCUMyA+yIuFEqyur5P/UkvfKkKN4SzIYkw9k7koQDOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghn35b8dfCCugJ3FSUgBNRnYkrwKqyhmMXQD+GGddBa1jQ/xDxUJjm3BTPYPYpHo3
	 1C8whpVYunGsAj2IzRcbsOAVizsB5JZSWogehBzBjQgAGZPN/IAc5aOHXxAYxqY1Ul
	 /33PMJGsD1GtKiSuTXMF9sxHT7zw/06gB7XMfqJE5YAMRGcH6jUAGqHacGQApSESIT
	 U6Ex+aAR2v1r54ZAWkhC3AsYcTDnOCKto9V0ed2b55GTqKMpUqAfmtu1N/e13xDES3
	 hbv9AKFH/wJjImNf68AZPmA6Yducp2Lmg82NIww4jE3NVL6h1o4b+CH85glQrqbRqO
	 aC1fHpQTOBviQ==
Date: Sat, 15 Mar 2025 18:49:54 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Brendan Jackman <jackmanb@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/13] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <isd5ptllbyya5rqzyr75w7b6vasnpyomnub22prdegr2jdodrv@75qx5eg5bppn>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <Z9YeR20Vua8GQIiW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9YeR20Vua8GQIiW@gmail.com>

On Sun, Mar 16, 2025 at 01:41:43AM +0100, Ingo Molnar wrote:
> > +config OBJTOOL_WERROR
> > +	bool "Upgrade objtool warnings to errors"
> > +	default y
> > +	depends on OBJTOOL && !COMPILE_TEST
> > +	help
> > +	  Fail the build on objtool warnings.
> 
> This is *way* too aggressive: objtool false positives are still common, 

I'm not sure what false positives you'd be referring to, these days the
vast majority of warnings I see are actual bugs.

> and an 'allmodconfig' should not fail the build IMO.

In fact it doesn't: allmodconfig sets COMPILE_TEST which prevents
OBJTOOL_WERROR.

I've had complaints from people who spent days debugging a broken kernel
only to discover it was related to an ignored objtool warning.

For non-bot builds which actually get run on a system, many of the
warnings should most definitely not be ignored.  Especially since
objtool is directly involved in some critical kernel infrastructure like
static calls/jumps and CPU mitigations.

All that said, I really don't know whether this default is too
aggressive.  But I do wonder if running it through a linux-next cycle
after the next merge window might help answer that question.

-- 
Josh

