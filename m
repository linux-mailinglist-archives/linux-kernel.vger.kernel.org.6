Return-Path: <linux-kernel+bounces-555411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F93A5B70B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4BF172869
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4FF1E8331;
	Tue, 11 Mar 2025 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Nu4Z8q8B"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F131ADC83;
	Tue, 11 Mar 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662322; cv=none; b=Yp+CBXh6HMe5sagWTMV1Ze1mYE3aU2KjAs96R5YCwuwWTqVTcDikkwioPMzEE7xJWebmBuAzHAWoPYTnKy+Rfz3BpPzmCPxPoXM9NFKsScX8WfP21cYFnsTcm7BoKGYqQwk2EzFzZ9mPaQPOBQfO9hEfZWgDEouPA554AA9rJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662322; c=relaxed/simple;
	bh=Tvdo/LZO1dissNuv/0SYsd1MKjzBgYB27TXwIlSgDWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHNlkqiP2HJfghJ/+WOqbmYPjzGcsFxbocHIrXzkNYhrahLadPmHZrkTrk+yOT7IAARJd6/z5wPmTb62QhCAf4VV8atifuVU+mjRtZvK6HY0zMzDRyoBzZ9VJSzSu+WE4X/dVhPuD5uG+POO7FG43zY5TgGJOE9EdatCdjkG9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Nu4Z8q8B; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tPjzWEIRgrMC7GoOBG9nlVWAbgBUY/TGQT4CORiN6s4=;
	b=Nu4Z8q8BfhcwGD/Cfdj8iKpZDOrY2WE5lT8uJsA6KpfyUxls4/rceTJeEasYV+
	GOywZ15Kq318QEyWn+WHn5c8CnrT6OVRE8ChQE5SR/r6ySHlwIInvTem+6AadQEP
	S6qUwhZ4PaTN+F6KjFXYbGAyFVrkTk9DG3EMsgcn1yXO4=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCXlUJGqM9nrs20AA--.48493S3;
	Tue, 11 Mar 2025 11:04:40 +0800 (CST)
Date: Tue, 11 Mar 2025 11:04:38 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to
 AUDIOMIX block
Message-ID: <Z8+oRjW7YN+kw73/@dragon>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
 <20250226164513.33822-4-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226164513.33822-4-laurentiumihalcea111@gmail.com>
X-CM-TRANSID:Ms8vCgCXlUJGqM9nrs20AA--.48493S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI1CGUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNQgKb2fPqEj92gAA33

On Wed, Feb 26, 2025 at 11:45:12AM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Needed because the DSP and OCRAM_A components from AUDIOMIX are clocked
> by AUDIO_AXI_CLK_ROOT instead of AUDIO_AHB_CLK_ROOT.
> 
> Fixes: b86c3afabb4f ("arm64: dts: imx8mp: Add SAI, SDMA, AudioMIX")
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Applied, thanks!


