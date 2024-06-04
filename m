Return-Path: <linux-kernel+bounces-201115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6418FB9C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A39F1C24D75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E964D14900F;
	Tue,  4 Jun 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Az0Z7vnO"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1BC149C77
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520495; cv=none; b=nNDvBbhPo6P4GbRYB+LFIaNvsRIIlkmEFKPobdZ0NXtFfQjpBvbB9CY6Fg/ihMc8J87x0WoB3VLMsTbmh1y4QxCXg5P6cn8atyrAGr4O+YtDGn1IIpdGgjKuBsXlhPDJfexZVFu2dXrUO8XASpSzBYzUQko7F7vJOQ+ydaxyQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520495; c=relaxed/simple;
	bh=aovq5NqWxYt3sBqCD5d7iuAYGwvvrWSv6toQq7F5VlE=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=SFtqAqFnRYtZ24HsuwEZkuIdm99PF1hC28Oe6W8sXaXiT7KEFoE2pBNlEZpnGhdf+xyu7hABVKsx2BjgLCqsYfGpZ+23SIrJ+loEOugBbIyo9+V6SLRJdR4RKMfQ+7semHwjphbU2MIFJ9KVufQN4MmVPChqcZvfvWsl4z+ITGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Az0Z7vnO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1717520476; x=1718125276; i=frank-w@public-files.de;
	bh=HzOGfsxtAbzPaiVG4Wh0M0g2GTonKekwIavduiotSwY=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Az0Z7vnOVH+mdpayYy/q9JTsVgSqUFFYhRbCJFajCAYqq0l4cL1H68GhtXgzwEwt
	 QFzRTsi+wXBOzagyesuhXpm4XE75rtMVNS4T3+5dsJV9e2BACOXb+yMLqNLI/AM/o
	 rwFDzIrCQjeoxdtA2ab5DVw56BKwQB9tGFy/mqEFP6snAmz6w5mweq2w3LrxY2ROu
	 QXWWLhRn5qEjoRhfge/A2Rar2P31LrkwzE2w+fHzbgc9LP6Mw1UumfxlLt0DrrOod
	 YcSah8NuT1hHfIp3H/D4n0OwmwHbpYpeHY0XhVCwxxxzyvqiqMVbVVfxwnAF7C1Ci
	 +Gw3WpS/I7QYXH8hCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.72] ([217.61.157.72]) by web-mail.gmx.net
 (3c-app-gmx-bap32.server.lan [172.19.172.102]) (via HTTP); Tue, 4 Jun 2024
 19:01:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-d7335867-6435-44f5-bddd-d825bcef2d33-1717520476265@3c-app-gmx-bap32>
From: Frank Wunderlich <frank-w@public-files.de>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Eric Woudstra <ericwouds@gmail.com>
Subject: Aw: [PATCH v2 4/5] arm64: dts: mt7986: add dtbs with applied
 overlays for bpi-r3
Content-Type: text/plain; charset=UTF-8
Date: Tue, 4 Jun 2024 19:01:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-a61f3152-8b44-4efb-9176-cc00a9449e63-1702133775512@3c-app-gmx-bs23>
References: <20231025170832.78727-1-linux@fw-web.de>
 <20231025170832.78727-5-linux@fw-web.de>
 <trinity-a61f3152-8b44-4efb-9176-cc00a9449e63-1702133775512@3c-app-gmx-bs23>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9D0FPugdNo2sfMSNB36s4sPbmzQ//ch9qQ1z7kf35oVBJSWNVj6kMbWcGc9aBiQjzC2SB
 D1Vu1e/qPOaNy0YQ7wBPotozdIB6KVss7NxxSgDCwMNy7l5Ttlr5CQNzDIJt8ytkZQjTS5YmUo8E
 gtZ0YupCJoTVOIh/Vs9ofhiqQYY6gL6/JZJMXjDq3bp7meLn6m5YVanVV2z8hjwx9RRrfi+KX4pG
 Aa0ViS2D2mdGefzxOeNFGm5eh01PGaUap0p4Vs+d2CIbAwaTz9DR+afUDR5NvZx3AJ0Qd4HcfTpb
 s4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I33YQDgclag=;efPVmOXOv1ZURw5hMJZ0SQKXJ6t
 l0gAZiw9iLJzhcMTcqoNArSgjhSaABD9M8NRYYIZ2v1hDD5xfE7eQk0nTpYnaSmFEQRUbDrC4
 8+ozPr8v/NjNh4sOnzZ6fDvdU25YkNzga/9QTz1qwDByef+IQ5cDLAQkYDPXkeqkc3AhZTyST
 GRiy1ZgkXmzqFLqJvrsNN8tFmU948zvl9PVqZSPpkefDIg+qAZmLYf+exxmDyfl5EgLpuIGdA
 wMs8iXVWR3tayyIbG7hiwVAQEpF7zoSMYOA8APv6TgmPYT8OzpjgaPoEW+zHtYrFi1iQRkBoM
 0zsFFMLTciAAjwltCBMoyzTHqf4f3aZGe+D1L2il2t+ZXzmprnyMknBctczSavcY77AnJu8NG
 sUhX8NwV8gv2UiQ+Dk8Xnqxqmz9XvoAqPVNuznGVsXPH9UZJt96hBG+EQNuFBXKqQhX0lfyOc
 ktmBjS0RqHcLGQ8hwE0w/iwgf812zGNACUS3mCTGelpfFSuJc4VZrOlwQrZMgjBs/ouAuZZ7U
 3vcDYZqduYAz/3xf020RQ4GakhzEi51eNTWqmhjNcgoNjH8T78AqVvshkJym/WmCGyCTzGAw9
 EFIvTC6Tq5QFAM1VqYk8iPSiHtFu2j4ZM4UUkuYz1p9J54JKDIFQnq5yWoCj1yl4kgIU/JZE7
 NZCfBoxXcBWRWTtjqV1KUGgx21lBowzqAlkzeRH78kLkDLIoy6UgFJigzXLay1M=
Content-Transfer-Encoding: quoted-printable

Hi,

how to proceed here?

regards Frank


> Gesendet: Samstag, 09. Dezember 2023 um 16:56 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files.de>
> An: "Frank Wunderlich" <linux@fw-web.de>
> Cc: linux-mediatek@lists.infradead.org, "Matthias Brugger" <matthias.bgg=
@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delregno@colla=
bora.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzy=
sztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>, "Dan=
iel Golle" <daniel@makrotopia.org>, linux-kernel@vger.kernel.org, linux-ar=
m-kernel@lists.infradead.org, "Eric Woudstra" <ericwouds@gmail.com>
> Betreff: Aw: [PATCH v2 4/5] arm64: dts: mt7986: add dtbs with applied ov=
erlays for bpi-r3
>
> Hi
>
> Parts 1-3 are applied here, but how to proceed with this? to add further=
 devicetrees like
> for mt7988 we have to fix the "broken" dt-overlays first.
>
> i want to keep to build the dtbo to allow dynamic apply in bootloader, b=
ut they should be checked in
> compiletime too and full dtb should be created for users not wanting to =
handle overlays.
>
> regards Frank
>
>
> > Gesendet: Mittwoch, 25. Oktober 2023 um 18:08 Uhr
> > Von: "Frank Wunderlich" <linux@fw-web.de>
>
> > Build devicetree binaries for testing overlays and providing users
> > full dtb without using overlays.
> >
> > Suggested-by: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=3Dq=3DEYjUdjE1_8g=
1MKtvw3vVzx5A@mail.gmail.com/
> > https://lore.kernel.org/all/CAL_JsqJSi=3DkJSix=3Df3787ULZnaCy_Y26Phdhy=
5y9fat_vkDuUw@mail.gmail.com/
> >
> > v2:
> > make full dtbs multiline for better readability
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/d=
ts/mediatek/Makefile
> > index c99c3372a4b5..24eeba0703ce 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -8,11 +8,33 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
> > +
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc.dtbo
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd.dtbo
> > +mt7986a-bananapi-bpi-r3-emmc-nand-dtbs :=3D \
> > +	mt7986a-bananapi-bpi-r3.dtb \
> > +	mt7986a-bananapi-bpi-r3-emmc.dtbo \
> > +	mt7986a-bananapi-bpi-r3-nand.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nand.dt=
b
> > +mt7986a-bananapi-bpi-r3-emmc-nor-dtbs :=3D \
> > +	mt7986a-bananapi-bpi-r3.dtb \
> > +	mt7986a-bananapi-bpi-r3-emmc.dtbo \
> > +	mt7986a-bananapi-bpi-r3-nor.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc-nor.dtb
> > +mt7986a-bananapi-bpi-r3-sd-nand-dtbs :=3D \
> > +	mt7986a-bananapi-bpi-r3.dtb \
> > +	mt7986a-bananapi-bpi-r3-sd.dtbo \
> > +	mt7986a-bananapi-bpi-r3-nand.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nand.dtb
> > +mt7986a-bananapi-bpi-r3-sd-nor-dtbs :=3D \
> > +	mt7986a-bananapi-bpi-r3.dtb \
> > +	mt7986a-bananapi-bpi-r3-sd.dtbo \
> > +	mt7986a-bananapi-bpi-r3-nor.dtbo
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd-nor.dtb
> > +
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-rfb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986b-rfb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8167-pumpkin.dtb
>
>
>

