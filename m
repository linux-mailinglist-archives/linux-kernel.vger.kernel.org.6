Return-Path: <linux-kernel+bounces-284330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D994FFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826B71F255D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C413AD3D;
	Tue, 13 Aug 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FahVQ5sH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736504D8DA;
	Tue, 13 Aug 2024 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538100; cv=none; b=ubUnPhftZARjSiKbUmN5W8cLJXJuASKf55zpFmmr66sNCuY7fv7J2Zqace3/olw1OVHRrglOEx8xCv4vV2ZY3YKLEkhNNHEHVBh8luSU0/XHW/2qJnaDqIi5y2FMTJjQkFZGua4wVLeYGf1ddtCrrI61RHx4Un88k4zRd2M7wyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538100; c=relaxed/simple;
	bh=AFskdL3uVLYDRKCA4/Foms4uqtBOZBMltps5iV9rnUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6iumRnkVOZJOm9g67CE3CZP/pCuSidseoqchNs8SJGSFIyZvwULpdd5RW3bDprb+2b3ORGsEGim+rJoTpAGBr/z9yStmDBvXj46QSoaVjyFVERBNErvDZWYlfk2qpk2qmRQH10shOEk2hbLytRw7V0P1Nk+OXs6Ab+1FJNO0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FahVQ5sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99561C4AF10;
	Tue, 13 Aug 2024 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538100;
	bh=AFskdL3uVLYDRKCA4/Foms4uqtBOZBMltps5iV9rnUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FahVQ5sHSjoHyZx8l8c8k7h9Stk6RrOmiuB9bjlXsWntFmD4PZGL4Nn6pBf2jJbUN
	 KyVnBBJaZtIOJrix5aMtI8RY3qkEIZ16gBvxlnZGd1HkwjM9BYfuggzhQIxbx00xjZ
	 Z0lVYpLjNqjOB8iVkRBPonCLLM4HeecwYFOWY40xrTR6+vZ5ShI56dXNhiaYVZbA/t
	 4hFp75CoIaLGv0CgTjdcIQqcy8mT+XVJ4WxV/X8N5k0m3mXRLP+xuQju9UKtX78bgE
	 UUkcSlX+vQjyrBxBkeT5g/Pq8pggEfdJZanR5pg38/Dsp5tDHHz/8JbObH3nkmxftt
	 AwMDnmaPXHbsw==
Message-ID: <d9060b49-66fe-4001-86cd-dda5e213e454@kernel.org>
Date: Tue, 13 Aug 2024 10:34:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sa8775p-ride: Add QCS9100
 compatible
To: Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806-add_qcs9100_soc_id-v1-0-04d14081f304@quicinc.com>
 <20240806-add_qcs9100_soc_id-v1-4-04d14081f304@quicinc.com>
 <90eae361-7d5d-440f-a85d-dfd81b384fe7@kernel.org>
 <4a350e94-3c95-48e1-9ea8-ced483c1aa45@quicinc.com>
 <14ec06bd-0c27-4930-8bce-d3f5b68067ed@kernel.org>
 <ace5b3e1-f4a2-4c04-821a-e797d0f55cae@quicinc.com>
 <9323127a-e6b5-4835-afa0-4ce0086fd9d1@kernel.org>
 <0d1c44b9-3d5f-4d93-af64-1756e52f4fe3@quicinc.com>
 <47c966c7-8736-44a2-8ec7-4d7989efa9cd@kernel.org>
 <72b2d710-a7cb-45cf-9dad-e9fbd876697b@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <72b2d710-a7cb-45cf-9dad-e9fbd876697b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/08/2024 09:07, Tingwei Zhang wrote:
> 在 8/12/2024 2:15 PM, Krzysztof Kozlowski 写道:
>> On 12/08/2024 04:16, Tingwei Zhang wrote:
>>> On 8/8/2024 7:05 PM, Krzysztof Kozlowski wrote:
>>>> On 07/08/2024 13:04, Tingwei Zhang wrote:
>>>>> On 8/7/2024 5:35 PM, Krzysztof Kozlowski wrote:
>>>>>> On 07/08/2024 11:17, Tengfei Fan wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 8/7/2024 3:28 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 06/08/2024 06:19, Tengfei Fan wrote:
>>>>>>>>> Add QCS9100 compatible in sa8775p ride and sa8775p ride r3 board DTS.
>>>>>>>>> QCS9100 references SA8775p, they share the same SoC DTSI and board DTS.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't understand this. You claim here that QCS9100 references SA8775p
>>>>>>>> but your diff says other way: SA8775p references QCS9100.
>>>>>>>>
>>>>>>>> Sorry, that's confusing.
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Krzysztof
>>>>>>>>
>>>>>>>
>>>>>>> I will update the compatible as follows to indicate that QCS9100
>>>>>>> references SA8775p.
>>>>>>>
>>>>>>> compatible = "qcom,sa8775p-ride", "qcom,qcs9100", "qcom,sa8775p";
>>>>>>
>>>>>> Is this still correct, though? sa8775p won't come with qcs9100 SoC.
>>>>> We have a new board. Hardware is same as sa877p-ride except sa8775p is
>>>>> replaced with qcs9100. We add qcs9100 SoC compatible to sa8775p-ride
>>>>
>>>> Does "new board" mean that "old board" disappears? No users to care
>>>> about it? Or just the existing board is being changed (like new revision)?
>>>
>>> We will support both boards. Sa8775p-ride board with sa8775p chipset and
>>> sa8775p-ride board with qcs9100 chipset. Both of them can be used for
>>> development.
>>
>> Patch does something else then - changes compatibles for the existing
>> (old) board.
> 
> Can you educate us the right way to add the qcs9100 SoC support in 
> sa8775p-ride board? We don't want to duplicate whole device tree file 
> since all the hardwares are same except the SoC, so we add qcs9100 SoC 
> compatible to sa8775p-ride board and still keep sa8775p SoC compatible.

Split board DTS into shared DTSI (just don't forget about proper
-M/-C/-B arguments for format-patch) and include it in relevant boards.
You also need new SoC DTSI. This will be unusual code, but it matches
what you want to achieve.

Best regards,
Krzysztof


