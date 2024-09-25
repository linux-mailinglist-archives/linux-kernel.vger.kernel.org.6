Return-Path: <linux-kernel+bounces-339428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5129864F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD879289B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B5487B0;
	Wed, 25 Sep 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Y5roqoIg"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB8DDC5;
	Wed, 25 Sep 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282374; cv=none; b=jIIglG4yDBKMgkDUM5VDAZRw7pmse+YqveEt6daf+mJD5jzlfGZP9Dl5j1BM66IOJ/TIGqgZXv6fd7NWvXxHsTO7nafjHqEKYnZLQJVGOwYh0lWLWF8gJO+1r+rMhb0McJ363kBplqcx+7grj6y0CUJPLwYE0HcosklSYDTN43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282374; c=relaxed/simple;
	bh=mmEKsumJaV/C4mSg39qdgs9ioH/P7I2y3Olde/K4Vfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUCM/K+dRMiphITSsS6TtVVj+xbtTZh61Jxatkvv38kAVghzfhoe3+PESMZZWbFSmEVJrBfWf3u75raiXFC1okFWjgOlIbCKdzQaZRteOFBkbxd1RbCABIp2um0sJywjcOimH6HoAqncnnZJvnmJS/klinfgI1F8EtZC2ubsB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Y5roqoIg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727282355; x=1727887155; i=wahrenst@gmx.net;
	bh=/+s/MJvLvSedW4ZMyn8J2kl/4UKa33y7jLnA8XfsWps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y5roqoIgXsQFzQuf/ACzNU4pahTsn9E57oTVocdGLQ24QlpnJMBVL06Z0mFotrk9
	 j72gUC6XQfH2qCVdBekN5hDzBrTZ/qDDf0JsU9Djf/aqrLTMvMBIw2ule72QfPihr
	 zgh23brPmWEbDXSkC5JcwERdfu9nHw41MOYsqJH2hvF5NJCTHdFOOqdUgT+DAI2dk
	 KwrnDaW1fHDqRdLVnorvh4xfMTjhv7G7pPTnVLo3PpzYg1QB+kHwR4UEp/8LIKMZA
	 m2EsSOHqKSFs3Pr+7dwk27QEhqBYXHqFDRe2u96KF1MvujZ8scayxHFIGcpYMBBV+
	 O21bMYAsw/DoaJbCqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1s254w0ZDJ-00xFsX; Wed, 25
 Sep 2024 18:39:15 +0200
Message-ID: <3e296eed-5dbc-4098-ac3c-3c3125a352d8@gmx.net>
Date: Wed, 25 Sep 2024 18:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: broadcom: Add missing required fields
To: Karan Sanghavi <karansanghvi98@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Anup <anupnewsmail@gmail.com>
References: <ZvQ27pvrnEYA8BB9@Emma>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZvQ27pvrnEYA8BB9@Emma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qHjJIXyZ0wH1uw0c/zb0EA2UhlAwq+UYG8OwhqNPpMCx7zLR0KI
 QSVFslHzzwQclHWDfpLt5yaArQiWPGXLffTP8OQGQ4fWdpjZIWs13bg8vC+D+03sTl3rLJw
 0nHvdSsU4NpqJYppZPoYtS86b1YFsMc/l62E9M0+ZMMa1/hoBZrxLzRKhZCFkR9nAHjZCHw
 lnGdVoltok0RduGz5Epww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jrc/8pPEFX8=;XJ22mE5GQkmuQyl8bX4pI2ki9Tx
 IAJ/pssT9vasKnGmfcWw4KDVDY/KfVaF56CH2CYpOnUvCj3VpWwYuGolBdEhL+PNA/93uxXwb
 l5M05FnILJUv/2kG6o+IA6IvPtAMpreBqGDXBmGwkT9xD1SMejj9Xak+Fb2lOqlVsepmZM//9
 n6Oe9Q7+UtkTn6mBouIJBLKWH6XW4zMGdjjww+YFAglsXz6pygsggMwW9VEvhKaSrgO9p+GWW
 BHFDbK62GpCfhXbN6bG7xyuRfcTDdSOZHI0l2PuJPfv4UuNBhdj2ZeXlhMSjVD1X9S9XMrW9n
 dmauFsDY5VqdiS0ymdAwfOW9T5BBMbilVx2gMpoUiPns7B7y/XoS2YtI/II95K4Ybaj/vcEfr
 KcJIFeb2Jp66Pt/al6MheUqGZ2w8xXgYjhHMMtujKlCKOTS13ZGa66/Srw2+SK6TLkfXSzfzH
 5XQ43+hUJglKRyMGFnlT4hCYZVC7zOqg0XifgCzyp1xyFxnR+Nf8J72CxK1gHR7uE7OD0YJZd
 Vdue5lJr+I63HFoFVkoInGa5KNnFXm0/9BVLbTrrNhFfGM2c1sLSICkC2e3Nd6iAA1RBHOfei
 CSFf1odCdV0kq7PraAwPpgHQzurULHcwjx/Id5s3f+1WG8I6Q0BW9hzTS7z2h0a4Nf+3ef/UK
 degKYK1YzJ3TEb9o9xyQgXJaoR5c2p0VJaPEbrsojw+81FgbfLdWO99e75DoxArkLsJ3+/xVW
 BMombBeo331bO+OKZSmbn0uK3INPDyvVa7SsSp0NoMMXG0OAxF26XDkJyEvaFQjTSL1qnqiny
 Aa5/pjSfzJQfhGMfT/PDyeXg==

Hi Karan,

Am 25.09.24 um 18:14 schrieb Karan Sanghavi:
> Added below mentioned required fields
>    1. interrupt-controller
>    2. #interrupt-cells
> in the bcm2711.dtsi file for the
> interrupt-controller@40000000 block as defined in the
> bindings/interrupt-controller/brcm,bcm2836-l1-intc.yaml.
> This issue was noticed while compiling the dtb file
> for broadcom/bcm2711-rpi-4-b.dts file.
> After including the above fields in the dtsi file
> interrupt-conntroller error was resolved.
looks like you made the same mistake like me [1]. This change breaks
boot of Raspberry Pi 4 [2].

There are a lot of DT schema warnings to fix, but this doesn't belong to
the trivial ones.

[1] -
https://lore.kernel.org/linux-arm-kernel/20240812200358.4061-5-wahrenst@gm=
x.net/
[2] -
https://lore.kernel.org/linux-arm-kernel/CA+G9fYuncv0fuBSC0A1z1G_UOv_XuMQz=
=3DDsrLZDK-Wc=3D10ghag@mail.gmail.com/
>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>   arch/arm/boot/dts/broadcom/bcm2711.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts=
/broadcom/bcm2711.dtsi
> index e4e42af21ef3..313b1046d74f 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
> @@ -51,6 +51,8 @@ soc {
>   		local_intc: interrupt-controller@40000000 {
>   			compatible =3D "brcm,bcm2836-l1-intc";
>   			reg =3D <0x40000000 0x100>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
>   		};
>
>   		gicv2: interrupt-controller@40041000 {


