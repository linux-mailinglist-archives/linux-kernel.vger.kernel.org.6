Return-Path: <linux-kernel+bounces-266780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD369406B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A669D1C227B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724171662F8;
	Tue, 30 Jul 2024 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/JgRF1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AF33999;
	Tue, 30 Jul 2024 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316098; cv=none; b=L1pIU78ZpmvcYAKnp910bOOeo8kqq4WbT6GZ/UjjyLKhA9rFy0dwocwlkK+sOoSH1hfYUVIbM7dcSyYZP5P773Iz6f6x1X0raDyo32iUr7Ze4nWSLo1r0aL/UvvEK5eQ31xb9pmanu8acDueOkrGBADB9i3dVJydGuXdCSZgxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316098; c=relaxed/simple;
	bh=fzBWPut0GGiuHt31Gpf5zYyofFcIgVb4VK6ByHw8QYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0hKyD6TJX38whuosRF323xljxKHcYY4b7O4IeJqgsxuRni7omF74GEOtkEOm60tUhs73ZU3h12JIballScpRYejrrML9zfCXOuXUwdLayy/XaVAKRvOJEo16VsCW93D+xejNoGKKyLwQokECUF7M/MBuy4Tff5ZiDB/MxSxPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/JgRF1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3608C32782;
	Tue, 30 Jul 2024 05:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722316098;
	bh=fzBWPut0GGiuHt31Gpf5zYyofFcIgVb4VK6ByHw8QYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/JgRF1Ep4CA2d6xBGNjTtjXsAoQgYM/GNUQXGkn0aSNkcEWoU3gJgUJZTvTAsEP2
	 79TuNWCEGVWAd2sP0fQI8xXHe/Bp18iKEqi+iNumd1mC3L4hT8HIFoRE9FVJZySoUE
	 prwjXSDaxW104qEUXMhQIeijdRc2jo6udPstSMkw=
Date: Tue, 30 Jul 2024 07:08:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: W_Armin@gmx.de, corbet@lwn.net, platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] [PATCH v2] wmi: Fix spelling mistakes
Message-ID: <2024073058-visitor-widely-3109@gregkh>
References: <20240729223649.135639-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729223649.135639-1-luis.hernandez093@gmail.com>

On Mon, Jul 29, 2024 at 06:36:44PM -0400, Luis Felipe Hernandez wrote:
> There were a few instances of typos that could lead to confusion
> when reading. The following words have been corrected:
> Binay -> Binary
> singe -> single
> chaged -> changed
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
>  Documentation/wmi/devices/msi-wmi-platform.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

