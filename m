Return-Path: <linux-kernel+bounces-316359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35396CE6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CD31F26BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DF158DC0;
	Thu,  5 Sep 2024 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="EfpRhp3Z"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A41552E0;
	Thu,  5 Sep 2024 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513682; cv=none; b=ofnAYXo5lyDcBYbIRTuNABCbwnipFEO0R/+QG5EIMTjaIWaA1RsuknT2LHq/HPSWOXdWWDZyIv4JaS2SDtedze4NkfT6hoUv+NwJ+XyoVXts0M3vMXh+RwCZkkOtIIjR0BeaJ1UCJv77xTPn2GDKcpbwsB/twOVB4FFcXf/YV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513682; c=relaxed/simple;
	bh=hlbfEgNRL28i9iLyVD7nqjPpldk3T8Ec2Tg/wrgpM2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=CE566TL0NPwv5i3o8OZmrVsECLSOavvIvYPzjndc7IVZ5ZzsQxq7QrAO0xi9xiiUAIBTWjcYdUaioSSwZyxIoAFDrkR3f8SewcNnQ9xcZjXAWrDwoBw6dCEypp3bGi4DLMONHR+LySDHzDygWJMFv1vt1Glaq2tKRjY+1AABhrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=EfpRhp3Z; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 68BA078946;
	Thu,  5 Sep 2024 13:21:03 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 68BA078946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725513664;
	bh=XXl1draoGyvH7yc3+jRqYw4sfe41HP36QMPNaMT42X8=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=EfpRhp3ZjiidifZR47wrTs788mQM7P1zUbcLsfxGyk+CCaiIfGTYDkev/WmxUifX7
	 YB2DNSmyJdIYCllr4Mag9eHLZikDPg475QnyRiOVbby+Hgs2MEW7cyXJepovCtAj1C
	 7bwyx08s7kBywcTUWWyKyS7+SUWkFwCtZv8Ue6LE=
Message-ID: <38d476f2-20ba-4aea-99e3-9a2e266844e0@classfun.cn>
Date: Thu, 5 Sep 2024 13:22:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Shanghai Novotech
 Ariaboard
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
 <20240904111456.87089-2-bigfoot@classfun.cn>
 <b9e5389f-8492-425e-bc15-35ea55c0e3b5@kernel.org>
 <2ec7de72-8560-430c-a6b6-5ef7ad5f5e00@classfun.cn>
 <c2390181-d736-4691-9bb1-0383c506bb1b@kernel.org>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <c2390181-d736-4691-9bb1-0383c506bb1b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/4 21:29, Krzysztof Kozlowski wrote:
> On 04/09/2024 14:14, Junhao Xie wrote:
>> On 2024/9/4 19:35, Krzysztof Kozlowski wrote:
>>> On 04/09/2024 13:14, Junhao Xie wrote:
>>>> Add an entry for Shanghai Novotech Ariaboard (https://ariaboard.com/)
>>>>
>>>> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
>>>> ---
>>>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> index a70ce43b3dc0..58d1a2e8b212 100644
>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> @@ -145,6 +145,8 @@ patternProperties:
>>>>      description: Arctic Sand
>>>>    "^arcx,.*":
>>>>      description: arcx Inc. / Archronix Inc.
>>>> +  "^ariaboard,.*":
>>>> +    description: Shanghai Novotech Co., Ltd.
>>>
>>> This is confusing. Prefix is entirely different than company name. I
>>> would expect prefix like shanghainovotech.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Thank you for your reply.
>> Ariaboard is a subsidiary of Shanghai Novotech, maybe it would
>> be better to change description to "Ariaboard"?
>>
>> Shanghai Novotech: https://shanghainovotech.com/
>> Ariaboard: https://ariaboard.com/
> 
> This does not sound like subsidiary but just name of the board family or
> product family. Their about page suggests "affiliation" but all contact
> points are for Shanghai Novotech.
> 
> I am fine with ariaboard prefix, but please provide context in commit msg.
> 

Thanks, I will add it to commit message in PATCH v2.

Best regards,
Junhao

