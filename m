Return-Path: <linux-kernel+bounces-299672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3F595D872
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8D8283969
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76C1C8228;
	Fri, 23 Aug 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ViMTctkb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE680C02;
	Fri, 23 Aug 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448537; cv=none; b=OPZqkT23t1yScp+Mwys9nmiYMmaTKI404qq+8R3DTWnUrsraHxlLBG3Gwi8vHaHwzyE92eTV51Dsqh5eCUl1ZfX5FudDNLSNipmrGLBQJseKkujSJrri9/EjwiS72a9Aie1nRIYylebC7BmupFvgnCnHtkvsqx6j6JQR292LK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448537; c=relaxed/simple;
	bh=c6xNW/TpQ5HUK0dj7qEfNUUIV3frhNM4wz6s9pjFjmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWZuF/saHDTyeru4szjnyo6QnoS2fmjdQB9HO6MRZkemLGPD7G+2flNLNvGA8LAVn5+OHYiXsCsNBbHEY8lQvju+Bi8B6uiJZ0dEDoM+VtjPs9xoQ0NxPaDxQ+uH2EKtVANmjS41mAitx2X0F4WgU8K3R2yjnC7HM4KaDoAMSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ViMTctkb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724448522; x=1725053322; i=wahrenst@gmx.net;
	bh=qkcGHdvyKCjnVC+LFjxQrSYxAZeZkbhPu1QmpJJSbQM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ViMTctkbFvrQPwsHewwRCGychyIdb/U7VRuLFyiyEnFTdYlPMyFXlpd/eOm6JPN6
	 JRHswhs/F13/kfcTlntA3G1+LHZdSirlEsAuUOnZ7kjvzrjfwAhxa+IOYXJ0xYfC0
	 LQcaaLLUP2DBbejTv9M+Wmp+akVL9My8zUj1UrFdhI1jw9oWSkqKeVbZyBAd/KEfE
	 7mu9aHY0QeNMs27GZcFrDckXLLayLnQwMGufVQjE1kl9PGF4CS3MTJsjfTAEgawfH
	 pAMKyxhoFRgwKDTOWUBHLdYC/RXjDkU6zJpR9cE3BRsYynkh3NKTIRNyrxwtvS3j9
	 CMxcBWs3Rf+t/Ls73g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1sRrKv18kB-00LWPH; Fri, 23
 Aug 2024 23:28:42 +0200
Message-ID: <bb55e4cb-245f-4e12-b4df-e9cdd06d2f67@gmx.net>
Date: Fri, 23 Aug 2024 23:28:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] staging: vchiq: Factor out bulk transfer for
 VCHIQ_BULK_MODE_WAITING
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
 <20240823-to_sent2-v1-1-8bc182a0adaf@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240823-to_sent2-v1-1-8bc182a0adaf@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WtY7zDdVfG5+xRbIlLZQ78ZvTDIMAoP2in784yEQWdzWiT0+CZ+
 fMFQvWIpimr7X7saucfHtBi/7eGMCMO/G3abhKy0iQXDgsy0X5Wvyse1Rd7eZmGOaeFrJTt
 kjigikNBFJBWc0ewhJdpTNFvzJLQWTdkLiGSbV4qxWErH4a6sJyap1l/elarN82VeAGdIno
 phWPW7/Z6QD0VQ+kSwDsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FpgBXQeSYpw=;8aZTMK2Mo4D9wMPi7CBUGgfTA91
 8lvbKF0pDBKVpWPM6ut/9oIZ7EH+yfjDT3eYRHBPAk6o1gXIfucwFf0Y5gXKNheUTKk1x1pUN
 z1FvT18I1wMH7jVPoZlq7JMtNRa0fafYC5fY50lfsQSZD7hCZGkbVDkUXzhSaZPRhCJFc7dTA
 AX76h8gY1NgGy8cMSZlWjviTukLrvszzzzeqhZEvNKAub4M+uf/pjfuftcLMk9ojFQC+SqcI4
 a2XdUgikWaUoBuxdp6kHO358XmMxJt/xv8JFt1nkLH97AKnA6SUTK6I+HIyEznqJHDVuLOiaW
 F5zZ70LXudkrnSjLQSsvvvw/O4fmskZee6T6eBQ20SfzGw1mNZYWu/x+6njfe8SeKUEGzYvmj
 t+BeyIPhTUoNGyJCVg8W8DGg9o5l1yvXuqQkvZW94ma0jmXW3qkSjOp8aavEQxbdWH5O99pGx
 OJ3ob5N4dDVUfH8VR4HeNOLH9KRD/LbM2MWt561Mq4c9xHZEg9WygEeNMubePIAas7nA9MxU+
 ZhFHN9meokc4bZrc04/55PgY7G51YWEYLCDBX4lC9Y25NC9FfxuqGRUf+j1IH3KNzOy8zWt2+
 xKXfdmXKuyZDj64wkHwnfRA2oqjeoN/QXh+luTQsC3FqgP7FeEIoDaiyUzMisBSEEh929dgMI
 pDkyZEzVElKNL7lCCAG+bEShBVqvUCpL1h809lcvdFauYJqyL6ofY7IQNOCMulLOleJMcBH7v
 +55/9YwcbCE5GiSu6hNNpmcV4QFJRS7eHkJVyqLos0eDU7BKkjfvZo55ypl1q1CqifI8M1eO8
 3OPXpzmPlTkkhfUvXvN21t0A==

Hi Umang,

Am 23.08.24 um 17:14 schrieb Umang Jain:
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
>   .../vc04_services/interface/vchiq_arm/vchiq_core.c | 52 ++++++++++++++=
+++++---
>   .../vc04_services/interface/vchiq_arm/vchiq_core.h |  4 ++
>   .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |  5 +++
>   3 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 50af04b217f4..228a41ecf90c 100644
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
> @@ -3143,6 +3138,53 @@ int vchiq_bulk_transfer(struct vchiq_instance *in=
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
> +bulk_xfer_waiting_interruptible(struct vchiq_instance *instance, unsign=
ed int handle,
> +				void *userdata)
> +{
> +	struct vchiq_service *service =3D find_service_by_handle(instance, han=
dle);
> +	struct bulk_waiter *bulk_waiter =3D NULL;
I think there is no need to init bulk_waiter with NULL
> +	struct vchiq_bulk *bulk;
> +	int status =3D -EINVAL;
> +
> +	if (!service)
> +		goto error_exit;
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
> +	bulk =3D bulk_waiter->bulk;
> +
> +	vchiq_service_put(service);
> +
> +	status =3D 0;
> +
> +	bulk_waiter->bulk =3D bulk;
Maybe i missed something, but before vchiq_service_put() we already
assigned the other way around.
> +	if (wait_for_completion_interruptible(&bulk_waiter->event))
> +		status =3D -EAGAIN;
> +	else if (bulk_waiter->actual =3D=3D VCHIQ_BULK_ACTUAL_ABORTED)
> +		status =3D -EINVAL;
> +
> +	return status;
How about return the return code directly at these 3 places? This would
improve readability.

Best regards
> +
> +error_exit:
> +	if (service)
> +		vchiq_service_put(service);
> +	return status;
> +}
> +
>   int
>   vchiq_queue_message(struct vchiq_instance *instance, unsigned int hand=
le,
>   		    ssize_t (*copy_callback)(void *context, void *dest,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 77cc4d7ac077..1fda8631d1b6 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -470,6 +470,10 @@ vchiq_shutdown_internal(struct vchiq_state *state, =
struct vchiq_instance *instan
>   extern void
>   remote_event_pollall(struct vchiq_state *state);
>
> +extern int
> +bulk_xfer_waiting_interruptible(struct vchiq_instance *instance, unsign=
ed int handle,
> +				void *userdata);
> +
>   extern int
>   vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int hand=
le, void *offset,
>   		    void __user *uoffset, int size, void *userdata, enum vchiq_bulk_=
mode mode,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 9cd2a64dce5e..445b7938eea3 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -324,6 +324,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_=
instance *instance,
>   		dev_dbg(service->state->dev, "arm: found bulk_waiter %pK for pid %d\=
n",
>   			waiter, current->pid);
>   		userdata =3D &waiter->bulk_waiter;
> +
> +		status =3D bulk_xfer_waiting_interruptible(instance, args->handle, us=
erdata);
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
>


