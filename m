Return-Path: <linux-kernel+bounces-303180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC59608B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884A528381B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57819F467;
	Tue, 27 Aug 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HZhfn8Zh"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [164.92.70.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB00E1A0717
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.92.70.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758189; cv=none; b=HwVykd+1+z59Tlf3ek1PC/sEJCZKc7z2qjjfRGXqDt1BG/XdBpuwBVFmm23wbYOmJ8KvkiubWYw/sw1spSmJm3biigGl349bfA8cP1+iZh7Ig0ztJ3d0HEhMu+wpzqSgxEb45eIMBPVJpr6rcMUlZg7/AmVjBTvjSVIsFUsD7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758189; c=relaxed/simple;
	bh=jVubUo4oWTPVIjpMQG9xOItjx9kQJh+7YT/BPKlBiY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc/4sTtiPHxfzcedIO6SPkAj3Hh0KfpHHogbaTpuMge9jaE2S3MNHjfV+HSRFBkLw/CImg/+ZjMUf/HzWbnpreCIeOYvMdM3eH/h0YlIv1kOAceinj7V+tRgbeI6qF2g/ipJfcIiY2zLhlBe3izIBcSy3JgAa9a0KngSs2FMZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HZhfn8Zh; arc=none smtp.client-ip=164.92.70.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724758181;
 bh=oz/rd4e08jz+p+5PwAy+8XVahhTtzgw1n8icFlOoc84=;
 b=HZhfn8Zh+Fcol542UqY23Mzj3a2wieHtcSJ1wL/6gk5ooOjSpfeWU9UER8wDObRjJJfHGMiii
 YLAO7WEylhlEYKaCZB3a2hnWZupXBq6HY3/nkFgEbTGWXLpzPhJGLWvxtgrodEGyrL3nk95W9oS
 kvbQkeEwCcoBpjrRqFfloU9iQJmxK7UkoIeJsU4ZossLdheANSH7TrbQGWNG0kr/Ro4rD3qIi2s
 gPYB1Kzf43AZccR3zzXKqIpcQzPeDHFp9fRfwyC99pLhG8N5egD03GLj1HH7V41zscLzbjbRRHm
 x9voG4/xfjEo+GcqJ/wLD0EJkyyc6PNP15ZP/Fg+Sg4g==
Message-ID: 1ec02fa5-4b11-424b-a595-c715b62d105e@kwiboo.se
Date: Tue, 27 Aug 2024 13:29:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
To: Krzysztof Kozlowski <krzk@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240826205538.1066103-1-jonas@kwiboo.se>
 <66ccebeb.d40a0220.356790.58caSMTPIN_ADDED_BROKEN@mx.google.com>
 <b69e5a0a-acf9-412c-90b4-ebe00c7e07d4@kernel.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b69e5a0a-acf9-412c-90b4-ebe00c7e07d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 164.92.70.200
X-ForwardEmail-ID: 66cdb8a4c498660ae9674ece

Hi Krzysztof,

On 2024-08-27 08:52, Krzysztof Kozlowski wrote:
> On 26/08/2024 22:55, Jonas Karlman wrote:
>> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
>> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
>> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
>>
>> Add devicetree binding documentation for the Hardkernel ODROID-M1S board.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index f08e9f2f5dfc..9e29a5ecc94d 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -598,6 +598,11 @@ properties:
>>            - const: hardkernel,rk3568-odroid-m1
>>            - const: rockchip,rk3568
>>  
>> +      - description: Hardkernel Odroid M1S
>> +        items:
>> +          - const: hardkernel,rk3566-odroid-m1s
> 
> hardkernel,odroid-m1s
> 
> Why adding SoC name to the board? Can it be Odroid M1S with RK3568?

No, the M1S (rk3566) is a variant of the M1 (rk3568) with less features
and the smaller SoC package, fully agree that hardkernel,odroid-m1s is
better, will use it in a v2.

I mainly wanted to keep it consistent to other Hardkernel Odroid boards.
- hardkernel,rk3326-odroid-go2
- hardkernel,rk3326-odroid-go2-v11
- hardkernel,rk3326-odroid-go3
- rockchip,rk3568-odroid-m1 (hardkernel,rk3568-odroid-m1)

If you agree to a vendor prefix change of rockchip,rk3568-odroid-m1,
maybe we can also drop the soc name from that compatible at the same
time? E.g. change it to hardkernel,odroid-m1.

Regards,
Jonas

> 
> 
> Best regards,
> Krzysztof
> 


