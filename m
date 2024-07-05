Return-Path: <linux-kernel+bounces-242881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D3928E51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1422875CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54113C9C8;
	Fri,  5 Jul 2024 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsLAefyy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E51F61C;
	Fri,  5 Jul 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720212256; cv=none; b=GbrcZZh0VFz47LL6ydqwBjSqrtk2Knxan91ApJpwBFLEGfGKpIFOVP7fBvoT7EVEWcEUciJDBzoJeA8x+HEtBjTD5tiUwD6hWH3XgdDc9HZGdjhc3NNM5uaF0aB7AiZSCebFM2KtiCZtp+nzcSUpjA2eazBL5eshqJxP+IdsXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720212256; c=relaxed/simple;
	bh=E0DMI2N+rLJVjmBgl8H/STkCxc80BZbM9Ut6SYTItVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUeODDXBqr/e+1LmXAGD2OHdSFeyMZuDZV8adQIpgkRg7+RsZInSb+c1eGf0PWu/aYDOArfBGWis9h6jrPfrbHda+TzWYnfKFW/lesZvSJwNFgatbVv07h/MmhMPrhF08G99bhOb6hofIwigohHTg/6wBF1Wjp6Uj/JcIxBpfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XsLAefyy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WAVTkyGIUNVQYbnMhsGGBhrzpc4yLy1OJogqCv6P6Bw=; b=XsLAefyyJd3YZZ+jdAB7/gxNyy
	WYOKFxzzFdap0yqppWFgnCcQ8I96hr3/cKmIN/h58UiK9emBD8LZadOWHGWkPQBDRYb7XJ4ZYHriw
	mh/v0P5zZKsajXgS2iQw0iHqJuvLViBz4t/bvFKeLmhtbsdHpoWLdHwAEa/5u5nlThIWu6ZfIyj6u
	XJ+fwuUsMJiTln8rKrGHTqIyJ+WtixHoIRLIUsogVP0UwmrLCvXyAJtMIK6LqUBhtHohqOPDPCjgq
	6GiLwZF1k2UCAUA0qkZtRAITiOzjLeQKDo0XKmKfMLqXyHocVeprSmly/LflesIJFBvTIU4pgNBNx
	t1HJzxeg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPpmm-0000000Go3q-45To;
	Fri, 05 Jul 2024 20:44:05 +0000
Message-ID: <318ebc29-df94-495d-b2bc-b24340c3d82a@infradead.org>
Date: Fri, 5 Jul 2024 13:44:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-4-52d000e18a1d@nxp.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240705-imx-se-if-v4-4-52d000e18a1d@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/5/24 6:52 AM, Pankaj Gupta wrote:
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 183613f82a11..56bdca9bd917 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -22,3 +22,15 @@ config IMX_SCU
>  
>  	  This driver manages the IPC interface between host CPU and the
>  	  SCU firmware running on M4.
> +
> +config IMX_SEC_ENCLAVE
> +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
> +	depends on IMX_MBOX && ARCH_MXC && ARM64
> +	default m if ARCH_MXC
> +
> +	help
> +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
> +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +          like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
> +          Unit. This driver exposes these interfaces via a set of file descriptors
> +          allowing to configure shared memory, send and receive messages.

The 4 lines above should be indented with one tab + 2 spaces instead of _many_ spaces.

-- 
~Randy

