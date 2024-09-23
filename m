Return-Path: <linux-kernel+bounces-335862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80797EBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4228B21542
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA581990C7;
	Mon, 23 Sep 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqoLV1xa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBD1E502;
	Mon, 23 Sep 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095345; cv=none; b=S7WfijmOGExaY857PBtZQl2HF9CX0vxLC1DPCEHDAZqKg07O09FWqOQFxfDzPLjS5tBAalLHszYNUA/Fz8EbEX81ZYwqPKINuGKF7pKTel2oaSBHadwzGxwfmOV1R5ekMteVqgkd0UqUQhOAlKgfM+BDU0dSOv1LoEfO7GyOEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095345; c=relaxed/simple;
	bh=ZO3tApegJN6iMdFa/YiioltGe4UFdob1JTPszLVjSeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngPCmpibV14f0SFQ894K6tUwq+cU03aHdQ55L/xS/sxR1Cy3bbVlZ5wB40WAPe/gf6ihXZ4Z1wgiDuXLZBZuVwR3ucC2oLaLs2fwuWNIm5Ig8KXV1snxNXKnelBNdw0V6/SvwM2QWmAuaQe52hLFKZ266hZyFWOiDbsBrPrysU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqoLV1xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06688C4CEC4;
	Mon, 23 Sep 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727095344;
	bh=ZO3tApegJN6iMdFa/YiioltGe4UFdob1JTPszLVjSeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KqoLV1xaKOzM1GQ3p/PRn75e7qgqjWixB0Sn12pZlMC0egrirgqu272A8HlOwx3tP
	 EbZXTQhM23Zzax0J1XfPcOsdXPcd9YCGpL3SLcNNr6ar7j1AHTTXVVS8NJ0Dat4NmE
	 jM8i1XmIzmgOlqUuJgaaSZxLzhvgwjotQTzU7Sugg2FM/3IMZQ1chmM1/139dqWVDc
	 HYV0FYJFqoN/vT0PfdgFpmzJZO6QmcWaV5fhMDlpLZQrEOHJw6/XzIW4mXoa34NUJI
	 5fENLUZhDgueLJZFf6KhFckG1q0CStE1N6X+Hre5nvS8z5z6hoj/VJM65tGWTJDG09
	 MbSRcSt3G0Znw==
Message-ID: <d6ec3b8b-9405-49fa-ba39-a0bf6311a489@kernel.org>
Date: Mon, 23 Sep 2024 15:42:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] sub: cdns3: Use predefined PCI vendor ID constant
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240913131710.3630560-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240913131710.3630560-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13/09/2024 16:17, Andy Shevchenko wrote:
> The PCI vendor ID for Cadence is defined in pci_ids.h. Use it.
> While at it, move to PCI_DEVICE() macro and usual pattern for
> PCI class and device IDs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/cdns3/cdns3-pci-wrap.c |  5 ++---
>  drivers/usb/cdns3/cdnsp-pci.c      | 29 +++++++++++++++--------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> index 1f6320d98a76..591d149de8f3 100644
> --- a/drivers/usb/cdns3/cdns3-pci-wrap.c
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -37,8 +37,7 @@ struct cdns3_wrap {
>  #define PCI_DRIVER_NAME		"cdns3-pci-usbss"
>  #define PLAT_DRIVER_NAME	"cdns-usb3"
>  
> -#define CDNS_VENDOR_ID		0x17cd
> -#define CDNS_DEVICE_ID		0x0100
> +#define PCI_DEVICE_ID_CDNS_USB3	0x0100

Why do we need to change this? You did not explain in commit log.

I would call this PCI_DEVICE_ID_CDNS_USBSS3. Also see later why to differentiate with USBSSP.

>  
>  static struct pci_dev *cdns3_get_second_fun(struct pci_dev *pdev)
>  {
> @@ -190,7 +189,7 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
>  }
>  
>  static const struct pci_device_id cdns3_pci_ids[] = {
> -	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
> +	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USB3) },

For better readability I still prefer
	PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSS3)

>  	{ 0, }
>  };
>  
> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> index 225540fc81ba..2d05368a6745 100644
> --- a/drivers/usb/cdns3/cdnsp-pci.c
> +++ b/drivers/usb/cdns3/cdnsp-pci.c
> @@ -28,10 +28,11 @@
>  #define PCI_DRIVER_NAME		"cdns-pci-usbssp"
>  #define PLAT_DRIVER_NAME	"cdns-usbssp"
>  
> -#define CDNS_VENDOR_ID		0x17cd
> -#define CDNS_DEVICE_ID		0x0200
> -#define CDNS_DRD_ID		0x0100
> -#define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
> +#define PCI_DEVICE_ID_CDNS_USB3		0x0100

This is an entirely different card who's device ID should be 0x200?
Also I don't think this card supports USB3 so it is a wrong name choice.

I would call this PCI_DEVICE_ID_CDNS_USBSSP	0x200	to match with PCI driver name.

> +#define PCI_DEVICE_ID_CDNS_UDC		0x0200

UDC is used for Peripheral controller only. Is that really the case here?
originally it was called DRD. 
So how about?
	PCI_DEVICE_ID_CDNS_DRD		0x0100

> +
> +#define PCI_CLASS_SERIAL_USB_CDNS_USB3	(PCI_CLASS_SERIAL_USB << 8 | 0x80)
> +#define PCI_CLASS_SERIAL_USB_CDNS_UDC	PCI_CLASS_SERIAL_USB_DEVICE
>  
>  static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
>  {
> @@ -40,10 +41,10 @@ static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
>  	 * Platform has two function. The fist keeps resources for
>  	 * Host/Device while the secon keeps resources for DRD/OTG.
>  	 */
> -	if (pdev->device == CDNS_DEVICE_ID)
> -		return  pci_get_device(pdev->vendor, CDNS_DRD_ID, NULL);
> -	else if (pdev->device == CDNS_DRD_ID)
> -		return pci_get_device(pdev->vendor, CDNS_DEVICE_ID, NULL);
> +	if (pdev->device == PCI_DEVICE_ID_CDNS_UDC)
> +		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USB3, NULL);
> +	if (pdev->device == PCI_DEVICE_ID_CDNS_USB3)
> +		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_UDC, NULL);
>  
>  	return NULL;
>  }
> @@ -220,12 +221,12 @@ static const struct dev_pm_ops cdnsp_pci_pm_ops = {
>  };
>  
>  static const struct pci_device_id cdnsp_pci_ids[] = {
> -	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
> -	  PCI_CLASS_SERIAL_USB_DEVICE, PCI_ANY_ID },
> -	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
> -	  CDNS_DRD_IF, PCI_ANY_ID },
> -	{ PCI_VENDOR_ID_CDNS, CDNS_DRD_ID, PCI_ANY_ID, PCI_ANY_ID,
> -	  CDNS_DRD_IF, PCI_ANY_ID },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
> +	  .class = PCI_CLASS_SERIAL_USB_CDNS_UDC },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
> +	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB3),
> +	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
>  	{ 0, }
>  };
>  

-- 
cheers,
-roger

