Return-Path: <linux-kernel+bounces-230421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3B917C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC4F2821A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F7F16CD12;
	Wed, 26 Jun 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsdaQ1TV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF108BEF;
	Wed, 26 Jun 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394498; cv=none; b=ctK1BuwKECNIvodb4+s0yGabFVBd21S+jUaS9+T346eHQ8lIYaI9doA09Nh/TwlHLQmVTgrQDPxgShGnMCoS4AAh+PHcTsA4wKDjEskt66Yc0ko8LMDFJADiu1fP9F/Khv6d1qH4j7twLnuai7hmnWioKuTk/75mbkrNUy58iRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394498; c=relaxed/simple;
	bh=f1/+g6RzRmHsBpgyUITjf068nJRrBDTAxMPmBq2MJ/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzqqSg73o0FrYPbNe7V1V5blF6vlX/xWK4JekadiBqdXtkBgWyygZJOExpj5IbRYZs8RXOegroLxB2W3Ct6r90gqchpdCOn549GHvbIhmwuVwUhjNuqJ/aDytEY0Wr0Ije+QwHSYbbojRXvJGSIlTnD3Xc7uX0QZIRpShpzZ9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsdaQ1TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED94C2BD10;
	Wed, 26 Jun 2024 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719394498;
	bh=f1/+g6RzRmHsBpgyUITjf068nJRrBDTAxMPmBq2MJ/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fsdaQ1TVNFoqAUNalY6JH06C+UyC/QRbS5PzeR1mYQfs58TWV8ITssRoQ95GdNQU/
	 JkhRIjzu+IOrQF9cvdRFk+K2yjzJ8oyMrU2YV1J8fIi2dpp5MfEFeseT96jKauj5HY
	 79CxtciGiSp+vFGrKml/D+/AS9mF6K64cxMFl7+EcVRQvg4m3OF999QdqWI/a3GEXk
	 29SQgnk6gREw8KKJ+qvcZarlCkh3g2P0dM3Ki3+/gs01D9552odlpwy1LrZjoyH6kE
	 BUei/w9PWuucjlOAKOcLDSzaNXTDWKGiuYqde+BmXrmDmnLNBzE1aOImBbhgcWzV7z
	 xRPBcnHOPuOYw==
Message-ID: <549edfff-24a5-403f-b35e-8929cc14c81f@kernel.org>
Date: Wed, 26 Jun 2024 11:34:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl,xcvr: Adjust the number of
 interrupts
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
 <1719291415-1168-2-git-send-email-shengjiu.wang@nxp.com>
 <293fb3d5-9b77-4321-8b31-d060cf96565d@kernel.org>
 <CAA+D8AMQv_=X3hC5uQbrDBN0EGo3U6EToGFVjUYcOVHpf5b=aQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAA+D8AMQv_=X3hC5uQbrDBN0EGo3U6EToGFVjUYcOVHpf5b=aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/06/2024 11:25, Shengjiu Wang wrote:
> On Wed, Jun 26, 2024 at 5:23 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 25/06/2024 06:56, Shengjiu Wang wrote:
>>> On i.MX8MP, there are 3 interrupts, the third interrupt is
>>> SPDIF wakeup interrupt from PHY
>>>
>>> Add ref: dai-common.yaml for #sound-dai-cells is needed and
>>> XCVR is a DAI device.
>>>
>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>>> ---
>>>  Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
>>> index 197ae8ba9c30..7470866e11c6 100644
>>> --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
>>> @@ -42,6 +42,7 @@ properties:
>>>      items:
>>>        - description: WAKEUPMIX Audio XCVR Interrupt 1
>>>        - description: WAKEUPMIX Audio XCVR Interrupt 2
>>> +      - description: SPDIF wakeup interrupt from PHY
>>>      minItems: 1
>>>
>>>    clocks:
>>> @@ -88,6 +89,7 @@ required:
>>>    - dma-names
>>>
>>>  allOf:
>>> +  - $ref: dai-common.yaml#
>>>    - if:
>>>        properties:
>>>          compatible:
>>> @@ -112,7 +114,7 @@ allOf:
>>>      else:
>>>        properties:
>>>          interrupts:
>>> -          maxItems: 1
>>> +          maxItems: 3
>>
>> I have doubts this was tested. The existing example should fail,
>> although I did not see any reports. Not sure why.
> 
> it is tested, because the minItems is 1. so the example can pass
> 

That's a very unexpected change in dtschema. It indeed passes, but is
not correct. Why interrupts are flexible? This should be constrained.
Let's wait for Rob's confirmation that this is not a bug in dtschema.

Anyway, update example to be complete in next version.

Best regards,
Krzysztof


