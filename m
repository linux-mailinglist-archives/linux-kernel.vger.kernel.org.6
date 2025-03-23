Return-Path: <linux-kernel+bounces-572758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AA7A6CE4E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 08:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80F81892839
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD6201016;
	Sun, 23 Mar 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYRFEOJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A719007D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742716237; cv=none; b=osbih/kSbtp+ztG5oXz5c4zf071Qo+PDMDdJc64W/9ux5EukovAW3VUBfsE4iCL9Euq41YEVwyAIQlwHCMUtVXJ7YDVGcONthuy2lJuj11XK/4X7G/X4HsDKyjIaXCF0sjLkNnLhq/BRIVACCFEwop23YbX/ys8p+rvCKYcld9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742716237; c=relaxed/simple;
	bh=wQtw/lzExY68HoaTxxcO/5W9O00TsDIJX+jBhReBfnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnTy4ncKDCRcW96BmbC03rKJcPMjO+FzX0UR6J8C8hLVk80uPL2Y1ctIlbrAX7qGYQcOu1n5TqTQRSRZxu0xuOHAOgmX6TKynfkMTsKuM12eHd1Q6+NYxWZIO8zofcqsLQFdNn+HKrg/er9HZySdo5z8zYD3JZcyNIa555P2j4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYRFEOJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E40C4CEE2;
	Sun, 23 Mar 2025 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742716237;
	bh=wQtw/lzExY68HoaTxxcO/5W9O00TsDIJX+jBhReBfnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYRFEOJyU/hLgJ9X9XdTbIUTGTq3My0P6TF+jHiD436yKLxNLA0rXK1isHvb/1X4o
	 lKbauShjMhXFCPOnjqEAMjdhmPvFksKUYv2Jya8axw74tx+A0kTO7IQ83Id1tdoKYO
	 vC0hcDe0N9WXYWcWQkqc0mR3PGpLMSmiB9Jkmf5Sw2kkYlXhz+4mRUT0Ej9eiYEbOs
	 zq/O30ClVnESlYZLiKRw7Ozuj3denN80DFE5ETK9TAs6IX4hFXAqh2GfmfsK3/S7nS
	 8xSh/9+MlnjGbeRP9c4iP83R4TpbjBIX+7sej+h0I6ZUd91/t1OxXLPG6kOsLewIDV
	 /A9wOGfw4z0Eg==
Date: Sun, 23 Mar 2025 00:50:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Brendan Jackman <jackmanb@google.com>, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 13/13] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <smpvowgf5xzatcat3gwpaxf3nvoacfyv4bbry545tjyxpx7dv2@bjurc4a4kn3l>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <alpine.LSU.2.21.2503171513220.4236@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2503171513220.4236@pobox.suse.cz>

On Mon, Mar 17, 2025 at 03:14:25PM +0100, Miroslav Benes wrote:
> On Fri, 14 Mar 2025, Josh Poimboeuf wrote:
> 
> > Objtool warnings can be indicative of crashes, broken live patching, or
> > even boot failures.  Ignoring them is not recommended.
> > 
> > Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
> > enabling the objtool --Werror option.  Also set --backtrace to print the
> > branches leading up to the warning, which can help considerably when
> > debugging certain warnings.
> > 
> > To avoid breaking bots too badly for now, make it the default for real
> > world builds only (!COMPILE_TEST).
> > 
> > Co-developed-by: Brendan Jackman <jackmanb@google.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Brendan's SoB missing.
> 
> With 'default y' being present or not
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Miroslav and Brendan, thanks for the reviews.

This was merged with a quickness, so I wasn't able to post a v2 to
update the commit logs.  However I will be posting some patches soon to
address the other comments, along with a bunch of fixes.

-- 
Josh

