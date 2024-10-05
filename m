Return-Path: <linux-kernel+bounces-351726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67840991567
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1562826EE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89FE13BC18;
	Sat,  5 Oct 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOZoAAsB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CD3F9D5;
	Sat,  5 Oct 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118444; cv=none; b=fsWP8cAHGe/mE3GOazPtPdV7LJLKVnS+rtKQc+R1D2YAK7qxWAytzg3AzBGsRAxJJGTU4Wjg7LduW/IddHPNJ9pNU9C6DhgLAnAjLer7qOb7KVKsuHdH98i9cvBRWIyTZEypXr+LXd5e5UlNjhfqfkdHvL8oTwbKUsi6C9DyLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118444; c=relaxed/simple;
	bh=eBx4vbY7QxRu2L5YvQ0tTJWgaUAJhUNKVZYzfl/hPqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSWrG4/ILvLDlOga9up5nBBX2HriqjyFTScFf5seg3JmFx2CxjBv5cxEZqyNTIj6i/eSPkP4yJQe8ATPl8YOpGQl6EL/qo8FeMUWUj0PlRWTluYYBX5nblGx3o8Wq+VCr9O9eS3L/KLjtuKaQd4Wiurv4jfuM4JcFQDMDa0a/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOZoAAsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB36C4CEC2;
	Sat,  5 Oct 2024 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728118443;
	bh=eBx4vbY7QxRu2L5YvQ0tTJWgaUAJhUNKVZYzfl/hPqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pOZoAAsBrSD+JtI+63+ztivU1s+y2u6ZSnrt5D+vewMrOmY2M1/pfUQz4yuXJjYqb
	 hO6s//X5+k/39iaGdK246+qEqKGpX2zby4RR3KIpyzLmI5p4fq8/WKXcICXSMlptOX
	 /InhYI5psWZSD98D/DuKowupu5HlL6OxFNs1MVTnpovP8fH/OxezRqx5ta1PvBG4FL
	 kHGnsZu5Gv5fcvEA9i4dnCab/2VIWPIoCEETCeBfp0XkXQQWXrOYtwM8aIugKurzLK
	 ID9qcAGeNBIEDrhleeCtbMlzZX2Mc/WFhOuU6AZb5jc+kdMD6PmaDPISk0l7fmsLNh
	 az95B52VfnlLQ==
Message-ID: <b273cddb-274c-4d88-935e-c94b8d94188e@kernel.org>
Date: Sat, 5 Oct 2024 10:53:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based
 on BCM4906
To: Sam Edwards <cfsworks@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney
 <kursad.oney@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241003220820.1345048-1-CFSworks@gmail.com>
 <20241003220820.1345048-2-CFSworks@gmail.com>
 <3okd7byomwmo5vjsyaaxsorhn6ldw3mp3k6whcklqnw2stx5tm@jpv2e5ydswzw>
 <80a9ec34-52eb-41fa-b068-3c9552065927@kernel.org>
 <CAH5Ym4g9hmX3mT5+Eqm=KHKYd+s_PM4qdho2a8FkAZmhMHOV4g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAH5Ym4g9hmX3mT5+Eqm=KHKYd+s_PM4qdho2a8FkAZmhMHOV4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/10/2024 19:21, Sam Edwards wrote:
> On Thu, Oct 3, 2024 at 11:51 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 04/10/2024 08:49, Krzysztof Kozlowski wrote:
>>> On Thu, Oct 03, 2024 at 03:08:19PM -0700, Sam Edwards wrote:
>>>> This is a series (EX3510-B0 and EX3510-B1) of residential gateways based
>>>> on BCM4906, a stripped-down version of the BCM4908 SoC. Although Zyxel's
>>>> marketing materials call this a "series," the EX3510-B1 appears to be a
>>>> very minor revision of the EX3510-B0, with only changes that are
>>>> transparent to software. As far as Linux is concerned, this "series"
>>>> effectively represents a single model.
>>>>
>>>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> 
> Good day Krzysztof,
> 
>>>
>>> Can you use the same email as for SoB?
> 
> I have sent patches to the LKML from a work email before, but I just

That's not what I asked. You can send them from whatever, I asked that
commit identity should match SoB in exact way.


> double-checked that I am using my personal email for everything here:
> 
> $ git show ec8e6d96a05f04 | grep -E 'dt-bindings|Author|Signed'
> Author: Sam Edwards <CFSworks@gmail.com>
>     dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
>     Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> $ grep -E '^From|^Signed'
> outgoing-ex3510b/0001-dt-bindings-arm64-bcmbca-Add-Zyxel-EX3510-B-based-on.patch
> From ec8e6d96a05f04df00d05dec00df80172d233d8c Mon Sep 17 00:00:00 2001
> From: Sam Edwards <CFSworks@gmail.com>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

So apply the patch from the mailing list and you will see:

Author: Sam Edwards <cfsworks@gmail.com>
Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Best regards,
Krzysztof


