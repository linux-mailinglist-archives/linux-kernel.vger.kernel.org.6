Return-Path: <linux-kernel+bounces-344634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2FB98AC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979EA284BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A9198E96;
	Mon, 30 Sep 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hzj4srso"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030E43AD2;
	Mon, 30 Sep 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721264; cv=none; b=eRXnoDkikcbWjAfPb7JqiLenXkCp3DcucCUFYjpUejHBICbIQJji/MIYdb0Y3tdtFtZmaV/og7j0GMXCVcEg7vocOSgKN7mcyn0N4CDl8fsBPtSU918nu3nusT9Mr/HOKFt9EsZJj9/ovyV4lCI3mDS9AVeRzT0gb5UEllR885w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721264; c=relaxed/simple;
	bh=DKsTlu8wW/M9F55tjFU0JXFSEqFN4I8eOkv5bl8qe3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZwgPgquRBMP+taiOTOB66p8UZAHBX/7yeieV5lPBqPeNgsx5BxvOSBTahYafqwvykVn0skIPOtMwk7si1GoWQ7Bp5oD8E475izHe64ElPAfXJTict9N4pEsZ1QDyRXMYRdkBKtS20iqNTXSyMbIQ8OrjNIDx8ZRdQlwYjyBt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=hzj4srso; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727721247; x=1728326047; i=wahrenst@gmx.net;
	bh=DKsTlu8wW/M9F55tjFU0JXFSEqFN4I8eOkv5bl8qe3E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hzj4srso5jH8STcJYzgjVbEZclC9BfFrF/3Tbw14LeqHZquU2RRmqQ7fhrlWyY7L
	 b8wppjaQK17+4WS+RUMQUjEz5ZWh+8SkuALVavea4ZT+1FLXOgOtar4HHCMUcC0uO
	 mz5sHRtRBkhBvcx/nMmhkPKA9pBmxNap1aY2LyWhwP/nRFYSP+R6P7k37Ke+OWtsq
	 K01rh4aJ0owUVIxmwfG9pTP2FMIm1LccAJw2xch5N9eyrb201I2ssKYIjpvPniWhJ
	 oUWXfsZb0FRkSfEWivoSZfLQ9y7gQJ6nal/YwwZ0waQzIIhtRk99jJLg8chMI33r0
	 eEkFnkCG0iCjZC70mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1sC3md2fTI-00pf4S; Mon, 30
 Sep 2024 20:34:07 +0200
Message-ID: <916d584f-6a9d-4eec-b6c4-319cfb298675@gmx.net>
Date: Mon, 30 Sep 2024 20:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: broadcom: Add missing required fields
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Karan Sanghavi <karansanghvi98@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-list@raspberrypi.com
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Anup <anupnewsmail@gmail.com>
References: <ZvQ27pvrnEYA8BB9@Emma>
 <3e296eed-5dbc-4098-ac3c-3c3125a352d8@gmx.net>
 <6723d91c-ac15-436e-878c-2d6fc1aac5e2@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <6723d91c-ac15-436e-878c-2d6fc1aac5e2@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oAXDcj/lVWQpMkkcSOhxmYT9B0o/dTtMDwVUMzWA1cWYIoZx7hG
 TaAvoPvrAhBHuTI+bI89gMw1cM9gPp/Co8mdxtPTXZ/r+0oqc+IjyqpTa8RZFngPZW/6412
 1ob55Ist23cWSeTXj9mL1MeKpXU2Y/0vSguz3dvZXP/kLZxXsIlVi4N7k4RQW6DjNB9MwDM
 uWuMmDCch2IJu5abeut1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wjxs5VoYkX0=;C6vrBoX9zTva/5XVl4gTQF4sqTe
 WMrPEN0OMn3jRI9zUdpA5VjykYecSknVwQ6oSXLkATd7YGjr9W+O+BjQoFCVbGl3aziUyQX0p
 ZUYYuTTcHU23h7dLPxrodl3It45U4ntGr7yyThc9j84venE9umahvWf6aWwDTsjJS/2B8rHEN
 1tRfVllfuLTfE+9V6WFwlZgJBm+bzeB7LpVNUnPTojwCVoFrg2Ahmq+zvzz0lr4ZeJWUx1cSX
 qER8CB5Z5Nhxn4rvoxuJmu17qsKLszahl2qVtnCuCNUbjaLWbY1fTo0HLo3AmhTp6LIBTCYiD
 LnCvPrJRjhNGbx2VXZkMEeAYML+pu9cnrVaG8SMLmDc8+pE9bC4VjTu0nFgSn2AuOx193GD56
 1EbpxXU3i7yOITa4t/dTnc7OxSWKXxj15ARV4xwH+8Vnsikih6saJJfr7amSHQ6VVo+v1bZKn
 /6TEo8e9kcI3e/YJ4iiSUI+XCCoTYq2TmsH4Mjgw70VQJzDFs+hF7m04gBwhYaDL1sn3dgXHp
 sWAinciqQlqub8cg/EkAd6XPanZfVJbJSDv6MzO2Ytkvsv6A3b02nVYXQS3Vd0cN4KJoj3pPA
 RQLw/JZIqGQkD3k5Mtwglmk5jmRxamqrLF7HMLUbEEholySIwP3YbeEInGBx9wed2F/9MXEn0
 d0YDbg0Dvshu9kEkKJjpvVjLEWvfuPQkaUyPl9AVDJv7z7Jj3Jf9dh+rzB7DLhQHhlP9ESOLL
 sT1CAul5Hu5RUufmL4qt4EqA3MK/KHATXaHJ3md/BqpFHK/E+iaFrJ4r5NbrsLYeBLixzsvk8
 HtjCtD75KfinXiK0eBw2CHtQ==

Hi Florian,

Am 25.09.24 um 22:38 schrieb Florian Fainelli:
> On 9/25/24 09:39, Stefan Wahren wrote:
>> Hi Karan,
>>
>> Am 25.09.24 um 18:14 schrieb Karan Sanghavi:
>>> Added below mentioned required fields
>>> =C2=A0=C2=A0 1. interrupt-controller
>>> =C2=A0=C2=A0 2. #interrupt-cells
>>> in the bcm2711.dtsi file for the
>>> interrupt-controller@40000000 block as defined in the
>>> bindings/interrupt-controller/brcm,bcm2836-l1-intc.yaml.
>>> This issue was noticed while compiling the dtb file
>>> for broadcom/bcm2711-rpi-4-b.dts file.
>>> After including the above fields in the dtsi file
>>> interrupt-conntroller error was resolved.
>> looks like you made the same mistake like me [1]. This change breaks
>> boot of Raspberry Pi 4 [2].
>>
>> There are a lot of DT schema warnings to fix, but this doesn't belong t=
o
>> the trivial ones.
>
> Including the #interrupt-cells would not have a functional impact
> however, and we ought to be able to do that.
>
> The 'interrupt-controller' property presence means that the controller
> will be picked up by of_irq_init() and that is was causes problems for
> people testing this. Stefan, do you know if the VPU firmware
> removes/inserts that property to tell Linux which interrupt controller
> (bcm2836-l1-intc or ARM GIC) to use or does it make use of the
> "status" property which would be the canonical way about doing that?
There is a config.txt parameter for this, which is called "enable_gic".
But if i use this i couldn't see any difference to /proc/device-tree.
Also i couldn't see any modifications by the firmware to the node in
general:

interrupt-controller@40000000 {
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "brcm,bcm2836-l1-int=
c";
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x40000000 0x100>;
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 phandle =3D <0x8e>;
};

Except of this i don't have any clue about the VPU firmware.

Regards
>
> Thanks!


