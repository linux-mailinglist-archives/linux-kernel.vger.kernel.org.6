Return-Path: <linux-kernel+bounces-369732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE99A21E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EF61C20F52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A81DD0EA;
	Thu, 17 Oct 2024 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rnKlCPku"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D51D517D;
	Thu, 17 Oct 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167075; cv=none; b=t+4eNdVCK9+sonu2VpsH6tLDJmMb3npOigCzAixcAEsmKENkI8ohF68i1C18S7QjVU5rberEtU5Ew5pOISpBKUZ8H1j7HLTr6c+OleWUtyrhGvvJweCFM4pVo2Q2w9HHm/Pyk6QNBa4gTgUIUw/zLIcRWG4h+h085eVELkLZYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167075; c=relaxed/simple;
	bh=umiIc90rdlGa+qSu7VpHqWG7qgxrnUgzBz1afaP27n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4p+UCJXjCTjYWtLeYG6Qk+9NVbIXjoetcGZDUSrtmprzqX8KTkgi7MjY5zr1q7i9B7SQD7BtUYDRart0mR4xjvjz60KX293EYfYLyRpIwJIDowMt+vsxPwuK/nez1329jLToDyLg1HYpY5j/P7m4VS2eUUkgXspLuuWqQKR8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rnKlCPku; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729167041; x=1729771841; i=wahrenst@gmx.net;
	bh=tGM77oWO99ehp8oxalUiBrAfzs6GPmlEtUm5Eeqlmcc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rnKlCPkuTyz8LWLMSgiJBmGaZZz+1vdCkmwnzetYTMwNgjtKv4a7K8zzTYfXRuPa
	 /Ht+i1AWcy8zJKbjqcOqcsCgDKmzd6vaEmNCryjfCfwZZTnTEft6vWY2C00Es81Dl
	 UzYd6dDieX+GF5OOyeeayM84Qy2/Q3T4DjwM7thgtC3+Xgm+uUvIHFGD0AVXDsi8H
	 OshqRNSq89gZKNKUC/uMCoOYSYsD0tf6mIy8+XezUzpujLJj0fydsami8ZhZZpmWX
	 1f7TUUUO+V0Y+kfwxjaMph553zfiYydQKD5WLB/nn9ROgms4p/MRhNtnKk2hF/9Fd
	 OIKA/1TC+0QMkUOaXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1tvHgL2wWq-00zBKv; Thu, 17
 Oct 2024 14:10:41 +0200
Message-ID: <37c2d19b-b2b2-4f60-b057-90953c5f9958@gmx.net>
Date: Thu, 17 Oct 2024 14:10:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241010081719.2993296-1-lukma@denx.de>
 <20241010081719.2993296-2-lukma@denx.de> <20241017103534.259584f6@wsk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241017103534.259584f6@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sdXtrEaUz9LR383/6xDzsWZhw8c49oAmETMHmmRIE+LIqTd7nkF
 otu8UznnGmZrJdEPKL4A4S+jaYQsaTWMJm4Bn12jmJBjqV0m8eZKszqFgUdfSoHQyIMk0mX
 aBpw9/qZ7ch/KsbhusrUWbPtgmIyhPqtZIG+2KTW1/0DlCrwvQPIu3sxD0ytif3AfWfd+ju
 vH+KoNyQr95bsp0aBCdWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O8Fzvmg/ZOk=;w5+HCHEi5qtLmrcoSnPhhni49l5
 G6Unn1mn0lHpvkVAmntp4wOSHhR07uROu2G2EhVuWEhSDK8mTuRVQOjxDZZ/UYLYzdigbH07i
 79IENlpni3tZ+n6Zbd8G9hsceV2W3soj7y6OvjRxNOzXejqEO8rOXMoJ8EFvBOLqeFhHPmXn5
 2kLl1VYDHKwAum5WHE1ONKjnBpi9IjSEFR5ol6x95D3JwxEM7GJBTap5a4LpiJ1Jo3/0uydfU
 BTslP29UKFYE2Lz7eznBcrT1b2b7PVzfkCPOKwZGCkbc50FF3p7Dvd/+6O5xsPdZheuMG35b6
 FzdKwRhXh/7V9k9YJivyhYVTMdrt1SSFrucN2yb0ZyKaEPrU8SDavN7xW34/qB7DYJ9scNGzw
 k2XSP8g0gC7ZYbzX6k7AJE4/5a7ZwcsVcInXd9+5tOIfEl4uwHxEn2ApaGs2UtCoCPawJC6fp
 PMTEuoqAX5WikFmypTjybOgBd2iGsItj8/K0iWMly0SLiBPxiiIm4JtKko668X7HqeNQGNqko
 Yrq8pYB1Y4z76SR9z6uh/0Qn4x5H6gbCNkEuV0UDFdBk2+9gvoRgyKPRK/nv5MOPieJheBTVm
 w0hpixxIO/DdfRzIxm0QtHmrQd9amSiPUhNLU/uGmyhkO0RnpAT/ypg+fumylCxKkrpimEs1R
 3kN66tBXd9/V9jxSrRTXhAZZ68ZNKILzJ/IHedEwQrZzkG0aTLcAiDG6Mj4cnpWC8wVFEdv1J
 5HIjqJUFmbVL7GHXfXWe1aw407gBlA5c2GiPrjjA1NzWkf9bBfdRsnXIDtKMzXklsejyUrjbd
 2d9lR6B3Qblrg0QOusN+Wy7w==

Hi Lukasz,

Am 17.10.24 um 10:35 schrieb Lukasz Majewski:
> Hi Stefan,
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
> Stefan, do you have comments for this version?
>
>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>
>> ---
>> Changes for v2:
>> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match current
>>    linux kernel naming convention
>> - Remove 'wlf,wm8974' from compatible for codec@1a
>>
>> Changes for v3:
>> - Keep alphabethical order for Makefile entries
>>
>> Changes for v4:
>> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
>>
>> Changes for v5:
>> - Combine patch, which adds btt3-[012] with one adding board entry to
>>    fsl.yaml
>>
>> Changes for v6:
>> - Make the patch series for adding entry in fsl.yaml and btt3
>>
>> Changes for v7:
>> - Use "panel" property as suggested by the community
>> - Use panel-timing to specify the display parameters
>> - Update subject line with correct tags
>>
>> Changes for v8:
>> - Use GPIO_ACTIVE_HIGH instead of '0'
>> - Add the comment regarding mac address specification
>> - Remove superfluous comment
>> - Change wifi-en-pin node name
>> ---
>>   arch/arm/boot/dts/nxp/mxs/Makefile         |   3 +
>>   arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts |  12 +
>>   arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts |   8 +
>>   arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts |  40 +++
>>   arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi  | 313
>> +++++++++++++++++++++ 5 files changed, 376 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
>>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
>>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
>>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
>>
...
>> +
>> +&ssp1 {
>> +	compatible = "fsl,imx28-mmc";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&ssp1_sdio_pins_a>;
>> +	bus-width = <4>;
>> +	no-1-8-v;       /* force 3.3V VIO */
>> +	pm-ignore-notify;
I think this slipped through?

Regards

