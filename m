Return-Path: <linux-kernel+bounces-299681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B7995D897
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3ED288C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95AA1C823C;
	Fri, 23 Aug 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GkGeuXaL"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE04192B63;
	Fri, 23 Aug 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448989; cv=none; b=b8AXZzB8aiOrHm/qhOlHXk9hXX1JRdR/daOS7m7ovwpT6m9V6fsE01RGR1DyqUsAuC/+qMUfrCIAUVbFTnOdA8f5QdeDkfniIRQzU4gMw0E3L7aWqxiquVQbPrUjv/wVoDWHhGQvoZUV8l8WTc94ydr8IXF1tlz0Gpilq8gIf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448989; c=relaxed/simple;
	bh=bgtNeBdFRgOMzt6/Ztu5Utjm6KRRbvyL+lMS0vWId78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8deELmCq2DK3z35EeZmJIvap16ngyDxCaBmEjVftMRUR8Riq1CeRn6j9ryei9r1zN3HJ4ZWlOoyuHcJxWSaW+NTYVd4a6N6DD8lqAe7XcAZ0CkzrU/gwrHuuc+omV9IIxiI59M6vIBX74G0k8+qnWVUz7rNAHTu4GGvCbeqtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GkGeuXaL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724448975; x=1725053775; i=wahrenst@gmx.net;
	bh=QjCeic97tlXZDf18PGTI2Ur/Bf8r70SwAOKnCpERP3s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GkGeuXaLDi6SclwKxaz5SCTABovXW/S1LjuFdzMAVqqO+1+XE+Nui/O7B8KDjrT0
	 IVA5EeUNg1dui2b44wGOrag8stYsNiJA2zonWVrIfDKcbkRFXkfB8hs5ENMGwQRgH
	 +EIB8+vPndajbg+T7sa2S2SmKVrO/7DKSLqGI0AW4yCnByzQqudm18OJsqdaaFb6a
	 6gPdOlkFZkv3wIydq++eQS/WthdNH7p4jcB901vxcIcPpPQx8vrxK9idNU4IWEuMo
	 3pyjDPixuWd/vpgd7iGOPmtabIhd5vOfpU5eWdCc3/UqjqVH9IuDzzYZyt/OV+AB1
	 d1M5Ocwff3N+xNN0rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1sVsd60b39-00Pw1G; Fri, 23
 Aug 2024 23:36:15 +0200
Message-ID: <5e6c2c1a-dc08-4ab6-8521-4f84b3c4c7c6@gmx.net>
Date: Fri, 23 Aug 2024 23:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] staging: vchiq_core: Factor out bulk transfer for
 blocking mode
To: Umang Jain <umang.jain@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
 <20240823-to_sent2-v1-3-8bc182a0adaf@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240823-to_sent2-v1-3-8bc182a0adaf@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tdB5/qLNqN3hRZWiFaLngHKoynNVooTUTq4cXsdNmXF21J+5J1J
 dt7luX1tEfCwro7IhyuRwTiSsJYmwVBdYkDgeH6/89WkHUWcJee55Tqlr50tXH8KA97jipv
 uDiRWYAdJQXt9vQcqE/A6sBtaL71jMyqYIpeJaI2/YryppCn31ziPTpyAzkczNqNx/VEwBR
 E4TGH9Om6eWCkQKU6iYuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rv/DWIzPXaI=;GYXuqqEBusmh/jMzExPERhwnfcc
 yvTLwY2sqOYubPHf0H12d+YaTCdBt5vsOefnD6Rjdw29xAfmmE349cBG+TExu2jqII6y4xEc8
 OIV+tzwQNZlxmrlQwo6+1/csbhwFa3RoPnMlB8mj9V8mq0vnLOCNcCFEiSGjjGIY3xnuRS1jw
 ikrzN6J2uHi5dPWjrSjVw6wwgvS8VwOuG74IMxhMVQG5iW4mV9je3ngS/niYCAQKwtmm2Uy1G
 Tzeqebv+kTfho+uvLpB+3qDVG+uw1SwBFknfpoVjfIiwH3VPzjrvltZsuuH6oDMnRlHXvGGkL
 wiu6oQ36gLqtB0OxEgF23BOJTgwC6ah091/fId0PbePCRMCmnlsESikU6RsPI646Xlf1Shs1g
 uyiQJWehZBIycM+zqfwquT1ds64HRhxEir6dszd8WnrErvLBJWnzS+I5B/5OpoN0q6lEBiThM
 4zsUFE+Ch2z1Ly5OU8YHvVJ3KImcklI94hb6k1pgvVw1Rzt0O8aEbUnIJyrjo7McEYTQWwHoq
 VY7qAYvtYmoh/meN56/HDhtysbBhihojqWsKDBC+MhsXMn5THg7UcHIXvysavKMNvUfbFhwq4
 udEZUlvIN+z40W8ol6fs7E88up//QDzhrazcCfqu6YxQIyWAuP6y+qDO4KsmsYYL2X/vZVMhV
 66hATtE+MeCZYlmoDEmUBJqYP6dbBDjfCc1Pqshwn40j7zkAUXl46icxqJzomXOBS3oIcGd2J
 to5cs9q2r3G04n+LXop0HGtMHNq2wfWdhhrKM4y6ObETmR3kfDtQb9kxeADoLyPSmKSLy0HvX
 rjG7MADsz7rk7tM+l+8xZmuQ==

Hi Umang,

Am 23.08.24 um 17:14 schrieb Umang Jain:
> Factor out bulk transfer for blocking mode into a separate dedicated
> function bulk_xfer_blocking_interruptible(). It is suffixed by
> "_interruptible" to denote that it can be interrupted and -EAGAIN
> can be returned. It would be up to the users of the function to retry
> the call in those cases.
>
> Adjust the calls to vchiq-dev.c ioctl interface and vchiq_arm.c
> for blocking bulk transfers.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  5 +--
>   .../vc04_services/interface/vchiq_arm/vchiq_core.c | 48 ++++++++++++++=
+++++---
>   .../vc04_services/interface/vchiq_arm/vchiq_core.h |  5 +++
>   .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |  6 +++
>   4 files changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index c4d97dbf6ba8..e9b9c76381dc 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -968,9 +968,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *=
instance, unsigned int handl
>   			return -ENOMEM;
>   	}
>
> -	ret =3D vchiq_bulk_transfer(instance, handle, data, NULL, size,
> -				  &waiter->bulk_waiter,
> -				  VCHIQ_BULK_MODE_BLOCKING, dir);
> +	ret =3D bulk_xfer_blocking_interruptible(instance, handle, data, NULL,=
 size,
> +					       &waiter->bulk_waiter, dir);
>   	if ((ret !=3D -EAGAIN) || fatal_signal_pending(current) || !waiter->b=
ulk_waiter.bulk) {
>   		struct vchiq_bulk *bulk =3D waiter->bulk_waiter.bulk;
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index c31f5d773fa5..341a06997848 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -2985,6 +2985,48 @@ vchiq_remove_service(struct vchiq_instance *insta=
nce, unsigned int handle)
>   	return status;
>   }
>
> +int
> +bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsig=
ned int handle,
> +				 void *offset, void __user *uoffset, int size,
> +				 void __user *userdata, enum vchiq_bulk_dir dir)
> +{
> +	struct vchiq_service *service =3D find_service_by_handle(instance, han=
dle);
> +	struct bulk_waiter *bulk_waiter =3D NULL;
No need to init bulk_waiter here
> +	enum vchiq_bulk_mode mode =3D VCHIQ_BULK_MODE_BLOCKING;
> +	int status =3D -EINVAL;
> +
> +	if (!service)
> +		goto error_exit;
Please return the error directly
> +
> +	if (service->srvstate !=3D VCHIQ_SRVSTATE_OPEN)
> +		goto error_exit;
> +
> +	if (!offset && !uoffset)
> +		goto error_exit;
> +
> +	if (vchiq_check_service(service))
> +		goto error_exit;
> +
> +	bulk_waiter =3D userdata;
> +	init_completion(&bulk_waiter->event);
> +	bulk_waiter->actual =3D 0;
> +	bulk_waiter->bulk =3D NULL;
> +
> +	status =3D vchiq_bulk_xfer_queue_msg_interruptible(service, offset, uo=
ffset, size,
> +							 userdata, mode, dir);
> +	if (status)
> +		goto error_exit;
> +
> +	vchiq_service_put(service);
> +
> +	return 0;
> +
> +error_exit:
> +	if (service)
> +		vchiq_service_put(service);
Since we return directly if service =3D=3D NULL, we can drop the if statem=
ent
> +	return status;
> +}
> +
>   /*
>    * This function may be called by kernel threads or user threads.
>    * User threads may receive -EAGAIN to indicate that a signal has been
> @@ -3018,12 +3060,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *in=
stance, unsigned int handle,
>   	case VCHIQ_BULK_MODE_NOCALLBACK:
>   	case VCHIQ_BULK_MODE_CALLBACK:
>   		break;
> -	case VCHIQ_BULK_MODE_BLOCKING:
> -		bulk_waiter =3D userdata;
> -		init_completion(&bulk_waiter->event);
> -		bulk_waiter->actual =3D 0;
> -		bulk_waiter->bulk =3D NULL;
> -		break;
>   	default:
>   		goto error_exit;
>   	}
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 1fda8631d1b6..ff3559c3d1ba 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -474,6 +474,11 @@ extern int
>   bulk_xfer_waiting_interruptible(struct vchiq_instance *instance, unsig=
ned int handle,
>   				void *userdata);
>
> +extern int
> +bulk_xfer_blocking_interruptible(struct vchiq_instance *instance, unsig=
ned int handle,
> +				 void *offset, void __user *uoffset, int size,
> +				 void __user *userdata, enum vchiq_bulk_dir dir);
> +
>   extern int
>   vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int hand=
le, void *offset,
>   		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_=
mode mode,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 445b7938eea3..1bff97ad28fa 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -304,6 +304,12 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_=
instance *instance,
>   		}
>
>   		userdata =3D &waiter->bulk_waiter;
> +
> +		status =3D bulk_xfer_blocking_interruptible(instance, args->handle,
> +							  NULL, args->data, args->size,
> +							  userdata, dir);
> +
> +		goto bulk_transfer_handled;
>   	} else if (args->mode =3D=3D VCHIQ_BULK_MODE_WAITING) {
>   		mutex_lock(&instance->bulk_waiter_list_mutex);
>   		list_for_each_entry(iter, &instance->bulk_waiter_list,
>


