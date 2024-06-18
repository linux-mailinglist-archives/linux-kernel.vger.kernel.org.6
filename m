Return-Path: <linux-kernel+bounces-220246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A890DE69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18571C208A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB91741F0;
	Tue, 18 Jun 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YizVcSxT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA2176AC8;
	Tue, 18 Jun 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746138; cv=none; b=rHKHUBiNItTaxcsp1pDYpfEGt5Hpx0txjzLVJIRywt3SVjFAhznSe0NYuohc8EvPsOVvlDg7O8QNne6MpRjuDo5wPp/phWzsSK4Hp19At2MWP64bjNvdocjZvyxxIfxdFt9uLliV7FnVU8BzWgiJG7NqFtHLerNl86vMLTVoueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746138; c=relaxed/simple;
	bh=6hlB0hECyGkvGQGtEMCvgHqYDEJrDxinQ4kICJmV+7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cs67qGPNoC5LZPxIQzdo18SXJ5sT5nO3O4Iy1vCJEWeFkZa8te9bLUNR7tfyAw0jGvliz7H4Yjr/ZJPvRCHmZ5pwaXQrewCZXh9gSKNlc2erXcGvz4VRXSm7NwDiTsL33wK7BMPDx5WPI+MnLb1RHgWplcYzdbuly2GQXhc7UOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YizVcSxT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7R2zIVkttgawynmDjOMRLnd8AzpY7WCckj0OL06otS8=; b=YizVcSxTIzbxo5DGes/qs931iR
	6ru4GPoSaeggSasc+l+NvPru5fEDsFEu0lDMyB5P+wJrn7kLOO+KRXX02z4TvUcfhSU/4L/Tr0PEf
	FVs/4ApvgFHhzrntYs5YrVa9ntaWYM5KRMy11LF6uFSb9Dg4i2dC5lLnGAswbJRHRfrWE+03ZKza1
	zIDwrxhXEcsqUpI5PEqcwTG4dHIFyqFW2nz+xZhEEbKtZ7TciVorIsuo1LaC5g83dt1EibGBCh5zh
	VK9t+BQgFhia5dCQ7rUKBeO2msOhg5tmUTcLkRIF0gq/SI0qJQZkNiMkKv1YAVgsxjWtgJuuQw13E
	cKyCSYYg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJgNp-0000000Gff8-2UuT;
	Tue, 18 Jun 2024 21:28:53 +0000
Message-ID: <c2ef0570-0392-4290-a008-df74f980f76d@infradead.org>
Date: Tue, 18 Jun 2024 14:28:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] firmware: imx: adds miscdev
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
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-5-a7d28dea5c4a@nxp.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240617-imx-se-if-v3-5-a7d28dea5c4a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 6/17/24 12:29 AM, Pankaj Gupta wrote:
> Adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like
> EdgeLock Enclave from:
> - User-Space Applications via character driver.
> 
> ABI documentation for the NXP secure-enclave driver.
> 
> User-space library using this driver:
> - i.MX Secure Enclave library:
>   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
> - i.MX Secure Middle-Ware:
>   -- URL: https://github.com/nxp-imx/imx-smw.git
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  Documentation/ABI/testing/se-cdev |  42 +++
>  drivers/firmware/imx/ele_common.c | 153 ++++++++-
>  drivers/firmware/imx/ele_common.h |   4 +
>  drivers/firmware/imx/se_ctrl.c    | 694 ++++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h    |  49 +++
>  include/uapi/linux/se_ioctl.h     |  94 ++++++
>  6 files changed, 1034 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
> new file mode 100644
> index 000000000000..699525af6b86
> --- /dev/null
> +++ b/Documentation/ABI/testing/se-cdev
> @@ -0,0 +1,42 @@
> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> +Date:		May 2024
> +KernelVersion:	6.8
> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> +Description:
> +		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-

		                                   for secure enclaves

> +		Enclave(ELE), SECO. The character device file-descriptors

		                                         file descriptors

and what is SECO?

> +		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-

		                                            userspace        secure

> +		enclave shared-library and the kernel driver.

		        shared library

> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>
> +		 ioctl(s) are used primarily for:
> +			- shared memory management
> +			- allocation of I/O buffers
> +			- get mu info

			- getting mu info

> +			- setting a dev-ctx as receiver that is slave to fw
> +			- get SoC info

			- getting SoC info

> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		  Currently the only useful flags are O_RDWR.
> +
> +		read(2)
> +		  Every read() from the opened character device context is waiting on
> +		  wakeup_intruptible, that gets set by the registered mailbox callback

		  typo in that name?
		or is it something that this patch series introduces?

> +		  function; indicating a message received from the firmware on message-

		  function,

> +		  unit.
> +
> +		write(2)
> +		  Every write() to the opened character device context needs to acquire
> +		  mailbox_lock, before sending message on to the message unit.

		  mailbox_lock before

> +
> +		close(2)
> +		  Stops and free up the I/O contexts that was associated

		            frees up                 that were associated

> +		  with the file descriptor.
> +
> +Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
> +		https://github.com/nxp-imx/imx-smw.git
> +		crypto/skcipher,
> +		drivers/nvmem/imx-ocotp-ele.c


-- 
~Randy

