Return-Path: <linux-kernel+bounces-512709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1856A33CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70993165072
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AE212F8F;
	Thu, 13 Feb 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PAMFv8qo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224851FAC42
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443173; cv=none; b=VAzfMWYOa35DaDpIC8W9ZOh89zq8GAevcKsEAreAFt3yxWoh1g/xxpHL5EW14QyCFZm8bM4VhwtMYPLQdMCxAEKKtrLFvdvuNnGuAfEjo/ArXyWXB+OB+ZcRvWpbl+civQtgImCOHcqQcWGKfH0npTZdcSHp61D2lcnL/WHGt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443173; c=relaxed/simple;
	bh=LXVJThLjduv+7chq4ELKcznat12qJGf5A21gp7uWdNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o6PtXAha4Tcfy15xdP5Sq/8nm8w6E9XErbwByK3kPGSEdKxAPsL0Hguq3X1VF1u2upqhah1h/ID/0+VOz6J+KxrOvhSzk1ajboz9KGB8VHopYzxd3vpL5vOHfC6rd+6LdxmHqeuX11s5CLXJ42k4ZF2ZzuwiImSzCI/U18ysoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PAMFv8qo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739443170;
	bh=LXVJThLjduv+7chq4ELKcznat12qJGf5A21gp7uWdNk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PAMFv8qoeRaLMo0F2+g1tIxH7+SuM/So8+w8LA3Ez6Eau2HcNoN0HMyzU080OD7CM
	 Nuws4daGm9/ZleXUPus/28MhtcxeZfOlC0O3IQ1vQQ1swQX7akV7MDjSCVn1SHrKvw
	 6UbNVSQFG3b5yoNN4JzKVbABm16J+4Oqd+ByfX6DoNDkeRX2bascC31u+vtLZQxY9o
	 PvdBu0eiRucRK3hWGp82/Zo9AI10//aaA5NRF6PbOYSg5YSRMtjXqFFulT3kz0tmGy
	 UCZFcROdSYGWyknjdVCBIqzNv/SMahUXAxeOv+nyyLRzJgow5UskF5s/QO+9vsrW6P
	 o0IlQL5jSA8Rw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0B7A17E00A3;
	Thu, 13 Feb 2025 11:39:29 +0100 (CET)
Message-ID: <b2ee0b9a-2d7a-4bbb-ae1a-c4abe6e7aeff@collabora.com>
Date: Thu, 13 Feb 2025 11:39:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/mediatek/hdmi: Simplify with dev_err_probe
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250112134708.46100-1-krzysztof.kozlowski@linaro.org>
 <20250112134708.46100-2-krzysztof.kozlowski@linaro.org>
 <ef0baed6-54d2-4f1f-9a4a-769ec09a069f@collabora.com>
 <59f8a02e-a716-40a8-bf73-111ad2a7af79@linaro.org>
 <8e8e3eca-dee0-43ab-95d9-aebd636245c7@collabora.com>
 <7341db6b-aed0-4da0-a5b2-6992d86ffaf3@linaro.org>
 <a65b01d8-3716-40bb-9171-ad6ed3121a89@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a65b01d8-3716-40bb-9171-ad6ed3121a89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/02/25 11:07, Krzysztof Kozlowski ha scritto:
> On 12/02/2025 21:33, Krzysztof Kozlowski wrote:
>> On 13/01/2025 14:48, AngeloGioacchino Del Regno wrote:
>>> Il 13/01/25 14:07, Krzysztof Kozlowski ha scritto:
>>>> On 13/01/2025 13:41, AngeloGioacchino Del Regno wrote:
>>>>> Il 12/01/25 14:47, Krzysztof Kozlowski ha scritto:
>>>>>> Use dev_err_probe() to make error code and deferred probe handling
>>>>>> simpler.
>>>>>>
>>>>>
>>>>> That's already done in [1] so you can drop this commit.
>>>>>
>>>>> [1]:
>>>>> https://lore.kernel.org/r/20250108112744.64686-1-angelogioacchino.delregno@collabora.com
>>>>>
>>>> Eh, this was first in v3 in the middle of Dec, so why you cannot get it
>>>> merged first? Creating such 34-behemoths causes simple cleanups to
>>>> unnecessarily wait.
>>>>
>>>
>>> Getting the series partially merged is okay for me, no complaints about that,
>>> but then ... in v4, there are two minor comments to address (one of which
>>> is a one-char nitpick!) that might as well be done while applying, depending
>>> on what CK thinks about that, so there's no real benefit in getting 28 commits
>>> out of 34 picked instead of, well, just everything...
>>>
>>
>> OK, month passed, I waited, so is your big patchset merged? If it is,
>> then this will effectively rebase my patch, as you requested.
> 
> I think I missed that you took the patch to your patchset, so sorry for
> the noise.

No problem.

Cheers,
Angelo

> 
> Best regards,
> Krzysztof




