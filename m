Return-Path: <linux-kernel+bounces-391084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF49B827A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F442819CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E31C9B82;
	Thu, 31 Oct 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyofyD93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4451EA90;
	Thu, 31 Oct 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398820; cv=none; b=WyqPiWi0DS85jzsXqOQ97iMT49Kb99I9D18iD2JaMPdrDpizV3cu8b8atXPVcuam+DDHbrJPyshCZpH9aNuS89pS58vVE5ZH9L+/vdCHOC3vJlaRSgqe03oofgWXuzBqVHaxGLNwWHVYL7dSf0JllHIT7bWBQ/qpvHT+hUp8UcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398820; c=relaxed/simple;
	bh=t1Qaw+eHLk+0ELHD31Y2cC89+Y0/KawO1t9fK9DxfPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvIB4U9gp25sD83tMtTmYDs/bcvIF4di2c7e3+yv3JiCTZUlsJWUtaSPcpotlro4Mhgkmq1nzRBRpxs0hWBFFJNdATKMLnz3mXq5ukVje1Ry1C3ArHcslYQlF8CIyI8rkqfD7aOyD6TruCcBsILChA5lBHqUpuY1dDiKbFTnqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyofyD93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E5FC4CEC3;
	Thu, 31 Oct 2024 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730398819;
	bh=t1Qaw+eHLk+0ELHD31Y2cC89+Y0/KawO1t9fK9DxfPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyofyD93LK7jqPeXVdvN6sBeqdVCbn+3uV3h57GOLnyp+H4YuGONRNBjnJ4qxhvjF
	 KrnLKNqQaRRlLwyR4jSx/YPoV4VaCHaWaW8O2s81tVwnwx1jf4ctv5KZD3OhoDirBj
	 m43UaA9HRJC0rmcJkXoqYzHgq33822kpyyMrl83k+AU9GM/HAdvGd2YkJdA7/lk4W1
	 +wgv6KS6yL71mybwfOEHSvta0AIIdCMhnQvVOa31aBSVJDfzrneM7y/kAlc49im/ID
	 N2/0EMrsNtW5ceB08GkcnGval6jZ0zdV6LUgyJ72lciNK2rG1tnH9KKWc4AOSlXmGi
	 75HFjeFX1tF5Q==
Received: by pali.im (Postfix)
	id 390FF83D; Thu, 31 Oct 2024 19:20:13 +0100 (CET)
Date: Thu, 31 Oct 2024 19:20:13 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH v2 1/2] dell-smbios-base: Extends support to Alienware
 products
Message-ID: <20241031182013.i2ze3h45c4ldgfbj@pali>
References: <20241031154023.6149-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154023.6149-2-kuurtb@gmail.com>
User-Agent: NeoMutt/20180716

On Thursday 31 October 2024 12:40:24 Kurt Borja wrote:
> Fixes the following error:
> 
> dell_smbios: Unable to run on non-Dell system
> 
> Which is triggered after dell-wmi driver fails to initialize on
> Alienware systems, as it depends on dell-smbios.
> 
> This effectively extends dell-wmi, dell-smbios and dcdbas support to
> Alienware devices, that might share some features of the SMBIOS intereface
> calling interface with other Dell products.
> 
> Tested on an Alienware X15 R1.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
> v2:
>  - Commit message reflects Alienware devices may not necessarily support
>    the SMBIOS interface
>  - Commit message now has "Tested on"
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
>  	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
>  		pr_err("Unable to run on non-Dell system\n");
>  		return -ENODEV;
> -- 
> 2.47.0
> 

