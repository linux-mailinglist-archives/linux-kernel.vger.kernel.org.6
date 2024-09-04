Return-Path: <linux-kernel+bounces-315842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA896C790
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA2B2146E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B71E500F;
	Wed,  4 Sep 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="apO17jy0"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1AB40C03;
	Wed,  4 Sep 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478231; cv=none; b=f3Hr6HBWaGRQHwU/TWy1feNXmp1N7n7g8sui++ZGzMW+p+/+wdymoAnZ6fkVLvfORWE2RU9FylQloS/J7GV5Bjto5BsecR6Ej1YqfiSiMJxeAMMe4i9eZGecwO5EbldkDnYSYJ7/+/uPCGo4JbXFlFlDiGLHkUaXfl9Rem9ehGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478231; c=relaxed/simple;
	bh=xuWU4fNWuIMwcErWy1ouDNdrXHxOAwxWeFLxiPrwxt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNcUwdPDGxzsnHaoZYmxQ76OFvp/j5u6DvzMf/+l5+6qOCi2AGSWeqH8zWMX4oUMSvgfihDPKqWetgYGv216K3SoKaBycqwFc4kC2ZZWqbKNX3hbFvWfAuwV4LLMugjIsrzKbKcBwQt8qTMPansNNOeyIpL9ueDUmcR1sBJoAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=apO17jy0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725478216; x=1726083016; i=wahrenst@gmx.net;
	bh=1pVy4z5VJnH23WU57VpJ/n65Q4tXoZAIuqpbRwgYadA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=apO17jy0UF7oCFITLMYv0l0uyCXROFwYdi2dhM18/j6aMqlaKfv9F7bspsEmbQt1
	 UmTOWBjmnshmJuDDn9BPrleQfpsnj2bUtxvRNHeDVImXRcuP2KvSGHvUx1KcetYJC
	 MmSFokn9RpQNNRRIBMOoQOg70xrIkhi18xujJktK+EZw9bGdacY3kPdDfEqoGiuX0
	 JfkPkWFgTyREbo+n/s3pY5co3vTtejCnPoXRtCNFgfN7aTWPfevkvG+UFQhyn9eb2
	 +/wumvxOeDOE+DhwuOW20UACMZra880xKTrwBtoiktmHJIR3qJbMGXJU38hJNROtR
	 qgl7NeONuPq1kLyk1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1sBEJI3tJj-00oXhK; Wed, 04
 Sep 2024 21:30:16 +0200
Message-ID: <17340b72-b0e4-47bc-ae8a-fcd11e36c99b@gmx.net>
Date: Wed, 4 Sep 2024 21:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] staging: vchiq_core: Factor out bulk transfer for
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
References: <20240901061808.187895-1-umang.jain@ideasonboard.com>
 <20240901061808.187895-4-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240901061808.187895-4-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N2f8xGOWdRD+al7hwuvP2dUqZ4dNhh/ABOi5xiZNGsN6ePY2fyk
 5Tb/bCLD18NwA1vOcqCSj7HvgE2s7Q1X2Ple0WEFuKe3D+5D79xHoa6bs45gc5YW+0Z5tLH
 JqHYRCR+aaq73SGVA8hG6wGpdMm0JnutwkcndNeP+OkLAvulwLJu+IlsDrk2AAVDQmtb1Pn
 22O30HBbPi3JYN++PGdTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3AQL0F35Z1w=;1zDT8yYOc0+RcCgLaOPWGuIgASq
 zqk/R49DG0uyihCvFvGt8vfgdhLhoED19jll4nHs4YC1lBpY3gzxXKnd7qtGGxKnQlN3Zw5GU
 t9qnEcduCPACd2g1HDfwHsPEUEzJgA8qiptLwHfV+xQv3QaCa1opubCB9fLDQIJmnE23hlJSt
 f67ybmnBNAJrNNb4jP+1O2CwNzP0rXMkvXzRkcY4Hqbj8SK9/W2gZyy1s/Eldg++PnaqjikSB
 P0kv11Fdzjpci4XkiacNVvqMR5Xmbjb7i2jb6m0g9/8wOTGWhbsXrcPeFRiFXVt6d4Arh2nAy
 YTUd0f363Pxb3/FSJvQ33yqlq6txNGi3pgj/fu4/2AwL50hjrfyqOZUg7E959MOoEs3kgVKCx
 nHHvVdaM5QIZrg0A18krmuCtLnKva3BcwUUDkWQzt/PtQTWR9h4s9hkpo3+mpYprNlQ9DTgo+
 4/9JN2gSFMKIwsEpFYx2gl8Bad/fVNQ4eRjnr9YNPaRGEdYp6uCLfOFEs3ejRNitQXNJmRudP
 ixFZ1ONqO5fqJL8J/FmfW0chNgQ+JuZppy4iBG7TbDYFJoVExAzSZZgejKjwtjQDWIHXJhA2Z
 u1AX6wM09zGo/kTtEo1DFt2KuCSLPoXa8fbtSwk9MioVoLli+36CQNQ3Cjevhf2NCwKv5fWUV
 n9or5DLJfcphnCwb+gOLq657DE8/8LRavlixNWxGQRFVZfL0lj8IPeKj7p/EPSqj8Jp12+OnU
 3KrEapUigFVrLx7aUyuXMZBdkyKg7+8ybQQ6YdkXaF3f/0i9BzS9dr6VENAdlLGVKtHVUkAcR
 RV6IUslPIeZfPQEQ4lzCq4mQ==

Hi Umang,

Am 01.09.24 um 08:18 schrieb Umang Jain:
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
>   .../interface/vchiq_arm/vchiq_arm.c           |  5 +--
>   .../interface/vchiq_arm/vchiq_core.c          | 44 ++++++++++++++++---
>   .../interface/vchiq_arm/vchiq_core.h          |  5 +++
>   .../interface/vchiq_arm/vchiq_dev.c           |  6 +++
>   4 files changed, 50 insertions(+), 10 deletions(-)
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
> index 6e3d24d4b720..c46634f39f4b 100644
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
> +	struct bulk_waiter *bulk_waiter =3D NULL;
my comment in v1 about init of bulk_waiter applied to this one ...
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
> @@ -2998,7 +3034,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *ins=
tance, unsigned int handle,
>   			enum vchiq_bulk_mode mode, enum vchiq_bulk_dir dir)
>   {
>   	struct vchiq_service *service =3D find_service_by_handle(instance, ha=
ndle);
> -	struct bulk_waiter *bulk_waiter =3D NULL;
> +	struct bulk_waiter *bulk_waiter;
and not to this one. I think this one here should be kept at least in
this patch.
>   	struct vchiq_bulk *bulk;
>   	int status =3D -EINVAL;
>
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


