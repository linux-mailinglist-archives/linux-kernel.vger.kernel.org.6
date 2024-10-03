Return-Path: <linux-kernel+bounces-348724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25498EB0F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8441C21A78
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3B131182;
	Thu,  3 Oct 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xzet3/Kt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71392811E2
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942897; cv=none; b=Y5/A3IsQc2ApyL54IL4k8jCopm6jDiA3p7C1YpDlzqEvALroOftMbz3GK4wPjWPnqN6Oi155CX+884LILTyhYpPmPdfym5MuWE0Dxm/8r0R1vCzbRDKkNFXiZBZtR07NyEPnkNSFuSv+45/4nIwS4G0JiXCDL84MCJzfjEY/i9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942897; c=relaxed/simple;
	bh=9obnleDI85uC1/OH57INKgO5FDblTLxyLq0nyXOJI0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNCvPXsVopUr4z6JHsfTZ3Do6/KshckysO4feYGqdaipgK3KWfbN5GZ+wW+drbWPusWhnkftL+R1Rcer8AQcVDjqhV1gZkgjpofCDMr0mRp4vvylbbo6CPLCJmTBxGWpzfaNZ9uGsxfkGAdpP0KgNyIeEWHX67Qezvy6l9O9Be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xzet3/Kt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727942893;
	bh=9obnleDI85uC1/OH57INKgO5FDblTLxyLq0nyXOJI0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xzet3/KthlycX8GfZxfuoR7EtnFyY/w4xpPPKHkSGEHjfEPYpwdwZzBDyCL5z3JnE
	 NTFAbxFPLs/oBXX7c/H5bnX7tsD/MUbJTR7XdrNi5SogDVWB44E1fmla+2Me3mu41G
	 UyQynCBAyqJgQdKQVXxQI4piVFkTjJhKBtDAJ+7gm5H0fY6vU8oi1qaZEXQbplB8zT
	 kYrRAx7BQH+yW/mudwghnvQImQVSvcZilSvyDAGXgemHehZDNkqtOVdCOlTNkh90rC
	 vih0xrkREKsS6iInFGcYX7SYc8FuxoIYuzwIH1GbxGGG5Lui6u8mqTuqxm+XC2Czr8
	 Hz1v4LAVf+HVg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 82A9417E10AA;
	Thu,  3 Oct 2024 10:08:13 +0200 (CEST)
Message-ID: <ae5eb5a8-d843-488a-8b68-9f6dd5d4603d@collabora.com>
Date: Thu, 3 Oct 2024 10:08:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] soc: mediatek: mtk-cmdq-helper: Various cleanups
To: Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
 <172786008674.33539.15432336067797076322.b4-ty@collabora.com>
 <3e0c8b18-81ce-4c9b-886f-d7c50fdf4c3d@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <3e0c8b18-81ce-4c9b-886f-d7c50fdf4c3d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/10/24 15:00, Matthias Brugger ha scritto:
> 
> 
> On 02/10/2024 11:08, AngeloGioacchino Del Regno wrote:
>> On Wed, 18 Sep 2024 12:06:17 +0200, AngeloGioacchino Del Regno wrote:
>>> This series performs various cleanups to the MediaTek CMDQ Helper lib,
>>> reducing code duplication and enhancing human readability.
>>>
>>> This also avoids double initialization struct cmdq_instruction as,
>>> in some cases, it was stack-initialized to zero and then overwritten
>>> completely anyway a bit later.
>>> I'd expect compilers to be somehow smart about that, but still, while
>>> at it ... why not :-)
>>>
>>> [...]
>>
>> Applied to v6.12-next/soc, thanks!
>>
>> [1/3] soc: mediatek: mtk-cmdq: Move mask build and append to function
>>        https://git.kernel.org/mediatek/c/2400e830
>> [2/3] soc: mediatek: mtk-cmdq: Mark very unlikely branches as such
>>        https://git.kernel.org/mediatek/c/21ab3dae
>> [3/3] soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration
>>        https://git.kernel.org/mediatek/c/66705b89
>>
> 
> You probably oversaw the sparse warning email on 3/3?
> 
> As I oversaw that you already merged this.
> 

Yeah, I did. There's no problem anyway, as we can always replace the commits
without noise, I haven't pushed anything to -next :-)

I plan to do that (drop patch 2/3, delete `.mask = 0` on 3/3) soon, at max
next week anyway.

Cheers,
Angelo


