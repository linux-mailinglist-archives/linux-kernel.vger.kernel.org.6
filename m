Return-Path: <linux-kernel+bounces-284210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15A94FE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A5B24127
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666C78289;
	Tue, 13 Aug 2024 07:17:19 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCF76048
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533438; cv=none; b=I9HsDfDXfS3ADV7aTIJ3+1ADUjj9iIyFcfD+5WQaCjjYSdUUaZY3tOtU6jzm/nfJPaHAPM/FUyML3tqnRBnTBedLhboNmG5ZXCm4jkAfsmdozk68kxu5WVuo7oJXvgzHe6Vge3hQO0auZHkgSZjtLHxsWvD72QWdtx3welGSGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533438; c=relaxed/simple;
	bh=BzqaiPlDEOmeYOBkBDSR0wWUbyiM+aj+DrAAsg1bNoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwEYn3AE2MdcBcGluGOGjymUaM2wmD4xl8QeP/3oXd6Kn2G3YhH9lKe8ozx+vt+a+b8ZGqqaqqmtbGYgq5VIdM9LYhejIFrUMlBfgMqJ0qsicflE6bZHS3aopWAjaQYXoWooybVC+rAwP0YEAvftk3q0UqmZYmk5Sx8joMvfrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id B9BA7A02C0;
	Tue, 13 Aug 2024 09:08:31 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2IvdH6c2ZxE; Tue, 13 Aug 2024 09:08:31 +0200 (CEST)
Received: from begin (202.250.133.77.rev.sfr.net [77.133.250.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 19763A02BF;
	Tue, 13 Aug 2024 09:08:29 +0200 (CEST)
Received: from samy by begin with local (Exim 4.98)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1sdlds-00000004AHp-0gDD;
	Tue, 13 Aug 2024 09:08:28 +0200
Date: Tue, 13 Aug 2024 09:08:28 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: bajing <bajing@cmss.chinamobile.com>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: genmap: remove redundant post-increment
Message-ID: <20240813070828.65yluzkszaurva5f@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	bajing <bajing@cmss.chinamobile.com>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
References: <20240813031753.5902-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813031753.5902-1-bajing@cmss.chinamobile.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

bajing, le mar. 13 août 2024 11:17:53 +0800, a ecrit:
> In the while loop, the variable lc is unused and is reinitialized later, so this redundant operation should be removed.
> 
> Signed-off-by: bajing <bajing@cmss.chinamobile.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/genmap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
> index 0125000e00d9..836276327bdd 100644
> --- a/drivers/accessibility/speakup/genmap.c
> +++ b/drivers/accessibility/speakup/genmap.c
> @@ -72,7 +72,6 @@ main(int argc, char *argv[])
>  
>  	open_input(NULL, argv[1]);
>  	while (fgets(buffer, sizeof(buffer), infile)) {
> -		lc++;
>  		value = shift_state = 0;
>  
>  		cp = strtok(buffer, delims);
> -- 
> 2.33.0

