Return-Path: <linux-kernel+bounces-367457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298749A02A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BB01F21CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615421B81DC;
	Wed, 16 Oct 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="klu0LFE/"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13528433CE;
	Wed, 16 Oct 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063928; cv=none; b=hK0h3oEaf4vdbq/a0pkSUVAkyZRW0lWnWifjIFN3nknT+OpzqBFKN7Vu0R0lrIrUvqYiWsFeL0LzuoH57r4XHlQCNpWPJY6Wd2Y22P9NOZ1w/qgfX5M6M4VuewjGl+H1szHUXVxmionlwyUfApJFg0V+Ct0Oez6MsWN+Tbmhfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063928; c=relaxed/simple;
	bh=1VcKXLqcRWYjptJfOGs0sR3n+z23n4N9252C2R6GmB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2y2Xfg9d+WyI5rYUbyVrh3LMA/YnfkG3+ntLCfP9bxAZKVGXx/rAkbXS+QzXUxleG1vre/N/0+s9Jwaoo70nv7TAvEx0RTxOXNCIIgy8SeG9st9RgJ9S1gF3+Bl/UQQapWREkw6gZmtJWjqAJFI4IzKRhjtqz246IeehHYGPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=klu0LFE/; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZIq7bLLD7CDFOySZChcNUEzc38kxhtLroVQls+zB/io=;
	b=klu0LFE/UmhM5nW2BX8vP48bh2I6ObOj2DqUtTmBDSMWmJsJu+njZKAuRVIPJG
	DgTuT1AL+iPCWDY0ge2ezZn3H9voP+1xFKNNCO+fe09zuBuPWCn/TnFSivviC4N5
	oq/omkMo1HdO7X4oBCPEioi+ipGmvY/a9zVX/FkYLjleQ=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCXLX6Uaw9nFv8YAA--.378S3;
	Wed, 16 Oct 2024 15:30:30 +0800 (CST)
Date: Wed, 16 Oct 2024 15:30:28 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-*: add RTC aliases
Message-ID: <Zw9rlO/x+spy3NS8@dragon>
References: <20240909221501.806515-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909221501.806515-1-tharvey@gateworks.com>
X-CM-TRANSID:Mc8vCgCXLX6Uaw9nFv8YAA--.378S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsBMNUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhJ6ZWcPZBUaEQAAsd

On Mon, Sep 09, 2024 at 03:15:01PM -0700, Tim Harvey wrote:
> Add aliases for the RTCs on the Gateworks Venice boards and on the imx8m
> SoC. This ensures that the primary RTC is always the one on-board
> provided by the Gateworks System Controller (GSC) which is battery
> backed as opposed to the one in the IMX8M.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!


