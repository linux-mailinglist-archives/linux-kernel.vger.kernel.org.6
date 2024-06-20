Return-Path: <linux-kernel+bounces-222204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438AE90FE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E69B20ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C25D8F0;
	Thu, 20 Jun 2024 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qpwJiuz/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E72139D7;
	Thu, 20 Jun 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870486; cv=none; b=GU86acoEW7SnZoPwaWxxOSaXwxPvOUaBrJs22iuJilsSZyUBZCqe9Ms7xLvu0J7cNyXJ5h5jtupAJll/cmu7BqCX9p3fEX0rtLWMgp8/iDhCG+sswN3i4n+4EgNkU26fp4SDVHsiNQVUObdT+GiaR8A6QcQVXIa/pt5dPJUx2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870486; c=relaxed/simple;
	bh=rhuKihUusm13Yt7WZRiQrggV9auR48Id+tI+3iKMR6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnzXHNnmn0hKWv8+IVle+pT3GgpVim/lACjHA63tcCYwk8LNPWJPxcCMJdEtdUNAGracx/3Z7fcKI4w4spSdv3XWhQsas6yoLMI7mRXV8Tl0lT0/P3OYuPkuG3jShdzrRu5MuoCdpao60rfQgTJFijEaERm0DwDTOSqDtAg8/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qpwJiuz/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718870479;
	bh=rhuKihUusm13Yt7WZRiQrggV9auR48Id+tI+3iKMR6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qpwJiuz/3GUiDh+pyl66iIMgpVTGYlwqM9wSwUBdC62zYV+8VAl8jBpqo0E2mtKzF
	 7LPTXRg4+sYEfo9htAyqEBkO5gGcNXkMhbzs3eomwlMgcmHVd/f1cbnErEhtcDGn0G
	 2/WEAw6ORtAQOA0LweJJTuXL+MN0B573w9mffSpZBEuRs1CcMqf0tGbpzw57rvfIbS
	 9hqIdTEsowLJcDmv4aIUGCxSIKA20NxlBXDEbO9zrmbPwHRfjOtkYrWgufbMGIxF2t
	 H1vRGdfpFu12Uu7wdUHCNHBQOSJMcIxyZfY0VS2ZcsTEv6XJgkffk44pX1cjzzkduy
	 SYD7/xmI1/d5w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B8B6D378205D;
	Thu, 20 Jun 2024 08:01:18 +0000 (UTC)
Message-ID: <a7317981-8690-4d45-81b6-cc6a63c459e0@collabora.com>
Date: Thu, 20 Jun 2024 10:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: mailbox: mediatek: Avoid clock-names on
 MT8188 GCE
To: Conor Dooley <conor@kernel.org>
Cc: krzk+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 jassisinghbrar@gmail.com, garmin.chang@mediatek.com,
 houlong.wei@mediatek.com, Jason-ch.Chen@mediatek.com, amergnat@baylibre.com,
 Elvis.Wang@mediatek.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
 <20240619085322.66716-3-angelogioacchino.delregno@collabora.com>
 <20240619-sleeve-citable-a3dc10e5cd4f@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240619-sleeve-citable-a3dc10e5cd4f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/06/24 19:49, Conor Dooley ha scritto:
> On Wed, Jun 19, 2024 at 10:53:22AM +0200, AngeloGioacchino Del Regno wrote:
>> Add mediatek,mt8188-gce to the list of compatibles for which the
>> clock-names property is not required.
> 
> Because, I assume, it has some internal clock? Why do either of these
> things have no clock? Doesn't the internal logic require one?
> 

Because there's no gce0/gce1 clock, there's only an infracfg_AO clock that is
for one GCE instance, hence there's no need to require clock-names.

I can't remove the clock-names requirement from the older compatibles though,
because the (sorry about this word) driver (eh..) gets the clock by name for
the single GCE SoCs...

...and here comes a self-NACK for this commit, I have to fix the driver and
then stop requiring clock-names on all compatibles, instead of having this
ugly nonsense.

Self-note: gce0/gce1 clocks lookup was implemented in the driver but never
used and never added to the binding - luckily.

Sorry Conor, I just acknowledged that there's a better way of doing that.

Thank you for making me re-read this stuff, I'll send the proper changes
later today, driver change + binding change in a separate series.

As for the other two commits in this series, completely unrelated to GCE,
those are still fine, and are fixing dtbs_check warnings.

Cheers,
Angelo

>>
>> Fixes: f2b53c295620 ("dt-bindings: mailbox: mediatek,gce-mailbox: add mt8188 compatible name")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml     | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>> index cef9d7601398..55d4c34aa4b4 100644
>> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>> @@ -62,7 +62,9 @@ allOf:
>>           properties:
>>             compatible:
>>               contains:
>> -              const: mediatek,mt8195-gce
>> +              enum:
>> +                - mediatek,mt8188-gce
>> +                - mediatek,mt8195-gce
>>       then:
>>         required:
>>           - clock-names
>> -- 
>> 2.45.2
>>


