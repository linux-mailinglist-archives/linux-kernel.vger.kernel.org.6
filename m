Return-Path: <linux-kernel+bounces-543644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071CFA4D7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814B03A3F79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB41FBC86;
	Tue,  4 Mar 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="AR4OKWdv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D63A8C1;
	Tue,  4 Mar 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080244; cv=none; b=lG/Hi28Wx9q5cnGWpGxNfM4ZNLWT/pL04dNYkVoD7GtEoWoC7vCU6fWOCsc89TxZUSElzuMwFeiOyZyeC3tNCtNJ1onB/BDcU8iy4CxPjcLJSf6tTr72bIdCCqOxcrGaSOKS/fHCXVOWHVHd1cFSSAISGX1MTAVXFl5AXpt5/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080244; c=relaxed/simple;
	bh=qAOUbI/BEbZDvaPix7eWz3Zl3lsDI9E9B/i/XFncmrE=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=RY6zgQqe+ckkmrlkTPrUP13sat1f0Diax9DQS4oK1S5jOtKfj0zodV+dEcjrngZbw6Fu24jJQ7lG++uBX4IBbptwP4bekzi1SklEv/E7fzmUCAXUd6I3YFJaAe9p2vqU6a5ZfChC2RTdFYubLl5G+Ynexf62NhmJ222Tpr48wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=AR4OKWdv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1741080239; x=1741685039; i=frank-w@public-files.de;
	bh=qAOUbI/BEbZDvaPix7eWz3Zl3lsDI9E9B/i/XFncmrE=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AR4OKWdvdxDkf5DnYJm79Y0Sc4ijHsQWiPWZt9Jxh7CXEcy3rWXJVsRT3FEsY5V1
	 arkL5I0mVS06IXKJzsJ6EL5n7OKgaBfXEQm07zyx8teMKZPBkyv58BVwCX77qkXCQ
	 NDyyNdNY/TzgHHzji5S/hJZJy4mqeoR2iv215vEIaPL1z0imelNWTr4s3+YySLAKZ
	 kMuP8puk2OI5D8aFIvk0WW7eZ7SGGJyQBSygnqxp4jm38b1dnVeejUK4uk2AcXg5v
	 cteS8a02dNP5iJ5E2PNoKFJmYCsDacJJrVdAHcjiOica9LInOsX2vgvIdAP0tAdkb
	 nnngzLRRmEEKWDArhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.15.84.185] ([194.15.84.185]) by
 trinity-msg-rest-gmx-gmx-live-5779db864f-7hl68 (via HTTP); Tue, 4 Mar 2025
 09:23:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-a81b2adf-df25-4888-9490-cc33257061b2-1741080239272@trinity-msg-rest-gmx-gmx-live-5779db864f-7hl68>
From: Frank Wunderlich <frank-w@public-files.de>
To: angelogioacchino.delregno@collabora.com, mikhail.kshevetskiy@iopsys.eu,
 matthias.bgg@gmail.com, daniel@makrotopia.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Aw: Re: [RESEND][PATCH] arm64: dts: mediatek: mt7986: fix pwn fan
 settings for sinovoip bpi-r3 board
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <618b3cdb-0fef-4194-aeb0-4111c011904d@collabora.com>
Importance: normal
References: <20250226050132.547353-1-mikhail.kshevetskiy@iopsys.eu>
 <618b3cdb-0fef-4194-aeb0-4111c011904d@collabora.com>
Date: Tue, 4 Mar 2025 09:23:59 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:KFILJolE/lIPpZ7AIJtQRhRvi++wI/bcQ2lgkUKddOMA3Q7Xb/PEi20XCxNzINqPUzkHm
 r7bRg3aTVEVsMlCFezAHQpCfZIo0rmfInJ2+KshK3/HnsDZVQyToDOfIq7Yg8TUITj56FlSD79uJ
 au2duhPJe/A8BywlmkG/zages3nOVMXUZpRudMTyhvgo9ASG9EMq7pUL7v5YnA7dBXvdqCXeAygt
 hZbvoECRr1DoZaOcqaJQxu8MG07dfNHknBdI7vF/3G+J8lWUMPq46r5DYZ+ogOorGIrIxlfNjHDD
 NE2eaCL+j9qRs6ulzEcIxr0a1XQpGMGixNQ8jBP66Lvlx+cYXMiL3KDNoM8gKzEbI0=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AxtGf+C3hYI=;FsXk14KBPKOyZP9J+CXltFfvtq2
 dkwYcHX+hPt9iTQqnJndWDKtrP2/oQun9cOggieklZuBgtwYaKW49tHL+CuHemzdlUDGJVpDu
 vwbfyYwXvWuk653PnMYvro0nqq4iuyzAJrauVKriQoApj6IJzvfEYSe7rJn20docf0vk6vRSa
 Ox6uLXiFB6rd4dW0u32lqFrnSJZMSxrU3a2pZQKniOBP23BhtFUBzHi1+Lx067uHyDSlD1ZsI
 xIJHauw41xHXmRE6e6xJ6Ddowzdm12er5T4+wx45slQjZPXBYwChWpOqwtC9wZSLa/Xj/q03a
 3Ttf8GMDTWZBOz0GIZPMhBhm/yTooJJBnyo/R7DXoj1Gxf0waCuQU6gp8/28gmEanPQl5EkwR
 wGtUPwl2fkJ+Hkr6QewmizRuh7ssrIEfGRZHcFxRYJVPLYzwyK6HwTiW6yaJPyj9vm2544pFv
 zyxbFRqMnW0lj8SjmtOqhyZinC5HQnnrTUcLs8S/piCBg9FyxSVNQwbto+Adg03sQM+5mjf3r
 zKMU2Yi5JdFdH9M+L6JJptDGHZz26P+7Wh5ckfF+EQZ23bfBFtlEqGlDZf73dA5IYSQfhk+Gw
 F0xKm2lMp9U9u2oc5hwtiIeMtbVX2FKM0UbaW87jreVzAljQlCNFCRHJpwNn8c8O+jdkgvp5v
 N80nE+vcDiIMwkXew8goRl999b0yfe3HCy4qZvpG3unhfkINIAv9+X1x6LAn9BgQghSEdbe5P
 EqKVsc35uCYrI/ksr6s1LXj/aTJk8ndZe1g2m78eTc/5k7ORl+SoavD3IWn3GGi984p78vxNT
 +yLpCYBNeab8R+jelpy4Ptnq0iW/v6WptYRSfilS+ucN6+6I+adWjtuE8K/MLt/wH1iG3c9Jo
 T6sIfnmXl4JkTa2kF8ZNVufhUMY1phc2syJBy7xbjvEaslVIPc8HV31jr7M1P/J+27Xh/FDce
 y/6pn/wrrPSdqmputgAQzGAoBajxhAhVW2pjWobo/6jVhRz/ui/3Po6fHi2lTYex3DTq7T9p4
 Y4QW2jnluSWJEJ3pJgjwNGSBn0znCFLWkO3vXtM+ti38NhYuDf5apyjM1d1GtbnVwLUIe8fe3
 x/HoX9uQtV9Yho7DH9h+InsuuEoS8z6SlOAZ5k7q7C8lIiYJXYTIao25kc16kCneD4FLqeGS8
 u16NW7a097nFzsjtWWs8Pyh4XdB+H7iLafDpXOUCimWo213NtkMTsKvl3FRVPVDkLWV9oXfaA
 vdfFMJv3KA12sFRTPLWFeRSD1uElb0l7Bj1wv+kf9f6hnGFBMauN8gk=
Content-Transfer-Encoding: quoted-printable

> Gesendet: Mittwoch, 26. Februar 2025 um 10:46
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> Betreff: Re: [RESEND][PATCH] arm64: dts: mediatek: mt7986: fix pwn fan s=
ettings for sinovoip bpi-r3 board

> I get that the cheapest fans you can get are not working correctly with =
the current
> mid pwm setting, but you can't break things.
>
> This devicetree should, at this point, hold default values that would ge=
nerally
> make the vast majority of fans to actually spin, because it's impossible=
 to have
> something perfectly (or vaguely, sometimes) optimized for each fan on th=
e market.
>
> Of course this means that you need to properly configure your fans in us=
erspace
> if you want to reach the sweet spot.
>
> I added Frank and Daniel to this thread, as they are the ones who origin=
ally did
> upstream this device.
>
> Frank, Daniel, any suggestion regarding the PWM values here?

Hi,

sorry for delay

i have the fan from sinovoip and that was working for me, but if your fan =
only works with new values, i have no point against this change.

btw. angelo, how is state for my r4-dtsi change?

regards Frank

