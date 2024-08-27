Return-Path: <linux-kernel+bounces-302806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA307960393
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6579928441C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BB11714B8;
	Tue, 27 Aug 2024 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sWXlwhQj"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B8154C0A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744762; cv=none; b=IViSZSLJw3xXm5gXUdoZ9zujxAMmi8WioFWeoe/larvRjM+tcQzIqQogeA2ZkAnh+vL1x9Nvigp2in3+WXz0LZb7MKmiTOxWyh/SIe5KQBUkUdSo71pSuCNfpqhR4+bOX+31ZWnKndgXe5RQZF3nVUxaHhdgDSBoQGmrxVkqAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744762; c=relaxed/simple;
	bh=bbk0tQ0wF3uxeuHRruOIwnx2cS3UksaT50vxrNI+QCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQBFrtNdz6oSTrTFw3XBBci01YOzqXpT02oh6eaLJVoMz4Zq3x27IuBnCmwCkv/IzJ7sYJNIEXk6jCvVNcb+6n8GPrR9zhnIrKnXdC1OrSNE6jRtazBjwy64rlUNu6b4k8kGcIwev3Y6qZ5tuF+F8pNEGiygqE/3YQ1o7WxpvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sWXlwhQj; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724744759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dup+ODPepsYvDhjvzu3c5t4q1At5aHxGmhzgD07IEqc=;
	b=sWXlwhQjli1GOfjMzHNS6/vIrlaFEfJTdzsErW7G8kxQ77T+R9G9OXhkuEezVnXHNS2V4K
	shXtz0eHFVx5jeuKJeJHmHmn/KS0YUhhUamho4zYnXQwCRismtbbJoJXyZoZyeM2YnQwxE
	1QSnM0BDmVtuVYMfyXU0LE9PwTST/Rc=
Date: Tue, 27 Aug 2024 15:45:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] amba: make amba_bustype constant
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
 robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/26 18:40, Andy Shevchenko wrote:
> On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:
>> On 2024/8/23 21:48, Andy Shevchenko wrote:
>>> On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:
> ...
>
>>>> -extern struct bus_type amba_bustype;
>>>> +extern const struct bus_type amba_bustype;
>>> Can we actually hide this from the outside, i.e. make it static in the C file,
>>> and introduce the dev_is_amba() helper instead?
>>>
>>> P.S. You may look at the PNP bus case (some of the latest patches there)
>> I found it problematic in the process of making changes.
>>
>> There have some usage of amba_bustype outside the AMBA code ,i.e:
>> https://elixir.bootlin.com/linux/v6.10.4/source/drivers/iommu/iommu.c#L155
>>
>> So, If we make the amba_bustype inside the AMBA code, the outside cannot
>> access.
> Yes, that's the idea.
>
>> If only internal access is allowed, it will compile and report an error, how
>> should I modify it next, and any suggestions?
> Make it patch series:
> 1) patch that introduces exported function called dev_is_amba() (1 patch);
> 2) convert user-by-user (N patches);
> 3) hide the bus type and make it constant.
>
Here[1] have many use of  amba_bustype directly outside the drivers/amba

When I try to hide the amba_bustype by move the extern from 
include/linux/amba to drivers/amba,

we find some errors: "error: use of undeclared identifier amba_bustype".

[1] https://elixir.bootlin.com/linux/v6.10.4/A/ident/amba_bustype

-- 
Thanks,
   Kunwu.Chan


