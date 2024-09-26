Return-Path: <linux-kernel+bounces-340759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7729C987781
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D912868DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079914A4E0;
	Thu, 26 Sep 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="bTrhtH3H"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A715AAC1;
	Thu, 26 Sep 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367966; cv=none; b=p0QtGmb4UgUcrXa5QqeZGFF720zIMKYvDt5usXKGWyjuBTNFSZdGvLVD61AmPbVBaS51cX8DnwSi/vSDtWjMSJvarSP0LzgztAH+yJUBJu/6e806+vWev48GS+2OFhfcHnO8gdt6a24EJeo2rhLr1nPM1yM0/zpcOvGu9a7HPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367966; c=relaxed/simple;
	bh=68iBfkfLXxtq1wvHdM3ZxfZa95RymsuFlkNB6q40704=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIkXDARYObo8itaHhy1mgxb9VHg8Z0O0WnzbxBRhzEmwPTTEJXoYFLuyJj/OyWWEMubB+Gk4k7tFnLuNmEpSOyEVKmJW3fDCGl8VR9JSdIJaKAJDMuJuY4rY8tg7AoIgFgP5cnM8C4CdbhGMJlSvxbIR9yn/Aqb0PqBKQtZrDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=bTrhtH3H; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727367955; x=1727972755; i=deller@gmx.de;
	bh=rKq1pKpnF4dqOpF6xuiATIVA5ssa2uc4bW84OW8MrwQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bTrhtH3HN+9bB+Oa647UQebWlTKskb/pKeizUkEfBCesX/KNbgvCGgQAuB4bpbc2
	 ECeToTFSTbfgM7o3Jx46syI1YemJH3FUZ3DWWpLHxFmfjf2/hl/uetg+TW+k9dSC9
	 wEdVyCa5u/H+zPjfSBVclL0r1/h00LsoCX1WhGcRENbkbKpmtzE33UDfmSKTk6u1D
	 ZdunhgaEH02s0lZDnVmKaVuRBnoOujvCapniItnb4jzaEQnDRnkTc5GzKA9yLd5hu
	 0RDPyixJ95nNGRuVpms0ZE4zqmOeEEFQzEVegWrFuLyzr924YRbifFaVFzgHMLQym
	 zsPepDFhGoyA2fCk2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1s7vNZ0KYc-00qCls; Thu, 26
 Sep 2024 18:25:55 +0200
Message-ID: <5bbe55fe-4b35-43fe-8180-4fcb91c52384@gmx.de>
Date: Thu, 26 Sep 2024 18:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: break earlier in search_fb_in_map and
 search_for_mapped_con
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240926115911.620624-1-qianqiang.liu@163.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240926115911.620624-1-qianqiang.liu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oZNcXTd+EM0GqPtDaNCY8rccPTgM3BaN16d27CZKnJ+pEqCcaVc
 S8Xq+4qpUP17JoiAGDCbCBoofvCsr1lrohe0KPdu7MXKsrHvBi17dqsD/FzMg4TnGneVL0O
 Dz6HclwWd+NjucA36crl2FNik8DOT14LWdqIX5Lp7zeArTcwK3iqW0pz9IbDaREEXBssmOH
 U/xFGLlk8LKsdfobnIHxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p3xh4ggUvhM=;ai9MB0zI1f9u+FRwp8A2ZSTlERY
 cBHmWvrTrZwj12PYMw9znOr187/mXXIamDENeNf2IZueuqS3pset9VwPwuU01gbOPKMpF7kJj
 k2xN4RLvgR0MmNfO20UuXpZgI/pb9w594XBQDZWqbhbmYdZoFbS/c7iFTCXdJZ7oMm5zZ5x1o
 DkRIqF5lRF/UNkbCakKntigJFPYhFe7FM+k0oZueqb1JMT9iTyR9gFvwAdYRzyOQ297G3sDcf
 F0XpjVlgMqLv0gI+I2jA6oUL/6WbVlcb40C55dM+QtmbQRWKULCeTO0ZjdH3b40vcvQX0J9Z0
 pdeQve8SC8Ox/Ozlsxhq1P7Hbd97gPjopUfQis5JOURssu7Eq+osavNZzgm814JUrrkKaTsvt
 ozb41ptvPIXflKdSatxBFgCTPNqyHnEuifiV1gbL2TtHPrEG2kVoCmuOJy+WQI+ZOWVsKYHqV
 ZPagRiT6n5sG/jgRcC9L3keVOXTDHUU8oU9uZ0z3tMug3O8nXnqvSumFAdzUdWRoyv8+AAbnp
 bKaf7cgWEp+1J+QIIVvbK1j6uB7kblUySiwd6LxJCrV5WB8ldR96OLgGYWEqs2Fop9SZBfoFC
 DwoaeArnZ6p6GEoFPlQAOShmNtn+v0ZOUH1FUEjKqlLPgY5F19GVBiQhKWme9Td0pHNhZNjot
 EUlVAW/diOFDxHvq9tlOSGfkswWSpMXaMT9Hv3BEHRGLs3OR1hNAzEJ3O3mkI4isCngOHEjXM
 fkpKyqRi4PUhpBuCZwLxguCz7DnPx8qUcgfYnYMLTJtIF4Zir1C+aBue5soIs3qDlrhK4Z+3O
 xluN8lEeLWO0Wu8ipSe2MhsA==

On 9/26/24 13:59, Qianqiang Liu wrote:
> Break the for loop immediately upon finding the target, making the
> process more efficient.
>
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/core/fbcon.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index d9abae2516d8..e8b4e8c119b5 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -512,8 +512,10 @@ static int search_fb_in_map(int idx)
>   	int i, retval =3D 0;
>
>   	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
> -		if (con2fb_map[i] =3D=3D idx)
> +		if (con2fb_map[i] =3D=3D idx) {
>   			retval =3D 1;
> +			break;
> +		}
>   	}
>   	return retval;
>   }
> @@ -523,8 +525,10 @@ static int search_for_mapped_con(void)
>   	int i, retval =3D 0;
>
>   	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
> -		if (con2fb_map[i] !=3D -1)
> +		if (con2fb_map[i] !=3D -1) {
>   			retval =3D 1;
> +			break;
> +		}
>   	}
>   	return retval;
>   }


