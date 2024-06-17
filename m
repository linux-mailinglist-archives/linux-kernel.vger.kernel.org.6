Return-Path: <linux-kernel+bounces-216905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552EA90A851
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EB81C25152
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD62190466;
	Mon, 17 Jun 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="isu0i9O1"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F10190464;
	Mon, 17 Jun 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612521; cv=none; b=cgtrzs3CtyrkuclhV0QPGECzLNchF5Jeeu7nk0aH4sGkS68XyD4A5Ot3sgf1vR+mkzlXt2bVecTvfalImlA5rYmDA1Zg/76yzNJ9gS0eTR3cGfRb0798+cN2gOmzq5adik7qgxSL6eHMCV7H/IwAS+2nTaUNYycHF70+49RJRbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612521; c=relaxed/simple;
	bh=m7ezWA4EapccuJHFsnN/X8zAkfEKsVddEeDHIkp3DSs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=haJxkvyFnt8gci44TNyeKlgh9WBWT1AqXb+wWfZxZC2RfARmxVs/467iuTXqIKA/w9No75i9aLdY8wjCJQVN5lNpU8xbmKHgdTuXi3qto1hgtlUTUAIDeudbfTTwa+0T7q14FBWxTYfTZ9gNF0yD//x2U9qQ1/rZdiHl0DWZSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=isu0i9O1; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A7506A800;
	Mon, 17 Jun 2024 11:21:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1718612506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=BwuhUxOR0latqkY8rTzfYsXbbsUhulcTI88pJ+A5+2s=;
	b=isu0i9O1jaU5xq9RCrKEsKPD1NzFaKbYiNezBKRHU5mUrOpvjpGUI38yeACbwzr3hRQVQ2
	VTAQlxBYCsX2QBr0JDt3v8nKXd/7JSBDAMGM6UsrXDRi7zOZnufnzHVfCoxGbgh83FvvsQ
	jEwFynmgv0WVwcqn+4XOjRo3wl9PgE+SUshbjn+Hx3ZGVSYCjscqvCB8A0baN2Eb5mnVBU
	i5HL0kVHyHNLe3PLGdMAZ0wk91S18aIxdPMDzJgLqP29qrfdkWTDreY5lLaTRu/F0stglH
	yE+uW8cuhVG/daFy67r7EMx+HiA/pFyf0xSLc65XGEyAPQI5HuITKREkNxyRYQ==
Message-ID: <c0d18fef-be65-461e-948f-c25e757199a5@lexina.in>
Date: Mon, 17 Jun 2024 11:21:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Viacheslav <adeep@lexina.in>
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: amlogic:
 amlogic,meson-gx-ao-secure: add secure-monitor property
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240610084032.3096614-1-adeep@lexina.in>
 <20240610084032.3096614-4-adeep@lexina.in>
 <20240610-dropout-compress-6d6a9b749524@spud>
 <4866f6d4-2e3c-40c7-a8cb-ba4e422ffef6@lexina.in>
 <20240611-undying-earthy-00236ac251aa@spud>
 <20240613164244.GA1999034-robh@kernel.org>
Content-Language: ru, en-US
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20240613164244.GA1999034-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Thanks for review.

13/06/2024 19.42, Rob Herring wrote:
> On Tue, Jun 11, 2024 at 07:07:28PM +0100, Conor Dooley wrote:
>> On Tue, Jun 11, 2024 at 01:25:11PM +0300, Viacheslav wrote:
>>> Hi!
>>>
>>> 10/06/2024 19.08, Conor Dooley wrote:
>>>> On Mon, Jun 10, 2024 at 11:39:49AM +0300, Viacheslav Bocharov wrote:
>>>>> Add secure-monitor property to schema for meson-gx-socinfo-sm driver.
>>>>
>>>> "bindings are for hardware, not drivers". Why purpose does the "secure
>>>> monitor" serve that the secure firmware needs a reference to it?
>>>
>>> This driver is an extension to the meson-gx-socinfo driver: it supplements
>>> information obtained from the register with information from the
>>> SM_GET_CHIP_ID secure monitor call. Due to the specifics of the module
>>> loading order, we cannot do away with meson-gx-socinfo, as it is used for
>>> platform identification in some drivers. Therefore, the extended information
>>> is formatted as a separate driver, which is loaded after the secure-monitor
>>> driver.
>>
>> Please stop talking about drivers, this is a binding which is about
>> hardware. Please provide, in your next version, a commit message that
>> justifies adding this property without talking about driver probing
>> order etc, and instead focuses on what service the "secure monitor"
>> provides etc.
> 
> To put it another way, how many secure monitors does 1 system have?

One per system in current device tree.


> 
> What do you do if the property is not present? You didn't make it
> required which is good because that would be an ABI break.

We need an indication of the ability to use the secure-monitor to obtain 
additional information within the soc driver. It seemed to me that using 
an explicit reference to the secure-monitor is the best choice.

> 
> You only need a link in DT if there are different possible providers or
> some per consumer information to describe (e.g. an interrupt number or
> clock ID). You don't have the latter and likely there is only 1 possible
> provider.

Would replacing the reference to sm with an option, for example, 
use-secure-monitor = <1>; look more appropriate in this case?


> 
> Rob
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Viacheslav

