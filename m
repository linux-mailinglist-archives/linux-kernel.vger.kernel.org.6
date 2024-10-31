Return-Path: <linux-kernel+bounces-390304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C319B7823
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEA01F24AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C819538D;
	Thu, 31 Oct 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmGBbOJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D82197A9A;
	Thu, 31 Oct 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368762; cv=none; b=d9bBWBjZonuNyels0AVt4r1KwG68LknV9jXmBfpPpUyuSe+V/YWhxvJlYq6puZpIlj7WiZZ21T9twjTftR+oCiy6H7UMNClX2UEHONel+YrNHcbf7DQtHvUpWe/AeFHKChpkmF96tYMpeS2bPVmnBkDWi5CsqpZxL26V/oFEJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368762; c=relaxed/simple;
	bh=0Z/Ae2UNtxEs3oOIzL9noQbt9KWPAGJ+Ppa2XVlpXeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKZjlYRH/9WWnzPkz6zJbYt2uIjYyDQzJAWq/yLqJsQPRnQrBanN4RJKLj8oGJm8uYPnO5p1PnzPyfqYGts7+zTsBDm/8bcJ2W6MNl/m/9IrfMg6aT/b0uCgr+KJJyvXU+FJ4lQhE9Z78eHziuF2Ku1bkRan2UlYV+9yEOOkLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmGBbOJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06069C4CEC3;
	Thu, 31 Oct 2024 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730368761;
	bh=0Z/Ae2UNtxEs3oOIzL9noQbt9KWPAGJ+Ppa2XVlpXeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PmGBbOJ0DKa25hH+c1NLm5IW6UAQOPuqujiGj89c+Dmkl9+bri+eg6qS8wnnXSXud
	 HduqN9MsQsDJiHd1E6FqtGnpgikzYv4vXhYymJDHNWcyv0BvGesK3LdaW+IrkEUox+
	 Kb4xLAsh2aLrzLbOn1qHAxuAP6v6unc816JgeplfgO4QyBxXtYXTUH6u9Xc30DagaT
	 Y01NeeLyCEZcvkv1GzH5/2HrD+IdpVJcIsK9lN8+hu6m4KSns8146sCQ5uy8C8nKNN
	 ED2MFbA8ebI8UEGkBDs/KparCPlu/s1J7APBi3pDIe4bKyPVr87hJG/rBFdxrj+3cQ
	 MbpxQWun36q6g==
Message-ID: <f11f1a3c-0626-4f6c-9bfd-1bf6fb37388e@kernel.org>
Date: Thu, 31 Oct 2024 10:59:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: wcd937x-sdw: Add static channel
 mapping support
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com, kernel@quicinc.com
References: <20241023061326.3871877-1-quic_mohs@quicinc.com>
 <20241023061326.3871877-2-quic_mohs@quicinc.com>
 <qzjbiby7w6a7m4e324hdatgklmejlcxfwv7tszzfmdqahgrbu2@bcwsdlrpncxq>
 <d98bff34-d7ea-2b05-0c0d-eaf0392aef3f@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <d98bff34-d7ea-2b05-0c0d-eaf0392aef3f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 06:07, Mohammad Rafi Shaik wrote:
> On 10/23/2024 1:22 PM, Krzysztof Kozlowski wrote:
>> On Wed, Oct 23, 2024 at 11:43:23AM +0530, Mohammad Rafi Shaik wrote:
>>> Add static channel mapping between master and slave rx/tx ports for
>>> Qualcomm wcd937x soundwire codec.
>>>
>>> Currently, the channel mask for each soundwire port is hardcoded in the
>>> wcd937x-sdw driver, and the same channel mask value is configured in the
>>> soundwire master.
>>>
>>> The Qualcomm boards like the QCM6490-IDP require different channel mask settings
>>> for the soundwire master and slave ports.
>>
>> Different than what? Other wcd937x? Which are these?
>>
> For Qualcomm QCM6490-IDP board soundwire master needs a different 
> channel mask setting.

I understand, but I asked different than which board? Maybe all boards
needs this different channel setting, so basically it is "not different".

> 
> The wcd937x channel mask values are hardcoded in wcd driver.
> https://elixir.bootlin.com/linux/v6.12-rc5/source/sound/soc/codecs/wcd937x-sdw.c#L35
> https://elixir.bootlin.com/linux/v6.12-rc5/source/sound/soc/codecs/wcd938x-sdw.c#L37
> 
> In case of QCM6490-IDP the soundwire master and wcd937x require 
> different channel mask settings, not the same.
> For Example, wcd937x ADC2 connection
> 
>                            Master                 Slave (wcd937x)
>                       +--------------+           +--------------+
>                       |  +--------+  |           |  +--------+  |
>           ADC1  ----->|  | PORT1  |  |           |  |   TX1  | 
> |<-----------ADC1
>           ADC2  ----->|  |        |  |           |  |        |  |
>                       |  +--------+  |           |  +--------+  |
>                       |              |           |              |
>           ADC3  ----->|  +--------+  |           |  +--------+  |
>                       |  |  PORT2 |  |           |  |   TX2  | 
> |<-----------ADC2
>                       |  |        |  |           |  |        | 
> |<-----------ADC3
>                       |  +--------+  |           |  +--------+  |
>                       |              |           |              |
>                       |  +--------+  |           |  +--------+  |
>   DMIC0...DMIC3------>|  |  PORT3 |  |           |  |   TX3  | 
> |<-----------DMIC0...DMIC3
>                       |  |        |  |           |  |        | 
> |<-----------MBHC
>                       |  +--------+  |           |  +--------+  |
>                       |              |           |              |
>                       |  +--------+  |           |  +--------+  |
>   DMIC4...DMIC3 ----->|  |  PORT4 |  |           |  |   TX4  | 
> |<-----------DMIC4...DMIC7
>                       |  |        |  |           |  |        |  |
>                       |  +--------+  |           |  +--------+  |
>                       |              |           |              |
>                       +------------- +           +--------------+
> 
> 					
> For ADC2, The Slave needs to configure TX2 Port with channel mask value 
> 1 and
> For Master, it required PORT1 with channel mask  value 2.
> 
> 
> In existing design master and slave configured with same channel mask, 
> it will fail ADC2.
> The new design will help to configure channel mapping between master and 
> slave from DT.
> 
>>>
>>> With the introduction of the following channel mapping properties, it is now possible
>>> to configure the master channel mask directly from the device tree.
>>>
>>> The qcom,tx-channel-mapping property specifies the static channel mapping between the slave
>>> and master tx ports in the order of slave port channels which is adc1, adc2, adc3, adc4,
>>> dmic0, dmic1, mbhc, dmic2, dmic3, dmci4, dmic5, dmic6, dmic7.
>>
>> I still don't get what is the channel here.
>>
> Typo error,
> 
> The qcom,tx-channel-mapping property specifies the static channel 
> mapping between the slave
> 
> and master tx ports in the order of slave port channel index which are 
> adc1, adc2, adc3, adc4,
> 
> dmic0, dmic1, mbhc, dmic2, dmic3, dmci4, dmic5, dmic6, dmic7.
> 
> 
> 
> https://elixir.bootlin.com/linux/v6.12-rc5/source/sound/soc/codecs/wcd937x.h#L599
> 
> 
> 
> Will be fixed in the next version
> 
>>>
>>> The qcom,rx-channel-mapping property specifies static channel mapping between the slave
>>> and master rx ports in the order of slave port channels which is hph_l, hph_r, clsh,
>>> comp_l, comp_r, lo, dsd_r, dsd_l.
>>
>> And this description copies binding :/.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>
> 
> Ack
> 
>>>
>>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>>> ---
>>>   .../bindings/sound/qcom,wcd937x-sdw.yaml      | 36 +++++++++++++++++++
>>>   1 file changed, 36 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>>> index d3cf8f59cb23..a6bc9b391db0 100644
>>> --- a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>>> @@ -58,6 +58,38 @@ properties:
>>>       items:
>>>         enum: [1, 2, 3, 4, 5]
>>>   
>>> +  qcom,tx-channel-mapping:
>>> +    description: |
>>> +      Specifies static channel mapping between slave and master tx port
>>> +      channels.
>>> +      In the order of slave port channels which is adc1, adc2, adc3, adc4,
>>> +      dmic0, dmic1, mbhc, dmic2, dmic3, dmci4, dmic5, dmic6, dmic7.
>>> +      ch_mask1 ==> bit mask value 1
>>> +      ch_mask2 ==> bit mask value 2
>>> +      ch_mask3 ==> bit mask value 4
>>> +      ch_mask4 ==> bit mask value 8
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    minItems: 8
>>> +    maxItems: 13
>>
>> Why size is variable? This device has fixed amount of slave ports, I
>> think.
>>
> 
> yes will check modify
> 
>>> +    items:
>>> +      enum: [1, 2, 4, 8]
>>
>> What is the point of using bits if you cannot actually create a bit mask
>> out of it? Why this cannot be 7?
>>
> Actually, these values should be fixed: 1 (0001), 2 (0010), 4(0100), 
> 8(1000).

What is fixed here?

I asked why these look like bitmasks but they cannot be used as bitmask.
This is a mapping, so index is channel slave port channel number and the
value is master port channel number, no?

> 
> 
> If required to set 7, it is handled in wcd driver based on mixer commands.
> https://elixir.bootlin.com/linux/v6.12-rc5/source/sound/soc/codecs/wcd937x.c#L1199

I talk about binding. Why you are not allowing value of 7 if this is a
mask? If this is not a mask - property says it is channel mapping - then
these should be [1-4].

> 
> 
> Example:
> WCD937X_HPH_L -> channel mask value is 1
> WCD937X_HPH_R -> channel mask value is 2



> 
> 
> The final channel mask for that specific port is 3
>>> +
>>> +  qcom,rx-channel-mapping:
>>> +    description: |
>>> +      Specifies static channels mapping between slave and master rx port
>>> +      channels.
>>> +      In the order of slave port channels, which is
>>> +      hph_l, hph_r, clsh, comp_l, comp_r, lo, dsd_r, dsd_l.
>>> +      ch_mask1 ==> bit mask value 1
>>> +      ch_mask2 ==> bit mask value 2
>>> +      ch_mask3 ==> bit mask value 4
>>> +      ch_mask4 ==> bit mask value 8
>>
>> and the value is what exactly? Index is channel, but what does "ch_mask4 ==> bit
>> mask value 8" mean? I don't understand this at all.
>>
> 
>                            Master
>                       +--------------+
>                       |  +--------+  |
>            ADC1 ----->|  | PORT1  |  |
>            ADC2 ----->|  |        |  |
>                       |  +--------+  |
>                       |              |
>            ADC3 ----->|  +--------+  |
>                       |  |  PORT2 |  |
>                       |  |        |  |
>                       |  +--------+  |
>                       |              |
>                       |  +--------+  |
>    DMIC0...DMIC3 ---->|  |  PORT3 |  |
>                       |  |        |  |
>                       |  +--------+  |
>                       |              |
>                       |  +--------+  |
>    DMIC4...DMIC7----->|  |  PORT4 |  |
>                       |  |        |  |
>                       |  +--------+  |
>                       |              |
>                       +------------- +
> 
> 
> The PORT1 has 2 ADC connections,
> 
> ADC1 -> PORT1 ch_mask index 1 -> channel mask value 1 (0001)
> ADC2 -> PORT1 ch_mask index 2 -> channel mask value 2 (0010)
> 
> 
> DMIC0 -> PORT3 ch_mask index 1 -> channel mask value 1 (0001)
> DMIC1 -> PORT3 ch_mask index 2 -> channel mask value 2 (0010)
> DMIC2 -> PORT3 ch_mask index 3 -> channel mask value 4 (0100)
> DMIC3 -> PORT3 ch_mask index 4 -> channel mask value 8 (1000)
> 
> 
> Will check and add a proper description.


Best regards,
Krzysztof


