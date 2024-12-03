Return-Path: <linux-kernel+bounces-429296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A59E19EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4B0163B65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113B1E284A;
	Tue,  3 Dec 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="iOEWZZCi"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B811E2827;
	Tue,  3 Dec 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223132; cv=none; b=FZO2yC9R2Z/plb+r75Nlo3+kvxsFwsZO+L9k9aCEISWu9A/+jep2Llk7CUedDZHCg7oihLz+pzMDxzXho2PfAbowHgtuI0xRmc5ceni1kKdVvqguCjQSMTDIAA35JSnPRL4ZGR2loi7EVWMYg+FWsGx2a3P6gkDLU7mPl9mjA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223132; c=relaxed/simple;
	bh=m8brqZ10UQQmm+whVJTe6/HtSk5dVE/Yz0fbKSHvKwE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XiJ4DvNZ59QclGfKgI+E2GdzVn+TRs9JKSJ8BiPt2iFc4KqtkBmuvBqxqiPI2Q+gsm1TWn83IaxqHAsbFkZlx9qZiY0ig3x1r9kfupDanqbTDGbCqt/EET1LBEFYTjLIWDXhLoYy8L3Z14FEKq0WaLQg1hU0FmJtG+wm6iDqwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=iOEWZZCi; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1733223114; x=1733827914; i=frank-w@public-files.de;
	bh=jOrlgDBwSC9mM8oelPeMw0+wbuO3Fb+HA9uerFd0F1M=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iOEWZZCiy9t2Oxr7wLKHTBi/lyeg9Upo0+HyO79C5O6or06CDFFkIR2eAQIRq/L2
	 RZwV0HSt/CQ5uNQSYhJ0kffb0icLv516fhLiXh1m3qEvTTvKDnrL+amuMiD3UHJ6y
	 it7qgITWliH74N0fDCgeuNPJgJZ5llFux1LvDybqNmALvNllmW75wzZqaos7IcCdG
	 l+xdDQ+deqH+U0yRJgTYH3jJzq7a80iTsKgpaY1QkFqrSk7scvQE2P36oJiVzA8YO
	 QAoHmxbJT5tVmXZRMWSajVGTuIiopptqAyImjv/HJq8LWZdCHRkxebwfvQQ9RV6bu
	 Dxq6xw/G69Xjlyi9EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([157.180.225.184]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1tN7TU3eEb-00HJha; Tue, 03
 Dec 2024 11:51:53 +0100
Date: Tue, 03 Dec 2024 11:51:54 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_03/18=5D_arm64=3A_dts=3A_mediatek=3A_?=
 =?US-ASCII?Q?mt7988=3A_add_fixed_regulators_for_1v8_and_3v3?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <016b77dc-2d33-4639-b241-2574ad877971@collabora.com>
References: <20241202122602.30734-1-linux@fw-web.de> <20241202122602.30734-4-linux@fw-web.de> <016b77dc-2d33-4639-b241-2574ad877971@collabora.com>
Message-ID: <371B3F0C-D468-45C8-B1F6-F4619B7C72DD@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AVZ5ZUm8ptySUab2O2As99HWvCQXqqik2NguTeurSgHy51Tzxde
 vlfJK6+tcdhrqDgfilpQGR9fkBnPhhrXzeXLiGPAx5aglfRyqtjlD84KvLhHLWUerAye2e2
 UU+8GUTwnyt7Zb8cYf8TRmBO+KBD/JnT7ChJFYsBKoL1BIdscZYgxSAV7whKhigx1XML4MF
 0byLMKqzKMDn9Q1VO08ZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RWkNNlChsdE=;rocX9nU54qiIa+fq9H7GdY62buo
 nl7nEx7rz587xlZ9MxauS/Ih5pM8w36fKob9HPdpZu9wSPFzl5GSwPKhsIpEqHuwtNGV0hfU3
 tTIOlQFVlJ/0p3PurWja9HHIwjc+iGarGOVm91HIhUeWoZaMB1b9I1RydV2yWkDVEwCcRyUSG
 bWhmXScFez/uzpTqFIS07OjVyQSW5fr8YN43rBhmvzbHrthsdcFyZWo0R2q3KhGkvEJSYOnsX
 0FyvbZ8bLj76Ned3xb+cO0GojM9IujJbcqKtSOU0OZbcRIDL+bmt0mIgd02H0Dda51VmGhH9c
 07c6M/4ujoK6q07GD+d7esyGW1ao88QD95zFrKqBgTmXnOBEQECdMQTVciTcJAIR44uYxI28B
 WtQ+GDNPeSwpcj3BfnuqND9e8ibXYOxUkrkh3OLijGFXJbHUcfHcXwUFdPpY3zSV+HkpjxS3S
 M28pSZ++f9JfzM/IYd0YqS/YrN62NusypkYaXcBumMjZct9siYFGJhgN84WNxOWPjKJ9BAqNH
 VaEgElqmWDBBD9VisFFNtcULy8zfSbAE/2bal6hIpCZ4G2yLTPUpLDd9/oajF6StU6A0L6HJz
 /vPWlRdm97yXSw5nhnd47W2atuqxEI+9Us6d2vt5gyrJ8+sJc+NuI/j51FWAPYZrQsdojMElN
 eel3hxXJsMLvyl33kLngwikF+i2Jybca4WlYIy7+TFx9eWg5G4po9Y4t0eUCPelagumoF3bg3
 E9ulxye8Wo0IG2PwNamtZ87VqlTth7BSZI82eGCdlYUFYNfThUEQdTGuLomZlOTpDfKIhByZd
 AscxHRMU0nEUcu2fex0jjBjg6bXHOpEGqB8o7o62tqQIQrCath4gXSl1fbeDq03NiggCGteuP
 YWxK6VJ0eOC843vp6HPWmdyqWGUdADbOY4EUcSKA1iTqzmH44WOkrIhwqsMROS2Kp5+oK+6jH
 3J+fCVLfnvUkvm+51W6LPaGzCvJVMqsPv/Y9XOzttBm9iqXyIGCe3MBu47nzQ66qUMbRQQTO4
 yFq3dYZC9eP7P9xnuTDjH1qxYHqv9uLBHU5WYeli0QIXZufE3NiqRwIN8XWy0RjByHAP5oFvS
 HhZLXRpPx9RJbtAGTI6CKo04czMaPn

Am 3=2E Dezember 2024 10:40:54 MEZ schrieb AngeloGioacchino Del Regno <ange=
logioacchino=2Edelregno@collabora=2Ecom>:
>Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add regulator nodes used for mmc to Bananapi R4 board=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>
>If you're adding the eMMC regulators, I assume that there's an eMMC, or t=
hat even
>if there's no device in some version of the board, these two regulators a=
re always
>assigned to the eMMC device - right?

Like BPi-R3 there is one mmc controller mapped to either sd or emmc=2E I c=
an move the regulators to the dtbo,but then they are defined twice (at leas=
t 3v3)=2E

>You should, at this point, do exactly that: you can leave the mmc0 disabl=
ed and
>only enable it in a DTBO=2E

I enable it only in dtbo=2E=2E=2E

>&mmc0 {
>	/* eMMC gets enabled by DTBO if present */
>	vmmc-supply =3D <&reg_3p3v>;
>	vqmmc-supply =3D <&reg_1p8v>;
>};

Problem is here that sdcard uses only the 3v3 twice

https://github=2Ecom/frank-w/BPI-Router-Linux/blob/6=2E12-main/arch/arm64/=
boot/dts/mediatek/mt7988a-bananapi-bpi-r4-sd=2Edtso

And emmc needs both

https://github=2Ecom/frank-w/BPI-Router-Linux/blob/6=2E12-main/arch/arm64/=
boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc=2Edtso

Only defining the vmmc-supply in dts and set only the other in dtso is pos=
sible but but imho not nice=2E

>Cheers,
>Angelo
>
>> ---
>> v2:
>> - move mmc regulators to board dts of bpi-r4
>> ---
>>   =2E=2E=2E/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts   | 18 +++++++++=
+++++++++
>>   1 file changed, 18 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts=
 b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> index d914eae2b524=2E=2Edf53512c6890 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> @@ -8,6 +8,24 @@ / {
>>   	compatible =3D "bananapi,bpi-r4", "mediatek,mt7988a";
>>   	model =3D "Banana Pi BPI-R4";
>>   	chassis-type =3D "embedded";
>> +
>> +	reg_1p8v: regulator-1p8v {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "fixed-1=2E8V";
>> +		regulator-min-microvolt =3D <1800000>;
>> +		regulator-max-microvolt =3D <1800000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_3p3v: regulator-3p3v {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "fixed-3=2E3V";
>> +		regulator-min-microvolt =3D <3300000>;
>> +		regulator-max-microvolt =3D <3300000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>>   };
>>     &pio {
>
>


regards Frank

