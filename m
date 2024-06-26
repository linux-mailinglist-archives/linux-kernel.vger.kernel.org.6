Return-Path: <linux-kernel+bounces-230203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8CF9179C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F49F1F230BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AB715B115;
	Wed, 26 Jun 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMuIKT0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8911FBB;
	Wed, 26 Jun 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387214; cv=none; b=gM/Lyj9K7wyvTVuGm8DDVrlWG35jQcsQTmVjVF0HzoY09PoxBFQFd1tThgMaIWvSHmYpoIP9GYPT0sj9rZvt0/ts2VStGdAzEqRLDrW1bwk7fEOaptOudx5qLpVgdSHtAtwUUD8pPJ4aUSuJm4FHzcqLTRouNmdLZf+c3YwGHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387214; c=relaxed/simple;
	bh=6jirXN/OoV3yU2W+vvPXeYDV0BuubNdjDGTAIzsegyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V015U3IiatoHDTdVGX4DSePXW0dlg21mMdQLaaWvg3QTtv+Z3/xzHPe+ra0NXt4yhQa/VbXumOoOVyTtmoQqaKrEhMwuhmIB7nCjWjyGXXaEB7lNoLNDz/FbchHPPaECbKB055D2cfI5r/WU8UVPgsjfIPjey2jy17t4HBD39K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMuIKT0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED2EC32789;
	Wed, 26 Jun 2024 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719387214;
	bh=6jirXN/OoV3yU2W+vvPXeYDV0BuubNdjDGTAIzsegyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AMuIKT0FsA3zYaek6ZuV4Rv2nj52/QzU0o/VJ1ynExVwcXIx8xsPgwnUndpcIvZFB
	 eW6NO4znE4RngRgmPF6Vdi5fWwztON7c21xLH3TWDnK7N5sqz2xPVNHdSxcB5hW7ZQ
	 PyIcKhaM8f7kCDx+YtSlDBbNFNjYDm1RCIUi3AwstfxokKnVAlYouh5dcqbCvCvh6I
	 GMRYQgQUNq3syT2aQjBn1M4hNi/GzyVsYwlqG6M8UYW064RzMH0qsocV8EGU1+u9WU
	 44Z4ct+ZRsQR6OLQJW75lAOcWmI3ArEKBLClibeRFBQZ89I1rQTs5bYImuNwvV0Lfo
	 cDo9nOlUapPVA==
Message-ID: <643ad6b3-3bbc-4a5d-ac47-6368f2171e87@kernel.org>
Date: Wed, 26 Jun 2024 09:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: allow ethernet
 controller in ICSSG node
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Suman Anna <s-anna@ti.com>
References: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
 <89880cda-1140-4ed5-a67f-2201c2825447@kernel.org>
 <99cc7afbb891de890ff051606f7a120f796e0fbc.camel@ew.tq-group.com>
 <14bebdc5-3239-47fe-b8cc-68daba278d73@kernel.org>
 <7adcd6789fb33fef10b7349934374e2cfb5ad164.camel@ew.tq-group.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <7adcd6789fb33fef10b7349934374e2cfb5ad164.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2024 10:48, Matthias Schiffer wrote:
> On Thu, 2024-06-20 at 10:29 +0200, Krzysztof Kozlowski wrote:
>>
>>
>> On 20/06/2024 10:26, Matthias Schiffer wrote:
>>> On Thu, 2024-06-20 at 09:24 +0200, Krzysztof Kozlowski wrote:
>>>> On 19/06/2024 13:24, Matthias Schiffer wrote:
>>>>> While the current Device Trees for TI EVMs configure the PRUSS Ethernet
>>>>> controller as a toplevel node with names like "icssg1-eth", allowing to
>>>>> make it a subnode of the ICSSG has a number of advantages:
>>>>
>>>> What is ICSSG? The sram or ti,prus from the ethernet schema?
>>>
>>> ICSSG (Industrial Communication Subsystem (Group?)) is the main device described by the
>>> ti,pruss.yaml binding (ICSS and PRUSS are different variants of similar IP cores); it is the
>>> container for the individual PRU, TXPRU and RTU cores which are referenced by the ti,prus
>>> node of the Ethernet schema.
>>>
>>> The entirety of PRU, TXPRU and RTU cores of one ICSSG, each with its own firmware, forms one
>>> Ethernet controller, which is not quite a hardware device, but also not a fully virtual software
>>> device.
>>
>> So it is not really child of ICSSG.
>>
>>>
>>> The Ethernet controller only exists through the various ICSS subcores, so it doesn't have an MMIO
>>> address of its own. As described, the existing Device Trees define it as a toplevel non-MMIO node;
>>> we propose to allow it as a non-MMIO child node of the ICSSG container instead.
>>>
>>> If you consider moving the ethernet node into the ICSSG node a bad approach, we will drop this patch
>>> and try to find a different solution to our issue (the Ethernet device staying in deferred state
>>> forever when the ICSSG node is disabled on Linux).
>>
>> Just disable the ethernet. That's the expected behavior, I don't get
>> what is the problem here.
> 
> If the disabling happens as a fixup in the bootloader, it needs to know the name of the Ethernet
> controller node (or iterate through the DTB to find references to the disabled ICSSG node).

Which is already solved for several such cases, including ethernet
devices? Aliases?

> 
> The name is currently not used for anything, and not specified in the binding doc; the example uses
> "ethernet", which is too unspecific, as there can be multiple ICSSG/PRUs, with each running a
> separate Ethernet controller.

Use existing solutions - aliases.

> 
> Existing Device trees use "icssgX-eth" for an Ethernet controller running on the ICSSG with label
> "&icssgX", but labels are a source concept and don't exist in the compiled DTB by default.
> 
> I do have an idea for an alternative approach that does not need changes to the DT bindings: The PRU
> Ethernet driver could detect that the referenced ti,prus are disabled and not just waiting to be
> probed and then fail with ENODEV instead of EPROBE_DEFER.

Sorry, but re-shuffling nodes into incorrect hardware description is not
the workaround for your problem.

Best regards,
Krzysztof


