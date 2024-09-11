Return-Path: <linux-kernel+bounces-325083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5359754D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4071B24146
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291B19F12F;
	Wed, 11 Sep 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u7vhr9Px"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF93156C6C;
	Wed, 11 Sep 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062955; cv=none; b=o4iaet3BFhW6QZVhREevCY1SmTgjAeEyOw3bVhVoLPPz7YjARpgyPPqEyk7fufjTPJTNaIhMxSFMxFB0O5WgMnPJEr6q+DS2c4pyDBXjnKebkGYZ27MHDzdmPrN6QoR9PIkYYGbpxFmo6paoOtSmIkQSSv3WRZHzX85kJowCobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062955; c=relaxed/simple;
	bh=UwC8kaCVcmXjbd6pLkYBElYcedPsNinPtJpQLxzsBX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbmxiOy2+VIgJaP4TzrjRUJAwJGt9bavg1qoBbhbxuB80bJtwRqcQr/wylc466aZPXIfJqd015VZyx0AiOZHTBuBwAqexx0VKm2i9B0Tjvm+PguRayc8WA6aRmaF0peMGOdOxu/sNGJleqkVU+19wdEeSg68awPe1HW0fcmhmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u7vhr9Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC673C4CEC0;
	Wed, 11 Sep 2024 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726062955;
	bh=UwC8kaCVcmXjbd6pLkYBElYcedPsNinPtJpQLxzsBX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7vhr9PxvvlJ4OgB5Fdz/YCFWw1qZUI4wDj5+FuwALYIhmXu3TUfzoOL+7pTGN/Zz
	 0PRZTQ135sJjOmY1s//90G3SQbByUio+0jK/LasLe0O0JPR658IHMySswjYNBlde1Y
	 g57nZH3tmAPC4ohBZX/U5pQC86Hxm7J5b6ob6+lE=
Date: Wed, 11 Sep 2024 15:55:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Steven Davis <goldside000@outlook.com>, hvaibhav.linux@gmail.com,
	elder@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
	dtwlin@gmail.com, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Fix capitalization and punctuation
 inconsistencies
Message-ID: <2024091142-quill-tableful-3c3e@gregkh>
References: <SJ2P223MB102660087EA9382BE5287FDBF7912@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
 <Zt7vVaxF2XP-_ZMA@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt7vVaxF2XP-_ZMA@hovoldconsulting.com>

On Mon, Sep 09, 2024 at 02:51:33PM +0200, Johan Hovold wrote:
> On Sun, Sep 01, 2024 at 05:18:59PM -0400, Steven Davis wrote:
> > There were a lot of inconsistencies in outputs and
> > comments, some were properly formatted and
> > capitalized, and some weren't. This patch resolves
> > this by properly formatting the inconsistent comments
> > and outputs.
> > 
> > Signed-off-by: Steven Davis <goldside000@outlook.com>
> > ---
> >  drivers/staging/greybus/arche-platform.c | 38 ++++++++++++------------
> >  drivers/staging/greybus/authentication.c |  6 ++--
> >  drivers/staging/greybus/bootrom.c        | 16 +++++-----
> >  drivers/staging/greybus/light.c          | 26 ++++++++--------
> >  drivers/staging/greybus/log.c            | 10 +++----
> >  5 files changed, 48 insertions(+), 48 deletions(-)
> 
> I didn't have time to reply here before Greg picked this one up, but I'm
> gonna ask for this one to be reverted.
> 
> The (core) greybus code uses lower case error messages so this patch is
> introducing an inconsistency instead of addressing one.
> 
> I just sent a revert here:
> 
> 	https://lore.kernel.org/20240909124853.9213-1-johan@kernel.org

Thanks for that, sorry about missing that.

greg k-h

