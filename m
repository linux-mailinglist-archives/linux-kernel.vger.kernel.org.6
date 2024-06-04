Return-Path: <linux-kernel+bounces-200094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B3B8FAA9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7540B239A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEECB13DDC2;
	Tue,  4 Jun 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiRWoCFS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117565F;
	Tue,  4 Jun 2024 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481979; cv=none; b=AlWLQv0ljuADiLayl8dYF/unZYtqu9RU4U35IEtnFkbrrdbPKjoIJqlA9ESFeuIcnIB9AVtdZyY7XfMS7p7qKJU+Kc/CaFW5kovP6YxDjDEoM5NiR4EErkpVlo6niqv2Lpx9SqRck0lzIYpzp38EVgNPYbowrJ4GOJNo3UAQGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481979; c=relaxed/simple;
	bh=jcUhSm+IFc5ARpltnuHkZQXo0zlpHAcNMJd72okD0uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b208jq6fLthPjTicr711UB50XMhk0hBbLEsNwXsQBSKZow1T0Tkqn7lQmNCMpFQjJj0g2AUQzDwEJe7lRfnAryh+lmja9bbntuGtfooRr4zA9v0QFwmN029KvPJOB5yXFkWBXLlU2JM7U4E2906Rc4Rtm22PK8ZEDuDKjdHO8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiRWoCFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0595EC32786;
	Tue,  4 Jun 2024 06:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717481978;
	bh=jcUhSm+IFc5ARpltnuHkZQXo0zlpHAcNMJd72okD0uE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OiRWoCFSvrCAhVhMBftLMawr+HikFitL+h6ljQAnWe8KsZ3S0F5Rp6tVKNMU8ygG7
	 dWqoUQFMCdnQV0X8diy5iB3uprWTHMJt/cA/g2dAgs4eNGyKQGmoVP9uFhuH8NiYTp
	 6TLyPu0BbHytfy1pIMh1TwGnmc56EyUIJjVJOjkSEsuSE6ZpEE3TmT2CEnRmzXQm4q
	 eZuOw+SEFUGy421II3H5EkbascivCMdhAPbJWxdZns9MV1g1zaDtr6A3xQjwvF8E70
	 TbNN7K7lY+hVZl3iI003swxTqEDTiVz7vVdUvl3knEOGTbvjusQY+Cshkopa7e9TVd
	 /sZMq7RwIqpCg==
Message-ID: <6a9253b4-d28d-400e-a37b-d98431a4aecc@kernel.org>
Date: Tue, 4 Jun 2024 08:19:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: usb: snps,dwc3: Add
 'snps,xhci-write-64-hi-lo-quirk' quirk
To: Jung Daehwan <dh10.jung@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <balbi@kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
 <CGME20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7@epcas2p3.samsung.com>
 <1717135657-120818-2-git-send-email-dh10.jung@samsung.com>
 <57966949-8080-4aa5-8d38-63ded1c2b467@kernel.org>
 <20240603030316.GA23593@ubuntu>
 <eb13e81c-2669-4e82-86eb-d61203475962@kernel.org>
 <20240603083657.GE23593@ubuntu>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240603083657.GE23593@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2024 10:36, Jung Daehwan wrote:
> On Mon, Jun 03, 2024 at 08:57:16AM +0200, Krzysztof Kozlowski wrote:
>> On 03/06/2024 05:03, Jung Daehwan wrote:
>>> On Fri, May 31, 2024 at 10:10:30AM +0200, Krzysztof Kozlowski wrote:
>>>> On 31/05/2024 08:07, Daehwan Jung wrote:
>>>>> Add a new quirk for dwc3 core to support writing high-low order.
>>>>
>>>> This does not tell me more. Could be OS property as well... please
>>>> describe hardware and provide rationale why this is suitable for
>>>> bindings (also cannot be deduced from compatible).
>>>>
>>>>
>>>
>>> Hi,
>>>
>>> I'm sorry I didn't describe it in dt-bindings patches.
>>> It's described in cover-letter and other patches except in dt-bindings.
>>> I will add it in next submission.
>>>
>>> I've found out the limitation of Synopsys dwc3 controller. This can work
>>> on Host mode using xHCI. A Register related to ERST should be written
>>> high-low order not low-high order. Registers are always written low-high order
>>> following xHCI spec.(64-bit written is done in each 2 of 32-bit)
>>> That's why new quirk is needed for workaround. This quirk is used not in
>>> dwc3 controller itself, but passed to xhci quirk eventually. That's because
>>> this issue occurs in Host mode using xHCI.
>>>
>>
>> If there is only one register then you should just program it
>> differently and it does not warrant quirk property.
>>
> 
> Could you tell me why you think it does not warrant? I think this is
> good to use quirk.

Because it is a fixed case, deduced from compatible. No need for a
property for this.

Best regards,
Krzysztof


