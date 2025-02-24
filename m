Return-Path: <linux-kernel+bounces-528727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA601A41B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E8F189397F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79624E4CA;
	Mon, 24 Feb 2025 10:42:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515F2441A3;
	Mon, 24 Feb 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393778; cv=none; b=Yxfp/ykivDaWbNclGDoMe99i97nIj9kTTuJwKyDsztBYQCswLZRtGABe8FEfcWWjcVVY374aku2I4rJNhKhAviz+0AMouTjMJFzH/vWMPcFsKJZYJrFyU+NxZS002tm89uzStaMwNgzIAFyt5sU4psQ2D4uhbpP42D2YWwwSMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393778; c=relaxed/simple;
	bh=4CO2H/3I+rDAR/lxC/JswNQslaWgSxVKeVHJwDE2nWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxGi2IPzlqiQ9rhkJER+iafe6guWoroaw8nqTsplD9vR93Zo8H+6mMup4qQ4qXu6sh6RXtOvN6ZGd5oVzqFF1jQEXEe4/7Hqe5quh/jJWvQpy2zWIxwxq7pCNeaIT+SRU+vgsRBrAug2784JjqfA9Iy/U9Uj4q97Vogi36gFWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14A231FCD;
	Mon, 24 Feb 2025 02:43:13 -0800 (PST)
Received: from [10.57.66.132] (unknown [10.57.66.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EE393F673;
	Mon, 24 Feb 2025 02:42:53 -0800 (PST)
Message-ID: <a61a762a-3606-4421-b1fb-c8f7b2923fea@arm.com>
Date: Mon, 24 Feb 2025 10:42:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/10] dt-bindings: arm: Add Rainier compatibility
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <20250221180349.1413089-5-vincenzo.frascino@arm.com>
 <Z7jMLCd4i_jtpAA5@J2N7QTR9R3.cambridge.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <Z7jMLCd4i_jtpAA5@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Mark,

On 21/02/2025 18:55, Mark Rutland wrote:
> On Fri, Feb 21, 2025 at 06:03:43PM +0000, Vincenzo Frascino wrote:
>> The Arm Morello System Development Platform uses Rainier CPUs.
>>
>> Add compatibility to Rainier.
> 
> Where's the TRM? Are there any known errata such that we might need to
> know the MIDR, etc?
> 

Please find the documents below:
- TRM [0]
- Erratum [1]

This series mainly focuses on basic DT functionalities, but I have plans to
continue with the enablement in future.

Thanks,
Vincenzo

[0] https://developer.arm.com/documentation/102278/latest/
[1] https://developer.arm.com/documentation/SDEN2275302/0000

> Mark.
> 
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
>> index 73dd73d2d4fa..2e666b2a4dcd 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>> @@ -177,6 +177,7 @@ properties:
>>        - arm,neoverse-v2
>>        - arm,neoverse-v3
>>        - arm,neoverse-v3ae
>> +      - arm,rainier
>>        - brcm,brahma-b15
>>        - brcm,brahma-b53
>>        - brcm,vulcan
>> -- 
>> 2.43.0
>>

-- 
Regards,
Vincenzo


