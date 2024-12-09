Return-Path: <linux-kernel+bounces-437202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A39E9041
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27CE162B88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441521764F;
	Mon,  9 Dec 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rxCK8EHz"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D9216E17;
	Mon,  9 Dec 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740367; cv=none; b=OnWMnFzIF8GjbY4e/SargdVVpJZ0SAIJ9rOQ0T7LgOJzRTh7GDUlfLDWBEqZSsLaF6f1OZqq5ji3snGJ9+p8tYEGWem4L9wS6wmgiprrX02hYKgvUyKplBWnJqYzLXyg99stuwIZ0eLHn8a/cguC1SPcdDR0nAFf83ilmLBbTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740367; c=relaxed/simple;
	bh=IaZmXAaUI3FCLQAuB1Npp/LTLYPPybZ+aVugr6WcA+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQs9/q30qfsWlW/jEEwEVDpWvFzrpXwzBCCmBJy/26otHvCbtoQe0+hABX0hfUhzy9LNOh0PSCrpGPVkMVewK43u8/EFzJY/wSerQ1bZEn54wwSEuIZ6omCw+W2MyhomP36OrUUG85wgib0p3NdrskGS/+LlTdLkabAQOoH/FEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rxCK8EHz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733740350; x=1734345150; i=wahrenst@gmx.net;
	bh=IaZmXAaUI3FCLQAuB1Npp/LTLYPPybZ+aVugr6WcA+Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rxCK8EHzNTk1KR9+KaG2iNQX5+w3OZsr+HRhu+v07NTOmsbRZaufx2q+xrJb4Ete
	 Wtd9AHyncgqykzcc7yGID+nSS47mrD+0AL0b7+B9atWp7F17+jaa4vzONb+TwK7Ur
	 e6U40xbgXcS/tG/LwMyTP/w+g5eht45P08sv4t2r8bm+foCbhY6kMIy/LvhnuHVnr
	 CNKWODzi0+ZOeVqGPiI+TDowtuKNK/cATp8EOKXmYIqJA47ojIYqwBY5CcBb7TKkD
	 TsiBODkLcvkUJQUhWDczl7yFX5kZAGDAKGMQG8sx6U50B143t8p5QJoZSvg/XoEhC
	 1xkMsZnUGCMza2XI0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.106] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1tNwZF4AwW-001qoh; Mon, 09
 Dec 2024 11:32:30 +0100
Message-ID: <c8fd371f-fd36-48c4-ad49-1e8f8db01383@gmx.net>
Date: Mon, 9 Dec 2024 11:32:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241107085705.490940-1-lukma@denx.de>
 <20241107085705.490940-3-lukma@denx.de> <20241119165236.69438f75@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241119165236.69438f75@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WT35FUcxkk24pmHWc8SbN7TbdU9tsAN2+EJ+r1nufEZCyVU0DTD
 LpUn0KYHF8odE8iif7UZ3qkEsIVIWYREq/3CSbPxoRWpo9/4XFBIzmtA2hJsYnCl9ST8Xv+
 SsGJ5ho7Flmf4F1fdrAi4ZDUiSPZ09qZiEYM8FNGiQofxrmure0utbfJ7gMdSiJ4mXCuBh3
 xWFlidfqTUrLfwNrK8Bvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:87TXXS13MfA=;3QWf8OLTUwXBXpKsWpJm8JR9S7T
 Igl6SlHxcaPbGBuGg7n0haj237PaPA+qn97bMKkt4QahRyMcvSG8H2f67sm2IslbW4oW4yLaM
 qHTUBaSG1vuAGjkyYgt2GEaDM+NUsB8Y4OM/cKvYyINniEZEqjCg7h+2M87LYIrZry6VPsOb9
 lN1tdkmbkyVgVK71OEShOTwKlHchKRuXLE4g281fUXAfFKMPMK8Bkjl8MLZXrMagaJm1YUpSP
 gjKgmKGLOeDnpa0bUYQDshvNi+RH3gTPqJHqZbCctL8k3XXZnRlJMVfETnumbbG8TZJyOSsvM
 oHIlBbvFvM8etPp7o/BD8vaGmbU86PtxTVNOeblRYUiugZSUt4Kjh6uJm8gPI73nzYooW+ifK
 Mwrw+T63qWfrq50h6x/xv1FQpodgvjWbYWf8pcmGx3kI4H8FXOHNH+Ijakn2DHEbECgj1YQWp
 EBjF8tijx3Vom338awhnkLjYXihDM/4qn7/CoZS0epATHVLW9CnkHcaG89Pqu9oDXjjuhS9+l
 JYIlXT8xERpKbiExA1szYxts1HgEpV9u2nom+kVE43ZQEcoPWTMV4uko2No5vW6d9AJTu7LBD
 4v/SAYXSQrucJEc/jHC7NYLjjWyl/elbJkzo+2toK1Vf4i1WJZFApx5OI29HOKGtUoH99FXgd
 jZpar3SphehSPPJuuLV4K+pm8I+Tq6E3tyP0+BG2tglRGhNZ/UMChHSyp37c+eG5kXomC8mQt
 2q4znHrE6kqmctoMFDNZ/xdARwZSkljgoUoZ2VV5Taf/nnXSk+W5O7hPMYfXRRFQkTDl65y1g
 tF6DS6O/fscb1syiv/jjtIONU6b80XFn04ILFyrItirq/sht2j16P6g/wMoHDyufDYGQdmeK7
 1/vk0Yuov0docj3rtbD3E3qthFPEFq9uDWYTuu4DlCbvQADOnR7G8mgQiimjJyxsVggCSxilU
 704nfotP/NUB+kV5pbhLcMrkU4Lo3gN6stoZ2EHJ4bUEYn3NyQtgrpDxdnlsqZW/rC8rCaMVa
 HSPEzJ6t8mkwGZEc3JbUgLcJo8ZWQ4XFRaXegdfIdCKr/qeO5YVb80mNKoiaJ4RHHS41rG1l3
 8vd7m/mVzIQQeIkNeliYs1MWtsl0eu

Am 19.11.24 um 16:52 schrieb Lukasz Majewski:
> Dear Community,
>
>> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
>> some extend similar to already upstreamed XEA devices, hence are
>> using common imx28-lwe.dtsi file.
>>
>> New, imx28-btt3.dtsi has been added to embrace common DTS
>> properties for different HW revisions for this device.
>>
>> As a result - changes introduced in imx28-btt3-[012].dts are
>> minimal.
>>
> Are there any more comments / suggestions for this patch set?
I've send my RB for this patch on October 31th for V10, but it didn't
made it into V11.

