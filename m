Return-Path: <linux-kernel+bounces-389366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F2F9B6C14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C524DB2220F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46C31CBEA1;
	Wed, 30 Oct 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lycBGzGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3B1CB333;
	Wed, 30 Oct 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312781; cv=none; b=BV5NfXZERzx0QjsGH9A36i2AacZcZMaZ6ptcZy42C9SOMplU/cNzKlABfHA451oUdHK+97WLiZjp6lB6tRlJ7mjjXG4q6VDsADGcEManls6fgI3hgxi9mcgIv0aA/rgwaXozaJ0CTbRnt1WDzD+O4FVB0ZOXGiNquJVghQupvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312781; c=relaxed/simple;
	bh=+Cev3fN7SlYcH4a500XJphKTvd7miL24lc7B03UhnwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNVji2uGpL8VocRYABMFkJpbaQjq3HxWvm4K2rtnivLGJ/q8IJWTrYzLoYr+JodN3rQQwtkhXCnGLZnBjCD1B+FLAu+aCGRC5F53cI3mq8wJIkWz5NYpWVvphYY3svx/jkp55arctNDH36s6eeVWyjJN/xT3ICNXhKJBOW7D1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lycBGzGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A940C4CECE;
	Wed, 30 Oct 2024 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312780;
	bh=+Cev3fN7SlYcH4a500XJphKTvd7miL24lc7B03UhnwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lycBGzGWvHZvCdK9W1mbrFINMzqcu5aL3s7eL29X1Z8VBhRLldNaJfbyGvTCi3rYO
	 t87hxuVNFd8rXh8l/ahPPuYN94L+xGzPweIsGqRRu78svDrnkeWm5B8Jo6uoMA6RGF
	 RvHqlpaq3ZsJ/h+ySFZUppvFCL1y0VwHnAjvI9PLtG89DJ9f/9CPA5OnRa2mGafx7H
	 sPJE3ZYh6mdSBHADzicyCCei5VHMWTmmMzgPGn4BYXpIu8nCIIiSwzT6FNz7I4AZiw
	 JBg+6O1xEtZy/plM3dahPR3GXpiEazUwx3POpM/AF6qb2fDLlma7zYAh7HITiDlmK5
	 8TYxgoY+LczCA==
Received: by pali.im (Postfix)
	id 668659D2; Wed, 30 Oct 2024 19:26:13 +0100 (CET)
Date: Wed, 30 Oct 2024 19:26:13 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, w_armin@gmx.de,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH 1/2] dell-smbios-base: Extends support to Alienware
 products
Message-ID: <20241030182613.xn3tl2khzuhft4sr@pali>
References: <20241030181244.3272-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030181244.3272-2-kuurtb@gmail.com>
User-Agent: NeoMutt/20180716

On Wednesday 30 October 2024 15:12:45 Kurt Borja wrote:
> Fixes the following error:
> 
> dell_smbios: Unable to run on non-Dell system
> 
> Which is triggered after dell-wmi driver fails to initialize on
> Alienware systems, as it depends on dell-smbios.
> 
> This effectively adds dell-wmi and dell-smbios support to Alienware
> products.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index 73e41eb69..01c72b91a 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
>  	int ret, wmi, smm;
>  
>  	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&

Are we sure that all devices with "Alienware" OEM string supports this SMBIOS API?

>  	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
>  		pr_err("Unable to run on non-Dell system\n");
>  		return -ENODEV;
> -- 
> 2.47.0
> 

