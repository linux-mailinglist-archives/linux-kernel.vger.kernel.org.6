Return-Path: <linux-kernel+bounces-305359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856A962D78
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA241F267A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF091A3BAF;
	Wed, 28 Aug 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pfT29mLg"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4B189BAA;
	Wed, 28 Aug 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861737; cv=none; b=RN8urGk+OBbRD39Wul1Q8bopk38NQ58qDmjNIO89bJkRThXc4JEjM97DHlRB519uQdlCfNBpCd+xNe15TA9vr8jz7fppqko31mF3bp4q/F58RMMEntU0TKSZjMElpJ9Y58JdLCu7CAjPIjNvilUk7fuUU1QM8PO+DicQ33ANfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861737; c=relaxed/simple;
	bh=LzrJBLUUzTBNBVpZCHtV3gHE+eUDErEkmHx8rmE8QjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNI4HsrU4YKs2bdYGJmyE5Sn6vQIoAa/nC0EIBzG3YiHz5ofwyrNHRVOmQOCUEObh/xMvXBdRqik3VQrnRgi1a+O7GkkYoqZ6yQGfhBsLh511DED4pvBQWWgoAlDOCBzdLOuCYVXun4zR86ivrcdbu+fnNP7/qfWwQa+FHcQo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=pfT29mLg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724861718; x=1725466518; i=wahrenst@gmx.net;
	bh=LzrJBLUUzTBNBVpZCHtV3gHE+eUDErEkmHx8rmE8QjI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pfT29mLgxw8xgPiRRRrU7is3xEfs6SizIrDzdICv7MFEMp7z9ayce00Sx3+tY8MY
	 YPRW4qzN1wtKfet64nQucfWNu6EYeqNjfxi2v0eCmJ48RM23zKXWA5adJlpi646kM
	 9B4MJbWQLoufJd197yaoucjqAzYI6xy8w3fbf/OWLznQKZ7IqqVHQOgvCD5eAvo7X
	 wJwao6J03rNXcPEkUI2cT/ppHT/XitLgRXDpstal9jlG1tl5MEXCr3TeAeaPm1xsw
	 p7JcY84p6U4lgcHvS+aeGbe/11Ek/F+MH3kHp2Jod2TbTKAbgyZgKbXBvlLLEG8QG
	 rRhjgYYnoKwtVr/bHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1svlnK3wQN-00FnQi; Wed, 28
 Aug 2024 18:15:18 +0200
Message-ID: <db357e68-ddae-40be-8945-15734d3ec832@gmx.net>
Date: Wed, 28 Aug 2024 18:15:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: mxs: Remove not used "fsl,imx2[38]-icoll'
 compatibles
To: Lukasz Majewski <lukma@denx.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240828093518.2628817-1-lukma@denx.de>
 <f4b7e56f-50d1-486b-9866-ee1f82262b53@kernel.org>
 <20240828173334.21dcdeb2@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240828173334.21dcdeb2@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2w+TjR4P91/lQ2e+lRY5nxJl6S/iUgwk+Cx6KmW/yHOSWfZhy2O
 D10QuLjotSbW4WIkh2p6hpF5HWcBqCbS09ioIdWClLAm7Vsqn9ugEMkln+sZU2gKJ9mjeED
 aUcropP+B0nOUkhHQKz9smB7IiBtD6u4D4l0wnZahupgwX7+UXknfYK9359emjRcjmmA+id
 q2dr/gqi0uu8kOj2S456A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h1THvmECcQs=;c6idsHm4HAT/RIJfPx4FiiJ+7Qt
 7h0BYDcYpr4smBo9rZ95G2RTWjtQE21vOIJ7PJlT8UC78urh/krmw64AhBV2K0wKjhfuC2QHc
 W0iixfmSJ+9s4NI7sTCh27ijkGYGPuplowgCYvvEk69hChjGFhj6E9mT1PQMRVxr7FdMpC0IQ
 7qVN+g7W26s+a98FapxNNFzGgDieV0xdTPnkKEa1fxrXBZ+j1fU+Sf9DNFoQ/rMkAPME34jez
 dtZmObrY5NZ5xnr4IcIUPok4fggx/O3itgjew/tg3utOr8EP/0tSDc1bLBiqJNJJ/FLFWhWc/
 58SSuq7Qk6Y9MldxzGFuGIcG1tOeyzIhDYeN8ouoqZJUdzMDW2o4A02y+ZXTX3qu7uR1YBG7i
 zLe11w8ZAnqgnllWO3OpYGi6L9MJsOUNoRj89cRc+FyIbK7N/b2rm3/x3GLBPkiIb8GN5AxDt
 yILMrxK3TdDjp2GXSYN1Wi+4MBXKkg8N/y8L7WmKx6wlvR3Cz73FSB3W853mLhZ4at2eDL8Af
 FAQ2CVTnmy8vTo+TfS2FDFsYO7rzfMzJZL4OnAwFrKiEa64kspZioVv3uf6l8y2iVSTzw8j3e
 8gaV/EBsuDGpahiTLaWpZU4DJYAAMOI7dBujsI7u5HU+BXvQlxKwmGflV3jIiQ11d4ofxvhz9
 WxxyNTvl8OvIdJWLvCs2BMAGDG0D4ksxb/wrKrYJw1gdv/rWJ07wxIuryHWuLjJi5q1L13WyI
 A10LLIrxTWXPlagdjSezePBAt1ngPntjVu53OENfqP+mYeJi45Cpy9o3Ov7H7yuG+khFl2+MR
 PR4sNIf/grJCaJ62wc8XSy+g==

Hi Lukasz,

thanks for taking care of MXS DT issues.

Am 28.08.24 um 17:33 schrieb Lukasz Majewski:
> Hi Krzysztof,
>
>> On 28/08/2024 11:35, Lukasz Majewski wrote:
>>> The 'fsl,imx23-icoll' and 'fsl,imx28-icoll' are not used at any
>>> place in the Linux kernel - instead for imx2[38] the 'fsl,icoll' is
>>> used.
>>>
>>> Hence, it is possible to remove them.
>> Preference is to have SoC-specific compatibles in the front, so
>> instead of dropping it, these should be documented as bindings.
+1

We cannot conclude that nobody is using these compatibles.
>>
>> imx23 and imx28 are quite old platforms, so I think no one really
>> cared about dtbs_check and their bindings. If the platform is being
>> actively used (as judging by your contributions) then some bigger
>> cleanup could be useful. Also, drop your email somewhere in the files
>> or maintainer entry, so we will know whom to ping when asking for
>> platform removal.\
>> But if there is no product on imx23/28, then I am afraid it might be
>> wasted effort - isn't it planned for deprecation/removal by Arnd?
>>
> I cannot say about imx23, but for sure imx287 will stay with us for
> many, many years.
>
> imx287 (arm9) is still in active production, for extended life time
> devices...
>
> It is just pervasive in the industry.
I can confirm this.

Best regards

