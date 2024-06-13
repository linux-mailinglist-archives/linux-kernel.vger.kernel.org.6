Return-Path: <linux-kernel+bounces-212594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1E9063C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52061F22ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F6B136E09;
	Thu, 13 Jun 2024 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+0pv7QH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD340135A4B;
	Thu, 13 Jun 2024 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258968; cv=none; b=N0Dr9p54C4KgYxJGMdrQL3xDzM7Kti+jP+LMOmutNskEQ2eHkoAMAYXZJcWHKrzIV6D4SlczcxHnmVluIJGs+3QiYNENcC2tOzNbf/09m19kBKw1Ls7TQHpDATOMpMm+LwHfifMSUTzDblyu/pspegPtDQg7Mb96w5RPsmK4c/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258968; c=relaxed/simple;
	bh=bbKEWwxPZT1MGbNUJwasQJFcX1zxr/x5+hhhJZnpu2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2cyG1DGFmaCClM2fQrbs3raXtxbWTU+mI+xDskWq+P0lFZzrj3SYU8h7xlrLjQ8W3DsgF4hTptBeo5u9JF33Oua/MHCUyVlwOGTkIs6+BpPL8yKzFDzwyDlu4Ry+tiQoJ6DjVZgEwIoFJ45BW4xjIxuL9kLT1cEPuwxpBtQSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+0pv7QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92148C2BBFC;
	Thu, 13 Jun 2024 06:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718258968;
	bh=bbKEWwxPZT1MGbNUJwasQJFcX1zxr/x5+hhhJZnpu2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l+0pv7QHW3Uo1aG1Nam8Rb0tUCcz94L4ehaSclgjQs0By5gn20C+2G3C/VSfpM6hU
	 XTRg6JQaIuGV9tXr6N4QXUOL5TQKBlSfLy2k02D5lvBXMuH5p6FwPGAZpQJjPCQ5+9
	 r23/SEQLrdzzdAK4xK6d6Zvs83RZ0N1M4Ucg12mYTT6mNiZYlnwRWvGMbU/9qzqX28
	 gSQ/TPSShofnZ0WaVywtGDbYzkSep0O3ZRQD9CYbGJ0PCSY/4ahmN2LFj+RwY8l3n2
	 0BRgIqlCf7/x9r5DLlK9g1OwHtqjhFNWfnjyyLuf8PnUba8wzuVXeW7O5ZWO6Qvn3V
	 hB/iAA3r57lMA==
Message-ID: <3275676c-7392-47ac-8345-808681462003@kernel.org>
Date: Thu, 13 Jun 2024 08:09:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2, 1/3] dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, balbi@kernel.org, devicetree@vger.kernel.org,
 joswang <joswang@lenovo.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130004.25662-1-joswang1221@gmail.com>
 <9c665afe-16d7-469e-ac3e-d0d7388a31b7@kernel.org>
 <CAMtoTm1ojhCSRb4c+MPjuJB+JaeD2ex6B7FpCaJtLvrTj0Q8Cg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAMtoTm1ojhCSRb4c+MPjuJB+JaeD2ex6B7FpCaJtLvrTj0Q8Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2024 16:28, joswang wrote:
> On Tue, Jun 4, 2024 at 2:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 03/06/2024 15:00, joswang wrote:
>>> From: joswang <joswang@lenovo.com>
>>
>> Is this your full name or known identity you want to use for all kernel
>> contributions? Looks like login...
>>
>>>
>>> There is an issue with the DWC31 2.00a and earlier versions
>>> where the controller link power state transition from
>>> P3/P3CPM/P4 to P2 may take longer than expected, ultimately
>>> resulting in the hibernation D3 entering time exceeding the
>>> expected 10ms.
>>>
>>> Add a new 'snps,p2p3tranok-quirk' DT quirk to dwc3 core
>>> for enable the controller transitions directly from phy
>>> power state P2 to P3 or from state P3 to P2.
>>>
>>> Note that this can only be set if the USB3 PHY supports
>>> direct p3 to p2 or p2 to p3 conversion.
>>>
>>> Signed-off-by: joswang <joswang@lenovo.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index 1cd0ca90127d..721927495887 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -242,6 +242,13 @@ properties:
>>>        When set, all HighSpeed bus instances in park mode are disabled.
>>>      type: boolean
>>>
>>> +  snps,p2p3tranok-quirk:
>>
>> Why this cannot be deduced from compatible? Which upstream SoCs are
>> affected?
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thanks for your help in reviewing the code
> DWC31_USB 2.00a and earlier versions IP bug, regardless of platform.

So this can be deduced from compatible, then use quirks in the driver
based on compatible and drop the property.

Best regards,
Krzysztof


