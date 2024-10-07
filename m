Return-Path: <linux-kernel+bounces-353565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD3992F82
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04AD1C22E45
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B881D5ABE;
	Mon,  7 Oct 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OsjNRe8w"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0A18F2E8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311776; cv=none; b=X1u4HYKpsGOscbbxBcM7lL/7VsXtoXEx5XKbaMYPa0Z0KMh7nJI3PXNP3LEJ6s7VVHJe++wLZhAiDD15uTxJcKhnt0471QMP6YQW0eMQyhbELlaoRQSsbB8vSrObdhL7KFC2wkLt028K7iq5G2q8h9d0LRWpvefU7zr4ZWaaFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311776; c=relaxed/simple;
	bh=YJBNkZmTCp4yDDi7LsNaw3f1xXzAird2t/fP2QX/qC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+jSq3MV923ygviTem74b7Yz/05xZnQThwl4vltOdqwjWil3nxNcCnpTYFIp7hi9vQo4/Qy1ke94OLt2MDLWnszLr+JtQvVskKIm05sHkacpZLtIJSG575YysNcTqnS2YReC6R7w5g9c45D1XTCdIuV6sy+nqHHsWsM4gGtCnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OsjNRe8w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728311772;
	bh=YJBNkZmTCp4yDDi7LsNaw3f1xXzAird2t/fP2QX/qC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OsjNRe8wVTqml8K0/JnJEGb2DitpIeHBMcTzxMA2oWb1pRDsZUtT03s/fhUcMdb7r
	 Gmy0XxxRNIsurmwSPoFbC5Vb2UkQiyI590xRX11I5yTDFz+uG1qp4JxiVYa1tzJleK
	 6rZBJuw5Eg26a+lNufv8VA2O19Ma22AW3qEqVi/Eerkuqc6DZ1Bx68xzznWXc64Fyn
	 Y4FWr+V90Enh/3eeQ+IzbIa5BvDdeW5h6XlqLQ7SsHY2dzzBqzZPuRTzVjcNJMqaEf
	 sdNOYKG682vHEOod6C23/priHckbxyUbO4Y4plnixQxg4CLKTxRBqJx499aJci5Nn0
	 sAeRUCqOzCC3A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A7C5C17E35FB;
	Mon,  7 Oct 2024 16:36:12 +0200 (CEST)
Message-ID: <8471ba7d-20a3-487a-8abe-f0fcf844c709@collabora.com>
Date: Mon, 7 Oct 2024 16:36:12 +0200
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
 <ae5eb5a8-d843-488a-8b68-9f6dd5d4603d@collabora.com>
 <2ebe6831-f213-4026-b7b9-689b3b5e78a3@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2ebe6831-f213-4026-b7b9-689b3b5e78a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/10/24 16:33, Matthias Brugger ha scritto:
> 
> 
> On 03/10/2024 10:08, AngeloGioacchino Del Regno wrote:
>> Il 02/10/24 15:00, Matthias Brugger ha scritto:
>>>
>>>
>>> On 02/10/2024 11:08, AngeloGioacchino Del Regno wrote:
>>>> On Wed, 18 Sep 2024 12:06:17 +0200, AngeloGioacchino Del Regno wrote:
>>>>> This series performs various cleanups to the MediaTek CMDQ Helper lib,
>>>>> reducing code duplication and enhancing human readability.
>>>>>
>>>>> This also avoids double initialization struct cmdq_instruction as,
>>>>> in some cases, it was stack-initialized to zero and then overwritten
>>>>> completely anyway a bit later.
>>>>> I'd expect compilers to be somehow smart about that, but still, while
>>>>> at it ... why not :-)
>>>>>
>>>>> [...]
>>>>
>>>> Applied to v6.12-next/soc, thanks!
>>>>
>>>> [1/3] soc: mediatek: mtk-cmdq: Move mask build and append to function
>>>>        https://git.kernel.org/mediatek/c/2400e830
>>>> [2/3] soc: mediatek: mtk-cmdq: Mark very unlikely branches as such
>>>>        https://git.kernel.org/mediatek/c/21ab3dae
>>>> [3/3] soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration
>>>>        https://git.kernel.org/mediatek/c/66705b89
>>>>
>>>
>>> You probably oversaw the sparse warning email on 3/3?
>>>
>>> As I oversaw that you already merged this.
>>>
>>
>> Yeah, I did. There's no problem anyway, as we can always replace the commits
>> without noise, I haven't pushed anything to -next :-)
>>
>> I plan to do that (drop patch 2/3, delete `.mask = 0` on 3/3) soon, at max
>> next week anyway.
>>
> 
> Perfect, before you do any locally please pull from remote as I did some changes, 
> not sure if you saw my message on IRC.
> 
> Regarding -next: we don't need to keep commit history in linux-next neither, to 
> even it got pushed to -next, we can drop patches in the queue with any problem.

My day was pretty full, I didn't. Thanks for shooting the email :-D

> 
> Have a nice afternoon :)

You too!
Angelo



