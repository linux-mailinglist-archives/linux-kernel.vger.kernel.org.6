Return-Path: <linux-kernel+bounces-187353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2448CD08F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A3B1C228C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C72144D29;
	Thu, 23 May 2024 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pNS7gjd8"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9F142E67;
	Thu, 23 May 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461069; cv=none; b=Xs3Q4JLNUzgFw4dghPBMKY+KzhppOYOUvzJGJpAxuTwmrqgSE+hFZTVwx5TBT+CK+ujddxwF//5FRBnLF5SV+BLtQ/TtzONbFYhPAyih3KpXGe5g7g59hyh/9N3TpCPjVpLmlXurHKfDvOMNSaa2zCrOOlYsQnM5OhaEu9OZ/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461069; c=relaxed/simple;
	bh=EZXFT71T2+Ibou+M+wWG08vBeRU6I7wQ7CjzDa+dPVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKPq0LKGlCbvV4NLZvrsFUB+5TPlnArFnHB+E828QIznF9OXxiGo1ijGZj7Wb7RoyyE1eBG/YSLXUevjOgzmThtJdDsgB53M7sx8eLUPNseHxhA2nrFLneypS2DTbw5Jdug/uga10MaEHMElsUgwz15Ncgxl/MYAhyTgEssa61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pNS7gjd8; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=vi5TPBBd99tv8Xmgnv/pBsNDXNH3b9oonqkMaft58mA=;
	t=1716461067; x=1716893067; b=pNS7gjd8nWXYq8+qmp8glq/uIhGjFUJzdCESU7xXRbXkD/a
	R0++GGUNYI0qS36zbyRn5LY7+h9EA05byPx4k0X7JFyoUXSFMyhUwtHVWH3WPXOtQQ3tDLszy/kOV
	iSu0A8ojMlREJUk+adRMFR8Hf5bP8tG7iSn0FW2W/2bXJDMjRO2A+jUWuaMLYB6HPFgOeevY3bb5n
	wdx0jh49HTq5Wrgg/lt4GpKBnoD4NwIxVIClbYJ32XV2WBvtwjnaFgbR637laWjaTqGBtoCYQ2wjj
	K+3JjRpG3YS1caukZt7lUBVvRjdovyDFd/LHoaMCRcwICks0ub8DWuwRjjs0Fm8A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sA5vo-0006Ps-SY; Thu, 23 May 2024 12:44:20 +0200
Message-ID: <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
Date: Thu, 23 May 2024 12:44:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: frank-w@public-files.de, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716461067;8f44dea9;
X-HE-SMSGID: 1sA5vo-0006Ps-SY

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 17.05.24 08:27, Frank Wunderlich wrote:
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

Did you sent this? Because from what I see with my limited experience in
this subsystem...

> From my PoV it is a regression in next/6.10

..I have to agree with Frank here. So it would be good to get this
fixed before -rc1 is out to prevent more people from running into this.

> because the driver change was merged (without "broadcast" fallback) and the dts patch [1] is not.
> 
> I agree that my patch can be dropped because there was already one.
> 
> regards Frank
> 
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


