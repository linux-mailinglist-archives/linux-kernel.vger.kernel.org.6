Return-Path: <linux-kernel+bounces-393490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A79BA141
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C33282364
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB91A0BE0;
	Sat,  2 Nov 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="C9sNYvq2"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC69433B9;
	Sat,  2 Nov 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561757; cv=none; b=GQQ1RpGsMvri/VNi1VY16iIm52+FRTo+ZLvOeelok9J1gQY0d5pfoQXzY3y9RmjSrTMhg0D0rX4RVEml+3gV5gYlrOpuduIISrJBoOOwDV5fT7TX/KA1WITdMqGltVrrkNyl9cOippfeDQBzwdww2FHWJ6lumzvgDdeOO6yvWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561757; c=relaxed/simple;
	bh=cYaEKL8jFowwNf+MqbW6XeaifeX92oLshQIv7CaBRbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpDIdj56LinHVHN0g9Q7SrKlZXFT2jFL29HGqbCPDK7NFcBnBq33aIlmpCYIAfbz3IdoQA2HXLdwW7DElefojWlbeOm/CeHvxv8gpoSpBAvb4oAJYafqDQGADmQv3q7pRslDBit7Cw/d8fZ6PXm9iqyZiUdv01wGHRyE0IbQmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=C9sNYvq2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730561723; x=1731166523; i=wahrenst@gmx.net;
	bh=RusafcclKl2RfSXhQjv0aPX9JFTNQs1CwGZazPC8Lz4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C9sNYvq2xrGUC1XlLvQGMAcPyvEEUzBCByIebj0ukDQP2J2weoKYfCvrwSzNcN0D
	 FJCvjVH53dIIc7N/99mn8ztCfLWi60LdB/xdx86WA8HzNuqhtWiRgPjvozAlTzQc3
	 e0rDNliJV7mHGYg5qgOrl2KH3JwiE4Q039QYREaYe/WUVAOU6ccq72Jv7PuhUdQ00
	 GuJkNszVLxhlw7DkkMX3lp8O5YSM7+7Mmkz79ZP/nMOWYBut1ARt/vOonkNM9RrSo
	 +aQcuK72QI0ViU8Io8tt7jM40zlLxU8N5F9qpEwKarkr7nhNCxpW3nFozWwns6m8H
	 EdHwesLv24E1t9DSew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1ta2OB2djs-00gJvn; Sat, 02
 Nov 2024 16:35:23 +0100
Message-ID: <065268d6-84eb-4247-b834-40a9ff32c1f4@gmx.net>
Date: Sat, 2 Nov 2024 16:35:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
To: Stefan Eichenberger <eichest@gmail.com>, Shawn Guo <shawnguo2@yeah.net>
Cc: linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com,
 elinor.montmasson@savoirfairelinux.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20241030122128.115000-1-eichest@gmail.com>
 <ZyXTFhEm9UCBii2c@dragon> <ZyY41nJY9ghwe-Y4@eichest-laptop>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZyY41nJY9ghwe-Y4@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Qb1kpG3hdxqRE5loRuAnM11ljAjYHICynec0g85WT++0Up49vf
 Sm++8OAke6qdyByODguM4Uj/mNR1qv/FlO9C/rwLM4ZkH5EJpefK+oDQwkQDEDwRz9feXUi
 uMlSPswKmvXPU6SjMbLZURoSW1u3v7zZnCCdgBsWEGYX0oIsvKbHz74hJ7Ybjz/XJzmrU8I
 R3K9TbgTxI4vOWg/D8iiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y/8Yk56S+Ro=;Lw3WHEGlPnaA5VXhUppkFZIUAeT
 M6Y8O48Wk8KftJnOWjKuOtnZWUH/3v3+W9NH4bRlEpZnfFwX+LbbrHfVuKjLK/xp8M3aeN1hx
 grtnYC3BOaphN6FRLDkKGgkuywaKMXJEOmZrfld+XnmnA17BGqDlHZcggxV1DDW2SS9lA/OPh
 QSDP5AxAvkMjl6PtBefW8+KJrfAlDuHtE22yaOE3Q5EIRZhAJKIzEZmimhi/UxtUVftcw6hxo
 svTAN90/miodusPK98g13FX91OFJLVUqM+8v1/rlW18OKqEb5sRPBSXipnjdtPtBu1yRR7FeZ
 PFk+l8RVpCsgXwBkXgGN+JGq2GehlnM5WgYxLDz1QsPLtLXHUgwCu+mB2E1Ot9/7PqXuYGGQ1
 8G4a1KWFSehEUto9xafil78hJo/WKur6f60XsYm+2L/0WLi7p/zSeLIKm+QHoRBbRw00RKxpO
 TgeV7Ulx6b3VC72Nh0z7Xrmsa3bzVU89LhFQKIxA/XIG/rM0aGq0ih8OrCxjpQVb+RORs0Nrp
 hcURzc1JfMQ5+0VXjBbFWvgnCeiRmwYVH8Ae/LbexQ/dALlLaIAU4+f5EHu8ELIid+2ZPsFuO
 5Z8CNtXXF2B8OekVgqsxWEXcOrpPmZjLYxcdXSpqXgA+sL+96M67rXqhc4FdrthxeZ6v8My8c
 SU2X9BiY8ysNXa+KoHMwccqnaQROqgCzu2hNZ9PMoWnBD8S6qriSrwjAUITpnvtRPCuriVkoX
 pJbFm6m/92q5qDzJ3mA9W5CqT/beB0h9ycwXp30IjRTVCllJkSzP0LwWvxh7pJdm/PH6+k33K
 jEuFTK+amGVlHTWjKQXz7nXQ==

Hi Stefan,

Am 02.11.24 um 15:36 schrieb Stefan Eichenberger:
> Hi Shawn,
>
> On Sat, Nov 02, 2024 at 03:21:58PM +0800, Shawn Guo wrote:
>> On Wed, Oct 30, 2024 at 01:21:12PM +0100, Stefan Eichenberger wrote:
>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>
>>> Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. Th=
is
>>> change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif sou=
nd
>>> card node properties") which moves away from the old "spdif-controller=
"
>>> property to the new "audio-codec" property.
>>>
>>> Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node pro=
perties")
>> It doesn't look a fix to me.
> I agree somehow, it was just that before the referenced commit our test
> succeeds with the imx_v6_v7_defconfig and after that we get the
> following error:
> [   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-ca=
rd: snd_soc_register_card failed
this error should have been in the commit message including the
information which platform/board is affected.

> So maybe it is not a fix in the sense of a bug, but it fixes the error
> message. However, I'm also fine with removing the Fixes tag.
But this patch doesn't look like the real approach.

Could you please clarify the impact of the regression?

Is it just this error message and audio works fine or is audio also broken=
?

Regards
>
> Regards,
> Stefan
>
>
>


