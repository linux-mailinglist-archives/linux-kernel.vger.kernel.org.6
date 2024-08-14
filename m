Return-Path: <linux-kernel+bounces-287301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A2095261B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCF91C21191
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D014D433;
	Wed, 14 Aug 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RPpvOwDx"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8413C820
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676959; cv=none; b=sITTsDtyYIi5Xjq26v1PKNRrrFkhbEkNvQ1JsREi1oSwtBGT7LD4YzykducdfJo5AioGFzxGcBPgB+EHLnBT/wOpc0XAZGsmCJU7UooAT3fPS9ZasyYBYstQmTek+arYUg52Q6E4c9EudZujEAOej6olMVZFBzvbXNVNLMDs6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676959; c=relaxed/simple;
	bh=H7nxzJ3p6l88rfM0aMfG4qGoGLko9bbr610DQl34zwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INsfHB4Xy+KWpzHTt80ykmJteNJToiGzpfcNd+ruHrH6BGce6m0pJSlCPED3lhXlHMZJxegIEHeeQkJGZ38/BS0civYuR9ntDYlYRe3fYTUcS4Aba9EqasajRqph3/dvwrJ3GIC1VKG2ORjVOmjzkfWSqWg75DCtzDnpmHiuWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RPpvOwDx; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9457240004;
	Wed, 14 Aug 2024 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723676948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zcxP5EsgtxCZMUGLLhH3WKQwDy1VPGiAYJ745P2bBuE=;
	b=RPpvOwDx42C6sY67jHhI6CO1krXDCwlaQyGIj1tzG8lZc5IJ8/ZZytMJRCtkAmXPiMAICz
	phSimiANRz8kHSw6geq0AXd2bRhoBv87ayWGzaPv3lv7f2fg+RVBgyxN41KIMihy6uLqHT
	AMyGbNnbTatHtkQ67/P2aHmm/hCz762tCiLIl1MSIzD4OUvm+25jmkkhPQ5Ione2vwB+I9
	fXri6cFyXgzRWWU+JrQNlLcBWt0cicu0VIDAkE2v3ocKkvU4ArOWz7hSerPlESBgncmOKY
	d141gwpw3/bGtM6NhsqWlxNPM2D+hGgxfnAE//tOUWobO4XSoi9c4/m8dkMNKA==
Date: Thu, 15 Aug 2024 01:09:07 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
	pthombar@cadence.com, stable@kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C controller
 driver maintainer
Message-ID: <20240814230855a6d6b54c@mail.local>
References: <20240814210915.4046554-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814210915.4046554-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 14/08/2024 17:09:15-0400, Frank Li wrote:
> Add Frank Li as NXP i3c controller driver as maintainer and add mail list
> imx@lists.linux.dev for it.
> 
> Add Frank Li as I3C subsystem reviewer.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Recently, I submit many i3c related patches and become familiar with i3c
> protocol. So add me as svc-i3c-master.c maintainer.
> 
> I reviewed other i3c patches. So add me as i3c subsystem reviewer.
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b96899a78890..92da600c3f189 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10701,6 +10701,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
>  F:	drivers/i3c/master/i3c-master-cdns.c
>  
> +I3C DRIVER FOR NXP I3C IP
> +M:	Frank Li <Frank.Li@nxp.com>
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> +F:	drivers/i3c/master/svc-i3c-master.c

I guess you should rather add yourself to the existing entry

> +
>  I3C DRIVER FOR SYNOPSYS DESIGNWARE
>  S:	Orphan
>  F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> @@ -10708,6 +10715,7 @@ F:	drivers/i3c/master/dw*
>  
>  I3C SUBSYSTEM
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +R:	Frank Li <Frank.Li@nxp.com>
>  L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  C:	irc://chat.freenode.net/linux-i3c
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

