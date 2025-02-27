Return-Path: <linux-kernel+bounces-536902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B3A48591
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AA73AA6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E41B394E;
	Thu, 27 Feb 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbx/yjtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D81B4241
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674788; cv=none; b=UcrexbWvr7I5cw2DNgao149qaixBIgN8A/XibOZaIrLpqeaGy/nJswfp2KNcQctrFT4l5qxxTM6zyOsUa0NzA1e6sCg2G8fR+LhLwTw5eSmxauVRtQO3JrMxyaYH8pICDKIJ8Zqpu2FPES1GpUR3t3woj2NuKpN96w087jskmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674788; c=relaxed/simple;
	bh=67tiD0TMFvksK5IXmgM9ni7fSjLJOtAe0ZBDW22/UDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHmY/aa/a6c2FgLk9WezXic+wBz0rQ4SllV0a0yE0/WDDv1C9/fo+CeQ7D+0CE7rANcnyQB9JFD5mxm1puAQxSq1U1BOaqUrD2H+GDJOHxfZJrWrkEBXHNA8LLOxivrYt3S9y3HvF1CRgL5gtg7A4ctt3pK6vmhYwLDn9CR44Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbx/yjtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75ECC4CEE6;
	Thu, 27 Feb 2025 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740674788;
	bh=67tiD0TMFvksK5IXmgM9ni7fSjLJOtAe0ZBDW22/UDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbx/yjtEVKHpXuRUPwgSu7KQiN+nc2mlvt859QZKoEEYoWIeBVczJ+ypaAXbo4c5t
	 6pUbkFY4jV0x1rXVCXuGnNxDkgw10yMV6tO9CicxBgNROQgwmgbfvW3OVRszmd69CY
	 jfhgGfWnNul9K3TBK0v5UEsnw4JCzTPk+HtFOScKxRcFDeuLE72sz8Q3YkOdG+iLfP
	 Uspywu3dolEngk3tnUHnQ7Nrmxn4FZcrrIetAJEPxY6SmJ3cK/y0UL0nIErrkXmhov
	 yzRGltt2dErPf+YzbjMU002Yl5QEwvBg0liWxPvpesbkkvIWfuRB8Xg7blQoC7NWyY
	 QLR4D7jwMTPIg==
Date: Thu, 27 Feb 2025 08:46:26 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1] x86/insn: Fix linux/unaligned.h include path
Message-ID: <Z8CW4ozmV4OwyXWm@google.com>
References: <20250225193600.90037-1-irogers@google.com>
 <Z7-ylCsV43noci77@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7-ylCsV43noci77@google.com>

Adding Josh and Peter as it's used in objtool as well.

On Wed, Feb 26, 2025 at 04:32:20PM -0800, Namhyung Kim wrote:
> On Tue, Feb 25, 2025 at 11:36:00AM -0800, Ian Rogers wrote:
> > tools/arch/x86/include/linux doesn't exist but building is working by
> > virtue of a -I. Building using bazel this fails. Use angle brackets to
> > include unaligned.h so there isn't an invalid relative include.
> 
> Right, it's using tools/include/linux/unaligned.h.

Josh, are you ok with this?  I can carry this in the perf tools tree if
you don't mind.

Thanks,
Namhyung

> 
> > 
> > Fixes: 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/arch/x86/lib/insn.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> > index ab5cdc3337da..e91d4c4e1c16 100644
> > --- a/tools/arch/x86/lib/insn.c
> > +++ b/tools/arch/x86/lib/insn.c
> > @@ -13,7 +13,7 @@
> >  #endif
> >  #include "../include/asm/inat.h" /* __ignore_sync_check__ */
> >  #include "../include/asm/insn.h" /* __ignore_sync_check__ */
> > -#include "../include/linux/unaligned.h" /* __ignore_sync_check__ */
> > +#include <linux/unaligned.h> /* __ignore_sync_check__ */
> >  
> >  #include <linux/errno.h>
> >  #include <linux/kconfig.h>
> > -- 
> > 2.48.1.711.g2feabab25a-goog
> > 

