Return-Path: <linux-kernel+bounces-288988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E69540DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E04B24311
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED078C7A;
	Fri, 16 Aug 2024 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6SKsz6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29B10E4;
	Fri, 16 Aug 2024 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784894; cv=none; b=D4TVBxtFSvN4Z9gBWx7s46FUtxXasVvMcALJF5JTNvobMQo6H0KnHcC1irF351ekK9gIusHm0knj6HUds4Uc8g64+VBYroGVMDM44j8Cd4qVV48wwcuPvPHd/phN961NsawHdvyev/AFc2c8D8HceoLn4Jlx3JWLWh8wK3SsHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784894; c=relaxed/simple;
	bh=7kyktabdKuv9mFqwTvNJijCo/dbL3dM/DaUNyZmR8CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k5NM6MOYMpFR8VItvQVEdBqtRaUwQ1iVocz5cc5Yzr7sXMhdrsPdSoYhxcEAkjduhckBX6NDNzA26NKb6dJrp5k0uUDBdf9mWAea+9EPGV033kJ9NBBwkRj73jDv7Xw65Us9buWpwq9UZMCfh9+XY6IQge33yLSibdz60H3kl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6SKsz6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7348EC32782;
	Fri, 16 Aug 2024 05:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784893;
	bh=7kyktabdKuv9mFqwTvNJijCo/dbL3dM/DaUNyZmR8CA=;
	h=Date:Subject:List-Id:To:References:From:In-Reply-To:From;
	b=p6SKsz6MPsj/0eg2UHoM4j/PLZDDjUaKJ3w2YUUGOEY+rjMO1XeXbsGWhFEruoGSa
	 qR0883WuD+8T1HYGF7/6FsIbkA0Zr3a4XQ9xsNl44HiD3ePg9cBJFvwYAxOd80Nkv2
	 9uhqU+mTa6sMOMagS+j+bQC9mo9gK/wZHMxsgXuogyGTlvwgFqZOGoVc4MZZUjGke6
	 XquGZ9KMBfeA821X6cT+F4CoUSfRgfli+UMHpX1suMBCpeh9UeiZRO+8u/vwI6sZZ9
	 iP+nZvapGZhEEPcbnawSp6TfAYxlbGzxGZwwizx1Q6tSVmcotC/JDbjxcfrwqICgaD
	 UCV40RzaEscZw==
Message-ID: <aa3a1835-19e0-43a5-b6a4-4a7e531f3b2e@kernel.org>
Date: Fri, 16 Aug 2024 07:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW1BBVENIIHYxIDA4LzEwXSBhcm02NDogZHRzOiBh?=
 =?UTF-8?Q?speed=3A_Add_initial_AST27XX_device_tree?=
To: Kevin Chen <kevin_chen@aspeedtech.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "olof@lixom.net" <olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 BMC-SW <BMC-SW@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-9-kevin_chen@aspeedtech.com>
 <b6be1531-d8e2-44d1-a81a-6db8f9ae4ad4@kernel.org>
 <PSAPR06MB4949EC0D0E0DA16F50BBF40489802@PSAPR06MB4949.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PSAPR06MB4949EC0D0E0DA16F50BBF40489802@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/08/2024 07:50, Kevin Chen wrote:
>>> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/b=
oot/dts/aspeed/aspeed-g7.dtsi
>>> new file mode 100644
>>> index 000000000000..858ab95251e4
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>> @@ -0,0 +1,217 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +#include <dt-bindings/clock/aspeed,ast2700-clk.h>
>>> +#include <dt-bindings/reset/aspeed,ast2700-reset.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>>> +
>>> +/ {
>>> +     model =3D "Aspeed BMC";
>>
>> Model of what? No, drop.
> Can I change to "model =3D "AST2700 EVB""

Model of what? No, it does not make sense here.


=2E.


>>> +
>>> +             uart12: serial@14c33b00 {
>>> +                     compatible =3D "ns16550a";
>>> +                     reg =3D <0x0 0x14c33b00 0x0 0x100>;
>>> +                     reg-shift =3D <2>;
>>> +                     reg-io-width =3D <4>;
>>> +                     clocks =3D <&syscon1 SCU1_CLK_GATE_UART12CLK>;
>>> +                     no-loopback-test;
>>> +                     pinctrl-names =3D "default";
>>
>> What is this?
> BMC uart using in uart12 in soc1.

No, that line. pinctrl-names do not make sense here without values.

>=20
>>
>>> +             };
>>> +     };
>>> +};
>>> +
>=20
> --
> Best Regards,
> Kevin. Chen
> ________________________________
> =E5=AF=84=E4=BB=B6=E8=80=85: Krzysztof Kozlowski <krzk@kernel.org>
> =E5=AF=84=E4=BB=B6=E6=97=A5=E6=9C=9F: 2024=E5=B9=B47=E6=9C=8826=E6=97=A5=
 =E4=B8=8B=E5=8D=88 07:19
> =E6=94=B6=E4=BB=B6=E8=80=85: Kevin Chen <kevin_chen@aspeedtech.com>; ro=
bh@kernel.org <robh@kernel.org>; krzk+dt@kernel.org <krzk+dt@kernel.org>;=
 conor+dt@kernel.org <conor+dt@kernel.org>; joel@jms.id.au <joel@jms.id.a=
u>; andrew@codeconstruct.com.au <andrew@codeconstruct.com.au>; lee@kernel=
=2Eorg <lee@kernel.org>; catalin.marinas@arm.com <catalin.marinas@arm.com=
>; will@kernel.org <will@kernel.org>; arnd@arndb.de <arnd@arndb.de>; olof=
@lixom.net <olof@lixom.net>; soc@kernel.org <soc@kernel.org>; mturquette@=
baylibre.com <mturquette@baylibre.com>; sboyd@kernel.org <sboyd@kernel.or=
g>; p.zabel@pengutronix.de <p.zabel@pengutronix.de>; quic_bjorande@quicin=
c.com <quic_bjorande@quicinc.com>; geert+renesas@glider.be <geert+renesas=
@glider.be>; dmitry.baryshkov@linaro.org <dmitry.baryshkov@linaro.org>; s=
hawnguo@kernel.org <shawnguo@kernel.org>; neil.armstrong@linaro.org <neil=
=2Earmstrong@linaro.org>; m.szyprowski@samsung.com <m.szyprowski@samsung.=
com>; nfraprado@collabora.com <nfraprado@collabora.com>; u-kumar1@ti.com =
<u-kumar1@ti.com>; devicetree@vger.kernel.org <devicetree@vger.kernel.org=
>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead=
=2Eorg>; linux-aspeed@lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>; l=
inux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-clk@vge=
r.kernel.org <linux-clk@vger.kernel.org>
> =E4=B8=BB=E6=97=A8: Re: [PATCH v1 08/10] arm64: dts: aspeed: Add initia=
l AST27XX device tree
>=20

Why do you quote my email twice?


=2E..

>> +             uart12: serial@14c33b00 {
>> +                     compatible =3D "ns16550a";
>> +                     reg =3D <0x0 0x14c33b00 0x0 0x100>;
>> +                     reg-shift =3D <2>;
>> +                     reg-io-width =3D <4>;
>> +                     clocks =3D <&syscon1 SCU1_CLK_GATE_UART12CLK>;
>> +                     no-loopback-test;
>> +                     pinctrl-names =3D "default";
>=20
> What is this?
>=20
>> +             };
>> +     };
>> +};
>> +
>=20
> Best regards,
> Krzysztof
>=20
> ************* Email Confidentiality Notice ********************
> =E5=85=8D=E8=B2=AC=E8=81=B2=E6=98=8E:
> =E6=9C=AC=E4=BF=A1=E4=BB=B6(=E6=88=96=E5=85=B6=E9=99=84=E4=BB=B6)=E5=8F=
=AF=E8=83=BD=E5=8C=85=E5=90=AB=E6=A9=9F=E5=AF=86=E8=B3=87=E8=A8=8A=EF=BC=8C=
=E4=B8=A6=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E8=AD=B7=E3=80=82=E5=A6=82 =
=E5=8F=B0=E7=AB=AF=E9=9D=9E=E6=8C=87=E5=AE=9A=E4=B9=8B=E6=94=B6=E4=BB=B6=E8=
=80=85=EF=BC=8C=E8=AB=8B=E4=BB=A5=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E4=B9=8B=E7=99=BC=
=E9=80=81=E8=80=85, =E4=B8=A6=E8=AB=8B=E7=AB=8B=E5=8D=B3=E5=88=AA=E9=99=A4=
=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=92=8C=E9=8A=B7=E6=AF=80=E6=89=80=E6=9C=89=E8=A4=87=E5=8D=B0=E4=BB=
=B6=E3=80=82=E8=AC=9D=E8=AC=9D=E6=82=A8=E7=9A=84=E5=90=88=E4=BD=9C!
>=20
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/o=
r other confidential information. If you have received it in error, pleas=
e notify the sender by reply e-mail and immediately delete the e-mail and=
 any attachments without copying or disclosing the contents. Thank you.

Maybe I am the intended recipient of your message, maybe not. I don't
want to have any legal questions regarding upstream, public
collaboration, thus probably I should just remove your messages.

Please talk with your IT that such disclaimers in open-source are not
desired (and maybe even harmful).
If you do not understand why, please also see:
https://www.youtube.com/live/fMeH7wqOwXA?si=3DGY7igfbda6vnjXlJ&t=3D835

If you need to go around company SMTP server, then consider using b4
web-relay: https://b4.docs.kernel.org/en/latest/contributor/send.html

Please be informed that by responding to this email you agree that all
communications from you and/or your company is made public. In other
words, all messages originating from you and/or your company will be
made public.

Best regards,
Krzysztof


