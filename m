Return-Path: <linux-kernel+bounces-169731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C08BCCC4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E193D1F220C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58379143886;
	Mon,  6 May 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="15YeLV1k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFA143736;
	Mon,  6 May 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994527; cv=none; b=DxNXplWuVyrdzFYVrGJ4R1DwNoqrH7rmpxkb1x4EbRO7QTbIt5Ho/YXQBal2TUtKSLI9pncCziSr6Oc+HqUaF+BZtoRB15tqqPI83goxHOL9nna7xjsr3dL6Ytdk+hVWB8iJtbUh4X/uTRb6z/+1x6LHHuToqdRrVZbgmJK2J7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994527; c=relaxed/simple;
	bh=WRfIjoGXJOrxKIMOIK6fA9+RaDmVZhu3OL5+XnDAkHA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d8pc+Gdz7q3DOGaRPPcZmSf2VwhGYvxTxemUnIRWP4qH3OdtvtBhpql4ZcDhuwznTfGtYGMy8qNHlUezey46Gb+3nzScZMQSqMS2dPdB7c/fHwh8dzYDn6K6ZGqvipLLBbnZiz/TeyH5TjluGiNvbzY23CsoVQ4UO/9cwZCPbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=15YeLV1k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714994524;
	bh=WRfIjoGXJOrxKIMOIK6fA9+RaDmVZhu3OL5+XnDAkHA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=15YeLV1kyZjf+iw+wMojXNyYslS6EWt/yfOUxNyedsZMJOicabHB71UbapyfmROU1
	 laIfq9QuGhe0QV0/T5L4nHJ77wdtpK3oXS0uYY5yDXGNC/JOJTyhls5n5Penh0Wqjf
	 PGBSwEY8x5qaMssoxcZdlkXKdvkxh04ii8WFniP97mrSYM1DD+teypxXAEvBBkuuoT
	 sZi2n/FIs5kzrpXTO+Z4ooZcoTk43qBETtKt1yWTprQdyTk9P97Is7wnkj+6AfTdZw
	 kluGZq24q4hXoVrNQWGDYASrMBnOX/1QgnlK3mUVBzPghA4+GAqlhyyI1LTbfVZqHZ
	 R9zaOkJt6TbPQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE6573782087;
	Mon,  6 May 2024 11:22:02 +0000 (UTC)
Message-ID: <1b8fa907-b48f-4ebe-bc17-3de1d7c0d062@collabora.com>
Date: Mon, 6 May 2024 13:22:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/mediatek: Add support for OF graphs
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Michael Walle <mwalle@kernel.org>,
 Alexandre Mergnat <amergnat@baylibre.com>, chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <1fc23530-89ba-4e36-9e9a-a1289f56a9bc@baylibre.com>
 <608fdbde-ad06-45ec-9771-18aa9f002f2d@collabora.com>
 <D12H4GDJJEUF.1Y91H9RMUIX20@kernel.org>
 <50be68dc-b86a-4334-9f83-43c6fda2c271@collabora.com>
Content-Language: en-US
In-Reply-To: <50be68dc-b86a-4334-9f83-43c6fda2c271@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/05/24 12:56, AngeloGioacchino Del Regno ha scritto:
> Il 06/05/24 12:02, Michael Walle ha scritto:
>> Hi Angelo,
>>
>> On Tue Apr 30, 2024 at 1:33 PM CEST, AngeloGioacchino Del Regno wrote:
>>>>> This series was tested on MT8195 Cherry Tomato and on MT8395 Radxa
>>>>> NIO-12L with both hardcoded paths, OF graph support and partially
>>>>> hardcoded paths (meaning main display through OF graph and external
>>>>> display hardcoded, because of OVL_ADAPTOR).
>>>>
>>>> Is that make sense for you to add the DTS changes of these boards into this 
>>>> serie ?
>>>> I asked because, IMHO, that could help to understand the serie.
>>>>
>>>
>>> Yes and no... but I imagine that you're asking this because you're trying to
>>> prepare something with a different SoC+board(s) combination :-)
>>>
>>> In that case, I'm preventively sorry because what follows here is not 100%
>>> perfectly tidy yet as I didn't mean to send the devicetree commits upstream
>>> before this series got picked....
>>>
>>> ... but there you go - I'm sure that you won't mind and that the example will
>>> be more than good enough for you.
>>
>> I've tested this series with the DSI0 output and it works. Nice! No
>> need for my DSI0 patch for the MT8395 anymore.
>>
>> But I can't get it to work with the DisplayPort output, that is the
>> dp_intf1/dp_tx interface. I don' know how the pipeline have to look
>> like. The functional spec seems to be ambiguous on this. The text
>> seem to refer to the second vdosys but there is also a diagram where
>> you can use the first vdosys and dsc0. If you have any pointers for
>> me, I'm all ears :)
>>
> 
> 
> The problem with this is that you need DDP_COMPONENT_DRM_OVL_ADAPTOR... which is
> a software thing and not HW, so that can't be described in devicetree.
> 
> The only thing this series won't deal with is exactly that.

Sorry, no, I got confused.

The series *does* already deal with that, as the pipeline is built before the check
for OVL_ADAPTOR components, so that will get probed.

What I got confused about is the fact that I promised myself to cleanup the support
for that OVL_ADAPTOR thing (which is unrelated to this series, even...), but again,
this series will still get that probed anyway.

Anyway.

The pipeline for DP1 should be simply

VDOSYS 1 -> MERGE 5 -> DP_INTF 1 -> DP

(eDP on VDOSYS 0 -> MERGE 0 --- DP on VDOSYS 1 -> MERGE 5)

Cheers,
Angelo

> 
> It's relatively easy, though, to add support for the OVL_ADAPTOR... as it would
> be just a matter of checking if any of the components in the pipeline contain a
> compatible that is in the OVL_ADAPTOR compatible list.
> 
> I'll try to add that up today, let's see what I can do.
> 




