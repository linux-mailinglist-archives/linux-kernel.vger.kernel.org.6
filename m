Return-Path: <linux-kernel+bounces-222257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C375E90FEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C8EB20B67
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46651A3BD8;
	Thu, 20 Jun 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m94fVAGC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D419DF78;
	Thu, 20 Jun 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872362; cv=none; b=m38p0AFvm5SdezObf/jvUwNhvHd5wKIKcgZKBlZoNAVOdYvK84eY1/0G8lNFT9OboVADGHmiKFpar0x0BD5oVOUDFPxaafTA0l3jwiKU2CF1HFRohdjZKyubSR2nIuCAc68tIRfOUQVxyqjw7Ruc+xK/00Hd7pmLtjx5x06l6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872362; c=relaxed/simple;
	bh=kZP756ApMCbsWPF0yi0qrMXeSdEChDIUSSlFRUyfPx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ozet9mPRBVfWx9WE1M/nDNYhj6rU1PcIVxndZZte/+KGHuH/Eoc7GHYMCwk5ty7pbMrR+gO9JlyhvvNsObs7UTu7ub9LfnbSkM+C8Xe3wDoeoSGfWvU9XcLywuybcbXUEi0MUHif2coMyDmecwjS9yZdMFFcb/8Vy8/dZH8hB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m94fVAGC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718872358;
	bh=kZP756ApMCbsWPF0yi0qrMXeSdEChDIUSSlFRUyfPx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m94fVAGCsmSi/o6TVENMyOEqnM63upOGVNIRWSaLxdveLfeD38e/3dwH3JxVowuNC
	 LihXaxoOcghFwfcLX+rWX9f7tm8RLtoS5hFz6RWtZRot/Bb8tNS/BkSXklJAkkEEvX
	 Pjfbt7NM49sO2VNTjUVi7qdP2fXSlVVJjkpQQ4IMt/rgAQCxXTjymx3Ya+dbSQZ4ia
	 +3ekd1Z5eytypiLJr13POcrBx4CubdXR/0DwxLnA5bVKLDJSD1XACQIgwCV/3tBhlc
	 rsTZGR+GuH5bNclWuqEg/2sbGuODI/LtoH2QYVgaQ62gnY+TmALeuK9k4Tw5NZj8hl
	 WfIy8RPIDBTXg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 93B9F37810CD;
	Thu, 20 Jun 2024 08:32:37 +0000 (UTC)
Message-ID: <c154527b-90c3-4834-a4a0-cff4524de5f1@collabora.com>
Date: Thu, 20 Jun 2024 10:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: mailbox: mediatek: Avoid clock-names on
 MT8188 GCE
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, krzk+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, jassisinghbrar@gmail.com,
 garmin.chang@mediatek.com, houlong.wei@mediatek.com,
 Jason-ch.Chen@mediatek.com, amergnat@baylibre.com, Elvis.Wang@mediatek.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
 <20240619085322.66716-3-angelogioacchino.delregno@collabora.com>
 <20240619-sleeve-citable-a3dc10e5cd4f@spud>
 <a7317981-8690-4d45-81b6-cc6a63c459e0@collabora.com>
 <20240620-district-bullring-c028e0183925@wendy>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240620-district-bullring-c028e0183925@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/06/24 10:22, Conor Dooley ha scritto:
> On Thu, Jun 20, 2024 at 10:01:18AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 19/06/24 19:49, Conor Dooley ha scritto:
>>> On Wed, Jun 19, 2024 at 10:53:22AM +0200, AngeloGioacchino Del Regno wrote:
>>>> Add mediatek,mt8188-gce to the list of compatibles for which the
>>>> clock-names property is not required.
>>>
>>> Because, I assume, it has some internal clock? Why do either of these
>>> things have no clock? Doesn't the internal logic require one?
>>>
>>
>> Because there's no gce0/gce1 clock, there's only an infracfg_AO clock that is
>> for one GCE instance, hence there's no need to require clock-names.
> 
> clock-names, d'oh. I misread that completely yesterday.
> 
>> I can't remove the clock-names requirement from the older compatibles though,
>> because the (sorry about this word) driver (eh..) gets the clock by name for
>> the single GCE SoCs...
>>
>> ...and here comes a self-NACK for this commit, I have to fix the driver and
>> then stop requiring clock-names on all compatibles, instead of having this
>> ugly nonsense.
> 
> Is it not worth keeping the clock names, even if ugly or w/e, because
> things have been done that way for a while?

It's worth allowing clock-names, but *requiring* that is unnecessary because
there is, and there will always be, only one clock...!

> Also, what does U-Boot do on these systems to get the clocks?
> 

U-Boot doesn't support GCE at all (no driver - at least upstream)...!

>> Self-note: gce0/gce1 clocks lookup was implemented in the driver but never
>> used and never added to the binding - luckily.
>>
>> Sorry Conor, I just acknowledged that there's a better way of doing that.
>>
>> Thank you for making me re-read this stuff, I'll send the proper changes
>> later today, driver change + binding change in a separate series.
>>
>> As for the other two commits in this series, completely unrelated to GCE,
>> those are still fine, and are fixing dtbs_check warnings.



