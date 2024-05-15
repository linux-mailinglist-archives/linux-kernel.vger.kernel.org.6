Return-Path: <linux-kernel+bounces-180015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E568C68E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F11F227C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E234155A25;
	Wed, 15 May 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APFFQZf2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E98155749;
	Wed, 15 May 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783742; cv=none; b=e0H4iM/0wsYde649OANx+5m2iy3jMRse8EtIMR5BxQe3oR8tq01DBIwL/MNoHZrcyDd0oPWCR+XMP6pEtU6IV5FO26bigBZsm3dKe+rcOgpsHGPpkL3570VhksxXoJmlmFJ7VT25bJb0sRDtb2Lp2CUdWwBb19QHIkcpvk4FqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783742; c=relaxed/simple;
	bh=o1k/xgmlCNQgq0CzkfNhpYuPEw2IgPrERI5Hqv5OGA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3p4Qbh3ustezpS8+CGpwAywrCUgA7/XsmYQFO2yQuQ2QXPVIU8KgOdO3HAdbfMNyq0HfJyBym/8G+7Uk4i1Va1e8KoPW4VlUrO3dRSTIx6Wg/yAJAEZU8j7cSe0Yb78er/iHgUr9ziXQmFXBLGlXdjWoU2UoOOcSDIpNozbqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APFFQZf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AC8C2BD11;
	Wed, 15 May 2024 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715783741;
	bh=o1k/xgmlCNQgq0CzkfNhpYuPEw2IgPrERI5Hqv5OGA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=APFFQZf2t31GrwMjXOPjpgr0445eftKSVfjlC173tmdGBv3lptYdU9NRLveI205il
	 YxvkmlyRMH1u8g8Jus8MfIHH0FK2ZPaM0WAlioATWw3Xr+1IYazepGGj8BUMyQyPLF
	 wjRTJZqh/FRYP3/gqLXv5KaxP6v6cxNnnH8ImmCYpLlsWIshvLC1CnKHsLrHocsTWu
	 eDNTm7pusJUZy3OMmrYoZ4crcvQZjGAAOJcow/IZNQ7EumGkMOJ4EhwfRRlfkogzbz
	 BD/BvBr8T5+QrtZceuI5qHkw4jG0xGnAgKp8Q1tmeFGSmMkSSJyDXBEpLzIZmIarQs
	 T6oO3sU1awNDA==
Message-ID: <eb6e2b5b-f341-404b-9215-6e80f21a6842@kernel.org>
Date: Wed, 15 May 2024 16:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] dt-bindings: fsi: Document the FSI controller
 common properties
To: Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au
References: <20240514195435.155372-1-eajames@linux.ibm.com>
 <20240514195435.155372-6-eajames@linux.ibm.com>
 <9200e46a-3cb5-4363-a560-ee3d88e05ced@kernel.org>
 <a219f01e-a856-46cb-83c4-4fde99b8addd@linux.ibm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <a219f01e-a856-46cb-83c4-4fde99b8addd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 16:28, Eddie James wrote:
> 
> On 5/15/24 09:18, Krzysztof Kozlowski wrote:
>> On 14/05/2024 21:54, Eddie James wrote:
>>> Since there are multiple FSI controllers documented, the common
>>> properties should be documented separately and then referenced
>>> from the specific controller documentation.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>> Changes since v4:
>>>   - Add interrupt controller properties
>>>   - Add clock-frequency property to FSI controller and CFAM
>>>   - Add detail to chip-id property description
>>>
>>>   .../bindings/fsi/fsi-controller.yaml          | 66 +++++++++++++++++++
>>>   1 file changed, 66 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/fsi/fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>> new file mode 100644
>>> index 0000000000000..8620e4da6de77
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>> @@ -0,0 +1,66 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fsi/fsi-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: FSI Controller Common Properties
>>> +
>>> +maintainers:
>>> +  - Eddie James <eajames@linux.ibm.com>
>>> +
>>> +description:
>>> +  FSI (FRU (Field Replaceable Unit) Service Interface) is a two wire bus. The
>>> +  FSI bus is connected to a CFAM (Common FRU Access Macro) which contains
>>> +  various engines such as I2C controllers, SPI controllers, etc.
>>> +
>>> +properties:
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +  '#interrupt-cells':
>>> +    const: 1
>>> +
>>> +  clock-frequency:
>>> +    minimum: 1
>>> +    maximum: 200000000
>> This is a deprecated property in general. Why did it appear? It does not
>> exist in current bindings and nothing in commit msg suggests changes in
>> the bindings themselves.
> 
> 
> OK, is there some document that describes what properties are 
> deprecated? Because it's used all over the place in the bindings. Anyway 

dtschema: dtschema/schemas/clock/clock.yaml

buses anyway should use bus-frequency but it is also legacy one.

> I need this property, I can rename it if you like. I can also update the 

Why do you need it? Why clocks cannot be chosen by drivers and initial
state selected by assigned-clock-rates?


> commit message to indicate that I'm adding it.



Best regards,
Krzysztof


