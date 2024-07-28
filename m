Return-Path: <linux-kernel+bounces-264530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FAD93E485
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F2DB212E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727A374D1;
	Sun, 28 Jul 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/xYx9T7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C52C69B;
	Sun, 28 Jul 2024 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722162620; cv=none; b=MEdylj8WdMJhf5SBxrUcuOVB+66VPuGADSsgYvamHk1RnlNWKM8l41qdRHQzPzc9qWgv+ktQ424pto3Ed5i6xVCqm8xTdIeXoK3lWouiQK1u4QWOpsNlk+nj+ri4M6alKkcMmQ9TBUKnY2aMlHCc/2umxSY5KykyWh3oYlRu1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722162620; c=relaxed/simple;
	bh=eDWjhLzi6G1agWre6Y7l9EsOG8ksGnVzkj/CACSAyj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVFvbq+bJ1T75Uhz/RPhV833GOrZgEAt2RtxFpGogZJp8UcxOuTOlbrujJ1w6zjy9hvzpmcbOadrB35elFqccHB/Mw238Q3EKeO86c7Uyoz74rMqlOogvOKUJS6EvVmN4iAXC86bebWBEsHReAUC2zqMsJ9DWuM2nLylHKNYW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/xYx9T7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C7AC116B1;
	Sun, 28 Jul 2024 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722162619;
	bh=eDWjhLzi6G1agWre6Y7l9EsOG8ksGnVzkj/CACSAyj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/xYx9T7/I2WLfcnu+Qa5RkJFKH7BboES21hXWKrBAIClTAFCPA1Oqyli2VQYQn7h
	 9yVsmefHU5cfToCSrPRG9wTIeOo3mD93MxzSc9NScVH/PEtZZgsgsei8bcXhXW01PW
	 WkbOvyR8aNgRuZZXiIZayXSyK08RAWwZd3Si9fGI+0tmLcz3vo4gs2aGf4OuLgFvAu
	 wVow3KrkyVlKuzd2cKdAlWDieWPy1zSFbfwBxUxOMBlEQNmSk0hZyZxeiBc6ACZn9H
	 zcJCbeuVv5/ssY8PSXvoooSn0oGM/6RcYMka/BqlBsGWVdVVr+hOSsmAurOZetqJJN
	 pO04cnEfEZNTA==
Message-ID: <3d9f76c1-2e14-43dc-b438-5fac94ffc73e@kernel.org>
Date: Sun, 28 Jul 2024 12:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,apq8016-sbc-sndcard: move to
 separate binding
To: Stephan Gerhold <stephan@gerhold.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Skladowski <a39.skl@gmail.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20240723083300.35605-1-krzysztof.kozlowski@linaro.org>
 <ZqVXUI37fNB5D0DM@gerhold.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZqVXUI37fNB5D0DM@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2024 22:23, Stephan Gerhold wrote:
> On Tue, Jul 23, 2024 at 10:33:00AM +0200, Krzysztof Kozlowski wrote:
>> The APQ8016 SBC and MSM8916 QDSP6 sound cards are a bit different from
>> others: they have additional IO muxing address space and pin control.
>> Move them to separate schema, so the original qcom,sm8250.yaml will be
>> easier to manage.  New schema is going to grow for other platforms
>> having more of IO muxing address spaces.
>>
>> Cc: Adam Skladowski <a39.skl@gmail.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> .../sound/qcom,apq8016-sbc-sndcard.yaml       | 205 ++++++++++++++++++
>> .../bindings/sound/qcom,sm8250.yaml           | 137 ------------
>> 2 files changed, 205 insertions(+), 137 deletions(-)
>> create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml
>> new file mode 100644
>> index 000000000000..6ad451549036
>> [...]
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> index c9076dcd44c1..1d3acdc0c733 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> @@ -27,9 +27,7 @@ properties:
>>               - qcom,sm8650-sndcard
>>           - const: qcom,sm8450-sndcard
>>       - enum:
>> -          - qcom,apq8016-sbc-sndcard
>>           - qcom,apq8096-sndcard
>> -          - qcom,msm8916-qdsp6-sndcard
>>           - qcom,qcm6490-idp-sndcard
>>           - qcom,qcs6490-rb3gen2-sndcard
>>           - qcom,qrb5165-rb5-sndcard
>> @@ -58,18 +56,6 @@ properties:
>>     $ref: /schemas/types.yaml#/definitions/string
>>     description: User visible long sound card name
>>
>> -  pin-switches:
>> -    description: List of widget names for which pin switches should be created.
>> -    $ref: /schemas/types.yaml#/definitions/string-array
>> -
>> -  widgets:
>> -    description: User specified audio sound widgets.
>> -    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> -
> 
> These two properties are also valid and supported on all newer
> platforms, please keep them here! There are certain use cases where
> these are needed independent of the platform, e.g. to control an analog
> switch or mux connected to speaker or headphone outputs.
> 
> I agree that it is cleaner to move the IO muxing to a new schema though.
> Perhaps we could define something like a shared qcom,sndcard-common.yaml
> schema to avoid duplication for these generic properties? In the Linux
> driver, these are handled for all platforms in sound/soc/qcom/common.c.

This was added to the common driver code but it does not mean it is
reasonable binding. I don't understand why for example we even accept
here aux-devs, instead of putting them into one of DAI links.

The pin-switches and widgets could be used, but are they? The only valid
argument to keep them is that you added them to common driver code.

Best regards,
Krzysztof


