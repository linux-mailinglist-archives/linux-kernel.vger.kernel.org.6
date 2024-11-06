Return-Path: <linux-kernel+bounces-398818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAFA9BF66D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6601C22617
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7D0209692;
	Wed,  6 Nov 2024 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="nVzSq430"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D820101F;
	Wed,  6 Nov 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921195; cv=none; b=qhm79niIWMqBUedt5fseDw3CrW64/RdO+qZbnRh8LOWcgERA9hTmuGeET09cBinsZo4dmjqQFUVlN/tKmiRJpuoTzgv52Ubrp1zUwOI9oNP3ojQ/B3wxJP7W7lVEXGjMGYjgHFIVdqll/KyzfIMgvhEATbubldvJd2OAV+415x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921195; c=relaxed/simple;
	bh=EFosc+cw1JPqHKsMcuTlSvGAgqaFhSr0nt/t0Ffi6wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMMTFuYuGr+quWlp+OmTWloIUDRAY8OvwA6D9ta6jUNQG0d++9YNXGySr6dwr+BO3L78KpCP+HZ0DYZ89SW/O83T9jPBgPlqjPrI2eGuMs0JCwK4fTHoSCO/fXNCXvmayNmCCmP9W3+0FgM6qRSelHDZroJm4+in+pnzS5BgKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=nVzSq430; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730921179; x=1731525979; i=wahrenst@gmx.net;
	bh=EFosc+cw1JPqHKsMcuTlSvGAgqaFhSr0nt/t0Ffi6wQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nVzSq430rcPCnysBaAqrTy/xvqNCSs/N4flSm8wUYcItD+eQ7oqZovrGjw+sjQ3a
	 roUnmcg8/y6RNQWhFbRbDli99w+J/pLZXCNOADUJcLbNeXvUIP8WruyG9j5PV/095
	 HBjaCaokX7vVf4Hr2D3IC+w6FOOsx0zK3QLWnqJUlQJ7b8i4Lamcvll9vsIAe6+mh
	 CdFQfvjnlCfyIQABFnMkICFzQmB/qRJvZZkPY1vMcZat9T/kQNlO3rOluWAWSaIE5
	 yRwxnDH+5d98Yg9nP5S9lA1hznYKao10IIjPR8dkcYArRak5EYdHRfMpLpa/YCfsg
	 IOiyGX/62D8YHfJzfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1tgSzX41dt-00nOU2; Wed, 06
 Nov 2024 20:26:19 +0100
Message-ID: <335a558f-f537-4a8e-86dc-9f76324eb206@gmx.net>
Date: Wed, 6 Nov 2024 20:26:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/4] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241022133040.686562-1-lukma@denx.de>
 <20241022133040.686562-4-lukma@denx.de> <20241031094236.17ed927d@wsk>
 <20241106115752.30397dbf@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241106115752.30397dbf@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aNTWWsgjPtdtKsN51CZVNMv+vVvk1wlQaApmIrbXGFGv8TpJGgp
 DRI/I20NxQawmmy8S0zekV9MweAUkhzQghbsJUk1ZEiu1+E2yDTzyr13IukcGXQBlVlIUHt
 p6EWMv0ZkHPkcs5mK1xczxzWHxsi7bPLzcKOblRQY9EF4YJQNHxqRRdl79ccFEtZCF53GNz
 WvGCz/aXVzpL3VKJXxF8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Yt3NNZzIq4=;3yV956ASsWUbSuhsEta/eezA++q
 t2LLBPbYFnBlYoHDTzv4QqQJgtpN5AqqGnZzcrnpcl8uzGqL7b2mUl2sFV0MGGdD1H0zQguhA
 SkQiZAfPDf2ArV6y+J8ajzEdubxb5s8AlcI7CkL+PDQBLLs3bja9JdDckfI7Y0MAncY71kGhX
 eudwb1r8y2l2/4zotx1FKAeC5c9QN4w5jVl08bDgc1wbihyM+zaZVebpDOcGXX+tE989MOYZP
 LMT/Rx7+mO1uU8QM59ouy3lkIqbd/1j9pT6ihnnMjDwYXhJNdqmUVkc6NmL5roXKZKfYmxAoM
 9FxrAkkPD0e2Ymb0UGHFTqak9wJ64qIG/6e/XEm511VQ34m/E5CoQKULNBC504Tby5ezW+aA/
 aadQS+UNXXFVk6SwOSA6IsAHHb2Y+48one+aq8EtpOEzY2oJzY1Xqt9NwZqgLXHJCsgWXLCxJ
 r33RYA72OCfSxf918TYGWg38G+SBR7rtIqyDKZY/AQL/q/P01BX964WD/1+LzRVK14aHLuoQV
 6Y43issqWvkjSqig8ZEPPjjOwc2THR519BJGHZrJkUNJRGgpwmgkN6Y7byKbVWy4EOuFJ8sfN
 AhAUXRwSB089hY2i844i6UIMs2E6sEG3vG0Bn9tJx9/Bf+NVoIIQ5QgsD6rJBcZ6TPu3lzIqT
 Y6iQptnfepKup8M5whJyA0b17BGjFJwekInZR/IQ94IP0iPHd2lDboiA4wom73LdtaPWarM9c
 rhvnY/4VDlSEiFNCLvjKtG143Stm3Mjilr8sr9X3I5hhZB4Es0Y4jiAO4hxtXAHYMqxYOMUIt
 /se+GwDYEOLF+ifr2cZaV4fMJMXUjmUkPcZAlQgHCJMCKneVKde3V/dSOWZ9o2KlfkWPfF1IB
 iwWNz8ZAQDsIP5Y6g7weTouBu3uRojnmp/zQdLrprzX8+2OFhctYtbacJ

Hi Lukasz,

Am 06.11.24 um 11:57 schrieb Lukasz Majewski:
> On Thu, 31 Oct 2024 09:42:36 +0100
> Lukasz Majewski <lukma@denx.de> wrote:
>
>> Dear Community,
>>
>>> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
>>> some extend similar to already upstreamed XEA devices, hence are
>>> using common imx28-lwe.dtsi file.
>>>
>>> New, imx28-btt3.dtsi has been added to embrace common DTS
>>> properties for different HW revisions for this device.
>>>
>>> As a result - changes introduced in imx28-btt3-[012].dts are
>>> minimal.
>>>
>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>>
>>> ---
>>> Changes for v2:
>>> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match
>>> current linux kernel naming convention
>>> - Remove 'wlf,wm8974' from compatible for codec@1a
>>>
>>> Changes for v3:
>>> - Keep alphabethical order for Makefile entries
>>>
>>> Changes for v4:
>>> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
>>>
>>> Changes for v5:
>>> - Combine patch, which adds btt3-[012] with one adding board entry
>>> to fsl.yaml
>>>
>>> Changes for v6:
>>> - Make the patch series for adding entry in fsl.yaml and btt3
>>>
>>> Changes for v7:
>>> - Use "panel" property as suggested by the community
>>> - Use panel-timing to specify the display parameters
>>> - Update subject line with correct tags
>>>
>>> Changes for v8:
>>> - Use GPIO_ACTIVE_HIGH instead of '0'
>>> - Add the comment regarding mac address specification
>>> - Remove superfluous comment
>>> - Change wifi-en-pin node name
>>>
>>> Changes for v9:
>>> - Remove not used 'pm-ignore-notify'
>>> - Add display names for 'panel-dpi' compatible to avoid Schema
>>> warnings
>>>
>>> Changes for v10:
>>> - Drop new line with panel-timing definitions
>>> - Add new lines with 'sound' node
>>> - Change 'codec' to 'audio-codec'
>>> - Change order of properties for saif1 node
>> Are there any more comments regarding this patch?
> Gentle ping on this patch set.
I do not see a reason to ping on this series as long Rob's comment from
Oct 22th is not addressed.

Please reply to him if something is not clear.

Best regards

