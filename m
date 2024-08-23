Return-Path: <linux-kernel+bounces-299686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C098A95D8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11381C21890
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C251C8232;
	Fri, 23 Aug 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JPzu+vVM"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925691922E0;
	Fri, 23 Aug 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449651; cv=none; b=f81QLwsZYQ7bimswBKvjx1DhqN9E9b3KLXSju5xTqp+WvGVW3TRNUDYNSmKhOdD4W4w0j3qVks043Q/SEHERxfm+zZ3DYdjjKx0sXUGTmr2Vwag8C5dVJlS8Mg++nVsUVvDYFaJDktNbIIx1lg1tbporur94N2GS+aW5jI7JSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449651; c=relaxed/simple;
	bh=PCDnMC8slProdj/MUscZCihbWNlAfgo5Fz3MCr1lm84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRt2mWJ8wMOB1uYos5qQLihY7xr343sd0guKPVEPUGrP2+/0fWD004XCcnfsS7RJIanm/3ies5B3DrokHxZ0RdyC9JqERegC1lBj9D5IyJ6HdL7tNkhho6Uom9FZ+iathcSYcM9ZE8kLsgjGxayHNjmE0LIMH0tGxpJPwOWqCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JPzu+vVM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724449636; x=1725054436; i=wahrenst@gmx.net;
	bh=xYO6QiXJmcSTMu9xVAlZbnC04DXri0/+K49HCyQdjZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JPzu+vVMQAeqxu8rEyBzOi08mbdwkPbweGG0CvC0aFXonuSZgx41P98OM61moe3T
	 4jdEC59QvlNFDSOvxnfUXgnDX0gjgHYagY+Bh1gGTdt6hMBd2hbgsje6LA87oSstY
	 rlsQS8YRFetksoyBi7FSvkjuHHeeFidI6raf5Dmk8FEulyP/61agF5t1A3yKQMc5t
	 +08bEkiIKPc7ikPXthiSl0LR8UZSqqtNDqnJPFxYZH35i3aPeINMhacw5PRCG2219
	 vs704ebLrOgF1obqedlAXWv+Rbwfbpek7Q9JuPQY9iGfD3FBdVjGMopIpaQn4POiO
	 HXYgRGuQ9w6aT9jGww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1s7T1k1SXc-00e0mN; Fri, 23
 Aug 2024 23:47:16 +0200
Message-ID: <437e7171-097d-43b0-876e-c6343518197d@gmx.net>
Date: Fri, 23 Aug 2024 23:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] staging: vchiq_core: Remove unused function argument
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
 <20240823-to_sent2-v1-6-8bc182a0adaf@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240823-to_sent2-v1-6-8bc182a0adaf@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kxKESK5O9T5ZHHdcIqK0azc3AdJmyxeIVDCOHvftSDizZljLdyZ
 +4J0SOSCWT8pt1ra27t/T0zs1gFnA6phyMUf+TcXWQYhM9mbIDeQOmJxj96qZW2ZV6L2JDN
 igvGr5R6NTEmkDBMDDftCE3YwUh6O7hYHQIG8bQt+ivs2ZvjoPZedR2c0HuFlvC4Xjx/HNn
 3t1a0Ly01cH/nFtQ6MSQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FtAPsWoh1Vs=;jV+TrRVLOBHjH0hXXVTUp1iswk0
 hQBFSpO7pERdwLKcu4M+i10aXLSNCcU9euWruAzlXZroaheHaUrRMBPpmrYaeYsJnOxmdtld2
 ypk3YUWk+Hyo09QMd0DYJc+3PMZijy7Ci3oAPRHfg6S9JDGf3pOsVn4jvkinM3FEW3HauG6zs
 7y3GbzJiG6tkZHBbBZd1FqbnfKe9m4LTs5142vyCXbrKuw4p0UI9w3QJQiA6EtHXU3aydCvEt
 SGDSQJJD05KhxUlBxEBhA64bzy5ROZ1j1/rbbdYk2ETOQQLBN1OMNMCMRErn5+GYJ/Jk12LVD
 JvW1YIR+O451A9iVMpSubeCSmXVEDLIbE+Al0aTREvUzEUUpyLsDDkJfAIZH3DAIdhISkLv/k
 Goq2X1vi/0Q/7ZGHs/VH80bnt1UlMIBZ+pxUPDX6lyeW36mRs0pZ2gBl+fj42/IFhlsmOcihZ
 C4fEOU67LP1ayUpskrSOc+yV3o2/IgzD8rScVMFczzcuSAP5McB4UdELRiaet7AQRIZxRCPCT
 fkqEq6jD4Egp5JMmiYOagUTl4EEboxuH1vPiIHMpqmiGnAUgv5wG+hQDDfbEG7IWEjZITrJ1p
 CIwlGJ8YNd+cPprDvf1cUgtjSuK3XitxZ6ygVyN35K+ZQbzfCgJl9GAOZ3Hh2+IHq0L2vQ3wj
 mFx0gNiAua85fP8fmPYx/MMvrAjVHjWwhDY8N9IlszMgQ5Vn+V2VbLQOoopYYOT14iBL9ZIQ1
 HQL6I0SNausN4hCVMzws00ROd7amaoYCteIp/QvGnw/0cPUjMlbxpHRvduwdGwBb22r0wDc+v
 q28GIXviJmEsRxik4Cgp2R9Q==

Am 23.08.24 um 17:14 schrieb Umang Jain:
> The argument 'is_blocking' in queue_message_sync() is not
> used in the function. Drop it.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Good catch!

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 6 +++=
=2D--
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 43c6a214be86..84631878f77d 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -1146,7 +1146,7 @@ queue_message_sync(struct vchiq_state *state, stru=
ct vchiq_service *service,
>   		   int msgid,
>   		   ssize_t (*copy_callback)(void *context, void *dest,
>   					    size_t offset, size_t maxsize),
> -		   void *context, int size, int is_blocking)
> +		   void *context, int size)
>   {
>   	struct vchiq_shared_state *local;
>   	struct vchiq_header *header;
> @@ -1524,7 +1524,7 @@ parse_open(struct vchiq_state *state, struct vchiq=
_header *header)
>   		/* Acknowledge the OPEN */
>   		if (service->sync) {
>   			if (queue_message_sync(state, NULL, openack_id, memcpy_copy_callbac=
k,
> -					       &ack_payload, sizeof(ack_payload), 0) =3D=3D -EAGAIN)
> +					       &ack_payload, sizeof(ack_payload)) =3D=3D -EAGAIN)
>   				goto bail_not_ready;
>
>   			/* The service is now open */
> @@ -3150,7 +3150,7 @@ vchiq_queue_message(struct vchiq_instance *instanc=
e, unsigned int handle,
>   		break;
>   	case VCHIQ_SRVSTATE_OPENSYNC:
>   		status =3D queue_message_sync(service->state, service, data_id,
> -					    copy_callback, context, size, 1);
> +					    copy_callback, context, size);
>   		break;
>   	default:
>   		status =3D -EINVAL;
>


