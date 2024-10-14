Return-Path: <linux-kernel+bounces-363727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD34299C620
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C11C22C43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B9157484;
	Mon, 14 Oct 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="r5u7iapi"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27476156230;
	Mon, 14 Oct 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899012; cv=none; b=IacpzmLj+rrFPRAF/3MSIIR8Uvf6Sj0IwRBB1RAnsSmIec9LOFmRylB9i3C2RoT7uwj6UBkSRmF2Z2/rsczZlZ/iQoGuFtM6xkUBcxFaeQ8Tb3b6ffFlq1xGJhJvT31w+t7mIaoaGIsWnu0uEiauhB8UnpWs0oZVoJZ7reE+j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899012; c=relaxed/simple;
	bh=C7Yx4DBLSGhLfhwFlsYhQHfKDsQCzVNXxnWgEMgLKSk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=p0rXTs7YvpHuz25BAZ5mzR7WB8nrFt2WbBrCmg2si4GZhQIj1GkE4LpfT1hnUiOpAQrE8nBjh0jXSCOidOnmUsho9VwCYQ2BMsfRGSZbw7BioD2+/ZLs64YNn/RJy5YcMiFzxDXRIIvRlPJYvRD5o0uS3KtUEGG/Gf3Zpsc/rAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=r5u7iapi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 736EE8BE;
	Mon, 14 Oct 2024 11:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728898907;
	bh=C7Yx4DBLSGhLfhwFlsYhQHfKDsQCzVNXxnWgEMgLKSk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=r5u7iapihoc8rDemMHEu+tVCB1ATI7uNVuzOzyoPmDQeCO3B9CrcuYNm1HzBX1ZJp
	 I18wbLE5UH1oAvPogDkuVCHVHfbBUQnDJ2ANNJMKhV6kTjq51/ynt9XBI2ALFQ/zWl
	 MVOBK1c5WNwQf/+lREuix3xBD2N+orawcE2k/r3c=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241013142511.9946-1-abhishektamboli9@gmail.com>
References: <20241013142511.9946-1-abhishektamboli9@gmail.com>
Subject: Re: [PATCH] usb: gadget: uvc: Remove extra semicolon from the macro
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Frank.Li@nxp.com, m.grzeschik@pengutronix.de, dan.scally@ideasonboard.com, andrzej.p@collabora.com, quic_jjohnson@quicinc.com, shuzhenwang@google.com, arakesh@google.com, skhan@linuxfoundation.org, rbmarliere@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
To: Abhishek Tamboli <abhishektamboli9@gmail.com>, gregkh@linuxfoundation.org
Date: Mon, 14 Oct 2024 10:43:25 +0100
Message-ID: <172889900570.877857.1005868402461236136@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Abhishek Tamboli (2024-10-13 15:25:11)
> Remove the extra semicolon after the
> do {} while (0) in UVC_COPY_DESCRIPTOR macro.
>=20
> Fix the following checkpatch.pl warning
>=20
> WARNING: do {} while (0) macros should not be semicolon terminated
> +#define UVC_COPY_DESCRIPTOR(mem, dst, desc) \
> +       do { \
> +               memcpy(mem, desc, (desc)->bLength); \
> +               *(dst)++ =3D mem; \
> +               mem +=3D (desc)->bLength; \
> +       } while (0);
>=20
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> ---
>  drivers/usb/gadget/function/f_uvc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/fun=
ction/f_uvc.c
> index 40187b7112e7..edf0355d712c 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -465,7 +465,7 @@ uvc_register_video(struct uvc_device *uvc)
>                 memcpy(mem, desc, (desc)->bLength); \
>                 *(dst)++ =3D mem; \
>                 mem +=3D (desc)->bLength; \
> -       } while (0);
> +       } while (0)
>=20
>  #define UVC_COPY_DESCRIPTORS(mem, dst, src) \
>         do { \
> --
> 2.34.1
>

