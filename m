Return-Path: <linux-kernel+bounces-308857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73CF9662C9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123501C238A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469371ACDE2;
	Fri, 30 Aug 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tbonnefille.fr header.i=@tbonnefille.fr header.b="K5c+keZu"
Received: from 9.mo563.mail-out.ovh.net (9.mo563.mail-out.ovh.net [46.105.73.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5911A7AC6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.73.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023864; cv=none; b=g67snVe4A84nK0J9Quti8vMhtUPw7L0p6icflBI7eFEmAfjGon3NXZQS7X0/buSgGRTKapwszMfi92rhQpGmEBNHhJkZvugRLF6Lc6IQLwEubq1QdIIuexaoR/zZoQqm4sbZ/3SdzmAmU1spe4mx/h83/8zVBFkgTvTshILT16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023864; c=relaxed/simple;
	bh=eKGTQ3Zw5H4pG3i21MZO96JUQWkAB7zpE+9rjberyv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eyl8QRxSNfi0JJBhnvPV0lwonmkODTu+bahISj5SBPdpJhGtmOnZCtfgRErs+jvNxxR2cyO0i0eJyVE1ca1oPSj9QAZUuAqIiordANKkNRV/sVXS6RdjRXVf/HoAW8lXQyzdfmBn2+kPCL91aSwa9beDZ0vygFLI2ShqaPzBmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tbonnefille.fr; spf=pass smtp.mailfrom=tbonnefille.fr; dkim=pass (2048-bit key) header.d=tbonnefille.fr header.i=@tbonnefille.fr header.b=K5c+keZu; arc=none smtp.client-ip=46.105.73.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tbonnefille.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tbonnefille.fr
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo563.mail-out.ovh.net (Postfix) with ESMTPS id 4WwJCW1MQcz1VMq;
	Fri, 30 Aug 2024 13:00:07 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <dfustini@baylibre.com>; Fri, 30 Aug 2024 13:00:06 +0000 (UTC)
Received: from DAG3EX1.emp3.local (unknown [10.108.42.252])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4WwJCV12JBz86Jy;
	Fri, 30 Aug 2024 13:00:06 +0000 (UTC)
Received: from [192.168.0.75] (90.89.163.127) by DAG3EX1.emp3.local
 (172.16.2.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 15:00:04 +0200
Message-ID: <5a463f00-a03d-4cf3-be3c-970ca5611486@tbonnefille.fr>
Date: Fri, 30 Aug 2024 15:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] riscv: dts: sophgo: cv1812h: add pinctrl support
To: Inochi Amaoto <inochiama@outlook.com>, Chen Wang
	<unicorn_wang@outlook.com>
CC: Drew Fustini <dfustini@baylibre.com>, Haylen Chu <heylenay@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Albert Ou
	<aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Conor
 Dooley <conor+dt@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Yixun Lan
	<dlan@gentoo.org>, <linux-gpio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <IA1PR20MB4953DC78BB0FE0C57EA94F91BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495348B5FFE61FF1D76ECC4DBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Thomas Bonnefille <thomas@tbonnefille.fr>
In-Reply-To: <IA1PR20MB495348B5FFE61FF1D76ECC4DBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS9.emp3.local (172.16.1.9) To DAG3EX1.emp3.local
 (172.16.2.31)
DKIM-Signature: v=1; a=rsa-sha256; d=tbonnefille.fr;
 s=ovhemp1147286-selector1; c=relaxed/relaxed; t=1725022805;
 h=from:to:subject:date; bh=3xzeZZed1caYdsVmSD9tMT8ztI6dOeLf77ko1WrVFl8=;
 b=K5c+keZu33DnBUPwc7skyaLF+NxHPTt9Cw0S98sXFVVW+SXVc5i0krrWTS/RoStbq6XJ6YfAhp7SBXylKTKY4r8KYFDxWMUiMChLJNb3jrOCqvpfKu8lj3Dnc57hzxZyNA2YQs+jTvx4U1muFytVNfLfJUlyr4eo2K7VoZQbPdqpPi29wk4SdWfeqLjxK77ffU6zepkcGXZeA9BYqezfVhhXcYydFI0i87T/Ra/EwCUZ+S2hrY7Jz71ita5msia3YHXVrtVnJI9TLAU89JINqsWU++in2i6QoOvp4Ph27zQX9cN9+4WolDbtIcbg7bdirjp7Ts/52etGiI9PAFLHbw==
X-Ovh-Tracer-Id: 14003380092947865892
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttddvjeenucfhrhhomhepvfhhohhmrghsuceuohhnnhgvfhhilhhlvgcuoehthhhomhgrshesthgsohhnnhgvfhhilhhlvgdrfhhrqeenucggtffrrghtthgvrhhnpeevvedtledtheeggfffudfggffhteeftdeitddttdejleegjeduieeugeehvdefffenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepuddvjedrtddrtddruddpledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepthhhohhmrghssehtsghonhhnvghfihhllhgvrdhfrhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepughfuhhsthhinhhisegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhi
 drvgguuhdprhgtphhtthhopegulhgrnhesghgvnhhtohhordhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhsiihhrghngheskhgvrhhnvghlrdhorhhg

On 8/2/24 2:35 AM, Inochi Amaoto wrote:
> Add pinctrl node for CV1812H SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> index 8fcb400574ed..2dfa450f0d26 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> @@ -4,6 +4,7 @@
>    */
>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/pinctrl-cv1812h.h>
>   #include "cv18xx.dtsi"
>   #include "cv181x.dtsi"

Hello Inochi,
I'm trying to apply your patch to the LicheeRV Nano series but I can't 
find the file "cv181x.dtsi", neither in the upstream v6.11-rc5 nor in 
the additional required patch.
It was first mentioned in the v3 of your patch series.
Was it supposed to appear here ?

If so, can you help me figure out where to find it?

Regards,
Thomas

> @@ -14,6 +15,15 @@ memory@80000000 {
>   		device_type = "memory";
>   		reg = <0x80000000 0x10000000>;
>   	};
> +
> +	soc {
> +		pinctrl: pinctrl@3008000 {
> +			compatible = "sophgo,cv1812h-pinctrl";
> +			reg = <0x03001000 0x1000>,
> +			      <0x05027000 0x1000>;
> +			reg-names = "sys", "rtc";
> +		};
> +	};
>   };
>
>   &plic {
> --
> 2.46.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

