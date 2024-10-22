Return-Path: <linux-kernel+bounces-376014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8799A9EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A621C2372A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722F198A2C;
	Tue, 22 Oct 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RyS8qpAU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29121991B9;
	Tue, 22 Oct 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589785; cv=none; b=u9KSqs/00bqUr8AgV6G57COE9VHHlVry2gYgbSL5f8sur0b0kfH9Likhl03JanTgOrqn+vRZdqVaH42u5WA4dfRcEEjHqJcy5Od0DzgUVML0oM9VFpw7h12W7Z4ssjWOe3RdxsY2Jq5cN966F5Taak034b/3ky79uBBAuVrxcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589785; c=relaxed/simple;
	bh=rYYlihFu8PwLnQ37fCubpAZgvwlduc501eQg14BRZc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeFtdg4nl7zGiRUq1SibdpQQX1OFgxVtz5e3cNxkSPEAtUbr7NPb7s6P/GpxKkUoUfDFpAeTjCkH3Br409E9H9Y/Et/f3I8y0nn1+gXNNT8wTp1GER20VBLvsRGWSKpoQ9pPnFvroFAKHnk3YNXRb+aaGiXRwFswegIJNOu4joY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RyS8qpAU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729589781;
	bh=rYYlihFu8PwLnQ37fCubpAZgvwlduc501eQg14BRZc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RyS8qpAUyS0IdeSFrKR+nTTgfdVJnszWGypO/0WWgWeZwMX8CoQ37F9+M/7Bw80OR
	 0sqyi88RHtBkm3cdWfmnO2tHE3Qs5cDGvgSyIDXyh209dLhb60yeKeb+kefkhDvlYR
	 HVe1W2pVbiT7CAIRpljRIkG21YOq1TGlJ3ObLDO22ACz5XxAiuKG+t65REIRzit7r/
	 e1QQDtH8gfLvZwsXLbZmg9GZh0ojE05UZNaPYstj/bmazndwJ0yllZZRSqBH+Mwmg5
	 NRIgE4oOJS8SLtCoi891uVpndk3Spgonx8BogTkf4JZM0VoItXMnoXuyITB22tXLNW
	 0LY7srv+LFoIQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C65A17E137F;
	Tue, 22 Oct 2024 11:36:21 +0200 (CEST)
Message-ID: <78f4da13-cbff-415b-a8eb-ec16108b5c00@collabora.com>
Date: Tue, 22 Oct 2024 11:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: Add bindings for MT6735
 syscon clock and reset controllers
To: Conor Dooley <conor@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Daniel Golle <daniel@makrotopia.org>, Sam Shih <sam.shih@mediatek.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20241021121618.151079-1-y.oudjana@protonmail.com>
 <20241021121618.151079-2-y.oudjana@protonmail.com>
 <20241021-goatskin-wafer-7582dbcfe1d1@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241021-goatskin-wafer-7582dbcfe1d1@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/10/24 18:56, Conor Dooley ha scritto:
> On Mon, Oct 21, 2024 at 03:16:15PM +0300, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Add device tree bindings for syscon clock and reset controllers (IMGSYS,
>> MFGCFG, VDECSYS and VENCSYS).
>>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   .../bindings/clock/mediatek,syscon.yaml           |  4 ++++
>>   MAINTAINERS                                       |  6 ++++++
>>   .../dt-bindings/clock/mediatek,mt6735-imgsys.h    | 15 +++++++++++++++
>>   .../dt-bindings/clock/mediatek,mt6735-mfgcfg.h    |  8 ++++++++
>>   .../dt-bindings/clock/mediatek,mt6735-vdecsys.h   |  9 +++++++++
>>   .../dt-bindings/clock/mediatek,mt6735-vencsys.h   | 11 +++++++++++
>>   .../dt-bindings/reset/mediatek,mt6735-mfgcfg.h    |  9 +++++++++
>>   .../dt-bindings/reset/mediatek,mt6735-vdecsys.h   | 10 ++++++++++
> 
> Is it really necessary to have individual files foe each of these? Seems
> a bit extra, no?
> 

It's only good for including smaller headers in each driver (and/or DT, but
then the SoC DT will anyway include them all).

I'm fine with that, but I'm also fine with one header for clock and one for reset.

So.. Conor, it's however you prefer :-)

Cheers,
Angelo

> Cheers,
> Conor.
> 
>>   8 files changed, 72 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-imgsys.h
>>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
>>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
>>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vencsys.h
>>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
>>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
>> index 10483e26878fb..a86a64893c675 100644
>> --- a/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
>> +++ b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
>> @@ -28,6 +28,10 @@ properties:
>>                 - mediatek,mt2712-mfgcfg
>>                 - mediatek,mt2712-vdecsys
>>                 - mediatek,mt2712-vencsys
>> +              - mediatek,mt6735-imgsys
>> +              - mediatek,mt6735-mfgcfg
>> +              - mediatek,mt6735-vdecsys
>> +              - mediatek,mt6735-vencsys
>>                 - mediatek,mt6765-camsys
>>                 - mediatek,mt6765-imgsys
>>                 - mediatek,mt6765-mipi0a
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2ce38c6c0e6ff..25484783f6a0b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14537,11 +14537,17 @@ F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
>>   F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
>>   F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
>>   F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
>> +F:	include/dt-bindings/clock/mediatek,mt6735-imgsys.h
>>   F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
>> +F:	include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
>>   F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
>>   F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
>> +F:	include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
>> +F:	include/dt-bindings/clock/mediatek,mt6735-vencsys.h
>>   F:	include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>> +F:	include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
>>   F:	include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>> +F:	include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
>>   
>>   MEDIATEK MT76 WIRELESS LAN DRIVER
>>   M:	Felix Fietkau <nbd@nbd.name>
>> diff --git a/include/dt-bindings/clock/mediatek,mt6735-imgsys.h b/include/dt-bindings/clock/mediatek,mt6735-imgsys.h
>> new file mode 100644
>> index 0000000000000..f250c26c5eb4d
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/mediatek,mt6735-imgsys.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_CLK_MT6735_IMGSYS_H
>> +#define _DT_BINDINGS_CLK_MT6735_IMGSYS_H
>> +
>> +#define CLK_IMG_SMI_LARB2		0
>> +#define CLK_IMG_CAM_SMI			1
>> +#define CLK_IMG_CAM_CAM			2
>> +#define CLK_IMG_SEN_TG			3
>> +#define CLK_IMG_SEN_CAM			4
>> +#define CLK_IMG_CAM_SV			5
>> +#define CLK_IMG_SUFOD			6
>> +#define CLK_IMG_FD			7
>> +
>> +#endif /* _DT_BINDINGS_CLK_MT6735_IMGSYS_H */
>> diff --git a/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h b/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
>> new file mode 100644
>> index 0000000000000..d2d99a48348a0
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_CLK_MT6735_MFGCFG_H
>> +#define _DT_BINDINGS_CLK_MT6735_MFGCFG_H
>> +
>> +#define CLK_MFG_BG3D			0
>> +
>> +#endif /* _DT_BINDINGS_CLK_MT6735_MFGCFG_H */
>> diff --git a/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h b/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
>> new file mode 100644
>> index 0000000000000..f94cec10c89ff
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_CLK_MT6735_VDECSYS_H
>> +#define _DT_BINDINGS_CLK_MT6735_VDECSYS_H
>> +
>> +#define CLK_VDEC_VDEC			0
>> +#define CLK_VDEC_SMI_LARB1		1
>> +
>> +#endif /* _DT_BINDINGS_CLK_MT6735_VDECSYS_H */
>> diff --git a/include/dt-bindings/clock/mediatek,mt6735-vencsys.h b/include/dt-bindings/clock/mediatek,mt6735-vencsys.h
>> new file mode 100644
>> index 0000000000000..e5a9cb4f269ff
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/mediatek,mt6735-vencsys.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_CLK_MT6735_VENCSYS_H
>> +#define _DT_BINDINGS_CLK_MT6735_VENCSYS_H
>> +
>> +#define CLK_VENC_SMI_LARB3			0
>> +#define CLK_VENC_VENC			1
>> +#define CLK_VENC_JPGENC			2
>> +#define CLK_VENC_JPGDEC			3
>> +
>> +#endif /* _DT_BINDINGS_CLK_MT6735_VENCSYS_H */
>> diff --git a/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h b/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
>> new file mode 100644
>> index 0000000000000..c489242b226e2
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_RESET_MT6735_MFGCFG_H
>> +#define _DT_BINDINGS_RESET_MT6735_MFGCFG_H
>> +
>> +#define MT6735_MFG_RST0_AXI		0
>> +#define MT6735_MFG_RST0_G3D		1
>> +
>> +#endif /* _DT_BINDINGS_RESET_MT6735_MFGCFG_H */
>> diff --git a/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h b/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
>> new file mode 100644
>> index 0000000000000..90ad73af50a3f
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_RESET_MT6735_VDECSYS_H
>> +#define _DT_BINDINGS_RESET_MT6735_VDECSYS_H
>> +
>> +#define MT6735_VDEC_RST0_VDEC			0
>> +
>> +#define MT6735_VDEC_RST1_SMI_LARB1		1
>> +
>> +#endif /* _DT_BINDINGS_RESET_MT6735_VDECSYS_H */
>> -- 
>> 2.47.0
>>




