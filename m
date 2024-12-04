Return-Path: <linux-kernel+bounces-430478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21A9E3161
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B834F1683D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAA33987;
	Wed,  4 Dec 2024 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NL1G7SVL"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AC27715
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279040; cv=none; b=Da2uwy7tC1RrvPyMCBA824XVp2BYbQ1rufISbQDs+FoFc5OzzsU9RWNTThOiDcQiJth33W6grsYHTO60+xTzVD5FXGDDvNQK49YRDH5BqJ/FcI8eisqeOGz8VJhbbY9rh9+AJcIUtOPBixL+pzdfJQVD62wXW7S9UV2eER49fZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279040; c=relaxed/simple;
	bh=6kj4sx7kUK6/t0DyEjE1u2rA1e/k19OPIQkCxRDBG2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2OQ3lWRilXOLD2vTu8AolDd2+HkCItFTKfmi4dMpwbyddvfjhLEkpWX027q3OSEYkIdUufRPjKiuO+a1ocC0avxmx1RsBbAP43IOq8fmxd2qJyqXGTlwgV1YMRm1sSHi87u0SNffEY3zrlgQIkMWnyrSk1kX9ooJ5sdaGn08gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NL1G7SVL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Dec 2024 21:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733279034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Erq8KHqMTiHk2SkHdDw3umySOz3AJFP/y3LhXC2ABUg=;
	b=NL1G7SVLrn4G82Se+3iwOIxOvlFDv471C3bN/t56vcZhoyWexvqSmebD2Ol/Qh5okSRjG8
	kMiBoIvr82besJESsC931Z49QhxWymZc9ePSSIAux1h5ZpZkF0jChFN5eGwmR144w0qgyz
	FKyhn04lQngC8hllFiLNfyVc9LsIMIQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-bcachefs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] bcachefs: BCACHEFS_PATH_TRACEPOINTS should depend
 on TRACING
Message-ID: <jdp4jdy7cj266m5xhrbodosfbj2lxoeykhkcugnbare5dbgkfw@xkpknsymnapl>
References: <2d26d15c39b72c815f14593b8cc916d47e82402d.1733243875.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d26d15c39b72c815f14593b8cc916d47e82402d.1733243875.git.geert@linux-m68k.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 05:40:10PM +0100, Geert Uytterhoeven wrote:
> When tracing is disabled, there is no point in asking the user about
> enabling extra btree_path tracepoints in bcachefs.
> 
> Fixes: 32ed4a620c5405be ("bcachefs: Btree path tracepoints")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied

> ---
>  fs/bcachefs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
> index ab6c95b895b33591..464b927e4fffd1f2 100644
> --- a/fs/bcachefs/Kconfig
> +++ b/fs/bcachefs/Kconfig
> @@ -90,7 +90,7 @@ config BCACHEFS_SIX_OPTIMISTIC_SPIN
>  
>  config BCACHEFS_PATH_TRACEPOINTS
>  	bool "Extra btree_path tracepoints"
> -	depends on BCACHEFS_FS
> +	depends on BCACHEFS_FS && TRACING
>  	help
>  	Enable extra tracepoints for debugging btree_path operations; we don't
>  	normally want these enabled because they happen at very high rates.
> -- 
> 2.34.1
> 

