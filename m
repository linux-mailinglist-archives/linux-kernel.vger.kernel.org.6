Return-Path: <linux-kernel+bounces-344342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB9598A880
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9718B1C2203D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D416199E82;
	Mon, 30 Sep 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="KDX/juuT"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF61990D8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710151; cv=none; b=jSUuqGFyQ4FwkXiD3QivF0DAwJaTcMXaaPhLPqmDnS2vax29VAmdIvg14vYl/IHg22lPXHn0MKnKmjnBhXnOzv75O5dkQRbVSPM4eNQFiWav1GjF4de1M2JJAXA3nzvPe6ubIQa+dDbEz/fAlX2T1sxjCmDE3icqncOE/2c/Esw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710151; c=relaxed/simple;
	bh=c4wR8tcH9RdAEoe2+47MbswBVdNokOoEY8naXrFqhiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssyG8a/rQPoKFdLcgr4FH05OV+dIPD42CnU0Aw32moNu+L3BgMth0nnGyS9UK8pwZo4+2OI5krgtvnEijgQjlW8ZUnOdOtkgZ/WE3oRvqyLhKgdPNHLi1BptsV/Wo/J5uk5DaWFD5zUDnRyzcz4a9CP/JYNKC/vjUFa8sgYjjwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=KDX/juuT; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727710124;
 bh=oySoeZXgklnZqRgl9rNvs2Vy1xJO0hdqK2BVTQwjHjk=;
 b=KDX/juuTwun4bp98WIV9bM+WjCrXK9QFl5f1ZlTIh2X6XLMnK6iT4JMctEu2gVIn5XOyXLYkC
 3Ar4MEr/20yYClvL7OibkbXfmnBxLFW9NtePnhY0ws4GQBd/5z4vUzDA688Q6HE/uTzs/cY+V8I
 d3f1F0qubs6zO7CROViw4nMd+00FZx8leHdN3qVHPMuQEXdFsosAsSCJMydaS5uORjr7zGKXKWF
 O+83HBps7FlUgPZA65OCcSdaEXvjsorv0Mn8t8LBCRPCG9qaxuMFzMBUn9ksT3MNysuqbbOYix/
 8APluXmWwHtUXiI01Yn7mirAjxELBDS4UUKPn8ILOYgw==
Message-ID: <3acf37cf-321e-4a03-a989-aff03fdec137@kwiboo.se>
Date: Mon, 30 Sep 2024 17:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] media: dt-bindings: rockchip,vdec: Add RK3288
 compatible
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alex Bee <knaerzche@gmail.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231105233630.3927502-1-jonas@kwiboo.se>
 <20231105233630.3927502-7-jonas@kwiboo.se> <3342168.44csPzL39Z@diego>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3342168.44csPzL39Z@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66fac3a9961bc87980ba467d

Hi Heiko,

On 2024-09-30 16:46, Heiko Stübner wrote:
> Hi Jonas,
> 
> Am Montag, 6. November 2023, 00:36:13 CEST schrieb Jonas Karlman:
>> Add a RK3288 compatible for a version of the Rockchip VDEC IP that only
>> support HEVC decoding.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> While looking for something else in my inbox, I stumbled upon this series.
> Looking at 6.12-rc1, it seems the rk3288 parts at least didn't make it in
> yet, so I guess I a rebase+resend might be in order?

Yes, this needs to be updated and resent, this series should still apply
clean on top of the dependent h264 high10 v6 series [1], however there
was some minor feedback to address in this series. Hoping to see some
progress on the h264 high10 v6 series and send an updated v2 of this
hevc series in near future.

Also trying to finish up a FFmpeg v4l2request hwaccel v3 series before I
take a closer look at a v2 of this rkvdec hevc series.

[1] https://lore.kernel.org/linux-media/20240909192522.1076704-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> 
> Heiko
> 
>> ---
>>  Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
>> index 08b02ec16755..0f00e9c86737 100644
>> --- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
>> +++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
>> @@ -16,7 +16,9 @@ description: |-
>>  properties:
>>    compatible:
>>      oneOf:
>> -      - const: rockchip,rk3399-vdec
>> +      - enum:
>> +          - rockchip,rk3288-vdec
>> +          - rockchip,rk3399-vdec
>>        - items:
>>            - enum:
>>                - rockchip,rk3228-vdec
>>
> 
> 
> 
> 


