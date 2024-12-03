Return-Path: <linux-kernel+bounces-429640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD449E1EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FA2163D60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68AE1F4716;
	Tue,  3 Dec 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mQZ0zZ91"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1271DE2DE;
	Tue,  3 Dec 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235746; cv=none; b=hu9WffBlGNiTSYcTSF5BATa7hDVKcsvp4Iav7vGDYkQaiFiVbhmntyMvRfYxEhPrMiw3X6ROqu2tNcDxoRU47jZ5MBsF4Gfwa+x3InAHtkugMax9vuN6z+BRDya1LAwm8Q31IzAfB8HNlMq2yOgbjpRkRS97yCX2BHgzRQkooio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235746; c=relaxed/simple;
	bh=LIGgbpNvs8ug8ujhBucQyBXzqtfXM2BSdyAxzQVrREE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xv90Jb6r1hiCFHeOBjRJqGigWVhr886DShfTNIMB+EAgfEGwwO5QWjk0NKTZ1XaLKCGWmpQzUqhik95pMfmDMA2RAxLMQN65J/c45akjaOKru1rgpGWqSHacjPrC6fno9Thw+MIAMLTKcBSWhj+eZXY3miPEOaO+aou+yVr61ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mQZ0zZ91; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733235742;
	bh=LIGgbpNvs8ug8ujhBucQyBXzqtfXM2BSdyAxzQVrREE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mQZ0zZ91/Hy36C5/1SvhSA/6gKvxSnKblYLlOcqBz6ep5NJ8KP0TTNdOGIBHAmEVZ
	 +F8olwwnhGKwUqvqEKrhn/bDEYDTgEhs3f5q24xI6mYfTOntsR+FBGAFCCnpFuPstU
	 Oxwv+hOCJZKGB0sitCvHfVvYFiAQQ74+gfVmpB3v6qtfXJCwrNFbdZOJn/yv+4jrHa
	 FIqa2cs/4i6xgSbQtTbj9V/0modhIcyHjSJzNQR8i2PwHe5eq9HjPuTMhkPNDnOVks
	 4Vd1swyjOJsQ4YwjYK7eZ1XxQiFt0CXY15KRyjzghNTPiCu5KEANskk1XSM4no7iID
	 +HDzGCHPT6EBA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F20BE17E0DE6;
	Tue,  3 Dec 2024 15:22:21 +0100 (CET)
Message-ID: <f47f08c0-0fb4-4826-9b25-1277cabe4bb6@collabora.com>
Date: Tue, 3 Dec 2024 15:22:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] arm64: dts: mediatek: mt7988: add i2c to bpi-r4
 board
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-14-linux@fw-web.de>
 <1ad355df-3f2a-4257-9374-1d125e138791@collabora.com>
 <CA7E06EB-D26A-45D0-BF13-9C6B640F27A0@public-files.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CA7E06EB-D26A-45D0-BF13-9C6B640F27A0@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/12/24 11:58, Frank Wunderlich ha scritto:
> Am 3. Dezember 2024 10:40:38 MEZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add basic i2c nodes to bananapi R4 board.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> arm64: dts: mediatek: mt7988a-bpi-r4: Enable I2C controllers
>>
>> Enable the I2C0, I2C2 controllers found on the BananaPi R4 board; these
>> controllers are accessible at ... I don't know, a header on the board?
> 
> These 2 i2c have directly connected spare devices (pmic on i2c0 and i2c-mux on i2c2 added in later commits to have it a bit cleaner). I2c1 is on gpio header which i have not added to let user choose if he wants i2c option or gpio. I can also add i2c1 to r4 board with the right pinctrl but imho it should be disabled to have gpio function default.

And again, you should really add all that information to the commit description,
as that not only helps me to review your submission, but also helps other people
checking the commit history....!

Cheers

> 
>> After which,
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>>
> 
> 
> regards Frank




