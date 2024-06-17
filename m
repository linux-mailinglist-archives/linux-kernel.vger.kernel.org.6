Return-Path: <linux-kernel+bounces-218496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDC90C09D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0151C218C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0556D53C;
	Tue, 18 Jun 2024 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OeHO81km"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E054C9D;
	Tue, 18 Jun 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671243; cv=none; b=t4f/dCFkdM2DzgW8PXX24qfpHn3iXqwz8VmtVdQ5piBO18RIPakQmgcHU16DuFpAnD815mrE9Wbpcr6vSgkFBOOc3MUM4bBEwKUmNFxi13sJqheDMMcoz1VuXUMpJOJ8I66pJz/rPakJOaWKHbEq+EgyZMwRg+8Two5daz+zE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671243; c=relaxed/simple;
	bh=ALACogNECgb+ISzRL3DiR92gwMszWqoY7VYJ4/YD6oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEGhmYtS9iTTXKTDwfxKwWb8+SuV/JRvPCSTlbl3azMESmxb5grr7UtD8NV9A8HJDR5APH7h64jEg4RprMOEbzfy3rKNeSZur++j8wH9mPC+uX5mERpwtdkg708UMSbmj9apFM3VtfYv00j8zDqFW48O72WCdTfCcAKub92r4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OeHO81km; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 59EDD8840F;
	Tue, 18 Jun 2024 02:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718671240;
	bh=49tr4flbfSKxYUh6g/+o6Wgnj89Yb+Mc42rvKfB7OMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OeHO81kmfk/9EszbLwJhbD+74umOcIw5+TO2vC1ozEsDolZpa7ZVIkzBy7puTJfo1
	 hFW76yH9X4Omvo5Xfyi7a1I6ElxBSBSiD3N81iVZqG0tDNzUgf0HAW5vGxTPacdBQu
	 H3yqMQ/Idf4U+EicWi58++9ilIyP7fxHVlHIQAMOyREL4y9DIBvjQwTKut93Wk24uV
	 1up3hGUNRvcvmVm+2roegGkM8ADW5oJ8Q+4sm4r0WHm+LZ3As8HeL0Up6+T2ZtJzBb
	 WDo/XvmgYSLwuVq08E3g6+I5JVvNpRHoFnKEBv8uh/mawKYIGtKpnKdn3uPuSgnZT5
	 ZpG9NWYlk0H+g==
Message-ID: <471057ef-afd9-4a83-95a6-a2c8cff52c68@denx.de>
Date: Tue, 18 Jun 2024 01:21:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix pgc_mlmix location
To: Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240617223952.1899201-1-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240617223952.1899201-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/18/24 12:39 AM, Adam Ford wrote:
> The pgc_mlmix shows a power-domain@24, but the reg value is
> IMX8MP_POWER_DOMAIN_MLMIX which is set to 4.
> 
> The stuff after the @ symbol should match the stuff referenced
> by 'reg' so reorder the pgc_mlmix so it to appear as power-domain@4.
> 
> Fixes: 834464c8504c ("arm64: dts: imx8mp: add mlmix power domain")
> Fixes: 4bedc468b725 ("arm64: dts: imx8mp: Add NPU Node")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

