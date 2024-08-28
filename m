Return-Path: <linux-kernel+bounces-304661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF6962356
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89B41C2167E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F105161914;
	Wed, 28 Aug 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="l2gyZteW"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB315B10C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837090; cv=none; b=Nr5O5fRTaMRkp7iywxWqfJ4cUcnqdVU5VZC/t5SmVrc8YgPeeS/DSgSZR5JafI+DmJmDb4cV+M+9K2KXA36BCY9Xy2kOb5APbprqQfdBzsO5isjtsDupxHaUWNUIlfdZvn89yxAnV2e1Jm4YPqIZuh4akcyQVOk8nvDnrro6kRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837090; c=relaxed/simple;
	bh=jxYnIslH6HYkg4T0/mYqNw1DQIwt8CU5u74tlXFV1aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIcD9Guc2mZiT6UrrYb2z3WdCG0fQiNppU1uhANZwmUw+u34dD7bTUwnDc2c1wITAcQquhiZJHYh5w+kFgywUCgTQBU8jGWQ4FQFKcQiKHkCUsRtVeyjVw4vO5GyfdKMFp1nSvCTsbzSpYWTMs9o7nk/P65riRtqev7v3bGdXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=l2gyZteW; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id jEX7sJlpgg2lzjEtTssxs9; Wed, 28 Aug 2024 09:23:12 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id jEtRsKWpiZlJQjEtSsz5Y0; Wed, 28 Aug 2024 09:23:11 +0000
X-Authority-Analysis: v=2.4 cv=DMBE4DNb c=1 sm=1 tr=0 ts=66ceec7f
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8
 a=M-OHScM7UXdo8wPXp2IA:9 a=QEXdDO2ut3YA:10 a=rsP06fVo5MYu2ilr0aT5:22
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7MLyh0ZMj/waRkEMqu5NvgdgV0+LWDWuoIenoixpKGw=; b=l2gyZteWv7EYdzX/4or9dLknID
	RGoc9pGyxup2y0WQL0LOCFxAwDcJT6z145RenV3kVY4TT9/cXoQYHu4TztYLqo6wpoFfv8HiLOh2h
	B9bqQoAhbyQWcjwmfIGTfHakVJFKSPNUut76T9i6QxRkPK2ARorZWRyvxrEe0PLSHsCw94eB7Fdbi
	GXdbT0sIeBapRRyJYFn6j+ObD/Yoih/cXdwPJ9A2PQRzngGoczHALepITGf7opJ2MKYTipvdoFJdK
	e6r6STKaBCZWBFCODAblZJAasuSlQ8IdxiDcmm+wlvKRMnUBDH02HARr32cKNXTaKFbUo6OxTEQdb
	gzwgc8BQ==;
Received: from [122.165.245.213] (port=38254 helo=[192.168.1.106])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1sjEtM-002IZN-1L;
	Wed, 28 Aug 2024 14:53:04 +0530
Message-ID: <207109b6-0b07-45dd-8143-f6e07cc427d8@linumiz.com>
Date: Wed, 28 Aug 2024 14:53:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] dt-bindings: arm: rockchip: Add Relfor Saib
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20240823153528.3863993-1-karthikeyan@linumiz.com>
 <20240823153528.3863993-8-karthikeyan@linumiz.com>
 <20240823-lark-regime-0d3ab4215d69@spud>
 <a5d4f421-5120-4421-944e-d39d67e482bb@linumiz.com>
 <9537c866-cddc-4958-86a8-d097982067cd@kernel.org>
Content-Language: en-US
From: karthikeyan <karthikeyan@linumiz.com>
In-Reply-To: <9537c866-cddc-4958-86a8-d097982067cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1sjEtM-002IZN-1L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.106]) [122.165.245.213]:38254
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 4
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGH3vvd7jo0hHxWAlDsG9glH1K6JuvElt3uLauyifgaTsCQxWI6NmOzXR9JRYGSFdGsiEvCKRN2gh8N7lB0g3xhHp9twyzJjSB7VXLceO/CYpEJDrPl9
 cBx/tHPtZutCURL9IM8+7osmmWlC6DBOP9w0lUC3lVs5ZEOvn43yr3QiHte2iU3dsUPtQ9q/Oq32gJ9urlWF7ngCSTsa+becuVnw8OFfFgXPc1d2v1podQYh



On 8/26/24 14:03, Krzysztof Kozlowski wrote:
> On 24/08/2024 14:48, karthikeyan wrote:
>> On 8/23/24 21:51, Conor Dooley wrote:
>>> On Fri, Aug 23, 2024 at 09:05:27PM +0530, Karthikeyan Krishnasamy wrote:
>>>> Add devicetree binding documentation for Relfor Saib
>>>> board which uses Rockchip RV1109 SoC
>>>>
>>>> Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> index 1ef09fbfdfaf..29f7e09ae443 100644
>>>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>>> @@ -848,6 +848,12 @@ properties:
>>>>                  - radxa,zero-3w
>>>>              - const: rockchip,rk3566
>>>>    
>>>> +      - description: Relfor SAIB board
>>>> +        items:
>>>> +          - const: relfor,saib
>>>> +          - enum:
>>>> +              - rockchip,rv1109
>>>
>>> This does not make sense to me. Why do you have an enum for the SoC
>>> model, implying that this SAIB board would have more than one possible
>>> SoC? I'd expect to see - const: rockvhip,rv1109
>>>
>> There is an upcoming version of SAIB board based on Rockchip RV1103.
> 
> Still wrong form multiple points of view:
> 1. Not logical, we never expect such entry in top level bindings,
> 2. Same board or different? If same, how is it possible to have two
> different SoCs (not modules!) in the same board? These are different
> boards. Or maybe this uses some SoM, but your commit msg explained
> nothing about this.
> 
> You have entire commit msg to explain the hardware. Use it, so you don't
> get such questions.
> 
> The code above: NAK
It's my mistake, previously my understanding about this binding was 
wrong. I will change it in v2 patch.>
> Best regards,
> Krzysztof
> 
Thanks,
Karthikeyan

