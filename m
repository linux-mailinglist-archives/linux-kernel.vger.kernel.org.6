Return-Path: <linux-kernel+bounces-320458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB2970AA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB3DB21275
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BF1779BA;
	Sun,  8 Sep 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IbWSfQ7u"
Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2C38F9C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725839499; cv=none; b=qiNr95ZXMl+sxs8XMhunYOt8axP4hqMrv+K/kg/J9G+Ko0KVzHBItbRz6pDk7GdScrentFCKDv+jnslngcc+VGl/SGCD9XF4B+ILO6dozibwQBUo05NEmXzfQ5ONy/N/SmvLs7uv3+0k0q3ycwUFMVMf069gEQx83ifoO2WcsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725839499; c=relaxed/simple;
	bh=EBryZdcz714do1mPnDAH6k5ZNjgJ36jHisPZ74d9Y+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvE4O0EOVHnngjeeA0unkmk2AwFQrJWZ6yORfzugnyCV7RQvZ3bUAygQWiSh3utmnY04/G0OynkbfdgFf9zmNCs7PHkyEboB7UtxPiwS1F26gl0eLyXW/f0d7Zmw2qbhqpLtiT+mxMLSTNBgkWZdY2Iv7uoI+aWi3+pRv/DSxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IbWSfQ7u; arc=none smtp.client-ip=17.58.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725839497;
	bh=ovAOMviYZ5bSsgrZCk4yESoIqIlWOIEGtYOKesznvVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=IbWSfQ7u4kd63nIxSlY63P8SbqCYfnbeKyS5TC1gFjcJWI8bYLwfVhGcAvwO/xUhU
	 hR+rE6oK7z7TRIQqGJQzdYCyf/282Ba+ALEJm+b0N4NkDFkAD0JCwHxm8OBQE6PapP
	 bt8tKPqFnxlf9MpnrQrlsbglXYEiJxDGd14LQ3dzVgMxVRa85bZYWDh6qr4xHaEfEe
	 DPvKxDZa+G++F5kkg/4Ec1yVeu4TaujvXpQIss0h4FCsZ1IOal7zLuD0O5WMVpsLrw
	 8V7BD+Vb4OME/oPjfa+DEqvU0nqOCjfzT915Up1caNuGiHtMG+ea+UgAYUFs0bIbQp
	 c3qkIdWoq4OlA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 6B52174021C;
	Sun,  8 Sep 2024 23:51:32 +0000 (UTC)
Message-ID: <3a907e77-792d-4bf1-8685-db48f607b562@icloud.com>
Date: Mon, 9 Sep 2024 07:51:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
 <20240909-fix_amba-v1-3-4658eed26906@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240909-fix_amba-v1-3-4658eed26906@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9r5L0a7NbYNATNvayp6rGPEYGwRHiStY
X-Proofpoint-GUID: 9r5L0a7NbYNATNvayp6rGPEYGwRHiStY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409080207

On 2024/9/9 07:37, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> amba_match(), as bus_type @amba_bustype's match(), reads periphid from
> hardware and may return -EPROBE_DEFER consequently, and it is the only
> one that breaks below ideal rule in current kernel tree:
> 
> bus_type's match() should only return bool type compatible integer 0 or
> 1 ideally since its main operations are lookup and comparison normally.
> 
> fixed by moving reading periphid operation to amba_probe().

or move to amba_dma_configure() which is the first bus_type's function
called after match()?

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/amba/bus.c       | 55 +++++++++++++++++++++++++++++-------------------
>  include/linux/amba/bus.h |  1 -
>  2 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 033d626aff46..8fe2e054b5ce 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -188,7 +188,7 @@ static int amba_read_periphid(struct amba_device *dev)
>  	}
>  
>  	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
> -		dev->periphid = pid;
> +		WRITE_ONCE(dev->periphid, pid);
>  		dev->cid = cid;
>  	}
>  
> @@ -246,24 +246,14 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
>  	struct amba_device *pcdev = to_amba_device(dev);
>  	const struct amba_driver *pcdrv = to_amba_driver(drv);
>  
> -	mutex_lock(&pcdev->periphid_lock);
> -	if (!pcdev->periphid) {
> -		int ret = amba_read_periphid(pcdev);
> -
> -		/*
> -		 * Returning any error other than -EPROBE_DEFER from bus match
> -		 * can cause driver registration failure. So, if there's a
> -		 * permanent failure in reading pid and cid, simply map it to
> -		 * -EPROBE_DEFER.
> -		 */
> -		if (ret) {
> -			mutex_unlock(&pcdev->periphid_lock);
> -			return -EPROBE_DEFER;
> -		}
> -		dev_set_uevent_suppress(dev, false);
> -		kobject_uevent(&dev->kobj, KOBJ_ADD);
> -	}
> -	mutex_unlock(&pcdev->periphid_lock);
> +	/*
> +	 * For an AMBA device without valid periphid, only read periphid
> +	 * in amba_probe() for it when try to bind @amba_proxy_drv.
> +	 * For @pcdev->periphid, Reading here has a little race with
> +	 * writing in amba_probe().
> +	 */
> +	if (!READ_ONCE(pcdev->periphid))
> +		return pcdrv == &amba_proxy_drv ? 1 : 0;
>  
>  	/* When driver_override is set, only bind to the matching driver */
>  	if (pcdev->driver_override)
> @@ -315,10 +305,24 @@ static int amba_probe(struct device *dev)
>  {
>  	struct amba_device *pcdev = to_amba_device(dev);
>  	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
> -	const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
> +	const struct amba_id *id;
>  	int ret;
>  
>  	do {
> +		if (!pcdev->periphid) {
> +			ret = amba_read_periphid(pcdev);
> +			if (ret) {
> +				dev_err_probe(dev, ret, "failed to read periphid\n");
> +			} else {
> +				dev_set_uevent_suppress(dev, false);
> +				kobject_uevent(&dev->kobj, KOBJ_ADD);
> +			}
> +
> +			ret = -EPROBE_DEFER;
> +			break;
> +		}
> +		id = amba_lookup(pcdrv->id_table, pcdev);
> +

or read periphid in this function later since it does some
preparation for hardware ready to read which also is done by
amba_read_periphid() ?

>  		ret = of_amba_device_decode_irq(pcdev);
>  		if (ret)
>  			break;
> @@ -389,10 +393,15 @@ static void amba_shutdown(struct device *dev)
>  
>  static int amba_dma_configure(struct device *dev)
>  {
> +	struct amba_device *pcdev = to_amba_device(dev);
>  	struct amba_driver *drv = to_amba_driver(dev->driver);
>  	enum dev_dma_attr attr;
>  	int ret = 0;
>  
> +	/* To successfully go to amba_probe() to read periphid */
> +	if (!pcdev->periphid)
> +		return 0;
> +
>  	if (dev->of_node) {
>  		ret = of_dma_configure(dev, dev->of_node, true);
>  	} else if (has_acpi_companion(dev)) {
> @@ -411,8 +420,12 @@ static int amba_dma_configure(struct device *dev)
>  
>  static void amba_dma_cleanup(struct device *dev)
>  {
> +	struct amba_device *pcdev = to_amba_device(dev);
>  	struct amba_driver *drv = to_amba_driver(dev->driver);
>  
> +	if (!pcdev->periphid)
> +		return;
> +
>  	if (!drv->driver_managed_dma)
>  		iommu_device_unuse_default_domain(dev);
>  }
> @@ -535,7 +548,6 @@ static void amba_device_release(struct device *dev)
>  	fwnode_handle_put(dev_fwnode(&d->dev));
>  	if (d->res.parent)
>  		release_resource(&d->res);
> -	mutex_destroy(&d->periphid_lock);
>  	kfree(d);
>  }
>  
> @@ -593,7 +605,6 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
>  	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->res.name = dev_name(&dev->dev);
> -	mutex_init(&dev->periphid_lock);
>  }
>  
>  /**
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index 958a55bcc708..4bb3467d9c3d 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -67,7 +67,6 @@ struct amba_device {
>  	struct clk		*pclk;
>  	struct device_dma_parameters dma_parms;
>  	unsigned int		periphid;
> -	struct mutex		periphid_lock;
>  	unsigned int		cid;
>  	struct amba_cs_uci_id	uci;
>  	unsigned int		irq[AMBA_NR_IRQS];
> 


