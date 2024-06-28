Return-Path: <linux-kernel+bounces-234632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AA091C8D5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E3D1F25B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09281ABA;
	Fri, 28 Jun 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XesoriSQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311B80630;
	Fri, 28 Jun 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611828; cv=none; b=b6RYmK0FLDnc4JpKaw1qyX7p9+47TOjeQHLYpZcLRsXzBGWXqOBtQhogmFWWovsWzDxNT9ac8Dk5Sk8gWspZlTC4sGTLjmkFo2X21smYyLzeg5nEdd+qcD1jeGtqmBlHWM54RJIk/pUcY7yXre+CL7AKPCaEh8XPFjpkwmx7HTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611828; c=relaxed/simple;
	bh=2SzSLQDtkY9neHotg9G5l9A/qZHaOlO/5cgaX8OuoYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb8dmySztojSGZnVE/QyvLJsWsIo3pBt4cnVMWZpIc4sfXGmAdEle4t5/A7He63cMIH34BTw3v6ELbeaqRVwTWo3UHTKBk/JqPIMLjOPBaaMnoPssnpizR1df+C/kxo02ylpjeflsiWp+HhRLGMxfLCCEHblSrUjvSOhM4DDuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XesoriSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B41C116B1;
	Fri, 28 Jun 2024 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719611828;
	bh=2SzSLQDtkY9neHotg9G5l9A/qZHaOlO/5cgaX8OuoYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XesoriSQQdUF02x7RS84iZD03IruGXLnqqOLjSrbFRPIw5rIbKH5RUrHiv0YdYJvd
	 ayFozyvx0EshMjX8xEmOZIvexUrItS4mn9ysJTDHH1f4shANqgnmAEGG+9EicBE3SP
	 38E5LJm/8cdc9r1ouCIT4RnDW2R1dfn/oP0BzcnJdfPHCVJwh7lh+VpHY2GFO3VTJN
	 EIbSz7NLX5nqgWC9YSo7PpCmbWpvaUl+1DZy5xXpKlGPPmUgdMA3YWiGSsJN6ZTsr3
	 eF94ESmTP5yKwRZX1Eay5WMd0biSLZco6jC3GzMWOHfPY6UG9SG+siWTnyQHlIlg98
	 RvpdVTqJgx+FA==
Received: by pali.im (Postfix)
	id CDAF37A6; Fri, 28 Jun 2024 23:57:04 +0200 (CEST)
Date: Fri, 28 Jun 2024 23:57:04 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell OptiPlex 7060 to DMI table
Message-ID: <20240628215704.i6ohbuz2zgegr27p@pali>
References: <20240628214723.19665-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628214723.19665-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716

On Friday 28 June 2024 23:47:23 Armin Wolf wrote:
> The BIOS on this machine is buggy and will in some cases return
> an error when trying to get the fan state, but reading of the
> RPM values and the temperature sensors still works.

Does this error affects machine usage (e.g. freeze of CPU or some
erratic fan behavior)? Or just kernel does not receive fan state and is
unable to report meaningful value to userspace?

> 
> Closes: https://github.com/vitorafsr/i8kutils/issues/38
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 2 ++
>  drivers/hwmon/dell-smm-hwmon.c         | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index 977263cb57a8..74905675d71f 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -360,6 +360,8 @@ Firmware Bug                                            Affected Machines
>  ======================================================= =================
>  Reading of fan states return spurious errors.           Precision 490
> 
> +                                                        OptiPlex 7060
> +
>  Reading of fan types causes erratic fan behaviour.      Studio XPS 8000
> 
>                                                          Studio XPS 8100
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 48a81c64f00d..c75bfe93f2f6 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1263,6 +1263,13 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
>  		},
>  	},
> +	{
> +		.ident = "Dell OptiPlex 7060",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7060"),
> +		},
> +	},
>  	{
>  		.ident = "Dell Precision",
>  		.matches = {
> --
> 2.39.2
> 

