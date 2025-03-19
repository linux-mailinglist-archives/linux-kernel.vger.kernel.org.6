Return-Path: <linux-kernel+bounces-567435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E492DA685EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95113ADFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23BF2505C4;
	Wed, 19 Mar 2025 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTC2J7vI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07520E31B;
	Wed, 19 Mar 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370006; cv=none; b=BI3+9M4H1jxxESAfyNRmSVkjdrof6I5LcmAkAWLydMOUVvnvjGB/AdpRj81jgAykYlV2Q1Sza4HmYQp7/DW796asMycWOhScIlqUXSOVaGYpp5NuwFEsMzH6SqQTAn84BLlYWxWcjvTbG7Pi5jNPyKo0AkDW+wOH4Xa2ep6kQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370006; c=relaxed/simple;
	bh=tKIbx2+7UEC6SU/Ci8glYFwYES+rjaNTdcbdH+R6TS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6vOfK/30ZIbVDI36fqCtZ0xWtJz46neO5QtQ3Ij+FdpsKgz76jUMf+st4S97+oaydJYpmb8wCFRUZ2gpe48i/H+1r7TLwsBeS9PGXtgkb6ehQXNpUBLYmuVioa+nnq/vzIFuBLCeKeHXf3SbWZ1tmP1VKZCde1fArx8pxuOy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTC2J7vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4F4C4CEE9;
	Wed, 19 Mar 2025 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742370005;
	bh=tKIbx2+7UEC6SU/Ci8glYFwYES+rjaNTdcbdH+R6TS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iTC2J7vI9gdw4qI2bdHDiMSymEqGhCe2EaCZpTpfQ2DERnFKR7kQs4qTvHQnTr7Tf
	 Ng+DPcHm19bSxSO0miPkBpWLO9gbiq1xESNFLalNDHqTCSKQCmbd3l20qsrxk52w7E
	 1h+0v7377B0cpcqmfluYlpWf/kC4rT5P6xGzjjlq9e/M9/O33V9w2INM76kL2Cdj/P
	 BfD+wdg8rSDUGHcoR4q3cB/LF3zf9aViOVfjBrvSYFhbuZWGQRR9UO2pkjT8JYGzm5
	 f2jqjFYo3VhcjJWuf2wRJ3A6viyEJjxq4lLg20lqwORpgH2hKficXCrNhSLVw+6SiB
	 w0dToPGlDelcA==
Message-ID: <cd445f29-ea01-4e57-b1b7-4e9c3bfbcc8f@kernel.org>
Date: Wed, 19 Mar 2025 08:39:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Danzberger <dd@embedd.com>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Nikita Shubin <nikita.shubin@maquefel.me>, Guo Ren <guoren@kernel.org>,
 Yangyu Chen <cyy@cyyself.name>, Ben Hutchings <ben@decadent.org.uk>,
 Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
 upstream@airoha.com
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-10-ansuelsmth@gmail.com>
 <4f16d239-f540-45d5-b67a-767b09f1c70c@kernel.org>
 <67d0862f.df0a0220.375bd.6b15@mx.google.com>
 <4a9ac302-dfbe-4d76-a634-a445957c313c@kernel.org>
 <67d95979.050a0220.166852.25e6@mx.google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <67d95979.050a0220.166852.25e6@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2025 12:31, Christian Marangi wrote:
> On Sun, Mar 16, 2025 at 06:01:02PM +0100, Krzysztof Kozlowski wrote:
>> On 11/03/2025 19:51, Christian Marangi wrote:
>>>>
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [0, 1]
>>>>
>>>> I don't understand why do you need index property here (which are
>>>> usually not allowed).
>>>>
>>>
>>> Eh... As said in the description this is really to differentiate the 2
>>> different physical port...
>>>
>>> Each port have a dedicated oscillator for calibration and these
>>> calibration are identified by an offset (all placed one after another in
>>> a separate register space).
>>
>> So different oscillators? Then describe the oscillator and its differences.
>>
>> Different programing model? Different compatible.
>>
>> Other difference? Depending what is the difference.
>>
>> But there is no such thing as "different port ID" based on your
>> description above. You just claimed that they are different, but you do
>> not put that difference to hardware description. Instead you encode that
>> difference in the drivers and it should be opposite. The DTS, so the
>> hardware description, should tell you the difference. And I am sorry,
>> but in 99% of cases "I am the first phy" and "I am the second" is not
>> the actual difference we are interested in.
>>
> 
> Ok to make it as clear as possible. (hope I don't contraddict with the
> previous statement) (actually yes the "separate register space statement
> was wrong and sorry for the confusion")
> 
> - 2 USB port
> - USB 2.0 needs to be calibrated with an oscillator
> - Each USB port have his own dedicated oscillator somewhere in the HW
> - Each USB port have at the same offset a register to SELECT the
>   oscillator. This register refer to the same oscillator selection in
>   the HW.
>   
>   Example:
>   reg 0x1fac0100 MASK 27:26 can be set to source out of oscillator 0,1,2
>   reg 0x1fae0100 MASK 27:26 can be set to source out of oscillator 0,1,2

So that's your difference between devices - you choose the oscillator.

> 
>   Both register refer to the same oscillators in hardware (hence each
>   port should select the correct one)
>   Selecting oscillator 0 for both USB port is problematic.
> 
> With this in mind is it ok if I describe this with something like
> 
> airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL0>;
> 
> and some dt-bindings include
> 
> #define AIROHA_USB2_MONCLK_SEL0 0
> #define AIROHA_USB2_MONCLK_SEL1 1
> #define AIROHA_USB2_MONCLK_SEL2 2
> #define AIROHA_USB2_MONCLK_SEL3 3
> 
> Or an enum of string like "osc0", "osc1", "osc2"...?

Both are fine.

Best regards,
Krzysztof

