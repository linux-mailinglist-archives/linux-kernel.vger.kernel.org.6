Return-Path: <linux-kernel+bounces-196335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74008D5A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBBBB250CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74627D40B;
	Fri, 31 May 2024 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="D0mi+kUA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DB3F8FB;
	Fri, 31 May 2024 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135934; cv=none; b=l1P0vafh52J/Fhh4ATlSMGer0ZU9Whz0AbDpv2YtLm5PuxXxi3k5MFzGL+J/anr9v29aRxizF/uANrb88Senzt1HZA/HBWiZ5QRWtDxaLAQmD3J0zWEj6UMlg4SluAYx4wG5ZPJ93Iwk13VcvoZjdgMi5W8N0S2w016ltNGA39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135934; c=relaxed/simple;
	bh=IuPngLtZwZOcdvzTEyXnPo1R5atzTCaIjZbLuOCpQIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T78MYOVs07HQPil/uDkAiSo+YRQHGBH3hfvlMLhYXbHY74SE1s6h14nRsknFGwc00CyN0ip1/wbBaNmsr//lwsnvx2H8NHz4NM76BvG0ea0TB8RgvAbL2sEjpTlctT/5bMN+bmqbDA6SZnvwXajOV/fMgNsSztGyXC7sfQMsjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=D0mi+kUA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A12161C0004;
	Fri, 31 May 2024 06:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1717135930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogNqXL0ApIs13zC/uLEPr6wCJVu7uWiXb0gYZeNG97o=;
	b=D0mi+kUARIW/Xiq4qgyPzhxwk2SU672KDO6+AgpFmL1CaodK3HoZxficaZsRgKxd+Y6ld4
	xTgv207ezmVW/JUCqfr7ts5OZaIl9J62KLyWJ7Cw07ev+gknGRuxB9NOM86jV7jo+EOcEO
	qqGiFpFFJTtXWcAqdCTEvPvqvq7mf0K/UTxfjLED4uuP7pKMsCMIDkLGukpDiyCNa5t1Bt
	gSllCuRStlW+yiCQpv+e8AUZeYFKwwWeEeeImrUMsqncDGXSDplQAZg1ePVa2XxvR8zsrI
	oPgVCSLqGDIOiS9Undmxf6hCgATSJ29i/+f7ycdAjVYaVB/RkhPXXd6lCAl36g==
Message-ID: <aaaeb4b2-e57e-4d7b-b598-a664cc05b0cf@arinc9.com>
Date: Fri, 31 May 2024 09:12:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 17/05/2024 09.27, Frank Wunderlich wrote:
> Am 17. Mai 2024 04:17:47 MESZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>> On 16/05/2024 23:48, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> After commit 868ff5f4944a
>>> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
>>> the mt7531 switch on Bananapi-R64 was not detected.
>>>
>>> mt7530-mdio mdio-bus:00: reset timeout
>>> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -110
>>>
>>> Fix this by adding phy address in devicetree.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> I don't like the mention of the Linux kernel driver on the patch log. What
>> you're fixing is the incorrect description of the switch's PHY address on
>> the DTS file. Whether or not any driver from any project is actually
>> reading it from the DTS file is irrelevant to this patch. That said, I
>> already have a patch series I've been meaning to send the next version of
>> that already addresses this. Please wait for that.
>>
>> Arınç
> 
> Hi arinc,
> 
>  From my PoV it is a regression in next/6.10 because the driver change was merged (without "broadcast" fallback) and the dts patch [1] is not.

What is a broadcast fallback? 0x1f is just another PHY address.

Arınç

