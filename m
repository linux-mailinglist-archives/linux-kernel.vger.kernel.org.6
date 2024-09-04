Return-Path: <linux-kernel+bounces-314986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6896BBEB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CD6B2D202
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C241D7999;
	Wed,  4 Sep 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="QLv7ABS+"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CA1D04B8;
	Wed,  4 Sep 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452004; cv=none; b=O0xEaDT3zugIF0iVv4pyZX37J/n8R3/PWb67Bwi2ZfUTfsXcLL+CU8o7SuSz2NW0MXyWasUjhFalV4EXa+O2yMSTywlmp9c7DEQ+IvneMoWjVY/kToQerlM2FlrSIfDvwT69w5Ziymy/Wfj8/Yu+f49Hla1fM3LUvq8CQS9s/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452004; c=relaxed/simple;
	bh=C11HCu5mtryKsu8C9faHMCSo+KyXN+MYZk0e6IQdrn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=S4/qjySn7h5yjWN0s6HxU9EQDvU4225HUuvmDUJto+mF88qY4pRflSR1S2ElkfYA+3AF5qjJj1GJY1VC9hqm52FfAW06Vr4O4RGGImhOdXsr9Bz5GSDBmpLKsmvUVKbCcO2OWSKjvjDaf6Y3dHpisy3l66OFIztVzYUtN838LyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=QLv7ABS+; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 8841D789DF;
	Wed,  4 Sep 2024 20:13:17 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 8841D789DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725451998;
	bh=Vm1m87bDBl/nK+yI9aANRki1TovLXqNDyh/ugIwEEqg=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=QLv7ABS+UJFGUiOqbubTLaLLzujkcYA8E7NhYmtham0E6VbeZo68QgBkn64zh0N2t
	 9atU1LzoG1fWfgTpspwTy2mNF62jGSMmt+nslLTprY5DkjBiKA/hp/U605JZGNzMMp
	 pCXiCY26LgogHZCu1C+cjjlAe49i7UVAU+JPG7t0=
Message-ID: <2ec7de72-8560-430c-a6b6-5ef7ad5f5e00@classfun.cn>
Date: Wed, 4 Sep 2024 20:14:26 +0800
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
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <b9e5389f-8492-425e-bc15-35ea55c0e3b5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/4 19:35, Krzysztof Kozlowski wrote:
> On 04/09/2024 13:14, Junhao Xie wrote:
>> Add an entry for Shanghai Novotech Ariaboard (https://ariaboard.com/)
>>
>> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index a70ce43b3dc0..58d1a2e8b212 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -145,6 +145,8 @@ patternProperties:
>>      description: Arctic Sand
>>    "^arcx,.*":
>>      description: arcx Inc. / Archronix Inc.
>> +  "^ariaboard,.*":
>> +    description: Shanghai Novotech Co., Ltd.
> 
> This is confusing. Prefix is entirely different than company name. I
> would expect prefix like shanghainovotech.
> 
> Best regards,
> Krzysztof
> 

Thank you for your reply.
Ariaboard is a subsidiary of Shanghai Novotech, maybe it would
be better to change description to "Ariaboard"?

Shanghai Novotech: https://shanghainovotech.com/
Ariaboard: https://ariaboard.com/

Best regards,
Junhao

