Return-Path: <linux-kernel+bounces-445928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A939F1D98
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC977168678
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452E161328;
	Sat, 14 Dec 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa7/XjYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB711712;
	Sat, 14 Dec 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734166302; cv=none; b=JXeLQXTyud1DQR+xL5TKqOQ6uJXhJj0DCWCUVoeAqGEvXhRR/E1fLuczKdIchJBDZcnz/1phufr8t/D1re9Xg7/dbTPQWM0BbxCQN8UNCc2jkF39n/cCsfTjFCWBU6w3wkSth0hOaqaPLVL5iQxX9rPPtLUvn9cc5P1jkMfn2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734166302; c=relaxed/simple;
	bh=qJP+1snHGVcuT72mDcsOpZlqJ/KIzbMZxkqkXsU6bQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfRw8GSeUQb2LoXkDam/282OYBJqeNe38d+3SBXEL4jooljLkKfGBampshql30/3IOulYcmTmk9j+1V4Uo0AkiIP6V4D5/fgW21zY9b4oi3KMXRDDIJaa+pIicCUNASqUmc+njiOG/f0JvVSC07RxdAJ3m254d5ffWY8HuSnu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa7/XjYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF4FC4CED6;
	Sat, 14 Dec 2024 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734166302;
	bh=qJP+1snHGVcuT72mDcsOpZlqJ/KIzbMZxkqkXsU6bQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oa7/XjYITj5mkQY9V4xCyLCPTQOpughEABEO441BWcjvoVhxWAFnOznpOGa4poz6j
	 mEx3BDs1NXZAAh/z+i4lmRYgXj64JSvsnL4hdd5XvtBO4mh2jHbK1/pxCD/vIwcG+Z
	 tnqW/phgYR5iUgaHLwoACUrNxcO18JrkhENs4XIfQgW/cUTXVskPK8aF/JTl0l7yMR
	 zFKUGorHbzHntyx41dOHBYjPeruRRscMYIopg8AJnZW5sO6Hcc5cWdQ/2MahsGwJ2Z
	 PpL6YAgiPnDpkBA8/2isIL7Y1hWGEZT/kz0NcG1poVv7nP35n1BeiTpB04akk4juMz
	 0zic8wKlVymDg==
Date: Sat, 14 Dec 2024 16:51:34 +0800
From: Peter Chen <peter.chen@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] usb: cdns3: rename hibernated argument of
 role->resume() to lost_power
Message-ID: <20241214085134.GB4102926@nchen-desktop>
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-3-28a17f9715a2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210-s2r-cdns-v6-3-28a17f9715a2@bootlin.com>

On 24-12-10 18:13:37, Théo Lebrun wrote:
> The cdns_role_driver->resume() callback takes a second boolean argument
> named `hibernated` in its implementations. This is mistaken; the only
> potential caller is:
> 
> int cdns_resume(struct cdns *cdns)
> {
> 	/* ... */
> 
> 	if (cdns->roles[cdns->role]->resume)
> 		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
> 
> 	return 0;
> }
> 
> The argument can be true in cases outside of return from hibernation.
> Reflect the true meaning by renaming both arguments to `lost_power`.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 4 ++--
>  drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
>  drivers/usb/cdns3/core.h         | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index fd1beb10bba726cef258e7438d642f31d6567dfe..694aa14577390b6e9a98ce8c4685ac8f56e43ad4 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -3468,7 +3468,7 @@ __must_hold(&cdns->lock)
>  	return 0;
>  }
>  
> -static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
> +static int cdns3_gadget_resume(struct cdns *cdns, bool lost_power)
>  {
>  	struct cdns3_device *priv_dev = cdns->gadget_dev;
>  
> @@ -3476,7 +3476,7 @@ static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
>  		return 0;
>  
>  	cdns3_gadget_config(priv_dev);
> -	if (hibernated)
> +	if (lost_power)
>  		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
>  
>  	return 0;
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 4a3f0f95825698f0524cace5c06bfcf27f763149..7d05180442fb94c5d1aab3d8ef766e365685f454 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1973,7 +1973,7 @@ static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
>  	return 0;
>  }
>  
> -static int cdnsp_gadget_resume(struct cdns *cdns, bool hibernated)
> +static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
>  {
>  	struct cdnsp_device *pdev = cdns->gadget_dev;
>  	enum usb_device_speed max_speed;
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 57d47348dc193b1060f4543c2ef22905f464293b..921cccf1ca9db27a66b06c7c7873b13537c74b05 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -30,7 +30,7 @@ struct cdns_role_driver {
>  	int (*start)(struct cdns *cdns);
>  	void (*stop)(struct cdns *cdns);
>  	int (*suspend)(struct cdns *cdns, bool do_wakeup);
> -	int (*resume)(struct cdns *cdns, bool hibernated);
> +	int (*resume)(struct cdns *cdns, bool lost_power);
>  	const char *name;
>  #define CDNS_ROLE_STATE_INACTIVE	0
>  #define CDNS_ROLE_STATE_ACTIVE		1
> 
> -- 
> 2.47.1
> 

