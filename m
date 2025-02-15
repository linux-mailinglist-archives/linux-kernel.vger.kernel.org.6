Return-Path: <linux-kernel+bounces-516313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1DA36F93
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373177A4073
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA471E5B9A;
	Sat, 15 Feb 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXjqyEc2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2701DD0D4;
	Sat, 15 Feb 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638547; cv=none; b=Fejgej6jCz2cowbj5T7BfinYPqoU0Nqat8Zzquuta2lU+tIcR9j54IYMMA2nxLZ8ujkuTG8FcJMAifAZcZCYAd/2wd9aRxBGknGVbDqFFHcPtLUNH4L1nK+NqwhsT7OB4ercDRtZ4hb2Y0qXwaJKcZQfH430RDVwna461kGtbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638547; c=relaxed/simple;
	bh=/8RJva3SXdrumd/TuyYf/AXbSom4nlr4LU3xva+4ZpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R61FXsFqkjwmGAx2ZEAdPwBsEe0xSinAfkS6uAAcV7Be7UPeNM+4WY0lveekALY+qDyuTxeo4INjJeCR9cetIz+0wGJ+lOZQo5ov7liO7sZ83d/wpVjL1UBE7b0rLhHVwdUWDJmBnmsndSxNWhxKFL1zhmc9PJo9FtC32HUqodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXjqyEc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995B6C4CEDF;
	Sat, 15 Feb 2025 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739638547;
	bh=/8RJva3SXdrumd/TuyYf/AXbSom4nlr4LU3xva+4ZpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wXjqyEc2K2D1VAR5R+Z+aZpPSbt+bQ7CHyPBQ+D4tkFMfxm3AeFIONF0XdwVgeVp1
	 7EruBTiOAy6YuPoAvrvfwW2p9PGeIDLvmJAKdU8v/+vpMUKdfIqYq1ipwugIOVlVRI
	 9IYsikhoGiDGpS5YkL4GZmyD4C/xZpWSbHRmRd5Q=
Date: Sat, 15 Feb 2025 17:55:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ian To <onlyian4981@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Adhere to coding style
Message-ID: <2025021550-sulfite-nineteen-335d@gregkh>
References: <cover.1739001527.git.onlyian4981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739001527.git.onlyian4981@gmail.com>

On Sat, Feb 08, 2025 at 12:15:53AM -0800, Ian To wrote:
> Edit the file to adhere to the kernel coding style. Reported by
> checkpatch.
> 
> Ian To (3):
>   staging: rtl8723bs: format comments
>   stagin: rtl8723bs: fix spacing
>   staging: rtl8723bs: remove extra blank lines
> 
>  drivers/staging/rtl8723bs/core/rtw_security.c | 279 +++++++++---------
>  1 file changed, 133 insertions(+), 146 deletions(-)
> 
> -- 
> 2.45.3
> 
> 

I am totally confused, I see many different threads here, none with any
versions, so which one is the latest?

I've dropped them all from my review queue, please fix up and properly
version your changes as documented.

Also, this subject line needs to be better :)

thanks,

greg k-h

