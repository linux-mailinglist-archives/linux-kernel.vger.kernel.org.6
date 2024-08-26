Return-Path: <linux-kernel+bounces-301245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC70195EE28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998F1283E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357351474B9;
	Mon, 26 Aug 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hwHvxQb7"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468D13D8A2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666924; cv=none; b=kyFTP2qwsYUnogAInEbaj49jTvnf/cwBUeMiRG15p8MvuXqRp7R3UIeQAUilyverQpKm+h92GmSvjY8606d9r2zvObm99aMEatJd8dTFjDuFxcdOXdDyb2AV5uNLif2r5pECLQW+6aIRV1t8pkSCvZHbk3AsPsMnAkiJ96MjSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666924; c=relaxed/simple;
	bh=yrzkkcmxVrgBD+3U0c2nu8HvqEzs8KUb6TBQ7Mn3ucs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LS+Y9WG9+uqUAZ82DvSywoHsHPwgDjYFusZfRLnQndkHprTfRVlVqpW6bNpR2G42dDG8vg4Xmky7z8LPHBTpe6/9viILSOnsg8OjxPTi3OyIUIQyWy5Z/R9FpSwuztEiagd7zEsZwH8e/Qzr8X8gXM7omHFSh96oM8aS0S52m/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hwHvxQb7; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724666920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c/PkSK7apD9R1kwQ7c6Z6Y49uFjsWqdjZDvA5jspN4=;
	b=hwHvxQb7OH+gLsq7kQawQ1mfOsPOCqL/ZjEuC9opuNgQ1aJIDf44K5zh7c6t54lgtzQVq7
	fmK40esPGrjWXdwzBCEskR5DadGJGSHCEEE4BsNgaZb1qtC/mmw86P9oCbnariP8NiOlcg
	O8Tz6eYbwL0RE1/l8vwYYziTdpgCJXc=
Date: Mon, 26 Aug 2024 18:08:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] amba: make amba_bustype constant
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
 robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/23 21:48, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>>
>> Since commit d492cc2573a0 ("driver core: device.h: make struct
>> bus_type a const *"), the driver core can properly handle constant
>> struct bus_type, move the amba_bustype variable to be a constant
>> structure as well, placing it into read-only memory which can not be
>> modified at runtime.
> ...
>
>> -extern struct bus_type amba_bustype;
>> +extern const struct bus_type amba_bustype;
> Can we actually hide this from the outside, i.e. make it static in the C file,
> and introduce the dev_is_amba() helper instead?
>
> P.S. You may look at the PNP bus case (some of the latest patches there)

I found it problematic in the process of making changes.

There have some usage of amba_bustype outside the AMBA code ,i.e: 
https://elixir.bootlin.com/linux/v6.10.4/source/drivers/iommu/iommu.c#L155

So, If we make the amba_bustype inside the AMBA code, the outside cannot 
access.

If only internal access is allowed, it will compile and report an error, 
how should I modify it next, and any suggestions?

-- 
Thanks,
   Kunwu.Chan


