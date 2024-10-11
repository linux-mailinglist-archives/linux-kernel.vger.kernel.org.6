Return-Path: <linux-kernel+bounces-360984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0049B99A20C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701671F23241
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E90212EF0;
	Fri, 11 Oct 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pE34G824"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F41D0E15;
	Fri, 11 Oct 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644087; cv=none; b=K+6ECd0pKm+KrQtyeGOyirH5jrzSy2QGAMj+1BWi5dRnItKNYMQ0ckjjoj8R92yjMX1rn65gYpzydpv73qzbYjVUQvUQ30aKehnxKJuPcHKcjHRKyRCJRQ6/eslHo2h5aYLCIlxHRSwLhltNnRyMOuZ8YI1XmVZ9vdWMXLwSxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644087; c=relaxed/simple;
	bh=BJhX/lmW/LILX88W3qn5ZKczb0DptbBEdZjDz6RxflU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bexcN19AuVi9+0dhewLZXpSgSk59unzQuCktdZp0QTa+pcN5kwmrkGmRbnUGJ30c8dLWeSUSfI8R0MgBYPRttus7ctB+vd7lLckBMVTittSKsiJWmgCZj3SsU07Z+DNMyhYZMzNM1uuJG+2UA6VoNrJqI94uEKGr/oi6Ex0eRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=pE34G824; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728644076; x=1729248876; i=wahrenst@gmx.net;
	bh=B0nqQTWmbX/DXBru/TDDCruKEolLwzT5aKjKNmMn0p4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pE34G824TsaI03+4EbgVmM4hxuWSOmuTvlN5XwOFYLEzmFXWoLXslEpjahLwIZjE
	 HyQF+aWIxruRFTKexMLPFzm/MpfI8N1LWkfatdrcEbsvdK+qUIK6I291uzuIkHjln
	 lAuoQEAz5x2qHPP91lpwtKyQ8wI9FnUPeBrFQVu4DaYKo92MsPF+EXr1SpNLUcqCV
	 Z9d+FfOEzfslSsjXj++nOtIRYaC57Vz5WYh+WjTb05IQFVj1P84XIjYSVE3UvS17l
	 zhPjhBlrFB48olYPsnEaLZ3Lhj+mChZUl+diyhKNazDUgegUR2eAkbdzc50xgNZEg
	 R8ffFGRvf7kozx2ELQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1tylzR2lwf-015pDe; Fri, 11
 Oct 2024 12:54:36 +0200
Message-ID: <eb4713e3-ccc5-4848-800e-dbf30158b8af@gmx.net>
Date: Fri, 11 Oct 2024 12:54:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] staging: vchiq_core: Lower indentation of a
 conditional block
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
 <20241011072210.494672-5-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241011072210.494672-5-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5HvJFIaJdVlUI3BICXc22twfJyPqXfvSQiy8GgciEliiSrCE9+N
 ywPwflgFjfYjGLwPCxCdXpuYEFbzjx5o5eeRn2CsFncP5RxBEQIcWpx2bWXQGmZfYpmDi31
 3UWYtxtLF9UGKaKHTLvAQFYgDV1ucKEEPBz1xf2MPee0Ub+iMfO7UJ1t5TWpCXzs5qt5ST1
 IW6KFZpbkrzeVx75uB3FA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WCGfBiwOFhw=;TWWCgkAaDvSNbOtqLyEFvUepvg0
 MH/WQDOlZKc7g0TzgP4J1+emuk6b7nTLEdzMTSbLOySmQZPDjPSVHFRPSOUM71GvlR+iew+4j
 Lg2Ro8y9xBTGFRqiMJ4A2IYWVmJQDvcOAmhrpspqHbvdLWfBpEuyBbOHUXd6g6N6RxkfUmmxN
 nBEnSgv9rkNdv/IqWCAqWxJotk1kPPlr9DrWHTxNk7W/IO4CKOgxA236t3KzHLbbfv0cMok1S
 9/FW5RqFG1ftIAq3FQ4SMeaT1b1usjL4ntbbQ3R182eXH/Lop0mb6uwADtFFmHP1v7IeRftDN
 bhCsVK870IM9vu5WQStYo/YcqW/aNYbI47pcmP2GX0/FMb2wmAtbnAxOGATfXgp5B5YTdiK3p
 s5Uk+qx4qp4Xryf1E//xhUp/non4q0mk2NHoMeGCiz3NkvHAfSpZcX7GKEQW7nqJuwkW+wAh+
 z43c63MMDCF+u662bxo70eSoXj7IeDHS9V8KxE33pFD7S+8SFuLcgV0Kx/syViSh5/djGivQ7
 tLEaUTpNufGop2O7qVs8vTfTWdhMgL8nptT944LRiupIFk5n+R6DDWgHux5NaRU8CJq8vmgmU
 M27P/Z38PRiOBTVK5VjPGKHHT92TkELjBivAKUshnqhXhMB1OZPapPmlv7A9N9vqnAbeCjvti
 YyaED5tBP9eVe4wUJ9t+90fXkonlo4Usg7aHb6ZupHIo6P9ay/8IYlwWCzmEg/jmnNo669sPP
 NwiJKRDzcRNDUJta0RD4bCJ80HyqV64QPNav9Tjw6ZNCkvs+nPAOJCEXHZK/Y0Yq9+6wUBh/v
 T09DqVXrfHsWDys9iA3wdR5g==

Hi Umang,

Am 11.10.24 um 09:22 schrieb Umang Jain:
> Lower indentation of 'if (bulk->data && service->instance)'
> conditional block. This is achieved introducing a early check for
> (!bulk->data || !service->instance) and using a goto label 'complete'
> if it evaluates to true.
>
> No functional changes intended in this patch.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../interface/vchiq_arm/vchiq_core.c          | 61 ++++++++++---------
>   1 file changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 15257cf66fa4..b95443043c27 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -1326,44 +1326,45 @@ notify_bulks(struct vchiq_service *service, stru=
ct vchiq_bulk_queue *queue,
>   		struct vchiq_bulk *bulk =3D
>   			&queue->bulks[BULK_INDEX(queue->remove)];
>
> +		if (!bulk->data || !service->instance)
> +			goto complete;
> +
>   		/*
>   		 * Only generate callbacks for non-dummy bulk
>   		 * requests, and non-terminated services
>   		 */
> -		if (bulk->data && service->instance) {
> -			if (bulk->actual !=3D VCHIQ_BULK_ACTUAL_ABORTED) {
> -				if (bulk->dir =3D=3D VCHIQ_BULK_TRANSMIT) {
> -					VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
> -					VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
> -								bulk->actual);
> -				} else {
> -					VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
> -					VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
> -								bulk->actual);
> -				}
> +		if (bulk->actual !=3D VCHIQ_BULK_ACTUAL_ABORTED) {
> +			if (bulk->dir =3D=3D VCHIQ_BULK_TRANSMIT) {
> +				VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
> +				VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
> +							bulk->actual);
>   			} else {
> -				VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
> -			}
> -			if (bulk->mode =3D=3D VCHIQ_BULK_MODE_BLOCKING) {
> -				struct bulk_waiter *waiter;
> -
> -				spin_lock(&service->state->bulk_waiter_spinlock);
> -				waiter =3D bulk->userdata;
> -				if (waiter) {
> -					waiter->actual =3D bulk->actual;
> -					complete(&waiter->event);
> -				}
> -				spin_unlock(&service->state->bulk_waiter_spinlock);
> -			} else if (bulk->mode =3D=3D VCHIQ_BULK_MODE_CALLBACK) {
> -				enum vchiq_reason reason =3D
> -						get_bulk_reason(bulk);
> -				status =3D make_service_callback(service, reason,	NULL,
> -							       bulk->userdata);
> -				if (status =3D=3D -EAGAIN)
> -					break;
> +				VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
> +				VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
> +							bulk->actual);
>   			}
> +		} else {
> +			VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
>   		}
> +		if (bulk->mode =3D=3D VCHIQ_BULK_MODE_BLOCKING) {
> +			struct bulk_waiter *waiter;
>
> +			spin_lock(&service->state->bulk_waiter_spinlock);
> +			waiter =3D bulk->userdata;
> +			if (waiter) {
> +				waiter->actual =3D bulk->actual;
> +				complete(&waiter->event);
> +			}
> +			spin_unlock(&service->state->bulk_waiter_spinlock);
> +		} else if (bulk->mode =3D=3D VCHIQ_BULK_MODE_CALLBACK) {
> +			enum vchiq_reason reason =3D
> +					get_bulk_reason(bulk);
> +			status =3D make_service_callback(service, reason,	NULL,
> +						       bulk->userdata);
> +			if (status =3D=3D -EAGAIN)
> +				break;
> +		}
> +complete:
I would consider goto labels within a while loop as error prone and
ugly. Maybe moving the enclosing code into a separate function would be
a nicer approach?

Regards
>   		queue->remove++;
>   		complete(&service->bulk_remove_event);
>   	}


