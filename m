Return-Path: <linux-kernel+bounces-392219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82759B9129
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA021F22E50
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27019E992;
	Fri,  1 Nov 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="lzfjqAC7"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D119CC04;
	Fri,  1 Nov 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464420; cv=none; b=RAWLl8/15ye28TSXOJuvSt+jzs+Sudfi/dfE1qsk1Ran8KsrVGLoVdpmQgf4WiFEmpXOcKImR/4dQKha76F9OPLuhjUq5N4bkMc5Kx22bo0qMd3t4hHoRxaSpzGXHBpEaLdfOCeL9wVBTt5oNuwE8sLG8dTWdCjP2aa+/glWhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464420; c=relaxed/simple;
	bh=tC+M1hH7fork9yJ4VGi51sWAlT5oGLZxXxBuaAYIzeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbgdSepYZgGu4ld7E3YYwpPwy2meBK/TnITWwv0GXfXGmvhDX99CDAw2dObzVkhw8m2mnFqJQgq9YLIKYwP5m8ziFt4tyP5b9p9fgFSk0oyEQby/5m/CJzPxG0siOnobHwGGn04KuvkykqCjiCEHXFqWv3x2jJ7bquAwXHa5s1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=lzfjqAC7; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 46C1A4346B;
	Fri,  1 Nov 2024 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1730464414; bh=tC+M1hH7fork9yJ4VGi51sWAlT5oGLZxXxBuaAYIzeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lzfjqAC7QS4yk5+91vpLtBSqpyvoMChGk5b35z7ZYw2NAAAgR6QBD5pL+D4TW/1+4
	 JuCBlvOktUM0YUHhICuYn7AgutVf6XCm2Mh2hOXzg1XY3Z7YspQ2r13G0mXlWVFnZ3
	 cNIueyOKLfTFxJotxw6emgqMMFcSDSVEe/3b26aMjH1f/kwfUcikAud7drvnh5dF5o
	 E9uqR9Rg/9hhU4bbQNEd6wvd8xcDW3Z3GtRHmJsnAhfCh/CevZSvaIeylXemsx6zOl
	 ccYNadlHn4cJE8d4jpgyELl4+1L4rhx7CkOSJe92Rp69IY8y39iU81LXSSVweQg1hc
	 6i/fZgl31e1dQ==
Message-ID: <5e0b5238-d781-458a-9285-df54a16232af@marcan.st>
Date: Fri, 1 Nov 2024 21:33:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH asahi-soc/dt 01/10] dt-bindings: arm: apple: apple,pmgr:
 Add A7-A11 compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241029010526.42052-1-towinchenmi@gmail.com>
 <20241029010526.42052-2-towinchenmi@gmail.com>
 <wpwa22u5z5hamvme7za7dqe7kjl5bap2a254w32yyqrohz235g@hk3izcckbdqn>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <wpwa22u5z5hamvme7za7dqe7kjl5bap2a254w32yyqrohz235g@hk3izcckbdqn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/10/29 16:41, Krzysztof Kozlowski wrote:
> On Tue, Oct 29, 2024 at 09:03:59AM +0800, Nick Chan wrote:
>> The blocks found on Apple A7-A11 SoCs are compatible with the existing
>> driver so add their per-SoC compatibles.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>> index 673277a7a224..5001f4d5a0dc 100644
>> --- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>> @@ -22,6 +22,11 @@ properties:
>>    compatible:
>>      items:
>>        - enum:
>> +          - apple,s5l8960x-pmgr
>> +          - apple,t7000-pmgr
>> +          - apple,s8000-pmgr
>> +          - apple,t8010-pmgr
>> +          - apple,t8015-pmgr
> 
> Assuming you keep the existing order of entries in this file, which is
> different than usually expected: alphanumeric.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Yeah, it's a bit ad-hoc but essentially "by release date" with a fork at
t6000. So:

- First the ancient s5l series
- Then all the t/sXXXX chips up to t8103 (M1) (numeric order, ignoring
prefix letter)
- Then the rest of the "baseline" Ax,Mx chips that continue after M1,
which are all numbered t8xxx (numeric order)
- Finally the t6xxx series (Mx Pro/Mx Max), which forks the timeline and
numbering after t8103/M1 (M1 Pro = t6000).

Unless there's significant objection I'd like to keep this pattern, it
makes sense from the POV of people working on these chips.

- Hector


