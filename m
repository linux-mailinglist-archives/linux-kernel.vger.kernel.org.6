Return-Path: <linux-kernel+bounces-562793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099CFA632FE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1654F189166A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45EBA50;
	Sun, 16 Mar 2025 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSRHZU8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A078F64
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742085708; cv=none; b=Ibc3Lk+Je+FfNMY05/qJDDugVHh7+xQRyXLKcuFCvnlQZP6GHZqaTnCnPDTsLF4mgiJsB+LU6Zj9KBfL9Ram7VXq6ihymqlCckCV7wF3sYvohx/HxQ9WEk8sky36rVSYII8LPqhEbVX7kUQhHVDGERgg6w8XJPf6gGcz8hZzW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742085708; c=relaxed/simple;
	bh=74i1xcf9t9tUTCTesTKhmzLyH86899nNGWyFWyBsH28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTw/QVVpp41oZ/QS/GkGw7Pre1n+DY8/c3tOLnPNzZfvB9LbDoG3FynocUr06E9eR8fSe2xFMihE+DbBPIjZLbj7DCS1CbXiR6H/wuGQDbncvlCanGAW7teTXfTG4Dj011Mii0DYTo+jKuOOM3tj8RW/u838DKXfAzrC8NVIGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSRHZU8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067C8C4CEE5;
	Sun, 16 Mar 2025 00:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742085707;
	bh=74i1xcf9t9tUTCTesTKhmzLyH86899nNGWyFWyBsH28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSRHZU8A+BNOYJPil1cTvQtJZqwWMAY1Sh3BPHRW3G98206eySrqn/ZTuDHcM5BxY
	 AAZdZo7d7uTDgw+DqKsJBIzT2I8oar4ECD14Y77Ix6X6ncPch1YJem7k1EdYbgfq+7
	 +GXj3tDYkhvvY2lzSCc4DKDqSMEzPQQU8wwHQ/HvlahCgHQSCY8/krGcO5icgwge/S
	 nwfqQKQ5SMfEZjnL/dr+IhRuiZmuAjO7Kn9fRaUXIjC0s9MjTaNojEbPiCUASdgw9Y
	 fP3bPLrPYddWb3m7xOh3MZp/8C4pXv91N9mwmiODSykfDfNpe7HzYgb76U2kxIwX7K
	 medykSPZMySkQ==
Date: Sun, 16 Mar 2025 01:41:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/13] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <Z9YeR20Vua8GQIiW@gmail.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> Objtool warnings can be indicative of crashes, broken live patching, or
> even boot failures.  Ignoring them is not recommended.
> 
> Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
> enabling the objtool --Werror option.  Also set --backtrace to print the
> branches leading up to the warning, which can help considerably when
> debugging certain warnings.
> 
> To avoid breaking bots too badly for now, make it the default for real
> world builds only (!COMPILE_TEST).
> 
> Co-developed-by: Brendan Jackman <jackmanb@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  lib/Kconfig.debug    | 12 ++++++++++++
>  scripts/Makefile.lib |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 35796c290ca3..bbfb9d575f97 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -545,6 +545,18 @@ config FRAME_POINTER
>  config OBJTOOL
>  	bool
>  
> +config OBJTOOL_WERROR
> +	bool "Upgrade objtool warnings to errors"
> +	default y
> +	depends on OBJTOOL && !COMPILE_TEST
> +	help
> +	  Fail the build on objtool warnings.

This is *way* too aggressive: objtool false positives are still common, 
and an 'allmodconfig' should not fail the build IMO.

Thanks,

	Ingo

