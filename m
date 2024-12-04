Return-Path: <linux-kernel+bounces-432233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C9C9E4805
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C27A163EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED901F03F8;
	Wed,  4 Dec 2024 22:39:36 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADB18DF6D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351975; cv=none; b=gu2ru7BlGnpCC4mcQGWcQBsKAcG7IeDauaYHyH8ab3ZaVfJgIixFGSCpQIT5eGpdo+MjkxZy3q35twyL77PD6DAFEr1bifamWqZB85WLxl1gNu5txTY7lgnUMLNnXsJRO7uOuHS38S4uIYgsKdKeggJdIiFaMJeRV96h5p8DoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351975; c=relaxed/simple;
	bh=0UNkFtz6f5HtGQSbPYlh1rvv2dNm+EfE2lI1BlAxaVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO1TJ9LUCosfMyYLTUF+rcz2LlN4LnFa+MvmsSsWyguSKpMfVzaa36qjiUzivPdSE2dLftmwXmDP2f6VvpYebSPmeXFR7sN2JDgD8QQkDBIcIFNyL4HVpfQEWL98BI7OMyL1a0X/W0tyWP52YUJ4X4cV8xtdN9rUQKwaT7eqsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 09670A2003;
	Wed,  4 Dec 2024 23:34:22 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBM__F55PESV; Wed,  4 Dec 2024 23:34:21 +0100 (CET)
Received: from begin.home (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 4F43BA1FFD;
	Wed,  4 Dec 2024 23:34:20 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.98)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1tIxwq-00000003GVc-1GEa;
	Wed, 04 Dec 2024 23:34:20 +0100
Date: Wed, 4 Dec 2024 23:34:20 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	masahiroy@kernel.org, nicolas@fjasle.eu, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: Fix the wrong format specifier
Message-ID: <Z1DY7PPuTA0y86ey@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	liujing <liujing@cmss.chinamobile.com>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, masahiroy@kernel.org,
	nicolas@fjasle.eu, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
References: <20241204150303.8219-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204150303.8219-1-liujing@cmss.chinamobile.com>
Organization: I am not organized

liujing, le mer. 04 déc. 2024 23:03:03 +0800, a ecrit:
> Make a minor change to eliminate a static checker warning. The type
> of '(unsigned int)kp[i]' is unsigned int, so the correct format specifier should be
> %u instead of %d.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
> index 0882bab10fb8..9bd78e1f023b 100644
> --- a/drivers/accessibility/speakup/genmap.c
> +++ b/drivers/accessibility/speakup/genmap.c
> @@ -153,7 +153,7 @@ main(int argc, char *argv[])
>  			continue;
>  		printf("\n\t%d,", lc);
>  		for (i = 0; i < max_states; i++)
> -			printf(" %d,", (unsigned int)kp[i]);
> +			printf(" %u,", (unsigned int)kp[i]);
>  	}
>  	printf("\n\t0, %d\n", map_ver);
>  
> -- 
> 2.27.0

