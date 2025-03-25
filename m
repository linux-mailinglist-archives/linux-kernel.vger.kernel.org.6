Return-Path: <linux-kernel+bounces-575472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A89A70300
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C9D1638D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59272571A8;
	Tue, 25 Mar 2025 13:51:37 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7191F55EF;
	Tue, 25 Mar 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910697; cv=none; b=G7Xrs6PwPeHDqtgtZijjz329CZf3Iq+blCHvx0t2iYKMQ/buDzBJo/8jpFn0xXFWbCf96xTHbiCJIh//MFAOHTuILuK2DMTblTYz983lnTVQ8wBHZ4S6ZmfaFUORBLvfHzQIvh+XTU6xbUrA21LK4xp3TsL9jEVJ8LAMlOaZvG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910697; c=relaxed/simple;
	bh=58b+7j6bymR8Q3PTmjiR9EoWQsVTVX5p2SCXPJ6mBX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dag5dzDgsMetZSlw8I3OBRAg4lPkfIy668NkkORurwNcHiZNJqaFR0zk/rF7AF1JIvGX7IZXpjn3cZi8OAPu584lvIi5xvgpKYVDbzHDKK3C1GQWLAi1lc/d5HCRb3wB8oo8eRDwkCg2YryMnPguiD5fawxISQYIyAIPGii5A+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6847244254;
	Tue, 25 Mar 2025 13:51:29 +0000 (UTC)
Message-ID: <0788826e-4b96-49ca-94ac-1d5b92f9ee64@ghiti.fr>
Date: Tue, 25 Mar 2025 14:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] dt-bindings: riscv: document vector crypto
 requirements
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Eric Biggers <ebiggers@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Andy Chiu <andybnac@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250312-abide-pancreas-3576b8c44d2c@spud>
 <20250312-flask-relay-b36ee622b2c8@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250312-flask-relay-b36ee622b2c8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeehiefhuddtuddukeetkeehhedtffduhfevfeeftdefveffgfeuffejjeejfeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheptghonhhorheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegtohhnohhrrdguohholhgvhiesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
X-GND-Sasl: alex@ghiti.fr

On 12/03/2025 14:11, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The Unpriv spec states:
> | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the
> | composite extensions Zvkn, Zvknc, Zvkng, and Zvksc-- require a Zve64x
> | base, or application ("V") base Vector Extension. All of the other
> | Vector Crypto Extensions can be built on any embedded (Zve*) or
> | application ("V") base Vector Extension.
>
> Enforce the minimum requirement via schema.
>
> Link: https://github.com/riscv/riscv-isa-manual/blob/main/src/vector-crypto.adoc#extensions-overview
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   .../devicetree/bindings/riscv/extensions.yaml | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 02065664f819..9aeb9d4731ca 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -726,6 +726,39 @@ properties:
>               - contains:
>                   const: zve64f
>   
> +      - if:
> +          contains:
> +            anyOf:
> +              - const: zvbc
> +              - const: zvkn
> +              - const: zvknc
> +              - const: zvkng
> +              - const: zvknhb
> +              - const: zvksc
> +        then:
> +          contains:
> +            anyOf:
> +              - const: v
> +              - const: zve64x
> +
> +      - if:
> +          contains:
> +            anyOf:
> +              - const: zvbb
> +              - const: zvkb
> +              - const: zvkg
> +              - const: zvkned
> +              - const: zvknha
> +              - const: zvksed
> +              - const: zvksh
> +              - const: zvks
> +              - const: zvkt
> +        then:
> +          contains:
> +            anyOf:
> +              - const: v
> +              - const: zve32x
> +
>   allOf:
>     # Zcf extension does not exist on rv64
>     - if:


Ok I see now where you enforce the right dependencies, you can ignore my 
question in patch 2.

Thanks,

Alex


