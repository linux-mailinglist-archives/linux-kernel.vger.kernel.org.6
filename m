Return-Path: <linux-kernel+bounces-557195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CE8A5D4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236A61794E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9521487ED;
	Wed, 12 Mar 2025 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YPP9L9ej"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BC4685
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741750648; cv=none; b=k6tkmn1T3uK9qVMPiblggbT8vpSmQjf+p9Tumdp60fgI+zFKGh2jBwPVzHUAPHZZhQJjIe5clyL+rE9pFWFan9paEgKIfyWlmgXFDxbsXaHuI215EdAquSdCPq5Ntz+Pc7xg9bB+eQzFf8E/3HlkznIk88SAt3J7rFFv1cpfehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741750648; c=relaxed/simple;
	bh=1mGu0yDyCQ458Tka2SSzI5rlIO/cPFfmP81Z1D30n1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eY7FdyZCexieDQivAHPz4DQbSwJpTYpmGL5QLzP+lgDKiuODvgi/2T0O205R3pzX563cXQT8VkYEvm5vFVTetpd+35I98F1XG64QK3P3W6zgKOqhKG/48aHzQMmYghV83L+Qbeg9DDmi0UBqowJ76hEX0wQ7rggOdoyIwTLGfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YPP9L9ej; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741750644;
	bh=1mGu0yDyCQ458Tka2SSzI5rlIO/cPFfmP81Z1D30n1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YPP9L9ejtf7YDWgjKiS+/Bb5OnS3GFJWvU+Ibf7DoWH51u5Kl3EvGQ6FxWmPOF1RT
	 GMz2QShVAKk0mUn1om8LX+qSd9UPeR76mrhhKJscW65mnVOprDMrOY3cHxqfK745xg
	 748aoaz3qjcsnqW6HaPcLL9sD4QWXS3gELJGQe5J5c8HVUGoxTfQihmv6X5tPohi4e
	 r1D77J3XfxP6GNgBjv2Fe0o2esAbaRborc19jcPjWf1iwFdp02ixCZlQOsqLelUaUy
	 hN/reqa0L9TkaYDmLQC/SI/7t820emZqmHYKLulypLvM3EBAxWPr0v3AsP3a7NCZMz
	 rLa6UWBI688Aw==
Received: from [192.168.50.250] (unknown [171.76.87.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0912417E017D;
	Wed, 12 Mar 2025 04:37:22 +0100 (CET)
Message-ID: <e492a080-78e1-4694-9e84-a5373f3f23c7@collabora.com>
Date: Wed, 12 Mar 2025 09:07:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: mediatek: enable PHY drivers
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
 daniels@collabora.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250311061703.16850-1-vignesh.raman@collabora.com>
 <dc659e19-c1ae-42d8-84c9-0d2aafa81fe2@kernel.org>
 <daa0733c-14e3-44df-8374-33aba6662813@collabora.com>
 <717b84da-f307-41e9-9dc3-67ea653cac5f@notapiano>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <717b84da-f307-41e9-9dc3-67ea653cac5f@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nícolas,

On 12/03/25 01:15, Nícolas F. R. A. Prado wrote:
> On Tue, Mar 11, 2025 at 05:26:37PM +0530, Vignesh Raman wrote:
>> Hi Krzysztof,
>>
>> On 11/03/25 12:54, Krzysztof Kozlowski wrote:
>>> On 11/03/2025 07:16, Vignesh Raman wrote:
>>>> The mediatek display driver fails to probe on mt8173 and mt8183 in
>>>> v6.14-rc4, with the following errors:
>>>
>>> Which boards?
>>
>> These are the boards,
>> https://lava.pages.collabora.com/docs/boards/chromebooks/boards/hana/
>> https://lava.pages.collabora.com/docs/boards/chromebooks/boards/jacuzzi/
> 
> You can use the Devicetree name to identify them in a way that's meaningful for
> the kernel:
> 
> mt8173-elm-hana
> mt8183-kukui-jacuzzi-juniper-sku16

Thanks. Will use the device tree name.

Regards,
Vignesh

> 
> Thanks,
> Nícolas


