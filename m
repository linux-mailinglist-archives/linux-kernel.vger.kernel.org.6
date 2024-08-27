Return-Path: <linux-kernel+bounces-303139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71C9607F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AF11C22950
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB2619EEA0;
	Tue, 27 Aug 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSxo0GdF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2419DF41;
	Tue, 27 Aug 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756074; cv=none; b=iMYqP116i6hFZMYTnBwkgJjWL8TNpWCOnH3cL3LeC6517WcO1FU1Xvex1vd8478Jy6L3+d5FeUSBuaBgiOsSLWbCsu/Xvc3X9GVLpNOTMFom/hAn/g2ZTtA2dws3L4cgmbMe2/0zg3xVZlsuFs+RJ4mOhw3OODZivrgWeoCMuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756074; c=relaxed/simple;
	bh=qr/Hp6BBFcGFu44bjDTuyx3scvk00Z3ynq+fe/9+cyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DubUW4Qp7PI+ShSyVOiYY3ScAgGXWMiFYCZQzmMRYApCaVU6yM+5AL/QM7inHM9fgYwD8rpzAoTLceDYHcGGgVzqwoTicx8RX3hV5EdR54flXV1UPstko9SqoW6C694YVzUumRuopxMXV2YcM9pP5/dGoMIxt5OLoOkAhkNqsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSxo0GdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F230AC8B7A4;
	Tue, 27 Aug 2024 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724756074;
	bh=qr/Hp6BBFcGFu44bjDTuyx3scvk00Z3ynq+fe/9+cyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eSxo0GdFbLfp/4tg60/bYyM+xfouKSvTasqRcSHD8ajTaLcw1CQ/ESWVxu4zL4+BA
	 F+kaiedylFmYhNYkX+l2DpL+I2tosLgj0A9tIWw17o+8qCnyAERovtKmZLWRMuH7C0
	 tEDtB7O6CBjiemTm/d7y+AN/cgymuzgud2TKIeY8SzFvDJaT7m7WfyltjM/EUipti0
	 oZ9VHsyC8VgAEHbWCdbWStLqVRtE0He16bAG0dtKZUoUExh7VQG4gauOVifuMK0ARi
	 86xaBGLd5nCQiLKOkWXdnbRpZM164PXRD+uLRA2MnFqF+YjLC+kfbZIocxp56u5cuG
	 SpupcX252urkA==
Message-ID: <344418a4-0365-40f0-a4d6-380fbfbf96dc@kernel.org>
Date: Tue, 27 Aug 2024 12:54:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>
 <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
 <6c28d580-9961-4bac-adcd-1724de68c9fb@siemens.com>
 <0ca0fc20-421e-4bbc-bcda-9e5c2ea3b1b4@kernel.org>
 <2bb6b337-d83b-4cbe-aff2-bbd0c7d17c2b@siemens.com>
 <ada462d5-157a-4e11-ba25-d412a2bb678f@ti.com>
 <da47dd71-18fe-4474-adec-d4f1571c02f2@siemens.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <da47dd71-18fe-4474-adec-d4f1571c02f2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2024 12:46, Jan Kiszka wrote:
> On 27.08.24 12:06, Siddharth Vadapalli wrote:
>> On Tue, Aug 27, 2024 at 11:32:02AM +0200, Jan Kiszka wrote:
>>> On 27.08.24 11:29, Krzysztof Kozlowski wrote:
>>>> On 27/08/2024 11:22, Jan Kiszka wrote:
>>>>> On 27.08.24 08:37, Krzysztof Kozlowski wrote:
>>>>>> On Mon, Aug 26, 2024 at 11:50:04PM +0200, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> Describe also the VMAP registers which are needed in order to make use
>>>>>>> of the PVU with this PCI host. Furthermore, permit to specify a
>>>>>>> restricted DMA pool by phandle.
>>>>>>
>>>>>> That's an ABI break without explanation why it is necessary.
>>>>>>
>>>>>
>>>>> It is needed in order to support the PVU, as written above.
>>>>
>>>> Above say only that you want a new feature and that's not really
>>>> suitable explanation for ABI break, because answer to this is: add new
>>>> feature without breaking existing users. But maybe there is a bug or
>>>> something does not work or never work or there are no users, don't know.
>>>>
>>>>>
>>>>> Previous versions of this binding likely didn't consider this use case
>>>>> and therefore didn't describe all registers associated with the hardware.
>>>>>
>>>>> BTW, if you see a way to add the required registers without breaking
>>>>> more than needed, I'm all ears. At least the kernel driver will continue
>>>>> to work with older DTs when you disable PVU support or do not add a DMA
>>>>> pool to the DT.
>>>>
>>>> If there is no ABI break, because driver still handles correctly old
>>>> DTB, then mention it in the commit msg.
>>>
>>> Well, this is strictly spoken not a topic for this commit because this
>>> one should have no clue about what drivers do with DTs according to this
>>> binding. But I can put a hint and go into details in the driver patch.
>>
>> Based on the Techincal Reference Manual for AM654 and the driver
>> implementation in patch 5/6, I think that the following might be one way
>> of hinting that ABI won't break:
>>
>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices to
>> specific regions of host memory. Add the optional property "memory-regions"
>> to point to such regions of memory when PVU is used. Since the PVU deals
>> with system physical addresses, utilizing the PVU with PCIe devices also
>> requires setting up the VMAP registers to map the Requester ID of the
>> PCIe device to the CBA Virtual ID, which in turn is mapped to the system
>> physical address. Hence, describe the VMAP registers which are optionally
>> configured whenever PVU is used for PCIe.
> 
> Thanks, will reuse this!
> 
> Additionally, we should then likely do
> 
>   reg:
>     minItems: 4
>     maxItems: 6
> 
> to underline that the old form is still fine. Do I need to do anything
> to reg-names then as well?

They need "minItems: 4".

Best regards,
Krzysztof


