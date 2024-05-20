Return-Path: <linux-kernel+bounces-183591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929798C9B06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E466280E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281EA4D9FB;
	Mon, 20 May 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3RKlVEnw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15061224D7;
	Mon, 20 May 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199932; cv=none; b=ifmvggwdRpFfW8TSi3I0UezfU20DuwpQ7KrwuvprVt1A1q6HZd05SPfFR46V44Ri8LxOG5y6TlBFcwRiAL0wi/ntTnx19XHW/szl48GixoRBxxd1zGsfJ/yyJkcyn/xuBvB2ZpwvKaWNXHJ7jekfC7nArURrQCT0p6q1lsThICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199932; c=relaxed/simple;
	bh=6NDH0z522me5vrgmflzfx3WQmnMcDdrAZ53MUWxQv/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g19ZYwiAKNwQcocUsUqqusmbvvBGGUZMTlPxQ9lP6OUvvusEP0h/168aKMhcvpSyuCi+LNIOIU2HMeNAF4n9SZKKVodMipBQBf4bAOT5UbZwhqag0xMZs7Kg+NYDXfw8akkmy+bbs8htezLh2ysWVBecdJayuGqoNV6vAsu/0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3RKlVEnw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716199929;
	bh=6NDH0z522me5vrgmflzfx3WQmnMcDdrAZ53MUWxQv/4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=3RKlVEnwwt+L5N6iv4pr5sMiBA1t3K7kWgvqTEz2d1rPQs0u9QxBIfxWjsU5Ch537
	 MwoEupaZcfEH4C6n5h8R0IDoqxWmROmYlaHoRlRJ7wjPrBZ/Q2kUZEOg5xMLmKHsni
	 LVSNEE08mvwsn0Jen6ElZtG6U57kCmUC11S4ghbAqW0cEyQAuYpJesHhj8ADRfXdR4
	 5qHAg0a9Wh0ytta1OEjeFBngPVBUthhT1DGluv2H5NzRfI/2ci45MZdCBWuUId4/nQ
	 TlCXVJzXpd2Jo6UUexOJwg2S72A7G0xA08/Z8OG9HNea6u1utU6oHEu+C8h44MZUUM
	 Ah+2Y+6LS3jtA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9B0B037809D1;
	Mon, 20 May 2024 10:12:08 +0000 (UTC)
Message-ID: <cf8c87fe-7a4f-423f-9c97-3759eeee4894@collabora.com>
Date: Mon, 20 May 2024 12:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8365: use a specific SCPSYS
 compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Alexandre Mergnat <amergnat@baylibre.com>
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-2-krzysztof.kozlowski@linaro.org>
 <f42ef151-6eee-418f-91e1-5ac08d161119@collabora.com>
 <2cc638ca-0add-4c8c-b844-606e22dbd253@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2cc638ca-0add-4c8c-b844-606e22dbd253@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/05/24 12:03, Krzysztof Kozlowski ha scritto:
> On 20/05/2024 11:55, AngeloGioacchino Del Regno wrote:
>> Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
>>> SoCs should use dedicated compatibles for each of their syscon nodes to
>>> precisely describe the block.  Using an incorrect compatible does not
>>> allow to properly match/validate children of the syscon device.  Replace
>>> SYSCFG compatible, which does not have children, with a new dedicated
>>> one for SCPSYS block.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Technically, that's not a SCPSYS block, but called SYSCFG in MT8365, but the
>> meaning and the functioning is the same, so it's fine for me.
> 
> So there are two syscfg blocks? With exactly the same set of registers
> or different?
> 

I'm not sure about that, I don't have the MT8365 datasheet...

Adding Alexandre to the loop - I think he can clarify as he should have the
required documentation.

Cheers

