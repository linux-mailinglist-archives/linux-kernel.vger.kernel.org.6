Return-Path: <linux-kernel+bounces-315819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE296C755
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F401F267C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24B1E5029;
	Wed,  4 Sep 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="K8r5Kg/5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC71E5014;
	Wed,  4 Sep 2024 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477374; cv=none; b=sY3ShuhqJF9zYAFXWvOtoaYBQ72yxBznTWWDNQA+AwM9T5nBfLEzBBMZFTmcFbAUCClr1ifysNbq3Wwcm8ZnuBz7TRUe28v5Hm4Ns8xY3Ix0JsehUH5LI+9j6piQtYelw0Pe4bub4EtzRUsHliaAn4Lsx9UPbsCcGMnxKSQAcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477374; c=relaxed/simple;
	bh=mQgoD/x6ljgkHZHvayrER/7PgBtsat98lfxItkCgWX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j24OwC7X0NVXJapcRQRp1woQuwo4S38WTTl7u6SXizflirXbOcaoX7srw6ltP0sxqnstvf7geVysRyApIQpAGkBN460DgAx657R0DuqM4bNDI5sXGLfVKUDIIIW0dIgrcJEnlOeOZxBsS4tkkwhf5I3cl/Av3LfXK4dQiVkAo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=K8r5Kg/5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725477356; x=1726082156; i=wahrenst@gmx.net;
	bh=z5z34O5Q8E3+SvWO5zBnKF6KASVGgdptrVQNxiqKgdE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K8r5Kg/5t+ZwFHLNzIQudWV8tBIfTjgUOq/xKqzB5Rut3KK9biZuzqD2O3zs8SqU
	 kpw0bBe1eiOCUBqxX/TpJmJHalLUQ4wNKP45Evu1MRA4dH3MVBzc9EgZ4lgOxpd3r
	 UDfCsH5SPZDE4S1ok1CBWDSbYGEX5RltlYXLJFnXsWWlqTpag5w0XJkCm5IdDR7pS
	 /CMQjQGGWa6X8jIpEXo1bS0ZBDrsrvPal4YGPmZS+IwxtbZGJA74zMX9DdlcPp/S1
	 OjzCsU2OefpeBrTxQ32Gr0IhwYkzZR8I2QPDprb2itBeoy9U78ummQJNoDUCImm04
	 kSQpi/gi/vZtcywOfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1rzgLN0KuH-00xbCX; Wed, 04
 Sep 2024 21:15:56 +0200
Message-ID: <1a2e59c5-e987-4f3f-b50f-57207d0d6b17@gmx.net>
Date: Wed, 4 Sep 2024 21:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] staging: vchiq: Factor out bulk transfer for
 VCHIQ_BULK_MODE_WAITING
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
 <20240901061808.187895-2-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240901061808.187895-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pUdyErNVmXPgsvl/Hmw2M17neC3QsKHDKhvk3wmOnzvmhB7A2Mj
 288U9luI/G8qAsX4RG1GUBeQ85Q33NYmqzvssMVeZUV5MtfnFOC2IM3ZYiwyalyKpUEr1BL
 U5P7r9LBYVciCrb8ywqSmWsV18M4hxRP5lUDo72OOklL7lNXi4/WxOH2XtMsjSfGEWlUYbT
 iXW4wLdxL1YRmv+b/t+uA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c0ozLs5c75A=;BgTY741Gom7T/wkuUgaA9IG1oQ+
 uvqx09TYY0dmlxoJ2pJfrm+ZTO1nESWLpxBKs3ARPYrGuI6sQk/qXlF6EucvQBumHFyY5lg0u
 j1KPVBiWuSZwpcy/bGr6i+edSzbboJMvauPRzQ2KDjJyg9IKxg720xk2x2LttsKLEMW/yAYnU
 qaOKIW8zW3W+XOeYQWa+c5PjWmgMcL94mg4yY8GotAeOOvOF3lU6h7MBwzUxPR6hrtFGF+J8v
 4NjRS6OyzWdb5gBQ8isJGZHEc+DE28YaIZfFnJB0Ofgj6g4fiWgrfJxidJRLX4w/500+U+24L
 pBe0b5pueD/6EvZIzIpOuGjDTkv8qtJIPCzk/5iGKr86exFVUFuOoirw6Tf5FHZWNGZ8bRl3T
 3MGf1gUG3jYon0mHtOiMKwXjrY3n6rWeeq5NXsGQR8sxlOuhzEbr4t13z6slXJ9c+5/YRZ7yI
 9kPB4VfSoklV5oMwF2URQ1AsTakKpAHvn6sRSBAwVyCFrtgUA1whQDTDfXQrTJWw8g+shOsok
 k6Dm6YIuoJmnxYNFZT4QENVyjUdGRR6roabmkOgtoRvMBe0SZNH0Hl0rJUa7qJsep/5j0n8Al
 0nz5E16ldI+Is/a+BUPjorIuajpcIrlwoGgsubePoPPndfXp0oRQOUjaDCAXIe3BgrCwXm60+
 y8AuPJIRfmo7RCPb2vKcJxBxojaZqNUbW1YRAs/ImGnB2tyTC1oYJAljgm+O6aySZoa0v8rpZ
 cVCfjC8tY/r5wDlc8Ccmb29Fp+x1zKEOC8yJK0+5s5ycX0Xmw5cICq85NdE7GBusE0z5sJT2M
 UhBBcZ0mOKxengB7n9QLrWog==

Hi Umang,

Am 01.09.24 um 08:18 schrieb Umang Jain:
> The bulk transfer is VCHIQ_BULK_MODE_WAITING is used by VCHIQ ioctl
> interface. It is factored out to a separate function from
> vchiq_bulk_transfer() to bulk_xfer_waiting_interruptible().
>
> This is a part of vchiq_bulk_transfer refactoring. Each bulk mode
> will have their dedicated functions to execute bulk transfers.
> Each mode will be handled separately in subsequent patches.
>
> bulk_xfer_waiting_interruptible() is suffixed with "_interruptible"
> to denote that it can be interrupted when a signal is received.
> -EAGAIN maybe returned in those cases, similar to what
> vchiq_bulk_transfer() does.
>
> Adjust the vchiq_irq_queue_bulk_tx_rx() in the vchiq-dev.c to call
> bulk_xfer_waiting_interruptible() for waiting mode. A temporary
> goto label has been introduced to jump the call execution over
> vchiq_bulk_transfer() for waiting mode only. When all dedicated bulk
> transfer calls are introduced, this label shall be dropped.
>
> No function changes intended in this patch.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../interface/vchiq_arm/vchiq_core.c          | 49 +++++++++++++++++--
>   .../interface/vchiq_arm/vchiq_core.h          |  4 ++
>   .../interface/vchiq_arm/vchiq_dev.c           |  5 ++
>   3 files changed, 53 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 50af04b217f4..914aa2766d57 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -3023,10 +3023,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *in=
stance, unsigned int handle,
>   		bulk_waiter->actual =3D 0;
>   		bulk_waiter->bulk =3D NULL;
>   		break;
> -	case VCHIQ_BULK_MODE_WAITING:
> -		bulk_waiter =3D userdata;
> -		bulk =3D bulk_waiter->bulk;
> -		goto waiting;
>   	default:
>   		goto error_exit;
>   	}
> @@ -3115,7 +3111,6 @@ int vchiq_bulk_transfer(struct vchiq_instance *ins=
tance, unsigned int handle,
>   		state->id, service->localport, dir_char, queue->local_insert,
>   		queue->remote_insert, queue->process);
>
> -waiting:
>   	vchiq_service_put(service);
>
>   	status =3D 0;
> @@ -3143,6 +3138,50 @@ int vchiq_bulk_transfer(struct vchiq_instance *in=
stance, unsigned int handle,
>   	return status;
>   }
>
> +/*
> + * This function is called by VCHIQ ioctl interface and is interruptibl=
e.
> + * It may receive -EAGAIN to indicate that a signal has been received
> + * and the call should be retried after being returned to user context.
> + */
> +int
> +vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
> +				      unsigned int handle, struct bulk_waiter *userdata)
> +{
> +	struct vchiq_service *service =3D find_service_by_handle(instance, han=
dle);
> +	struct bulk_waiter *bulk_waiter;
> +	int status =3D -EINVAL;
> +
> +	if (!service)
> +		return -EINVAL;
> +
> +	if (!userdata)
> +		goto error_exit;
> +
> +	if (service->srvstate !=3D VCHIQ_SRVSTATE_OPEN)
> +		goto error_exit;
> +
> +	if (vchiq_check_service(service))
> +		goto error_exit;
> +
> +	bulk_waiter =3D userdata;
> +
> +	vchiq_service_put(service);
> +
> +	status =3D 0;
> +
> +	if (wait_for_completion_interruptible(&bulk_waiter->event))
> +		return -EAGAIN;
> +	else if (bulk_waiter->actual =3D=3D VCHIQ_BULK_ACTUAL_ABORTED)
> +		return -EINVAL;
> +
> +	return status;
return 0 and drop the assignment above?
> +
> +error_exit:
> +	vchiq_service_put(service);
> +
> +	return status;
> +}
> +
>   int
>   vchiq_queue_message(struct vchiq_instance *instance, unsigned int hand=
le,
>   		    ssize_t (*copy_callback)(void *context, void *dest,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 77cc4d7ac077..985d9ea3a06a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -470,6 +470,10 @@ vchiq_shutdown_internal(struct vchiq_state *state, =
struct vchiq_instance *instan
>   extern void
>   remote_event_pollall(struct vchiq_state *state);
>
> +extern int
> +vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
> +				      unsigned int handle, struct bulk_waiter *userdata);
> +
>   extern int
>   vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int hand=
le, void *offset,
>   		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_=
mode mode,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 9cd2a64dce5e..550838d2863b 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -324,6 +324,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_=
instance *instance,
>   		dev_dbg(service->state->dev, "arm: found bulk_waiter %pK for pid %d\=
n",
>   			waiter, current->pid);
>   		userdata =3D &waiter->bulk_waiter;
> +
> +		status =3D vchiq_bulk_xfer_waiting_interruptible(instance, args->hand=
le, userdata);
> +
> +		goto bulk_transfer_handled;
>   	} else {
>   		userdata =3D args->userdata;
>   	}
> @@ -331,6 +335,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_i=
nstance *instance,
>   	status =3D vchiq_bulk_transfer(instance, args->handle, NULL, args->da=
ta, args->size,
>   				     userdata, args->mode, dir);
>
> +bulk_transfer_handled:
>   	if (!waiter) {
>   		ret =3D 0;
>   		goto out;


