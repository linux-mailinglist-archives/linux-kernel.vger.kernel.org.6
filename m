Return-Path: <linux-kernel+bounces-270445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A7943FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969221F2185E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA21494B3;
	Thu,  1 Aug 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCBECuio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7A148FFC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474683; cv=none; b=oTrbV0QW3QDCbAmdjjv4hbQstXvrtwnW+7JeIBxrjGAVYAFpcgfqCcN0GWR/xV7T+JsqHcnjytQTnIjNeHdeiiRhce5Qn9eDVZQnhPNztcbgBNycqVKtvxqCTASYPo0veaDESwDFRpcjx1ryqgzKDAMPJEPHQwmU+qbg3KlUvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474683; c=relaxed/simple;
	bh=kMhT3w3t/38VTJFgp26fB+HmsCXvazjabANR3QYznu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwvoS4FJ5g9qgshWd43ORbs5CDNi5Oz53JlmbWXH6JUERSQa+WFpmN0/P2sNyUBu4ETof8b8M/619BmKxRnvCy6TjE3xilWet0TR68DHyU7YQm8a48qr5V+TavYBeB56k0cjizseF3UrGXWL1JAYdK1daG4CXdyte4ADHg7+AQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCBECuio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15216C116B1;
	Thu,  1 Aug 2024 01:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474682;
	bh=kMhT3w3t/38VTJFgp26fB+HmsCXvazjabANR3QYznu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCBECuiosVYV/SzAQAPAUbALlzWL2fUGSu9WvfZM2RBlWCCJehRyz9jyqbCqTi0GX
	 h2BPGeFFMg7IAZy+CU7uIioEGPQ//qTnR/XReTViz9YfUT8+VIzGi7kY/JI/fT41CJ
	 og628iBfM3vwUj8mdNXWW8fDpuz6e4Fg+HH3e3gsL7KZMdVTM4CqBtzXEN4CirThnx
	 Dcm+gWmdA4krUDhIecIAqli96TYmftNV9FkhAviAIK7WFGgKs7IbgiRkdRcvkch6SB
	 uPl1SqvknCWfUlZvEx3gsyE+FIJ+rbkfGK1Vjy3KiZzMoY5jLnYesFFKllaj5BfYYt
	 TFM4i75ty8U3g==
Date: Wed, 31 Jul 2024 18:11:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Alexey Dobriyan <adobriyan@sw.ru>,
	=?utf-8?B?Uy7Dh2HEn2xhcg==?= Onur <caglar@pardus.org.tr>
Subject: Re: [PATCH] Remove *.orig pattern from .gitignore
Message-ID: <20240801011120.GA1620143@thelio-3990X>
References: <20240729155738.29142-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729155738.29142-1-laurent.pinchart@ideasonboard.com>

On Mon, Jul 29, 2024 at 06:57:38PM +0300, Laurent Pinchart wrote:
> Commit 3f1b0e1f2875 (".gitignore update") added *.orig and *.rej
> patterns to .gitignore in v2.6.23. The commit message didn't give a
> rationale. Later on, commit 1f5d3a6b6532 ("Remove *.rej pattern from
> .gitignore") removed the *.rej pattern in v2.6.26, on the rationale that
> *.rej files indicated something went really wrong and should not be
> ignored.
> 
> The *.rej files are now shown by `git status`, which helps located
> conflicts when applying patches and lowers the probability that they
> will go unnoticed. It is however still easy to overlook the *.orig files
> which slowly polute the source tree. That's not as big of a deal as not
> noticing a conflict, but it's still not nice.
> 
> Drop the *.orig pattern from .gitignore to avoid this and help keep the
> source tree clean.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> As this has been in the tree for so long and appears not to have botherd
> anyone, I have a strong feeling I've overlooked something and this patch
> will be rejected. I've actually had that feeling for a few years
> already, and today I decided that maybe everybody else used the exact
> same reasoning, explaining why the annoying *.orig pattern is still in
> .gitignore.

I don't really have a strong opinion myself but it does seem reasonable
to be consistent. For what it's worth, Stephen Rothwell checks for
accidentally added .orig and .rej files in -next (and catches them
occasionally [1]), so I wouldn't expect removing this to matter much.

[1]: https://lore.kernel.org/linux-next/?q=.rej

> ---
>  .gitignore | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 7902adf4f7f1..58fdbb35e2f1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -142,7 +142,6 @@ GTAGS
>  # id-utils files
>  ID
>  
> -*.orig
>  *~
>  \#*#
>  
> 
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> -- 
> Regards,
> 
> Laurent Pinchart
> 

