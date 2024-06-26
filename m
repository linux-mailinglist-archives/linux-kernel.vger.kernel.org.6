Return-Path: <linux-kernel+bounces-231515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E146B919964
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C731C22047
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709301940BE;
	Wed, 26 Jun 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="YNWO0p1S"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A43183083;
	Wed, 26 Jun 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434756; cv=none; b=Pel1Vt+U9L0Ajos4HYxYDL9H8oi2bQxz7U7UAk4P5bXMW5xghW6YI9rSolKCLk1GgbpVkdQFyia0Oi8yDFAX4Ei7Xc3SLlNTrLOCskmXW37ge1rLFsYfz7QUJPkNn8fek5RjDaYg85c39rIFDdTpJVoQAtzZmDvGexPxuBL+nuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434756; c=relaxed/simple;
	bh=Q2zx4FCE+9vWzUk0d/h5q21/e2DzpcrLNzzRKzzybW4=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=NjOv0LMpJad5642cU+Iu2B0CXV6vWg2K/jJH9wlSeg4DNcSFkSPC02T6fGVJsl9otGwvdI13E1EmA4J8ZLVHquUKQ3BEFjB47ejsEQD9iAbj8inmldsbeqDiu5PUgTHTm4FbVMwAwrOEqOwjJ78HOKruzdiI3oqhhHdbavsF/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=YNWO0p1S; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1719434738; x=1720039538; i=frank-w@public-files.de;
	bh=pk/N9sOmyyAO4ndkcOpo2JyR6rq6rZ6YNLMlI2Iu1jk=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YNWO0p1S8yZ9haDoKlixUf472oG52OroaMMosbQ+2vIJIc8BREiQ7/MdYNLawIop
	 ssJjq68KQlzonznId5UryJByp9yOYU2HNC/v/CPiUO5usFr+mGtWVQJHzmR/+P8Ss
	 jjJw3AYPIdAmCG0PmQ0aQiNSoiI03Lil8ndJ7BKszsMPy9gMKK8Vs2SVbmutaN1N4
	 sXqy+9p+EEg5QJLuKgD97ZJWj7saY2jkWO5UeWBhgZOuvVolzM6ISQpj1aqoQbn5D
	 7penzWZKBmMTV3wJhQj2jMYP0B5MjTBQa+P2Ai1WxqPIOb3kp+z3xlQchfsp6pPno
	 KUrEYevAX9rbCd38Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.144.17] ([217.61.144.17]) by web-mail.gmx.net
 (3c-app-gmx-bs52.server.lan [172.19.170.105]) (via HTTP); Wed, 26 Jun 2024
 22:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-82c94d49-2a78-4470-83cd-3c6747e01849-1719434738199@3c-app-gmx-bs52>
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Wunderlich <linux@fw-web.de>
Subject: Aw: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs with applied
 overlays for bpi-r3
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 22:45:38 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20240608080530.9436-2-linux@fw-web.de>
References: <20240608080530.9436-1-linux@fw-web.de>
 <20240608080530.9436-2-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:daJFNidyjDGhyFZbMsktP6EGcQiBfnib8hwMUfkVUsYRCpPDuHMV8E+AxflUNdQsHdpdD
 pfTKh+R0QJkTmlvD2vsFp38nO9v8Zpyz1pnHBZOktjzMoy6Eny0NKHOdbEsH4mRYGZ3d/9Cd1F0a
 rTvA+KWLWZd2T7H85V1+mD0QSKgWrVjzzPpJUJcJk5495pJrnJW0bKqee9D96Dax0ptf02YIfNFM
 qq5fxqVWCfv7iSoYomxByOBGur0FZSBCXKR1wuvz7zRttvuXnMjYnpuKYVqOi5OLxUxP1888EQIn
 s4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XPnMrznUCb0=;4s1q346PEfAs1ZEbGmfpvnnqEqI
 wPAcR5eEi340YxYCXG0NYoi1SjePCpeYdrNdCs8WqUF2w0MOMNQdHjkKxxmBUYaZzOk22MoWo
 iKwMYuGp2Kw9DRjkAPKTIrjj2+lChHNBkPFvztGk+3wKW/wquXWwXuYTpeRrXfFGMnY1kQzyP
 BYdWsyQN/ylt+n5J21Jj1ZztLi4x7joN0AKTxuIOgs0qMLJw2mcPIxx9BEyIlbIXekf/ArP/m
 fhyp0bIOsVGkEm3lbuTZ9ryNa9Eo0Kk9dg61hSZwn8U90DOKhoVId/ZjrJr8XrFKBB0FLeQur
 e88CrVawQ/Kd+nYpjoBKB0SgZBAd+fkwzk45q/jVxkDHsFVq5bP/TR6gNQFHs9+75IHPJzrkk
 RM5hTc4a9JhwLcFNMnq0nS/AOrWAfn/gGm/XMqvv1jkJnPs+alOLDnCv5KtQyGWd9WMgOKgQb
 aYg4vjbQUvdH2MeCJsDoGjjKFZ8O1jXq+v6tHXtvt83/FAdZhyWgZ+C+tKNZfg11fYnKd5P7m
 IOXIfdCkN0bo61zOCLGB72tmg2JKjavJhBTAyRKdrzK1twkczEEL65k3p4YhZudJLffO6mAYE
 LTQ5ve8mq2FHcK2UJZDsAnkFXB5oP4KfoYws0/KWDBHLWXZrXsKZFdp+s9WwqSN6vdpP2mOy5
 N9q3k+jcOEJwexQ03I3uz4N6dL/VWNubc6BuAAuorVkMjKKjQIn9igcTW17kWbQ=
Content-Transfer-Encoding: quoted-printable

any suggestions? hoping it does no laying around so long as v2

regards Frank


> Gesendet: Samstag, 08. Juni 2024 um 10:05 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>
> An: "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del R=
egno" <angelogioacchino.delregno@collabora.com>, "Rob Herring" <robh@kerne=
l.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+=
dt@kernel.org>
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, linux-kernel@vger.kern=
el.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infrade=
ad.org, devicetree@vger.kernel.org, "Daniel Golle" <daniel@makrotopia.org>=
, "Rob Herring" <robh+dt@kernel.org>
> Betreff: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs with applied overla=
ys for bpi-r3
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Build devicetree binaries for testing overlays and providing users
> full dtb without using overlays.
>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=3Dq=3DEYjUdjE1_8g1M=
Ktvw3vVzx5A@mail.gmail.com/
> https://lore.kernel.org/all/CAL_JsqJSi=3DkJSix=3Df3787ULZnaCy_Y26Phdhy5y=
9fat_vkDuUw@mail.gmail.com/
>
> v2:
> make full dtbs multiline for better readability
> ---
>  arch/arm64/boot/dts/mediatek/Makefile | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts=
/mediatek/Makefile
> index 37b4ca3a87c9..0ec5b904d35d 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -15,6 +15,27 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi=
-r3-emmc.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd.dtbo
> +mt7986a-bananapi-bpi-r3-emmc-nand-dtbs :=3D \
> +	mt7986a-bananapi-bpi-r3.dtb \
> +	mt7986a-bananapi-bpi-r3-emmc.dtbo \
> +	mt7986a-bananapi-bpi-r3-nand.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nand.dtb
> +mt7986a-bananapi-bpi-r3-emmc-nor-dtbs :=3D \
> +	mt7986a-bananapi-bpi-r3.dtb \
> +	mt7986a-bananapi-bpi-r3-emmc.dtbo \
> +	mt7986a-bananapi-bpi-r3-nor.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nor.dtb
> +mt7986a-bananapi-bpi-r3-sd-nand-dtbs :=3D \
> +	mt7986a-bananapi-bpi-r3.dtb \
> +	mt7986a-bananapi-bpi-r3-sd.dtbo \
> +	mt7986a-bananapi-bpi-r3-nand.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nand.dtb
> +mt7986a-bananapi-bpi-r3-sd-nor-dtbs :=3D \
> +	mt7986a-bananapi-bpi-r3.dtb \
> +	mt7986a-bananapi-bpi-r3-sd.dtbo \
> +	mt7986a-bananapi-bpi-r3-nor.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nor.dtb
> +
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-rfb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986b-rfb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7988a-bananapi-bpi-r4.dtb
> --
> 2.34.1
>
>

