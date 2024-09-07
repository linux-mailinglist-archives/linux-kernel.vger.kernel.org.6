Return-Path: <linux-kernel+bounces-319776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D3970212
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A80B237BA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76F15B103;
	Sat,  7 Sep 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GkJVL/+d"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE787159583;
	Sat,  7 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725709779; cv=none; b=rRKgGS0ozjGSbbqN9JLHkx1qJWNw3JiCCq3UZ/rlukKtSbg8EAiPm3uw9Jc2GxMrlgTicc3vJMl6AgLGbAiN4VEO45x+wOwlHYtn0CWB2SsqJu4HFnfJmjuSKtLv17aZQOktOeI2lcbLHWLquEK0CtgBJmfUfHRCEIZVU+k6FZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725709779; c=relaxed/simple;
	bh=djI8BGRkj46S1qzEgKP3B3hEa62L//RPhr0cSKF2LUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEDGCTxbzWfTFtcA82o2C5ob/a3uLHbf8GAwhpFBH953ImN1SfrQn0fvcNdf4ZhkS46CdV5f2X65lwU9IbTOcnrZr48fEpBjcx8EbzbBCvCB0R/b89J/8gPhu0tcalBtKQ8SDKa2xykVvSZbmyM6bcrkM0IK1MjL2xFj4raLIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GkJVL/+d; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725709761; x=1726314561; i=wahrenst@gmx.net;
	bh=HJ/p5a63dQNSRdiicH47k5M4HkDXkNI9n5S8d1EwY1k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GkJVL/+d+nwhHqLtD9TiQCtaBbNvTaJmMw2cYvbAJ11Kbz/4kXcXl/13hMeYi/IF
	 iN8pd6VppQLqCSICn6vJJdYAId4TF1objLmVhg5Duc5D5vllxaAI4yTjS6h7OQr7L
	 ZKsY8gnvlPnOWpXeKsbt9cDRd2Tcg3KFPFfBBtR8n3sf6po7vdJsSL97BRESVSMG5
	 jo+FoWYQEOXWUzivXYqkPtqokvq7pHcb18INnfd9Rtn+78lCTQqlkUg6a8qzxUjuv
	 KpY70SCJHUR8pXQbUGm7LjexifCSRyFaXjKtsjcjWIeiYpAtzAwE+co3j5+9x78A0
	 TP8qmdAkU7/3Zfv/3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.128] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1snSAl0IBG-00D6il; Sat, 07
 Sep 2024 13:49:21 +0200
Message-ID: <5e3f9758-e392-44af-83c4-e60714046708@gmx.net>
Date: Sat, 7 Sep 2024 13:49:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] staging: vchiq_core: Factor out bulk transfer for
 blocking mode
To: Umang Jain <umang.jain@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20240906072506.174026-1-umang.jain@ideasonboard.com>
 <20240906072506.174026-4-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240906072506.174026-4-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y+U46tTUQZaiaoP4QMNw8UZm5YbdpDDeDJ7HfwsEnxrHWM5HDwm
 uAYh0BOQNUpKpBnfEbiY0U1MX6dHjeUHgpKsW0XuqfOQyXcrIl/vcdrkJWwG615ds/j/jEb
 uT8ApjtLhYIQgNocBizPMmxCAVqh3M5Vj7f/kvvzROayBy0lY34zSMr9Qo0omMctWvv6WZi
 b3Fl7iNpH7wmBOUhzrepA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5RvyLnInHUI=;kzkJ06/ngosiwsgEEHooZzDnYKs
 LmNWOEoqfGWYmqOegn7bN1MPCD+ERv3+Oq3KviubiTNZk1PMzKD6M/fqaI5Pht2S0uXidMbSc
 Nkp/mLuVxBLyAdBF0+VJBPe6olBnsEEPl5CRnUE5WbXAqNFlPu1eOrKa31QXKJigArST+jw8Z
 fP2k9dqnl4V7DDb6O9zGLs8HHfO4yQoEtHYMNSZSwvwhXoZZRJqZOJ29X0Ay8xsvEjPVpOhbQ
 u5GHPrpoDIgO8IqHQGrb5J00hh6cLIbrmUxDx6t5c6IMD0IxiivAjLg2Ky0IygnRofT6AW2Ji
 TxympjAyFORO97+HCRPamaGg2Kr+yUiY3ibP2H7Gn7V01nRKxKEsidbAF8dlCYF+QSOuB5OSo
 R2aKbvyfeMB5P1hwRZH8M7BX3qSL8h4A1QGRjSQCOiMKxL2KFaGsLHJJVjjrtv/a/+h/pb/mP
 ACPNeSin4nCpaSN5JfieAyfpcBJoI0dF273oWRF4SfKYSuU8sF8WBZ+J/GTQf+y8qW7KGDAxu
 49klIzefoM2kr7lIwVr10h00cGXhGgs5ZbnDxMrLug26cF7H2tJgqa/4vYvIw+fN4Xi6UIXaY
 6vwVW/b3iNHc5+mIrdJJ1XXsLyq9TW17ictZLgkIK6KloCcb3ua5lODAiSt2VnuPil3nP4Qnq
 qiehAYKjTK6AfrNYoodNXAJT09t0vuWuYqJ8+AQqASeoAzP76tWpRg3bhAalq2LJ4B31oSbYg
 bXzWXtGvKKI5SxNYlMUbyC6teyiyG182kj8++FmWI1xm2yVnyGeglbQ83COVTiddv/wpPBcTs
 9FXoAvfrERgr/FfAjqV7yBhA==

Hi Umang,

Am 06.09.24 um 09:25 schrieb Umang Jain:
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
i applied this series on top of recent linux-next and the vchiq ping
test on Raspberry Pi 3 B Plus (multi_v7_defconfig) crashes or hanges
strangly.

I bisected the issue to this patch, but it's possible the root cause
might be introduced before.

But i'm pretty sure that the series introduced the regression.

Sorry, i don't have the time analyse this issue deeper.

Best regards
> ---
>   .../interface/vchiq_arm/vchiq_arm.c           |  5 +--
>   .../interface/vchiq_arm/vchiq_core.c          | 42 ++++++++++++++++---
>   .../interface/vchiq_arm/vchiq_core.h          |  5 +++
>   .../interface/vchiq_arm/vchiq_dev.c           |  6 +++
>   4 files changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index c4d97dbf6ba8..688c9b1be868 100644
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
> +	ret =3D vchiq_bulk_xfer_blocking_interruptible(instance, handle, data,=
 NULL, size,
> +						     &waiter->bulk_waiter, dir);
>   	if ((ret !=3D -EAGAIN) || fatal_signal_pending(current) || !waiter->b=
ulk_waiter.bulk) {
>   		struct vchiq_bulk *bulk =3D waiter->bulk_waiter.bulk;
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index f36044bab194..43f951fa4b89 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -2985,6 +2985,42 @@ vchiq_remove_service(struct vchiq_instance *insta=
nce, unsigned int handle)
>   	return status;
>   }
>
> +int
> +vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance,=
 unsigned int handle,
> +				       void *offset, void __user *uoffset, int size,
> +				       void __user *userdata, enum vchiq_bulk_dir dir)
> +{
> +	struct vchiq_service *service =3D find_service_by_handle(instance, han=
dle);
> +	struct bulk_waiter *bulk_waiter;
> +	enum vchiq_bulk_mode mode =3D VCHIQ_BULK_MODE_BLOCKING;
> +	int status =3D -EINVAL;
> +
> +	if (!service)
> +		return -EINVAL;
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
> +
> +error_exit:
> +	vchiq_service_put(service);
> +
> +	return status;
> +}
> +
>   /*
>    * This function may be called by kernel threads or user threads.
>    * User threads may receive -EAGAIN to indicate that a signal has been
> @@ -3018,12 +3054,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *in=
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
> index 985d9ea3a06a..2dd89101c1c6 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -474,6 +474,11 @@ extern int
>   vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
>   				      unsigned int handle, struct bulk_waiter *userdata);
>
> +extern int
> +vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance *instance,=
 unsigned int handle,
> +				       void *offset, void __user *uoffset, int size,
> +				       void __user *userdata, enum vchiq_bulk_dir dir);
> +
>   extern int
>   vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int hand=
le, void *offset,
>   		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_=
mode mode,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 550838d2863b..830633f2326b 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -304,6 +304,12 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_=
instance *instance,
>   		}
>
>   		userdata =3D &waiter->bulk_waiter;
> +
> +		status =3D vchiq_bulk_xfer_blocking_interruptible(instance, args->han=
dle,
> +								NULL, args->data, args->size,
> +								userdata, dir);
> +
> +		goto bulk_transfer_handled;
>   	} else if (args->mode =3D=3D VCHIQ_BULK_MODE_WAITING) {
>   		mutex_lock(&instance->bulk_waiter_list_mutex);
>   		list_for_each_entry(iter, &instance->bulk_waiter_list,


