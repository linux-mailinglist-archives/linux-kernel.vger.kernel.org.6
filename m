Return-Path: <linux-kernel+bounces-213962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EA2907D10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7740D1F269F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38E8614D;
	Thu, 13 Jun 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rKVWOqN0"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3E136E1C;
	Thu, 13 Jun 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308923; cv=none; b=iT7eOAstsFp7iGKf1q88IZJfLcUMv1W+M2eEQMB12Z2aOp5NBVrNwjL3c9dPMnSvsxUIxzsWIdcI8J6L3Dr76yMzlvPfu3T95NKGQ3uWgxNg2dWT8IEoyARbymozYves6G+b/ivVmw/N+Qe7aieV6rGsIQNLi2WrfVFW5O+fYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308923; c=relaxed/simple;
	bh=5LYkrusvY5cTU3BiJR5GVcZm2ONsDatoXUhRDIuRGUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzVeQ0ye/1A7160q5cseNFhUpIsWt3THeEY0vgok06ISMh1xeJQvLN1GqcTSxE5HVYAh6317zNTJ1IRF/2e/Z0XgSU8FaLNOGpqXYV9wyDsoFlyisJ1+m98Pxx1+Nod7z0tlyEEg67vpKA3dsyf0DS4EzyVq0WUXzpqMFLPx6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rKVWOqN0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718308904; x=1718913704; i=wahrenst@gmx.net;
	bh=qR4+mA3O0jWR2wy0+TvddgQx0KCXZH6Qx7QgE7ecexk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rKVWOqN0bSN5j/Yh9KBSJQp4sytUWkVlRXyk7tu6ZdgFl5EJIucx+M5IKjVjvQ1r
	 oMfNavs3HbgiYyeHuMDcsyLfMb1pOSuUdbizmAihhYW6dE0lHPwUPMvODr4wXohf0
	 KL3n4qBIF70d0zuWlBwifEr5lXYzbIr6KYfMiEiBYEB4Y2eEIxCXt6wVX5PiE5hY6
	 fomdOKyzB+NwOsaGpXgj9imFKQaq5Pvcc38ceawyXr4k8z3O1EZREW/Zr0jjWLHma
	 U5l30t/wLcwYEdQGdKJjOYYhcabWWIXdQ2sB45wCQlRwgVbps2BgJ2UnHMLEz0/ez
	 QVgi0B/nRm2A0Nl9Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1sqMVn05MR-00p3RH; Thu, 13
 Jun 2024 22:01:44 +0200
Message-ID: <082d9df0-0947-4452-a3fc-87eab2019e01@gmx.net>
Date: Thu, 13 Jun 2024 22:01:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation
 check
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, detule
 <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com>
 <20240613194150.2915202-2-kieran.bingham@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240613194150.2915202-2-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n8ZTbygcpPASQDBe6Kqi0TDkm/iK1Ky6t6lKNe4jXh0Q1aWBZIs
 o9PmTYnzjt8Z8/1Fa2vIG3HnI/iNQW8UbM2KwhXavW9ypPiNvQB1CFywK8+7scxh7otBLR5
 SkULQFWKurtbeiPF89L9xA7dcZNYkvf/WcFHnorvHoy2He8Y2I5QenR5hIOTf+HvOMxYgfo
 1pL83cRoTBdVdOqILK4aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:coSkVz26Hkg=;5itTSO+sg8rk1IUVV+srfdcqHC9
 1LOJUQOYs3TqmYVjvJ9SfZLt5JCFG4j2sYWDNG3JJJwF4Ee58lX2fXDc35t6hyvF2YcWtRdhU
 0AbW8f/XCJnruvQL8mN8C2L7WuidL6toCeSZzjBakUWjeHoLdqrGcAijuRbFVVvD1Hhn3cEK1
 Xhy0RS2uhssyCZo3TO9RAf0iiJLMx/c2RUncyD0H9GCddvzDq81c16L4/S/dQS8dk9CrKhpvK
 u2OMWg8VBnQzDTSOlZ0h2zLG/rPEp04Qce1jVa633d+vpHBBdy2fg2gJNqZBcZ3n1wZHUvea7
 ZgHUqgpr4ZlWYsqFdRIFh/5mQzA5/iF2IZYllRu7vTA+iCLX4YRp/AZpDBBOpAWsZ4Xg1u6l1
 c6t8evpn5TOfkkk/A2m4EjCd0huD6W212DV9qcVwtIboxvnI4eqWV1d9df0oK3edOGlfdqQG/
 FoMyzGdcwoutf9pjueyUlwF8/yIBeqdlRBgKsjv/stpZ+ylotiV0cZxJxGN7p7b3Gjjn07raS
 Yk3MJ/LxeOjaXK2sAmK2FY41/6fTae3G+yFJBndHlPYf8mxBK6kiTnbeubFQxdJKcvAEkK2e0
 7SmTSsFdw323lSaXk9pWLcaS6Bu4lAhUG4CDJ9a0MaCvr/3fvc+PP7L0a38eB27p2LP7wcf6H
 159znoZuugGz8nlCrhSSP19lyl5dLg8CgLrVe2nJXYdHhxKCed/bVA1kzosa79FaDBANU93Pz
 KFRna7oNduYoLoe//Ly1rxh3VHk+mcYfd7gMqxjlpUD3gMxB+Aw4Jc/dGEgxw+8Z3nhk3XjlG
 zuUE+lz2QpY4MUhfQ+ZYxmtxXTtzJiWrWmv0ojIeXWDYs=

Hi Kieran,

Am 13.06.24 um 21:41 schrieb Kieran Bingham:
> The vchiq_state used to be obtained through an accessor
> which would validate that the VCHIQ had been initialised
> correctly with the remote.
>
> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> vchiq_state") the global state was moved to the vchiq_mgnt structures
> stored as a vchiq instance specific context. This conversion removed the
> helpers and instead replaced users of this helper with the assumption
> that the state is always available and the remote connected.
>
> Fix this broken assumption by re-introducing the logic that was lost
> during the conversion.
thank you for sending this patch. Maybe it's worth to mention that this
patch also drop some unnecessary NULL checks of state.
>
> Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vch=
iq_state")
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
>   3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 54467be8c371..67d853f5f2a0 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -804,7 +804,7 @@ int vchiq_initialise(struct vchiq_state *state, stru=
ct vchiq_instance **instance
>   	 * block forever.
>   	 */
>   	for (i =3D 0; i < VCHIQ_INIT_RETRIES; i++) {
> -		if (state)
> +		if (vchiq_remote_initialised(state))
>   			break;
>   		usleep_range(500, 600);
>   	}
> @@ -1299,7 +1299,7 @@ void vchiq_dump_platform_instances(struct vchiq_st=
ate *state, struct seq_file *f
>   {
>   	int i;
>
> -	if (!state)
> +	if (!vchiq_remote_initialised(state))
>   		return;
>
>   	/*
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 8af209e34fb2..382ec08f6a14 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -413,6 +413,11 @@ struct vchiq_state {
>   	struct opaque_platform_state *platform_state;
>   };
>
> +static inline bool vchiq_remote_initialised(const struct vchiq_state *s=
tate)
> +{
> +	return state->remote && state->remote->initialised;
> +}
> +
>   struct bulk_waiter {
>   	struct vchiq_bulk *bulk;
>   	struct completion event;
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 3c63347d2d08..8c4830df1070 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -1170,6 +1170,11 @@ static int vchiq_open(struct inode *inode, struct=
 file *file)
>
>   	dev_dbg(state->dev, "arm: vchiq open\n");
>
> +	if (!vchiq_remote_initialised(state)) {
> +		dev_err(state->dev, "arm: vchiq has no connection to VideoCore\n");
Can you please downgrade the log level to dev_dbg, because vchiq_open is
called from userspace, so we can prevent log spamming?
> +		return -ENOTCONN;
> +	}
> +
>   	instance =3D kzalloc(sizeof(*instance), GFP_KERNEL);
>   	if (!instance)
>   		return -ENOMEM;
> @@ -1200,7 +1205,7 @@ static int vchiq_release(struct inode *inode, stru=
ct file *file)
>
>   	dev_dbg(state->dev, "arm: instance=3D%p\n", instance);
>
> -	if (!state) {
> +	if (!vchiq_remote_initialised(state)) {
>   		ret =3D -EPERM;
>   		goto out;
>   	}


