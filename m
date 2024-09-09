Return-Path: <linux-kernel+bounces-321395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65729719F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFE91F23FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466D1B9B43;
	Mon,  9 Sep 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAScQvSu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80ED1B9B51;
	Mon,  9 Sep 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886276; cv=none; b=mujwR20aQ4p5EGNZ2ppuZX0bahjv0fiJRppU00foM6EVEdOoJCGjlg45tABEOWzJLYUVRBB7gK8t8dT6Sqs1PpOM8InIl1IXHocN/cpqALI8OcIiGoy6aHY0ISnohRzKRMJpJ/R7osAAeOO/38QRChISwLGRzNRYJ/1piwOakHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886276; c=relaxed/simple;
	bh=FCM7QUxF9t/5Rbr8bek4qbmnESDmM8rDLSdHDKwEgno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbDOH7fn16YN7VEuO1ntgaN11mTy1lcWfXvLDGeNB76dkOlpmPH9M7jR7N1Olo08maVf8ExvPcICGTMsX12875RVB0sTrEje+S/7i72nLpJr/OWSLUUSCfEeFvNa9+PROYGifJpKNK3EBqrhkjzUlBSjcRiyOTB0gXjje/D7vO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAScQvSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81DCC4CEC5;
	Mon,  9 Sep 2024 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886276;
	bh=FCM7QUxF9t/5Rbr8bek4qbmnESDmM8rDLSdHDKwEgno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAScQvSufGoYBm7kSUi1tNRWrLNLp+MKttudG2dHKPATAroOkBSx51RMy7INbdP9h
	 849/nG9qnTKY8Wp4V8ccsBen7SCtAbQJurjvodcTH7NZdMj9IZdME3kgHkb2bxDVNS
	 fkbUx9a9oNMM0+3ODFNWgV+o/Uix6bQwcrkRjLg4yMxjcImtmvWkIDk8dwLMPRvEV8
	 +BU6Lu/ElDAK87+EzM5YizeMi5jr2pYdlGEfvcLyi4o+xe1Mks9eOsUoqiUHyPzcWQ
	 wWhcG3lyM2EKKAXYamu+9HJQOLrgBDEuwOXtRHco5VllEKrh3QXbTkfTAuMjXcKrTf
	 4UzFoPmdiT6Zw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sndrh-000000002SN-3uNj;
	Mon, 09 Sep 2024 14:51:33 +0200
Date: Mon, 9 Sep 2024 14:51:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Steven Davis <goldside000@outlook.com>
Cc: gregkh@linuxfoundation.org, hvaibhav.linux@gmail.com, elder@kernel.org,
	vireshk@kernel.org, rmfrfs@gmail.com, dtwlin@gmail.com,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Fix capitalization and punctuation
 inconsistencies
Message-ID: <Zt7vVaxF2XP-_ZMA@hovoldconsulting.com>
References: <SJ2P223MB102660087EA9382BE5287FDBF7912@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2P223MB102660087EA9382BE5287FDBF7912@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>

On Sun, Sep 01, 2024 at 05:18:59PM -0400, Steven Davis wrote:
> There were a lot of inconsistencies in outputs and
> comments, some were properly formatted and
> capitalized, and some weren't. This patch resolves
> this by properly formatting the inconsistent comments
> and outputs.
> 
> Signed-off-by: Steven Davis <goldside000@outlook.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 38 ++++++++++++------------
>  drivers/staging/greybus/authentication.c |  6 ++--
>  drivers/staging/greybus/bootrom.c        | 16 +++++-----
>  drivers/staging/greybus/light.c          | 26 ++++++++--------
>  drivers/staging/greybus/log.c            | 10 +++----
>  5 files changed, 48 insertions(+), 48 deletions(-)

I didn't have time to reply here before Greg picked this one up, but I'm
gonna ask for this one to be reverted.

The (core) greybus code uses lower case error messages so this patch is
introducing an inconsistency instead of addressing one.

I just sent a revert here:

	https://lore.kernel.org/20240909124853.9213-1-johan@kernel.org

Johan

