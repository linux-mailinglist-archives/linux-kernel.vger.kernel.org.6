Return-Path: <linux-kernel+bounces-575687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46FA705CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA63A6802
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309B225D204;
	Tue, 25 Mar 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6nfM5Py"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5492561B8;
	Tue, 25 Mar 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918351; cv=none; b=Cgcl+Lzzjsie8WgtRs0fCjXrMWHFnG+L0PrMaAD8v81Y4yO6JuREfde22hHos3vQmxJjmASUGhW/RWrhbzhtojzhc6k5uNNjMf0zT+tD996CNwS6hkhy5mGxdNe1BLmdHniQFeeuXVb0/fzA8yvYK2lNS2EzJLUTDDXkDwRfGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918351; c=relaxed/simple;
	bh=Hj9iUmChR+8d/DA0X8uEVz7oxaYB43JGSC9g8Q7U1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S05WM3xouyZu6dz2b4Z7PqZQgPdhtuz/bkXxL73XkvpoW6yiKinUeFjO6pQiZyOVnsR7xz0nONx42ZwidND+gWM2wDxZdRowHQcWJCdnwLc2ZBC2qQ6lVvWgo0zMHsyVZxc7aojyDy+krFllrvPYZ8gn3H07PO5mMw76mk5PXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6nfM5Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9A5C4CEEF;
	Tue, 25 Mar 2025 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742918350;
	bh=Hj9iUmChR+8d/DA0X8uEVz7oxaYB43JGSC9g8Q7U1Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6nfM5PytlRiRwvENoHvQLzMdshWAT+bkAJwF27SipW8Z/7W4Bu6xs7vyB0LU1XXD
	 JyvvX1Vnc3r+fc3KZauUjqF7yhax/uhN0/+hOI1qaadtRNRnC+SecVbTqgYGmLFHSc
	 DKiGv5Z7qWGaVxD65DMSsbUuij+JgaUa1S7WUpHVzDaihN6BBi3M2G8pGvqYeryJgC
	 hnDQn3LiwZN+Eo3mDBnkGpYSnwTHRJH0abEweIis7wRPW+HZziFmPd7qWrf6e/TCtc
	 OjJqpEOLWPLr3WPMvRmMhMzkVNLW+kfsaLtUsIWFto1sL0W9jTk9VcYe44jfdIRrY4
	 +qcnuCvrBzqfg==
Date: Tue, 25 Mar 2025 08:59:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] platform: cznic: fix function parameter names
Message-ID: <20250325155906.GA1886499@ax162>
References: <20250321085315.915808-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321085315.915808-1-arnd@kernel.org>

On Fri, Mar 21, 2025 at 09:53:07AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A invalid prototype made it into a previous patch, causing an clang warning:
> 
> drivers/platform/cznic/turris-signing-key.c:25:55: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
> 
> and a slightly different warning with gcc-11 and earlier but not gcc-12 and up:
> 
> drivers/platform/cznic/turris-signing-key.c: In function 'turris_signing_key_instantiate':
> drivers/platform/cznic/turris-signing-key.c:25:43: error: parameter name omitted
> 
> Add the parameters to get a clean build with all compilers.
> 
> Fixes: 0b28b7080ef5 ("platform: cznic: Add keyctl helpers for Turris platform")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503210450.AoOpbJXC-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

You will be taking this I assume?

> ---
>  drivers/platform/cznic/turris-signing-key.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/cznic/turris-signing-key.c b/drivers/platform/cznic/turris-signing-key.c
> index 3b12e5245fb7..3827178565e2 100644
> --- a/drivers/platform/cznic/turris-signing-key.c
> +++ b/drivers/platform/cznic/turris-signing-key.c
> @@ -22,7 +22,8 @@
>  
>  #include <linux/turris-signing-key.h>
>  
> -static int turris_signing_key_instantiate(struct key *, struct key_preparsed_payload *)
> +static int turris_signing_key_instantiate(struct key *key,
> +					  struct key_preparsed_payload *payload)
>  {
>  	return 0;
>  }
> -- 
> 2.39.5
> 

