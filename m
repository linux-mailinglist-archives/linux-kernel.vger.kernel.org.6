Return-Path: <linux-kernel+bounces-377824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB19AC74B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463DD282FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D7919E961;
	Wed, 23 Oct 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e21v5Slt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526B174EFC;
	Wed, 23 Oct 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677874; cv=none; b=D6XeBEIJiusyTZgzYyWugNpMMVvDiEudLi3nbK5LmmdSOsdAwxYugfij4+++PPd++4j3J5WNLFUTJpx1Rg7/7qxQ6M71tkdjDzl0I6qvcdUKzN4xW54HiUOFbgCu32P12bvDs5loTa4BmU5DGB6P0+j/tIj1juV52mKLCkRxthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677874; c=relaxed/simple;
	bh=xCx3jsjzrOByOzC4EI6X1N+HxVOj1x9mXT+HTjDqNf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvmLxQgPdOsJL0GCi1SfdlHeM2bRheaGC0pawU1lTT8ZlmA2R4Fxej/5tU3to614bkHZX95/vn/g7pUOeovC2ooQq67rrzLONq8NygLE/ns9Ph0ubd09CHCziI/Pld4N9JGaUgStYQsh8zJE4uvndDUBxcDYZuo8eFmqbVXEwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e21v5Slt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C1C4CEC6;
	Wed, 23 Oct 2024 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729677873;
	bh=xCx3jsjzrOByOzC4EI6X1N+HxVOj1x9mXT+HTjDqNf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e21v5Slt8BPPi98ubJombH5sgfSMajJwUUfZ07rTfZNczQjy8PbV6x2cv39fH/0jP
	 2F7GwTA1eN6dty+HVGbQ8BPAtA3GHDu3Wm7brkrte42xey0AadUrJarfxbtT69AlAV
	 +t/ZzvRDYFMmw+h43gmT9TvivNRJlGZgAL5NoFr4=
Date: Wed, 23 Oct 2024 12:04:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tony Chung <tony467913@gmail.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: mos7840: Fix coding style warnings
Message-ID: <2024102308-gorged-wrench-48e9@gregkh>
References: <20241023091414.18098-1-tony467913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023091414.18098-1-tony467913@gmail.com>

On Wed, Oct 23, 2024 at 05:14:15PM +0800, Tony Chung wrote:
> This commit fix the coding style warnings shown by checkpatch.pl
> 
> Signed-off-by: Tony Chung <tony467913@gmail.com>
> ---
>  drivers/usb/serial/mos7840.c | 50 ++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

