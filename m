Return-Path: <linux-kernel+bounces-317417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420A596DDDB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748711C23210
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1360199391;
	Thu,  5 Sep 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CMVVNwIw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C48289A;
	Thu,  5 Sep 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549550; cv=none; b=RsSSvby/XOJYN5vWSufJhkd/Wwhhw38YwZtUUptE5Cnro7mCdVONZ3g35iJ2cQ2OhuFv0pppYdJvAmsDjJ2vN9STtkXoaeXN5cCMjCLhUQfZVhkdPU/qLUnxsL46xREfQbXVeOB+lmwBHEj0FOhLrC5ZVRAfvLAD381C50TxhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549550; c=relaxed/simple;
	bh=h6qYuZYgpSHs+Z6XA/OOd6aWXfix0xnSTXQZqCHk0s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sf46C2GDgopwjuuNbJUIeKJWXq72e9QKxjK0nzjUeE2Ph226W9BRl4O+bVKyP1fyxxQ4FAbJfJAzUtBI8unYbXUdUdb6f6WosWsy/lDI9JA80yIkRs9Kso4gCKNifoNKOU/4VgiM/v9ueKVNlX1GF0KxJEGB5GNMCAV2ozzD3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CMVVNwIw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725549548; x=1757085548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h6qYuZYgpSHs+Z6XA/OOd6aWXfix0xnSTXQZqCHk0s8=;
  b=CMVVNwIwcoa9ruRch+6eeRp5zESN+UL4haKv/wE+ogkP+ETh4bcisW0x
   yoMbI5gmjGZc/L+5VHRp3Nes4o7fmtASSk01cZKqBXwayxvdF8R++zyLn
   AOjt5NQYkt/diwAS//rFfeLrV9P2PmjPepFBDD8izV/T28p6gO5xqxeoL
   muCyWGOYjoG11XY/m+0RTs2LD8Lnn9C+X98iI4ln/tByBzq/e2aSBvYQZ
   7o9iXms4s/q+Yk7CmZDlOG9tOYKbD4rroTanI5H1zpINnZ+GAlDFvKZef
   qz1gwl11xmom1vUDQjOdRqneVukkmCVL/6LT0BFrqaxRJhPHjfqM1Awqv
   g==;
X-CSE-ConnectionGUID: YW3ZuO0gRNG7kqx0NbYnYA==
X-CSE-MsgGUID: z8/lXfkdR0yUdNqwUfDCng==
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="34474291"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 08:19:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 08:18:36 -0700
Received: from [10.180.116.241] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 08:18:33 -0700
Message-ID: <2e0ab6c7-a7d0-44fa-8e8b-cd04e5c0359c@microchip.com>
Date: Thu, 5 Sep 2024 17:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: Add SAMA7D65 PMC compatible string
Content-Language: en-US, fr-FR
To: Dharma Balasubiramani <dharma.b@microchip.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/2024 at 11:38, Dharma Balasubiramani wrote:
> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
> since the SAMA7D65 PMC shares the same properties and clock requirements
> as the SAMA7G5.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

For the record, driver addition is here:
v1:
https://lore.kernel.org/linux-arm-kernel/cover.1724948760.git.Ryan.Wanner@microchip.com/

v2:
https://lore.kernel.org/linux-arm-kernel/cover.1725392645.git.Ryan.Wanner@microchip.com/

Best regards,
   Nicolas

> ---
>   Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> index c9eb60776b4d..885d47dd5724 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -43,6 +43,7 @@ properties:
>                 - atmel,sama5d4-pmc
>                 - microchip,sam9x60-pmc
>                 - microchip,sam9x7-pmc
> +              - microchip,sama7d65-pmc
>                 - microchip,sama7g5-pmc
>             - const: syscon
>   
> @@ -90,6 +91,7 @@ allOf:
>               enum:
>                 - microchip,sam9x60-pmc
>                 - microchip,sam9x7-pmc
> +              - microchip,sama7d65-pmc
>                 - microchip,sama7g5-pmc
>       then:
>         properties:
> 
> ---
> base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
> change-id: 20240829-sama7d65-next-a91d089b56a3
> 
> Best regards,


