Return-Path: <linux-kernel+bounces-550697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E81DA56310
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECDA1892B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742E1E1DED;
	Fri,  7 Mar 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8DCTYdo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E5D1A5B9E;
	Fri,  7 Mar 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337825; cv=none; b=VS6NvzvCcoa25nSXDW0Wy2c4sdUYnQMj+sBPeBDcBYqwtf/VSXeff+MamTg/fmpf44rF6Kfn4j0Ypq3/wQ3PesyiJ/pQmwcq6DBa15l3Mk+NxbPmxOr/yyb5kbjV+Kls7l1vG8L5LUo+qGbaPFVa6yuAdCFnE9qVjUKHniZqgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337825; c=relaxed/simple;
	bh=GdvVVcDXx825xwHiDeenmFGVQv+cy7j7wXByGy3GLRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCQgEej2VXPxHahIobkHnRm7833yR5ssKKaGMtx4BmIcxnURCEgKD7uUvrQVWZuTNkso+ZGcGm3G7oNOrFjFlPyntXwDmlHHHpV5do7P53P5RZ1CVSJP9AuUm+2O6HXPZlqLgqynNMCtcbdkyMrD5PlZGDP5EwBCa9L6LV6G8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8DCTYdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B75C4CED1;
	Fri,  7 Mar 2025 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337824;
	bh=GdvVVcDXx825xwHiDeenmFGVQv+cy7j7wXByGy3GLRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8DCTYdo+Xi9+P2rH/JhJ2Z8naxSK1QwDzwMWmhO2epqAOBNa+SZOA8OsM+jdzVgt
	 8rQx8cHWBr6hpVTUDYj5u+99BIQ2ga6pSgyon6ACNHyFBy6fD/JaUCkDG6XkSI/cDi
	 5Zb0gOt/oVIPUj0LozoFvBhCTR5v83aNNmV5q06Ppl2QaAZpuAVrP9z+n7q2LbQAEu
	 veaTzYie9lg55aNKqGSkqLWajDVlwhoIcOrMCSFsnrKZkT8RmXkIQUHmQAyW2NkPSn
	 FRIu0yStlp8hO9dXQIydoMGnGrfkK7trduXY7lv4nHs13LZpGsJLSNAp+6eqGor7rE
	 UqaiDwUlLqt8g==
Message-ID: <f8e2091b-52dc-4b7a-b781-84588dd6b1ba@kernel.org>
Date: Fri, 7 Mar 2025 09:56:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K reset controller
To: Wilson Ding <dingwei@marvell.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Sanghoon Lee <salee@marvell.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 Geethasowjanya Akula <gakula@marvell.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,
 "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-2-dingwei@marvell.com>
 <174068786548.161165.4348563654300627455.robh@kernel.org>
 <BY3PR18MB467346EB1FA7CEF0A3300350A7CD2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <d2929546-27de-4893-a611-dd4a3bca1a64@kernel.org>
 <BY3PR18MB46734A2425361D8BE83E4282A7D52@BY3PR18MB4673.namprd18.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <BY3PR18MB46734A2425361D8BE83E4282A7D52@BY3PR18MB4673.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2025 01:03, Wilson Ding wrote:
>> reset.example.dts
>>>   DTC [C]
>>> Documentation/devicetree/bindings/reset/marvell,armada8k-reset.example
>>> .dtb
>>>
>>
>> That's a bit odd but anyway warning is correct: you cannot have such
>> compatibles alone.
> 
> I understand I need to add one compatible here to resolve the
> warning. However, as we agreed, we keep the sud-nodes while
> there will be no new compatibles in parent node. So how shall
> I avoid this warning?
> 
> If we do want to add a compatible in parent node, what should
> be used for the compatible name? I think the most suitable name
> would be something like "marvell,cp110-system-controller0".

I don't know. I don't work in Marvell, I know nothing about Marvell
Armada and I was not involved in any Armada SoCs.

Read your datasheet and come up with some reasonable name based on
datasheet. Why do you ask people who do not have datasheet?

> However, it was already taken for in Armada clock controller to
> be compatible for legacy dt.
> 
> https://lore.kernel.org/all/bb21ee9acc55efac884450ff710049b99b27f8bf.1496328934.git-series.gregory.clement@free-electrons.com/

I don't understand what it means.

> 
> This is something about 8 years ago. I wonder if we do need to
> have the backward compatibility for the field devices at that
> time. Can we drop it now?

Drop what? You need to keep ABI.

> 
>     syscon0: system-controller@440000 {
>         compatible = "marvell,cp110-system-controller0",
>                                 "syscon", "simple-mfd";
>         reg = <0x440000 0x2000>;
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         swrst: reset-controller@268 {
>             compatible = "marvell,armada8k-reset";
>             reg = <0x268 0x4>;
>             #reset-cells = <1>;
>         };
>     };
> 
Best regards,
Krzysztof

