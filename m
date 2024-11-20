Return-Path: <linux-kernel+bounces-415419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6279D35D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A84DB24EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AF1175D50;
	Wed, 20 Nov 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7f0vM2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071F15CD46;
	Wed, 20 Nov 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092539; cv=none; b=b0kswcJcj4cKV8Ahqsxib5EluRPAMC0CIJ+NUUCIblc7z0tSRuGFVs/okBUjHEtm3zj+6yta18sMDqsYH+owa1Rfh1ECHMuAzZW8Jq4LIgzyIDpja+QBnEl9+TJ52dptemFqByoOjfxIYoqQ+iJAJH5z3do7d0a1URM7H1fSpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092539; c=relaxed/simple;
	bh=tlURkDdJbTiE28ex0REYW/z3accfej8M+svuPoygbF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kza4FGpdJ6X31NUkdMXVwKjLFJWlQC2TJLFVAoCPF32KIMF+L+NT3l0fDZO6XqVn4UXev3DbvH1/kvqkBUPTcDUJSa3V8WRAl7p2KF+pHfA1Hl9ir2fH88ztw+BrZVrRpsIMvw1sHNeU5gGnR3YRonEZI+DY92xxh8sDrHbYdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7f0vM2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ED2C4CECD;
	Wed, 20 Nov 2024 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732092538;
	bh=tlURkDdJbTiE28ex0REYW/z3accfej8M+svuPoygbF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u7f0vM2Ii96hafzmSNstWpwy7tCXybBR83HOuCo2IAdH5ppIjbqPo1OgamvyZ4q6L
	 1n6dxQVDbUQGhq12OpLYXOt4dpBjbIDUq+sjajvR3wTxm5hb4ZcQ1U75cVxxVJndcT
	 UpDGXlC/TZ8bIMUBY2Dug7vZ00zyVxr10dCuuMJ7kgtO4vXxBLE7QtXdqI/xPlWxlq
	 OuPx/qaxuU4Iq9u15uNoszeq0pzHvI4PHDlH8gvwmpEwuAwSbab73Ev0cgvZjbnSdc
	 7QUMmF/NuQBAn7eNS6oIuWgMBTyaz2fzR853R7fF/cxbZjWcvu88W9SCTP1xQhsuuT
	 Gh4pRHIm1Uk/w==
Message-ID: <9896a38f-4b68-46a9-83b8-bf76abea47ba@kernel.org>
Date: Wed, 20 Nov 2024 09:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
 <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>
 <20241115-happy-garter-2cf65f4b1290@spud>
 <83c8487c-2c50-4315-8244-ff80632165e9@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <83c8487c-2c50-4315-8244-ff80632165e9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/11/2024 09:34, Kryštof Černý wrote:
> Hello,
> 
>> On Fri, Nov 15, 2024 at 03:58:06PM +0100, Kryštof Černý via B4 Relay wrote:
>>> From: Kryštof Černý <cleverline1mc@gmail.com>
>>>
>>> Adds the newly added vcc-supply property to bindings.
>>
>> This commit message is a circular argument. You're adding it to the
>> binding, which of course means it is newly added.
> 
> You are right, I will replace with "Adds the vcc-supply property to 
> bindings." in the next version.

No, please say why, e.g. because it was missing and device has it
according to datasheet.

> 
>>>
>>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
>>> ---
>>>   Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>>> index 422becc6e1fa8d58665c5586ebdc611cd0b2c760..a6b9e0658ec858cb24b21cf64443a061bb43e4ef 100644
>>> --- a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>>> +++ b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>>> @@ -25,6 +25,9 @@ properties:
>>>     reg:
>>>       maxItems: 1
>>>   
>>> +  vcc-supply:
>>> +    description: phandle of the regulator that provides the supply voltage.
>>
>> "vcc-supply: true" should suffice.
>>
> 
> Right, I suppose you mean to remove the description and just have 
> "vcc-supply: true".
> If so, could you explain why no description? Is it some standard property
> or because the name is self-explanatory? If you mean to keep both, 
> please reply.

It's almost self-explanatory and your description does not give any more
information. git grep for existing code - you will find also examples
which give actual information, e.g. detailed PIN name and accepted voltages.



Best regards,
Krzysztof

