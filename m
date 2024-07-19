Return-Path: <linux-kernel+bounces-257692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F17937D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D7C1C21289
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42920148848;
	Fri, 19 Jul 2024 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr3mcFZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5236BFA3;
	Fri, 19 Jul 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721426059; cv=none; b=VCL34HXq6k0Da8hom51RcRuMGHbehoZNOUnYlFI+asygJqUunRoh4QTDJBCjmzsqt5s5ZmnwlebtQP6FHjqVX6QoxtNoFoibofATWiYYGCzZI/GFIozM53CoJ4wjwi8sN33urKOdm2eKNl7lxhsyKIxPeIHU+/FkT5bthwOWPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721426059; c=relaxed/simple;
	bh=5S3O3HwV3cSLnwEWin8YBGqht8GA0AEQGVLmc4D/3H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRYE2tezRQYxQHcHCpDy/oY5nfjU8F4WQpTt7aDcCB9+0dgYJGTn/OsRYAVZxk2saO8g+K6gm2XvOJgqDmWrMZwQCotKT6LnSaNy6Bvf0rv/aMd1Lw/zCzjKwGiY8UVG5ZeQ/hTyErXYi15bKuTW+8/VCXqJr0yRDFovK9pm/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr3mcFZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF26C32782;
	Fri, 19 Jul 2024 21:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721426059;
	bh=5S3O3HwV3cSLnwEWin8YBGqht8GA0AEQGVLmc4D/3H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gr3mcFZHybOEWlheEtOtz+M+BK+qmfxnmtsxDYhXwHDaSG+q94OMH9bM2cqqORpkS
	 WygPjoxVmzN+fNXqsmpQLofBXV4/uMG+qdJMiUTtOd6wWhvqE0CTtTPeNqHuxrKj5C
	 I8GixgJH+TRuJophZxrVttRU0EDBCv5jJz0eYatH3xDZvIQLUkX4G+HEnlQfp+mPuP
	 w/ck8JKjoZvauuzgO0/5+vfoMLJVfqcGVbtT+3dREFYy/FqALdTBBi7SxgD8dbJ9wA
	 vy6kxE/JhndjtrXlSS4LGyXLElOSErtfIQp4i27h4vEc+zg493ouI01jTjLq0GtLmj
	 hIcU09Ts1OCLw==
Received: by pali.im (Postfix)
	id EFC8B2F2; Fri, 19 Jul 2024 23:54:14 +0200 (CEST)
Date: Fri, 19 Jul 2024 23:54:14 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell Latitude 7320 to fan control
 whitelist
Message-ID: <20240719215414.sqjkqnzb5hrgah55@pali>
References: <20240719203706.19466-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240719203706.19466-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716

On Friday 19 July 2024 22:37:06 Armin Wolf wrote:
> Add the Dell Latitude 7320 to the fan control whitelist to allow
> for manual fan control.
> 
> Closes: https://github.com/Wer-Wolf/i8kutils/issues/8
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index c75bfe93f2f6..ac4484bd949b 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1488,6 +1488,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell Latitude 7320",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 7320"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
> +	},
>  	{
>  		.ident = "Dell Latitude E6440",
>  		.matches = {
> --
> 2.39.2
> 

Looks good

Acked-by: Pali Rohár <pali@kernel.org>

