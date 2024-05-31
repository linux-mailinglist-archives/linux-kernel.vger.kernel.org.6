Return-Path: <linux-kernel+bounces-196347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39798D5A87
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9001A1F25010
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECA7F7D5;
	Fri, 31 May 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="eGq3ffqp"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DD2869B;
	Fri, 31 May 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136834; cv=none; b=NhWaMjE8FMDlndA+3rG+UCNrRVcSdUS9monSUX8udTFcfPJ1/n7QpeF7IVvC4zOviW0gvKERvBd1q1isbmHQwQaPkCZGPHaZ2LT9xsjmwpMqVNizIe1m2fMeH6JzlsJQMsdbftdb56MpyHyWNTC+3NbjXl9+DSCcqwI7XXYFJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136834; c=relaxed/simple;
	bh=Abqbmbv6m7OSx4SM6pPeuwsWyCF9/dkeA5rDX1J3QDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehvM7/ehoG4rxWZuJdHnFBJ0/Y21usXHXgfBDheKQOSy8pOt+8RqqHYUAFhRteMN+oEfprdYyLFm/8HRs0Vf2NoHOm1tXCVOsqD4XlGIwq6oS4L2Fb6g/3Wiez2K9QW27kbWjOcnImtobD6qsAEfhDSsa02kWJygQ/V/4mOOYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=eGq3ffqp; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81A0420002;
	Fri, 31 May 2024 06:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1717136829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zy1cnGQvTAxJdqW7P4KyXAC1ZaEpJr7PACoUts6QosE=;
	b=eGq3ffqp83/N1gLAgM8JYWcMvcCTRitzX5R1UGe8NF9hIj6IRPQxKc+O0DkNAUVaCRaHEK
	Ljy4ulf7UGl9dc2UFje8M4kD7urm6hNTQpAyI7aqgF58iw+0CJTGYrhkJB8+NFbc2jTRPk
	tt2bvi3JerB8Zs6FQaaw12LcsVgmXK6l5vbSKAH+3kJFw/G7OekLM4q8mHxZZd+JrhDe6T
	bwyEzlBAr2T3qm2X19yE1ZmN86Qt1uMTnUIrSuzlZyw3F9vrdCMqaNd5f4k2tgEa7EkiDh
	aTslJVDMa3bO1tkW0Ww9fsGoeYG2q7/YE70pjbutWesdQL8gsXef5idj0GV2Cg==
Message-ID: <512c2d0d-6f4e-48b5-825b-f56a5109dee8@arinc9.com>
Date: Fri, 31 May 2024 09:27:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Frank Wunderlich <frank-w@public-files.de>,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <aaaeb4b2-e57e-4d7b-b598-a664cc05b0cf@arinc9.com>
 <81944186-AFAA-4C8F-8E55-1AF4CBD97573@public-files.de>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <81944186-AFAA-4C8F-8E55-1AF4CBD97573@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 31/05/2024 09.18, Frank Wunderlich wrote:
> Am 31. Mai 2024 08:12:06 MESZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>> On 17/05/2024 09.27, Frank Wunderlich wrote:
>>> Am 17. Mai 2024 04:17:47 MESZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>>>> On 16/05/2024 23:48, Frank Wunderlich wrote:
>>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>>
>>>>> After commit 868ff5f4944a
>>>>> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
>>>>> the mt7531 switch on Bananapi-R64 was not detected.
>>>>>
>>>>> mt7530-mdio mdio-bus:00: reset timeout
>>>>> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -110
>>>>>
>>>>> Fix this by adding phy address in devicetree.
>>>>>
>>>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>> I don't like the mention of the Linux kernel driver on the patch log. What
>>>> you're fixing is the incorrect description of the switch's PHY address on
>>>> the DTS file. Whether or not any driver from any project is actually
>>>> reading it from the DTS file is irrelevant to this patch. That said, I
>>>> already have a patch series I've been meaning to send the next version of
>>>> that already addresses this. Please wait for that.
>>>>
>>>> Arınç
>>>
>>> Hi arinc,
>>>
>>>   From my PoV it is a regression in next/6.10 because the driver change was merged (without "broadcast" fallback) and the dts patch [1] is not.
>>
>> What is a broadcast fallback? 0x1f is just another PHY address.
> 
> Afaik 0x0 is some kind of broadcast address if real phy address is not known. The driver change seems not allow this 0x0 adress and forces devicetree to have the real address.

That's not true. 0x0 is just another PHY address. The driver change
actually allows reading 0x0 from the device tree and using that PHY address
to control the switch registers, instead of using 0x1f which was hardcoded
on the driver. But on the hardware, the switch actually listens on 0x1f.

Arınç

