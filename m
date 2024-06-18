Return-Path: <linux-kernel+bounces-220189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F790DDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3481F24A82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA590176AB4;
	Tue, 18 Jun 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UmOGp6kA"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB336AEF;
	Tue, 18 Jun 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744400; cv=none; b=tQdJrXQh7iJ4aJ9MkH30zUg9CMls7RoMSTPEUGB/ZfV6OB56vX9Pf4MrOjfIiLXN3avcHmgy6TirJrqNu1YOJfmmYA0MC72PKVKMYsUV5gDP5fol5Aap14DoFPJJQCYwZhCArg9i0b8c3YgWNjs5eY6az8Goc3wvDEmnzujZI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744400; c=relaxed/simple;
	bh=6Wz0qavIcGXG3zJDSp0SjQWZH51p8gZ3Joj+rMnDXLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufsUgqxkvX2p2RSmqCk4GVTU9H0oo8hwTgSE96pGA2jGjWuT/0zyWK3Sy100qMzK1bhMCUSz2WdREM9lHPJrrQHYTbitI/el7zDYktacf91dmm2aDzcokhyVYqAeWq6xEyk2kLwVbwR9046Lfu0jUclV3BSZsmcTYA4bzfONQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UmOGp6kA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718744364; x=1719349164; i=w_armin@gmx.de;
	bh=MmECG9E/2VutsNlPUEt2UkHxGGytK6+o71DcLl0dUMQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UmOGp6kAM21rCaJogsI7XsXpimXS7SySCPFrn+VGc8pdUa7CB6WHHsgPf9g/tQmV
	 A96DCDyfmQUO36xR/xFmdEc5rmU3rEJGMEn1dHAo0qKH2nAZ2yfOgZxLp89WUVOeQ
	 KKPZUGhIRJ4/m4k7J33ml0XwwmdtJBBaTiM1ggLcBKge1SXg09BoMHAilHF2TRlAo
	 agNTpa4VtM0OZU+Mdm07C6HWsevzSND6IIw+oCoN2Y32beajAc0xRurvSTcpLHI9w
	 pnUHfwQ+vj55EEz1eSVC82nJXQdcdtB0BAJmpMnZ+tVw0vNNi2tRXux97UhwUpcj9
	 C5gQxGPlnytG6A9gaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2WF-1slH231XD5-00g7xW; Tue, 18
 Jun 2024 22:59:24 +0200
Message-ID: <c19e8f05-a189-4091-805c-1898de4e1095@gmx.de>
Date: Tue, 18 Jun 2024 22:59:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 0/3] hwmon: (spd5118) Various improvements
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Stephen Horvath <s.horvath@outlook.com.au>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Sasha Kozachuk <skozachuk@google.com>,
 John Hamrick <johnham@google.com>, Chris Sarra <chrissarra@google.com>
References: <20240618195348.1670547-1-linux@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240618195348.1670547-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aXz0wUK9mlfockTnnLbgT/StykYPC7Lf0wwRtL50zC5WVV0Fxbq
 y6c96v3KQ8cLU/1YbWeTX7SdfE+ITrzswUB56H54C2bbgYoI1wOkSezWRrdIi8086ujzf7h
 XHTsPpHlXwRAUV6O018DiKfnerXAkyKgC8XVDTb2oZ2HlZnWpOjmpkUHQabczesVmTPyE9i
 M+71JKdTxRVrpX5SEgicA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eRQ9vyaso2o=;FFBs7NQDxxwI8+VojZFav2dDPmP
 +iE7a5USYULxT+FXzCqAeH81v5N821eMCS0vGBJWazUxX+iTnHcq1AyKi1+5R9lPxB80FKEWr
 E5bXPBAna0WBjYDYLMELcsoRQrRNuPeNu/q+zlWHupWUceXyxJH7hqwz9yMbSAl7u+OtByh14
 wikY4yY0c3OOOLOB7FkBMnxqVe5l9iVMQewlZya/yO6kp2rzLXORAjxWYwzeZefNmqeZFzovv
 bYAQCsJLO8kyu8n06mmN12CIQTZctq/DrqY4dkeoCK1RCsZI0LAW9F+9iVZxQqm2mTdqxZ4hk
 jZEleYVOhkmHiIRpDXkVJX2zi/cKCnp1iCen5ocKkl4CsTwizGnJc7X4KYQX/ca+0XMjU4X8F
 WkEOHbXwDKLUIoI8FOPS/1vswTsRV7tqYU0Mw+FbGQYKhbWjaSE3BFU9Jxgpg5cQIwQs/IloZ
 PGapWQxkfeYVSuZOdLcKFg58AlHle69MC6BvDvTsQwKpo+Wo5S2Vz3f04A2JCSRzoYJZ5WFZq
 yGvMRTD1QaTNMl4n0bhmd1A/doUT9lVqJUmZeW7VqGsQkZJxp/pHT/Iai2ntf4ovWkid9FdUO
 tCuAAmNdmZkUfccyVrikgFbEOeoGKTbRKy5ulOwPpCVEmhGI5qr3hUrmyaUu9tFnZIq/5OwQi
 T+VdVkAmhLqQs4/aZHDqTxHq7eUv5mzoDz3BpeCMwC9kAzBNeXVoaEzmJ9dLSwWXwSPSFgxL6
 lTPHpG/WnsXvut5euJFcQRKQtWUBTNZwZuKs0fLC+9kTbtIYptgmKcG1kL53AyBimAY9F4jzu
 X5eHUYjbCarLhKA0B8rjstrGA5d6pLB/NKHTM+3apEJxI=

Am 18.06.24 um 21:53 schrieb Guenter Roeck:

> The first patch of this series introduces multi-page support using the
> regmap infrastructure. This simplifies the code and improves regmap caching.
>
> The second patch introduces a spd5118-specific regmap bus to implement
> SMBus accesses. This solves a problem seen with i801 I2C controllers
> when writing to the chip. The I2C_FUNC_SMBUS_I2C_BLOCK support implemented
> in those controllers does not work with spd5118 compatible chips, so
> byte-by-byte access needs to be used explicitly.
>
> The third patch adds support for spd5118 compatible chips which follow
> the standard literally and block access to volatile registers if not
> on page 0.
>
> RFT: I was able to test the code on AMD systems using the piix4 I2C
> controller. It needs testing with i801 controllers and with Renesas
> chips.
>
> v2: Added patches 1 and 2; simplified patch 3 to rely on regmap
>      based paging.

Hi,

i also have an AMD system and DRAM chips without the Renesas controller, but still:

Tested-by: Armin Wolf <W_Armin@gmx.de>

> ----------------------------------------------------------------
> Guenter Roeck (3):
>        hwmon: (spd5118) Use regmap to implement paging
>        hwmon: (spd5118) Use spd5118 specific read/write operations
>        hwmon: (spd5118) Add support for Renesas/ITD SPD5118 hub controllers
>
>   drivers/hwmon/Kconfig   |   2 +-
>   drivers/hwmon/spd5118.c | 131 +++++++++++++++++++++++++++++++++++++-----------
>   2 files changed, 102 insertions(+), 31 deletions(-)

