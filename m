Return-Path: <linux-kernel+bounces-427566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469BB9E036D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA035B24514
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346401FC7FF;
	Mon,  2 Dec 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="h+yj/f3N"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000C1D8A14
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144664; cv=none; b=OCZFoqOIJomTG23q2cqdVusChsyAMBCvuEwxsSK4tkuINgPDvPbiQ3TSXU9d8kB6M+n392tUBZNz9w8DNlMDPH64aWqweyfKuNYidggzV2B5nstI+H+MNYAZ13HsDnL8xjm/0TUR4Ewlx57go+0IErDEtx9znPB7Gf6uhNEkUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144664; c=relaxed/simple;
	bh=kHD3uSGQR4ZrMMGCYsr0oSmkNdOmeVOEKfCdyFbc43o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8iq5eD0KR9k+STOPrEOmORmREhN9gLYB+/wr+mBQ4p3ZmKYcLuUbIJx7UJSZKROwnQMwpotkaUBxTmNEzmIwWKE1C9ZbnykGQEg45WfYyU4IcAKUVl80HgiaOTJALlHFn0j+B+r5y3XIyOQW7qyYxRbZxrqbF3Kkin9B0S8QHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=h+yj/f3N; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6DB6988A3C;
	Mon,  2 Dec 2024 14:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733144661;
	bh=b09IRayHwKFz5QGfAbSRVqGIdYJP6UQsFIWjXyUo8oY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+yj/f3NFDdx+V0dgz4eU4yQI74vVHUnS8pMIYyABCxKMdE9HLVtixAhSauNvfcgN
	 AVxxTdXdwbK+kcJ5V7GAbZWMfJu/XaIDeZpx5fiNBp20ApLDNA/BxZQjKTaY7G2JzP
	 uJv5+CtMqmavmHAa98O9KSzI96vmDbO03Kfa4Ep8kFKO2ESfbO7vaxX3nIAaKkaVQY
	 Vo9Wtvi2dT7RP+OBlzmZem9+OUyrWtdIO0/XPSkeSJlJK1K23F7GX0nL3ON9oYahWM
	 XKEWh8G9f+nQ6Uq5TCytf/VadexunrmWC93FifVLY/n4vBWIDZBFnJ7x13vo1MReKF
	 FcaosijILgbUQ==
Message-ID: <50ee0207-b37a-4a6a-83fe-32a7a43645ce@denx.de>
Date: Mon, 2 Dec 2024 13:56:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Liu Ying <victor.liu@oss.nxp.com>, Nikolaus Voss <nv@vosn.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Fabio Estevam <festevam@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nikolaus.voss@haag-streit.com
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/2/24 7:32 AM, Liu Ying wrote:
> On 11/27/2024, Nikolaus Voss wrote:
>> LDB clock has to be a fixed multiple of the pixel clock.
>> As LDB and pixel clock are derived from different clock sources
>> (at least on imx8mp), this constraint cannot be satisfied for
>> any pixel clock, which leads to flickering and incomplete
>> lines on the attached display.
>>
>> To overcome this, check this condition in mode_fixup() and
>> adapt the pixel clock accordingly.
>>
>> Cc: <stable@vger.kernel.org>
> 
> It looks like stable is not effectively Cc'ed.
> Need a Fixes tag?
Isn't this fix effectively superseded by series

[PATCH 0/5] clk: Fix simple video pipelines on i.MX8

?

