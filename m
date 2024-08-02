Return-Path: <linux-kernel+bounces-273040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0289463E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661CF28346A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D615C123;
	Fri,  2 Aug 2024 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="BJsUhZ0c"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1825632;
	Fri,  2 Aug 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626756; cv=none; b=pO5SNS6PgYcW5wGBZ7e6QfGi9FJI28ZlULoLFf16ViaFb9wIMrnmH47NmJwBjVPEsD4y5ag0s0uJgyrzVodSy+kNgwbbsOcDly68DoyEXm0Wzo3pu0bWex1uWz/Loxr8+OIKMAAKPTCDsOy9eAC1eClrXsre5+NK6NYRJ0yy7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626756; c=relaxed/simple;
	bh=GdFwJJIwKZaQlNkwUluHuStd5qQRZ2MWHHn5D8L8gzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY79GEOannBYz3HaRUbZzzVdLHG/LYY2Sm5nmny7owznm7k0oWDXPxzgRtK3DhqqR3LH1nsqPCsxB4I3qYs3jwNulFdI1n9N3guB7Qo9IXzx6n6D7RsA1c7qy8B3IBMIG54XGcYAF5fhxGnevFrOPEvEAN2XbKabtBahaLHNiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=BJsUhZ0c; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722626740; x=1723231540; i=wahrenst@gmx.net;
	bh=GdFwJJIwKZaQlNkwUluHuStd5qQRZ2MWHHn5D8L8gzs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BJsUhZ0c4f3ogxe+F1cuGDFNJFhKJ4BLo/SX/mGIWCXnbNgKaNWDxP4oohbeyztV
	 E5yNaAZb5qFf6MZz7o2WrJzhEExPmicQSzSn0yneESc+6DA29m4l0P3r+4gYGyXNn
	 3ulzw6GLgbwn4J0XTGMV5Phk6W5Zx3GnTK3qz0Hwd+W7Bn3tUUFPcp1L9kpmNlG4V
	 LUxQIGiMSh/WCxpz+OUygRBI8Ha2PPScYNRQzx2xGfaOoq8knplu7ZhAAtEHbtb1i
	 cKl0HvnU3ejv4NmEJ3hpYD0qVuENBwdF7wBxHj8neXxFtWE2LI9DZjzHAWEITfVlK
	 xg5soVm0QjVrOoEEZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1sb3pn3FjI-00HUMy; Fri, 02
 Aug 2024 21:25:39 +0200
Message-ID: <3d8682b8-1bb9-46a2-89b7-3f8cc9e42118@gmx.net>
Date: Fri, 2 Aug 2024 21:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx93: add cache info
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de
Cc: kernel@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20240801081111.1492688-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240801081111.1492688-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4e49B3BczLv88uy/ocVitT8cLT/lYIEC0VpFq3IjpWVqkeHyvXN
 gJPYiqUsd6EH0gMPIAqBovUhx4Iu9zhddXxudBSxYlosPdKdf/Lta+fwFeow4EXxaZwawq0
 ACCL+NmBEpZcNhn/DviVAdNScsctbn9fyZAfo0bJbzmICt/nd6aOHPDqqJ/F91hyRDJdYvf
 l+4fykDd3rHtdg0EuWpVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0J6cUHvGjQI=;tITd6qsYbHiTYE5cIufJynLL381
 EK12EH4aBRJjT97IfasicyBHgRqv9PRhb1d4vdBfu7x2nwazYSGUj6ZoQrePCEQxR8hh+vYn/
 Yl/zSBSWnn8fy7ubiFzDHmQRu///T0C0F2ngh1uM3r6KlxyxPx/ep+1DnEWtIhAY7zn2zW/6n
 V9HKZkgx9iu7s8ezzFkp1TW7mydUCtLaQ7CEYY3NO3p/AxKYspKwq+FQ6HV97jS86EDuoZqbe
 rs+uOk5ARerN0GdWIF6vsK/g1FblGotrQ1/La/14KQkKGbmgwH1zB1WsoWFq6tuEApWmF6raR
 lexYzof68Pu/fqhuMTVa1aXUPQ72rG3OxdSAvvbOvbVgxu2OYeY41i1f1p70DDfsLlDTdQD/X
 WqWkY9f2mhL/xXct7RC2vN5jWvopmRM8tAnYPQfEDPJnpkCWoXLgwB9JD/qdtOpcjvUL47qjD
 unRUik85l/rM2G+UBnMZtgBZRxUJin16O0fH0/chQPmxxRoiCm6ynSCdl23i1B7wQTX3RJL48
 +OcCSg1TwdW7BOWzGGxoJuJ394Xbss7lYffMCwRsqLh2Qnl17pchsR3xPquqpIDBdI49GxNXa
 qchZlK/kaLrsyHs7PfkESDfB/lSfyL6ONYDdxcvA+6+lzYWCYM40tBZXZHYkMGXTbGNYpMw8L
 3NTUNVofXiFFBqH0IVpptPp21gFPgTk9fN2vvrtBsMO+OFuiTDzY9CkkJSpbjvFOIYl5uXMIo
 +A8o9vM9pILcPkp02+dxaXPnV67t3H8PcaaTwFCZ7WjvcNVlPJFgnQWcLLteQaIIDYj6OlGdR
 JkiekQnWVKuobo1XenzJI4sw==

Am 01.08.24 um 10:11 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX93 features two Cortex-A55 cores with per core L1 Instruction
> cache size 32KB, L1 data cache size 32KB, per core L2 cache 64KB, and
> unified 256KB L3 cache.
>
> Add the cache info to remove cacheinfo warnings at boot:
> "cacheinfo: Unable to detect cache hierarchy for CPU 0"
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

