Return-Path: <linux-kernel+bounces-363718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F9199C5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99FC1C22C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF4B157466;
	Mon, 14 Oct 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hj9MCMT9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6921A270;
	Mon, 14 Oct 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898849; cv=none; b=mY5qE/RQnp7QiSp1bLuHAiZ/yeS0KCvBfzSGN+/r65wyciVrHXnXWJYaBA0VsR8iU5ERsEiTFYs+UNm67/g8bDkEtU7XfVdIEsh/FhZoMXyAHDzou8G2sZGXnIqjaluzpHhHgtdwsBhEzxsBrxY0KXriZfMpN3rUTipDFUMKQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898849; c=relaxed/simple;
	bh=/NpiSmBVuP9T6x4q3CHJt1BOpKGypAsg4kg+Wj/DAB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P1PjNVlXWGiVBWhIhFljOwxlq7LwUC7PcN7fUC8+c16K8TkIKyMxXf5YX8Yd5hlYeZc5FbKRwbK04stu9BW9w7C7ZmlxdtOMI2Ka4ID88sg6yHMsk6KVmtI77Hm36lggEDtJ5+4CxGJGd3kwd6m/zTHtD+I1j/DDS9fXnzXaL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hj9MCMT9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728898848; x=1760434848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/NpiSmBVuP9T6x4q3CHJt1BOpKGypAsg4kg+Wj/DAB8=;
  b=hj9MCMT9dE1FGkwySBLkWJ9yivo/tfH1ajvvwU13HuKRhXDybgawpkiT
   Hl1Mb9fuQAh698rXDdBzw1PLcs3KqXhiIZ8HZpRUoPA2bjAJ0JWm5/Lm0
   xBLW4jtSQFXV2Z6F6T5C6DIDdCJaZJTlMdMJUVd6mos+2u861uaIEFubS
   Qta7VnBdt3n0vVydwNHqIWZwqOKzThx+iq0eJHWsiT8eHwp+Lfp1H7VK/
   0vSVDaf6Qv7kLXbesWznqgKidft8uniVChQeBEn1N1pt2NBB/ElvLor8Q
   jcyP3A2DB8AicEkGlSzvs+0KEPp6kBmRn4hdonuUCZeXTSRt6endThbnZ
   A==;
X-CSE-ConnectionGUID: jo68VbivTo+yYcT4uhvzmA==
X-CSE-MsgGUID: ooE1JRb5SR+Ocx9lVSNyFQ==
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="33538981"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 02:40:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 14 Oct 2024 02:40:13 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 14 Oct 2024 02:40:11 -0700
Message-ID: <70b4be62-818a-44d8-8330-c912ce6b60e1@microchip.com>
Date: Mon, 14 Oct 2024 11:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] MAINTAINERS: Update maintainer list for
 MICROCHIP ASOC, SSC and MCP16502 drivers
Content-Language: en-US, fr-FR
To: Andrei Simion <andrei.simion@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241014092830.46709-1-andrei.simion@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20241014092830.46709-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 at 11:28, Andrei Simion wrote:
> To help Claudiu and offload the work, add myself to the maintainer list for
> those drivers.
> 
> Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Thanks Andrei:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas


> ---
> v1 -> v2:
> - add acked-by tag
> - adjust commit title
> - update maintainer list for MICROCHIP SSC DRIVER
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1eebb14efb5e..73afcdd005ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15144,6 +15144,7 @@ F:	drivers/spi/spi-at91-usart.c
>   
>   MICROCHIP AUDIO ASOC DRIVERS
>   M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>
>   L:	linux-sound@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/sound/atmel*
> @@ -15252,6 +15253,7 @@ F:	include/video/atmel_lcdc.h
>   
>   MICROCHIP MCP16502 PMIC DRIVER
>   M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
> @@ -15383,6 +15385,7 @@ F:	drivers/spi/spi-atmel.*
>   
>   MICROCHIP SSC DRIVER
>   M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
> 
> base-commit: 7f773fd61baa9b136faa5c4e6555aa64c758d07c


