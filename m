Return-Path: <linux-kernel+bounces-551485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F0A56D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6ED17B8DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4F22170A;
	Fri,  7 Mar 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="j+HbEQvu"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399C2206AF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363349; cv=none; b=KG2QyzwP1b8vz5V0jLv25VABo81M8QVE9mXbNCYvXBOGQqnppf9BLQUGfZDySUVOFHUmoNizugHBhroRy/vcdO3HpcT1GMC99K4NhFMxNJxemWle14ToKhDdWehtJfp4jhIDNSdwQYRUbxSXFHSotN7HvoQKOCWPL+tbtm8w+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363349; c=relaxed/simple;
	bh=pl0XdGNLYz9x5NdFwUSgV/y76o1nKr6GfSx+T2FWcDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0lD+F/kirID8AqMA8mxSEVMDc/0vx8X7/VWiJfv51q628clRRqvq6HXYMXFkc6YThSQe/6qxcAPXqeQtqs8yyf2CNqNAN05I1vVxMblpgqD3vkvftv+cGhBoMcIbx+MHP1xBXyMLeOc/SjGQZ7G8oGfGDxH5SVdeffzEmPcMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=j+HbEQvu; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741363341;
 bh=aCrPvOluCec+vwfJ2dRCW1m+hFa1hc7eEdH3qmC/0uk=;
 b=j+HbEQvud+Q+Ni8rf3aqaCex6yPxhR3oNiwAV2Xh2hswFyFZEtMzz0sVvwx+zqIRf1qKcMZN8
 eTlIBzAmxbQ7dEYiy1Pno5jGiUYMc4FS5FxCLaZBZ4GvRvrorF6p5j5ZG5azyY1LZqh4tHfjdbl
 MfBGIX/0j1qvV3MRfUdkZnljnBxsKJST8U9P0o96EPXGoDY98mSr0qNdOsQTlzKzxplhtmRGOwh
 AT/tydxh7Zy0rtFkKlIEEXGZ/zsIm+QRPxVvoNvWCvPbmeypcosnt8GXC3nwPo5vgTfg6NHDXDb
 Iio+sFREMHPOFQYB8Lgovc48riHl6J3D60/ngQPLqqZw==
X-Forward-Email-ID: 67cb18782ea74034f8b964f0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <de2fb6c6-b053-4be9-8c44-2476c5eb26a6@kwiboo.se>
Date: Fri, 7 Mar 2025 17:01:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: net: rockchip-dwmac: Add compatible
 string for RK3528
To: Conor Dooley <conor@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wu <david.wu@rock-chips.com>,
 Yao Zi <ziyao@disroot.org>, linux-rockchip@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-2-jonas@kwiboo.se>
 <20250307-tipping-womanlike-a1ce2370d8d3@spud>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250307-tipping-womanlike-a1ce2370d8d3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 2025-03-07 16:42, Conor Dooley wrote:
> On Thu, Mar 06, 2025 at 10:13:54PM +0000, Jonas Karlman wrote:
>> Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
>> Ethernet QoS IP.
>>
>> Add compatible string for the RK3528 variant.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> I was not able to restrict the minItems change to only apply to the new
>> compatible, please advise on how to properly restrict the minItems
>> change if needed.
> 
> What do you mean by that? As in, what did you try and did not work?
> Usually you do something like
> if:
>   not:
>     compatible:
>       contains:
>         rockchip,rk3528-gmac
> then:
>   properties:
>     clocks:
>       minItems: 5
> 

Thanks, this seem to work, will use in a v2.

I tried to do something opposite and instead set minItems: 4 when
compatible contains rockchip,rk3528-gmac:

if:
  compatible:
    contains:
      rockchip,rk3528-gmac
then:
  properties:
    clocks:
      minItems: 4

but that resulted in something like:

  rockchip/rk3528-radxa-e20c.dtb: ethernet@ffbe0000: clocks: [[7, 173], [7, 172], [7, 171], [7, 170]] is too short

Regards,
Jonas

>>
>> Also, because snps,dwmac-4.20a is already listed in snps,dwmac.yaml
>> adding the rockchip,rk3528-gmac compatible did not seem necessary.
>> ---
>>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> index 05a5605f1b51..3c25b49bd78e 100644
>> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> @@ -24,6 +24,7 @@ select:
>>            - rockchip,rk3366-gmac
>>            - rockchip,rk3368-gmac
>>            - rockchip,rk3399-gmac
>> +          - rockchip,rk3528-gmac
>>            - rockchip,rk3568-gmac
>>            - rockchip,rk3576-gmac
>>            - rockchip,rk3588-gmac
>> @@ -49,6 +50,7 @@ properties:
>>                - rockchip,rv1108-gmac
>>        - items:
>>            - enum:
>> +              - rockchip,rk3528-gmac
>>                - rockchip,rk3568-gmac
>>                - rockchip,rk3576-gmac
>>                - rockchip,rk3588-gmac
>> @@ -56,7 +58,7 @@ properties:
>>            - const: snps,dwmac-4.20a
>>  
>>    clocks:
>> -    minItems: 5
>> +    minItems: 4
>>      maxItems: 8
>>  
>>    clock-names:
>> -- 
>> 2.48.1
>>


