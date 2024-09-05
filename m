Return-Path: <linux-kernel+bounces-317287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714D96DBED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BA91C25572
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A569C14A8B;
	Thu,  5 Sep 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dwx79tDg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D18F5E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546933; cv=none; b=Ym4LA3WQtBY3mfRtBJWC+GOqUWLL0F0ON45EDK03YFQitK8DIW4DMCKfuHEZ2ePeZSv2fSbstNlW1Aw7AgTkwFmFs0g6n1PyfuaNeuSKd+rSzzH40qI8RSrPlzvqNXAw2GO/idniDNZo+ZZc7WU/38e5tszGRXTInOaQzmtV4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546933; c=relaxed/simple;
	bh=M2bjSeQ/wOoMeypqH5BiDYSv8yfyfc2dSXqndMN3VTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NJTDEnGfGnAfzWRfB1SlKaDdi3avz3BuYkKHihqswJUAOFhzjvbFBLsUebumE4ByrXUcQ70ELTw2tDFRwQHR2Jk3h0hULVRHlTSacGyOLYXXxw4odbtapwWcWKUEZhiXtvwXwakChw/uBuItVo3CINTzEibRlu136IxNplghJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dwx79tDg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725546931; x=1757082931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M2bjSeQ/wOoMeypqH5BiDYSv8yfyfc2dSXqndMN3VTk=;
  b=dwx79tDgXNnOfjacFGcOCVqdPBQV4reFk2iUPMUkWkVnJo9hdg4uvf6z
   ht8owhVY2QNWXQUjmhbIOtjpInzwcKfhHLOpRSYB07+Kr0fK3cLPy5nDe
   6sQzM+CpvaYjsl9XxLIJHSxKxS0TRUPqImQVNfRvH169OHiCP3qaWJCbP
   FGLh0JHlot2ewUlyI/iY+X/7V2h/GOP8sk2crjouerQystoZcg+gHDfQX
   shMBtvWaJGMk16Sn/3zUcqCHNgZKWOsgqgNbWOtiO+jdQjHuxKKgqZ8qU
   /BuM7yu/judf4loGeL/RhKSVXoXcXQPNFcMm4ExVN5NrXoyA7IDOZvvgM
   Q==;
X-CSE-ConnectionGUID: yD/jRtJuSYKqcSiMy7MBoA==
X-CSE-MsgGUID: AVU+b/zbTCyNrH2oKjCauA==
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="34471258"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 07:35:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 07:35:00 -0700
Received: from [10.180.116.241] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 07:34:58 -0700
Message-ID: <1da24d04-e99d-4b22-aec2-92d89d9cf089@microchip.com>
Date: Thu, 5 Sep 2024 16:35:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mfd: Convert comma to semicolon
Content-Language: en-US, fr-FR
To: Shen Lichuan <shenlichuan@vivo.com>, <lee@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<opensource.kernel@vivo.com>
References: <20240905092718.95011-1-shenlichuan@vivo.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240905092718.95011-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2024 at 11:27, Shen Lichuan wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>   drivers/mfd/atmel-flexcom.c | 2 +-
>   drivers/mfd/rk8xx-core.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index b52f7ffdad35..d5df5466eaf5 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -95,7 +95,7 @@ static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
>          if (err)
>                  return err;
> 
> -       val = FLEX_MR_OPMODE(ddata->opmode),
> +       val = FLEX_MR_OPMODE(ddata->opmode);

It surely doesn't change the behavior, but it's probably a typo anyway:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com> #  for atmel-flexcom.c

Regards,
   Nicolas

>          writel(val, ddata->base + FLEX_MR);
> 
>          clk_disable_unprepare(ddata->clk);

[..]


