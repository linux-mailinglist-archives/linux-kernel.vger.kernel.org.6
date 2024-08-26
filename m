Return-Path: <linux-kernel+bounces-301015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D076595EB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012661C2127E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4B13BC3F;
	Mon, 26 Aug 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSOXYHJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DF13A3F3;
	Mon, 26 Aug 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660119; cv=none; b=lMXLbvwLxlr/cZsSEM4P5ZAlgUTmuizI98nVzxtz451Sf69z3guqYVhtmpySNCoYHVEd5uh3qnJAfWSmZZ19Y89/ZCUsg4znP0u4XRSRmGkDfjup4e0WUu/unDAK/V6Jqmp7wIoTHFIK5T9wuvDp8O6lYEOAfpHuoSJHMJyV9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660119; c=relaxed/simple;
	bh=mtt94lOze4hX1t8kQFcroSCkGOs+snsSQ3mu2Oel574=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxYfdLS0nl+AS91Xm/ObnilFYzqLWo2GvQHFh7bB7DwQGPLE5iPsAKxBJnPN1efaD1EHi2vZMt1gow5Oh03J358aetvGoU3mywcjMeLn3WrYoLCNuS6ASubmIcFIPze6IaDUvGsOw1Rf/1I8sA06FXkt5X5lXQ8QE8OX0T4osQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSOXYHJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A02C8CDD2;
	Mon, 26 Aug 2024 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724660118;
	bh=mtt94lOze4hX1t8kQFcroSCkGOs+snsSQ3mu2Oel574=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qSOXYHJg7CFbIPoMoq4oSQgV7+NK5BHIw2lcOXp8xzXHulN7LOyfu+gl2Ie4sjxDs
	 YvYJ24wEcNhBzHYNEhfHovrhW3Cyb8ftM0PA+KmhCwWAcwfp5xygTjy73/q2c8Kgk/
	 uGvHFXNtBmWAkaFmPgSWhM4sQvSrZrleaZrD4ipFBlGWbymb3EhfjIs7fz/S2k46x2
	 mGSAeMPrwMQiEKt6JYcpfJtleIwnCRICY8wi/1a6P6+9Xu1+PtlXphqxtpmc0GXmmH
	 l8SywurQ2u5tKmoDzFVyAoQiy8wFrR0zazrAh4kwtokoMz/MuFVCR68Bknugv6kwlL
	 m+lLjUgmn8Xdw==
Message-ID: <45e1533a-5f97-4262-b6ae-477f1f94aa8b@kernel.org>
Date: Mon, 26 Aug 2024 10:15:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: display: ti,am65x-dss: Add OLDI
 properties for AM625 DSS
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: DRI Development List <dri-devel@lists.freedesktop.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240716084248.1393666-1-a-bhatia1@ti.com>
 <20240716084248.1393666-4-a-bhatia1@ti.com>
 <93844c97-46b7-48bd-9397-2bbba9c09510@kernel.org>
 <73f033cb-d890-426d-8b1a-f9c56456961d@linux.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <73f033cb-d890-426d-8b1a-f9c56456961d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2024 09:32, Aradhya Bhatia wrote:
> Hi Krzysztof,
> 
> 
> On 7/21/24 21:09, Krzysztof Kozlowski wrote:
>> On 16/07/2024 10:42, Aradhya Bhatia wrote:
>>> The DSS in AM625 SoC has 2 OLDI TXes. Refer the OLDI schema to add the
>>> support for the OLDI TXes.
>>>
>>> The AM625 DSS VP1 (port@0) can connect and control 2 OLDI TXes, to use
>>> them in dual-link or cloned single-link OLDI modes. Add support for an
>>> additional endpoint under the port@0 to accurately depict the data flow
>>> path.
>>>
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> ---
>>>  .../bindings/display/ti/ti,am65x-dss.yaml     | 135 ++++++++++++++++++
>>>  1 file changed, 135 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>> index 399d68986326..249597455d34 100644
>>> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>> @@ -91,6 +91,24 @@ properties:
>>>            For AM625 DSS, the internal DPI output port node from video
>>>            port 1.
>>>            For AM62A7 DSS, the port is tied off inside the SoC.
>>> +        properties:
>>> +          endpoint@0:
>>> +            $ref: /schemas/graph.yaml#/properties/endpoint
>>> +            description:
>>> +              For AM625 DSS, VP Connection to OLDI0.
>>> +              For AM65X DSS, OLDI output from the SoC.
>>> +
>>> +          endpoint@1:
>>> +            $ref: /schemas/graph.yaml#/properties/endpoint
>>> +            description:
>>> +              For AM625 DSS, VP Connection to OLDI1.
>>
>> Eh, that's confusing. Why do you have graph to your children? Isn't this
>> entirely pointless?
> 
> I am not sure I fully understand. The same display source video port can
> connect up to 2 OLDI TXes - hence 2 endpoints which connect to the OLDI
> that were described in the previous patch. The idea has been to
> accurately depict the connections of the hardware.
> 
> What am I missing here?

You are missing the explanation: why do you need to represent internal
parts of a device with graph. Where does this endpoint point?

Provide some diagram showing the architecture, because either it is
wrong or I do not understand what hardware you want to represent here.

> 
> 
> side-note: I do realize, as I write this, that it has been quite a while
> since you reviewed, and that you may have, rightfully, lost context.
> I apologize for that.
> 
>>
>>> +
>>> +        anyOf:
>>> +          - required:
>>> +              - endpoint
>>> +          - required:
>>> +              - endpoint@0
>>> +              - endpoint@1
>>>  
>>>        port@1:
>>>          $ref: /schemas/graph.yaml#/properties/port
>>> @@ -112,6 +130,23 @@ properties:
>>>        Input memory (from main memory to dispc) bandwidth limit in
>>>        bytes per second
>>>  
>>> +  oldi-txes:
>>> +    type: object
>>> +    additionalProperties: true
>>
>> Why? This looks wrong.
> 
> This, I will admit, was a shot in the dark. The binding check asked me
> that I was missing either this or unevaluatedProperties. I tried to make
> sense of the two, but with little luck. Eventually, I went with this.
> 
> I could change it to unevaluatedProperties if that is indeed correct. I
> could also use some comprehensive resource to understand this, if you
> have something to recommend. =)

This must be additionalProperties false. See example schema or writing
schema.


Best regards,
Krzysztof


