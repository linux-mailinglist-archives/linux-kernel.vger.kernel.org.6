Return-Path: <linux-kernel+bounces-187796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7328CD8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79171F21BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0DF1CF9A;
	Thu, 23 May 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRqcliRi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22517BD9;
	Thu, 23 May 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482731; cv=none; b=kTt/Vnk4oFou5kyFS/6Nqe0p7n9feZWUmVadMqwsD9mBn9WGUfmum22t06nqBWlrICN0hG/yvNnOPYSBdrCkv4JBG/HNpPUx9GxI/GQrymZP0aSzyK8N66OhKsyHjorzrVZgUx6QdeqvId7Z1BuWMT9pzk2+4PEYW8Lm+lNuu3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482731; c=relaxed/simple;
	bh=Qp2cK468rwwqNdV1hrKOlsM51j4WX1baGTX5Xh/9+QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzLETVXmQbH6mRzLYoOa91DfKvQPGfdOVAVksK+pF6QkkiN7rXMjRAdcnxnXMeOPW61FTERhfpvJ4Yb2ZDrgJUQeuECGw8gWvBdtCtU+N5TOfCjKXDtNAS3RFGH2B7ZDpCmm/46mWZibpoaUqbgpu18KGe0gbHAvT1d68jPHtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRqcliRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54197C2BD10;
	Thu, 23 May 2024 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716482731;
	bh=Qp2cK468rwwqNdV1hrKOlsM51j4WX1baGTX5Xh/9+QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRqcliRiuLMx4OZ3+vAz+rn96k7hHfMVewUnMViITYeJkJYH3TXmpEv9CwPWcJqDW
	 2/4Vlp9Gn9unaoGaXkF2ygBF1Gg0CUyt9kTwaiTKgwIOP5AqM60RWBHRlk4pQXzR6h
	 AgfIWT+tUrv41Et6qZLseQDJ/vUKpzLGqOKIK+mu1cgC1KNe9peVA/Oqyl4aVyXSs9
	 LHVrGYj4arYo3jh0DxcKwTG9YlFCDit5jtYicUzPInHsx1D5TgrqctxvO1S0+1kDQg
	 mP5NH7/8JvL5DGLH9dHv+D1u+EYRM1FKDSK7LR8KiSa6zy9ZZjGmlnfYIYXSGDOi1P
	 GWgeTLFl6oFmg==
Received: by pali.im (Postfix)
	id 5643B820; Thu, 23 May 2024 18:45:28 +0200 (CEST)
Date: Thu, 23 May 2024 18:45:28 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell G15 5511 to fan control
 whitelist
Message-ID: <20240523164528.xrq56r4m3snweofl@pali>
References: <20240522210809.294488-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522210809.294488-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716

On Wednesday 22 May 2024 23:08:09 Armin Wolf wrote:
> A user reported that he needs to disable BIOS fan control on his
> Dell G15 5511 in order to be able to control the fans.
> 
> Closes: https://github.com/Wer-Wolf/i8kutils/issues/5
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 48a81c64f00d..942526bd4775 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1545,6 +1545,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
>  	},
> +	{
> +		.ident = "Dell G15 5511",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Dell G15 5511"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
> +	},
>  	{ }
>  };
> 
> --
> 2.39.2
> 

Looks good,

Acked-by: Pali Rohár <pali@kernel.org>

