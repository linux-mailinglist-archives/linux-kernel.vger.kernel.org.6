Return-Path: <linux-kernel+bounces-181694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F98C7FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A3C283FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49C5231;
	Fri, 17 May 2024 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="KY2G/WYp"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8E79CF;
	Fri, 17 May 2024 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912275; cv=none; b=RQ7IfdwtbB8EbvsfG/NwAJim50kT8OoRgkVrex4nwKdBX5apXQcKEsOq9xgLivEcJvUtJLKovxrmm90Nc5dbBe42+x/SUQDG0SSPXXDCnylagvlSP3fM2+m7hPrQoy7EmNQkuCR5Xqoi8xLCY1P80tCDW2iI2yhOaOEMtacY3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912275; c=relaxed/simple;
	bh=g57A5V+Sfsxdnh+yZ6gMwBZ5DBK4DQCuYjE0epwgfHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJw7lLIMa4RXRa72K/Q4md8jTw/YlXUIlG6sFp98a0I1DghWN5srY3EvuDXCKfbV7if/RDq/hdKVBpwF5hjgccMvVCAWeRMIxEum4UrBTTh6r1FtFq7ELn3a82oOn8qPM1dzNK5hwzJluT6l+MMNYX97JaahAvYSoktEsw08sx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=KY2G/WYp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98B1C40006;
	Fri, 17 May 2024 02:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1715912270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8LXtNuPs1T0FwCJ4tyBd0pKUOD1CJ/nDtHY2O0VUkQ=;
	b=KY2G/WYp0/vwq1jpNBxeQSt4VnFzz7zuDt2pCo9g9M55oqo9ueszQZenZhwt1QnS1BthhX
	WzN5s4b0QFc95b++3a2N/xq4777R7kavfVVgm7zSzYTmM6PeSgzmH4OrYiwCkeBfLb5DB2
	Yy4tczx7NwWpeNPJzjZSmctS3SlC+C3KPTkoq7X7ukxcQJq4Fo+ULQ3L3/Gehgcuf1RxDN
	U1QIur2aZ8UM1202wL3hk36BNclrXsf7Dyjj7nNWjDHohDC7T50qiOWlIkRrypqn/a+8OJ
	Gy2Vi9cLxCsjTLBwfVyG6gq0UR2LKfZOzKpaDfsbBxHQbEynZwwDYTiiNqVV0Q==
Message-ID: <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
Date: Fri, 17 May 2024 05:17:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>
References: <20240516204847.171029-1-linux@fw-web.de>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240516204847.171029-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16/05/2024 23:48, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> After commit 868ff5f4944a
> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
> the mt7531 switch on Bananapi-R64 was not detected.
> 
> mt7530-mdio mdio-bus:00: reset timeout
> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -110
> 
> Fix this by adding phy address in devicetree.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

I don't like the mention of the Linux kernel driver on the patch log. What
you're fixing is the incorrect description of the switch's PHY address on
the DTS file. Whether or not any driver from any project is actually
reading it from the DTS file is irrelevant to this patch. That said, I
already have a patch series I've been meaning to send the next version of
that already addresses this. Please wait for that.

Arınç

