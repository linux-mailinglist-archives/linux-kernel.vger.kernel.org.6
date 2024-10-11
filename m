Return-Path: <linux-kernel+bounces-361008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD199A250
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7741828767D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1B2141D6;
	Fri, 11 Oct 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="RRPBowiU"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE7215009;
	Fri, 11 Oct 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644749; cv=none; b=iE70RirZZ6anUx0JFBx3JbXh6XnrOCCCBdhBs9ZArTTzYJPE3Q4gJlic5Jt+7FBzTpLjSe3zHRaLUsnh8LxkVnO+PysL9AGYVyoDXGqhqNE6NamdrsdQJaNDurZCOE5W7ZFRJCE8sRpgRuYHMNIFRZKveKZ5u6w/kMuLtvg+nzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644749; c=relaxed/simple;
	bh=6D37WDeB/DH8wJD3vRLW50kinLc/15xw0HCbvv/Chmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJE25QeDhocz+f4h0J5B41cjDqpd7sGgK8itz+ArogoDbWdFyjB6qXk/QRQkobCi3uJ2ZoPTHqTRwFF5h+AlRI0d4U1OB/RMDla99Rig7e68b57yCkPGFRdEbQ5iSMOs8oJlbuGkdT38ljATKQBwjbRPsf7ewx4T7V6aEU2mEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=RRPBowiU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728644737; x=1729249537; i=wahrenst@gmx.net;
	bh=YrZ9LfEnyaou5WYzeSPJTD4kfXnwi/ikkYywgRF7yOc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RRPBowiU8GCpvc7aa60vdTGp1g/T3JUyh6EWrOSNM38retbCCDCmsQfM8219ri29
	 39AzuJfkMH19ZFc0wZcGwaFW194N49EuTz/T9xFr4ncs8e6yJHBawt8LQXcXL3rln
	 Cl1Q8vfDv6iw/i96wfOFBZSAm5v78/NAJKIQbA9862U6lsvw0NiQeaCI/FBAiTBjw
	 24AEuwq0vU7KgzKef4MZr2tLXdOTcvckaCdVsk19gXTC6u6pnSHUg3VjIOhV62l5i
	 9TdG2bcTOo4uOrX3n3PEOUlMYzXfJUzKcUgOwDksWEsVkz1M1n7+rIr+P3LehKc9U
	 dXkkb69asvIP3mZo9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1sxqYO0541-008QRK; Fri, 11
 Oct 2024 13:05:37 +0200
Message-ID: <3822dfe4-6ea0-4934-8c7d-85a2433adff0@gmx.net>
Date: Fri, 11 Oct 2024 13:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] staging: vchiq_arm: Lower indentation of a
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
 <20241011072210.494672-7-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241011072210.494672-7-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vjcGG8L9TmRPsXePVp23Y+W14RQC9VY1bmVX6LpFl0bKPaTX1gy
 wdcMGgual033VzsewYZHdZbuT5rrZWZcQN79BWluYSNdDo7bf7TWpG6AKhf7cEUkWaxm17V
 X81rcFdITfFhw3hcgS1Zwn6n9/SwJMiCjUZrlT5I0/VHSWafkg8jwxzS/BZattKjSmccndN
 lmcRMRkOsubcOVbG545iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M0/kSwbpfJU=;U6J2KrqhRNs1GfWY4gNlAHpzq43
 F6h4hELw4Vl5aJ7Nc8LKH38nfRx8r7yzVm+pHBN5KH9NLgQ7VdmoUdLZBjnIwjxS+hcsINuaf
 SQcWxQlHkKdG47lRw0MZpf2OdVbOWMeU7JWLoOuYdO15kWeSKZqQbAgehTJfP5TaTI5zyz3R/
 CrxF/Ek52PBnmc3z+Vfpbp0wNpXj14vC+PwOeP9/+4nZ7OgT6cwRhFrnyp9AtXvoRlmpbI8rq
 k803yltci0miQFsWtzjD68Xm0V2ds+HdTS3fPHg6qwcMYdFomhew8kW0WPI6MOhMG+YWKEBan
 wYfy9bms3LrqGq/E7SiEWhj2aWTdcp/1S5svsXTW412jJn1O60q6Xu3u98sYvhlxJYMpv8R5F
 Ix5u+msTxQsoOFscXqVxKbyMczrPL3+BXnofw6cjn5xqVQ8yEr/4ekjzjd/A8L6M27+xFzNgf
 RSLcb9TMis6vmNBwBloDisonveb6aLgDUk3Usvf5B1ehJdk3tFrEuZ1nHbXHop0YYBn+Bdseg
 8sw0HR+ML8viWBeaP9X4GyhNz+y3UBdfTAbof7e1judKvJwq347JQJYNz3g0A3ZhIDLOeRnhA
 u8+cNbgNoEhJRTayVYg856yi4JzOUUF5vSCJvkSPwZSfPv6OXXgOHXr1za7chOPRIVOHkJaZ/
 nbQgP0YkJhtf1YXYqz/knB2Lb00Swl/y81V5zBbZUmQxM59JIJklRkE5sBVXY6q+g5XCc7kN4
 cu/g8v8Su6kMhsSrYvSFtza9SeQwInUHjTVuP896jVm+axfm16c1Of9FAknfKYUNPFLk7SUqw
 ECWboUobgtELPJ9Cp12HutvQ==

Hi Umang,

Am 11.10.24 um 09:22 schrieb Umang Jain:
> Check early if we need to allocate the bulk waiter. This helps to
> improve readability and reduces the indentation of the 'if (waiter)'
> conditional block.
>
> No functional changes intended in this patch.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../interface/vchiq_arm/vchiq_arm.c           | 34 +++++++++----------
>   1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 27ceaac8f6cc..a4a7f31b124a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -564,28 +564,28 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance=
 *instance, unsigned int handl
>   	}
>   	mutex_unlock(&instance->bulk_waiter_list_mutex);
>
> -	if (waiter) {
> -		struct vchiq_bulk *bulk =3D waiter->bulk_waiter.bulk;
> -
> -		if (bulk) {
> -			/* This thread has an outstanding bulk transfer. */
> -			/* FIXME: why compare a dma address to a pointer? */
> -			if ((bulk->data !=3D (dma_addr_t)(uintptr_t)data) || (bulk->size !=
=3D size)) {
> -				/*
> -				 * This is not a retry of the previous one.
> -				 * Cancel the signal when the transfer completes.
> -				 */
> -				spin_lock(&service->state->bulk_waiter_spinlock);
> -				bulk->userdata =3D NULL;
> -				spin_unlock(&service->state->bulk_waiter_spinlock);
> -			}
> -		}
> -	} else {
> +	if (!waiter) {
>   		waiter =3D kzalloc(sizeof(*waiter), GFP_KERNEL);
>   		if (!waiter)
>   			return -ENOMEM;
>   	}
>
> +	struct vchiq_bulk *bulk =3D waiter->bulk_waiter.bulk;
I think this is a behavior change, which might lead to a null pointer
dereference in case waiter is freshly allocated.

Tbh I don't think indentation prevent us from unstaging this driver.
There are more important issues (e.g. resource leaks in probe error
paths or excessive usage of WARN) in this driver.

Regards
> +
> +	if (bulk) {
> +		/* This thread has an outstanding bulk transfer. */
> +		/* FIXME: why compare a dma address to a pointer? */
> +		if ((bulk->data !=3D (dma_addr_t)(uintptr_t)data) || (bulk->size !=3D=
 size)) {
> +			/*
> +			 * This is not a retry of the previous one.
> +			 * Cancel the signal when the transfer completes.
> +			 */
> +			spin_lock(&service->state->bulk_waiter_spinlock);
> +			bulk->userdata =3D NULL;
> +			spin_unlock(&service->state->bulk_waiter_spinlock);
> +		}
> +	}
> +
>   	ret =3D vchiq_bulk_xfer_blocking(instance, handle, data, NULL, size,
>   				       &waiter->bulk_waiter, dir);
>   	if ((ret !=3D -EAGAIN) || fatal_signal_pending(current) || !waiter->b=
ulk_waiter.bulk) {


