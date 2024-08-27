Return-Path: <linux-kernel+bounces-303364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E22960B35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4569AB215EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5411BA87C;
	Tue, 27 Aug 2024 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="SA79Irt+"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548819D076
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763718; cv=none; b=e4z5jtUpBZq0lOwhYjtHnu7idbBv35UH3t0uRFuZDeAoj854tWHxJ0IxsG4G/lXlq9YiMlBCnrtAHEdGb5k1REVB6b3Aw6Mi5LFoalbR9BhpwC8ryTZQj3nXDbn8ALvBwDhhx1tBrL2rpgIsiq6ttNQ1h4KlawiFL9orLDrr1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763718; c=relaxed/simple;
	bh=t8u4tNyz7wHL5M/0SNVAJ8o4p/fLR/xY9fCwR/a9Usw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ9j+p1xLUmTLMiZtI2pj6YWTAgBKjLfYmwpkVewEL1F97HqN7RjwyaDjPcd97tdB0futrRyLwoHoWv8S6swehX8RjqHAjMQveGKVw/sQtm0Y44+PdSqCV9S2LLs1Ibl7f3A5sSjaGoE97aYjmjrWMF5l8rtHYjy5cVIYt4qkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=SA79Irt+; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724763707;
 bh=KZfENK1t3+yf0BK3gmf2/PNsiTAlFh2wSe1HI5OaUgY=;
 b=SA79Irt+xUmgatt/St6kq6eYTPLfl2YWu2miMJvMnoeO58Bbucu+RiziPbx65PC3HlkvJJCgu
 pGY/L2CAl07IQns4igfBfQ3bkBrmFC1G8K9Vv+DtdJY/8REEjxAH295BzNibxYYx4RxV1vi9MmL
 izaKWywy3DkgffdDzm0G6NnOJfX2mde+V8st6vz+y8KJSv5EDd0Pht41Fm+3cxW3kxZZ2OtNyGQ
 AUSwBtUJxC1xOgM7tx3gKBcerjX7gEqiqIlI4taOjly+1RGskyT8uIibUi/pgW0IMeTLWTcGAK0
 MEooJtNofL5bSxxQnxpHLdvVLMSCny46jYSFxMb+5sTQ==
Message-ID: b6c7513e-26c3-4f9d-bdb4-c4710bea5820@kwiboo.se
Date: Tue, 27 Aug 2024 15:01:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
To: Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240826205538.1066103-1-jonas@kwiboo.se>
 <66ccebeb.d40a0220.356790.58caSMTPIN_ADDED_BROKEN@mx.google.com>
 <b69e5a0a-acf9-412c-90b4-ebe00c7e07d4@kernel.org>
 <99731A50-58FA-4829-9785-339051E791B2@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <99731A50-58FA-4829-9785-339051E791B2@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66cdce388a3cb1214853bd7e

On 2024-08-27 13:44, Heiko Stuebner wrote:
> Am 27. August 2024 13:29:34 MESZ schrieb Jonas Karlman <jonas@kwiboo.se>:
>> Hi Krzysztof,
>>
>> On 2024-08-27 08:52, Krzysztof Kozlowski wrote:
>>> On 26/08/2024 22:55, Jonas Karlman wrote:
>>>> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
>>>> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
>>>> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
>>>>
>>>> Add devicetree binding documentation for the Hardkernel ODROID-M1S board.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> index f08e9f2f5dfc..9e29a5ecc94d 100644
>>>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> @@ -598,6 +598,11 @@ properties:
>>>>            - const: hardkernel,rk3568-odroid-m1
>>>>            - const: rockchip,rk3568
>>>>  
>>>> +      - description: Hardkernel Odroid M1S
>>>> +        items:
>>>> +          - const: hardkernel,rk3566-odroid-m1s
>>>
>>> hardkernel,odroid-m1s
>>>
>>> Why adding SoC name to the board? Can it be Odroid M1S with RK3568?
>>
>> No, the M1S (rk3566) is a variant of the M1 (rk3568) with less features
>> and the smaller SoC package, fully agree that hardkernel,odroid-m1s is
>> better, will use it in a v2.
>>
>> I mainly wanted to keep it consistent to other Hardkernel Odroid boards.
>> - hardkernel,rk3326-odroid-go2
>> - hardkernel,rk3326-odroid-go2-v11
>> - hardkernel,rk3326-odroid-go3
>> - rockchip,rk3568-odroid-m1 (hardkernel,rk3568-odroid-m1)
>>
>> If you agree to a vendor prefix change of rockchip,rk3568-odroid-m1,
>> maybe we can also drop the soc name from that compatible at the same
>> time? E.g. change it to hardkernel,odroid-m1.
> 
> I'd also agree with going with compatibles without the soc name in it. It is an ABI break but I think except the chrome devices no other board actually uses that part of the compatible ?

U-Boot and the FIT spec [1] does have a FIT_BEST_MATCH feature that use
the board compatible to find the best matching FIT configuration.
Guessing this is a feature of FIT that the chrome devices use.

I have recently learnt that the OpenWrt project use the board compatible
to validate if a system upgrade package/image can be applied to the
currently running system.

OpenWrt does not have an image/target for the ODROID-M1 (or other
Hardkernel boards), so this ABI breakage should not affect OpenWrt users.

I do not know of any other actual use of the board compatible.

[1] https://fitspec.osfw.foundation/#select-a-configuration-to-boot

Regards,
Jonas

> 
> 
>> Regards,
>> Jonas
>>
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 


