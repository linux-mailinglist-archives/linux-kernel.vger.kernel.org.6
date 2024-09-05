Return-Path: <linux-kernel+bounces-317424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C1F96DDF0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F2E1C20FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871F19D081;
	Thu,  5 Sep 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S+SbEAlY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10E10940;
	Thu,  5 Sep 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549701; cv=none; b=ti+yCsL7y0+ddmLlSAVJP3xr7XC7EfFvkTdCZXMRXJfmOZIoIoaSVEK9nyyoEX4WnMD9J0RWUM9CSuw9KLYLOKxkWhxUXJpThzMVSh/fQATVS3JtuxUewX6uNNdOoXE0JI14AzTXQ0aG6fnHF9vKFyR/XMxvraYPYWoQEWdDVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549701; c=relaxed/simple;
	bh=yGl/dLIM0UZWLi8QRker46izTh0jwKXyeHwDZm0sgp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GccygxguCWZOcbpxdR5ay9PqeYIBJIVeRViHrotbpdInYU2VfTJYQmBDBgigukNanAYbm+A+/9KzMOGb7rGtI2ChaqkXGCcEdBqhQfOh/6zOl/JAHpe7BgQotuqu/O3xVZwQ4iOSAEnIwJt2I0tFs251nBnlXqSyM0RjqqpVwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S+SbEAlY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725549700; x=1757085700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yGl/dLIM0UZWLi8QRker46izTh0jwKXyeHwDZm0sgp4=;
  b=S+SbEAlYnxXijP18oaftgLt+3DjdKsl/mgUYC8LMdC0M1ELQ34Bo7OfR
   Z10Tqb9DWOjTWPT0TFYILLuHpVKKzDMiJ1vVkRIO1AiOHl8ZUIy1gd+Fo
   oyqcPDGIwxmUD485oAKg6s8Ii5Xf2sLMsmt2F/8Q0AeypqXYqHzJuVuCG
   +QOJoYhYQBgbB68nR7kKQhOdhOFZw4vEEfqH/Vo+pMeac/Zb8GfV/ZJdd
   hq/Irtsxg32iN+cSoK7ev46jaZYKT78GQi7VpLwBgqQpEBTMl8R+BUtBt
   O3sujx6c13HtMcsitsrHFEef/MYghrcKvQieQVmmfEPXRH9HaRcbZIi+m
   g==;
X-CSE-ConnectionGUID: 0RjtCNvaTQiSYu+j1QXsrw==
X-CSE-MsgGUID: fF2QpZm5TmKZcdOPBLO2LA==
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="262338257"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 08:21:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 08:21:06 -0700
Received: from [10.180.116.241] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Sep 2024 08:21:04 -0700
Message-ID: <1da0abbb-94e5-42fd-a2d2-71d5d7d253fb@microchip.com>
Date: Thu, 5 Sep 2024 17:21:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3]clk: at91: add sama7d65 clock support
Content-Language: en-US, fr-FR
To: <Ryan.Wanner@microchip.com>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1725392645.git.Ryan.Wanner@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <cover.1725392645.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2024 at 17:54, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Hello,
> 
> This series adds clock support for the SAMA7D65 SoC. There are also
> changes to the master clock driver and PLL driver in order to account for
> the increased amount of clocks being supported in this new SoC.
> 
> Trying to account for all the updates happening in this system, this
> patch set is based off of the most recent updates to at91-next branch.
> 
> Changes in v2:
> - Correct PLL ID from PLL_ID_IMG to PLL_ID_GPU in the description.
> - Adjust master clock description to match amount of master clocks 0-9.
> - Correct bad spacing and bad alignment.
> - Remove double variable definition.
> - Add missing kfree() at end of function.
> - Reorganize clk and pll driver changes in patch set.

To the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> Ryan Wanner (3):
>    clk: at91: clk-master: increase maximum number of clocks
>    clk: at91: clk-sam9x60-pll: increase maximum amount of plls
>    clk: at91: sama7d65: add sama7d65 pmc driver

For the record, additions to the DT binding are posed here:
https://lore.kernel.org/lkml/20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com/

Best regards,
   Nicolas

>   drivers/clk/at91/Makefile          |    1 +
>   drivers/clk/at91/clk-master.c      |    2 +-
>   drivers/clk/at91/clk-sam9x60-pll.c |    2 +-
>   drivers/clk/at91/pmc.c             |    1 +
>   drivers/clk/at91/sama7d65.c        | 1373 ++++++++++++++++++++++++++++
>   5 files changed, 1377 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/clk/at91/sama7d65.c
> 


