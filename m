Return-Path: <linux-kernel+bounces-393195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75209B9D84
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C61F21BBA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590551547DC;
	Sat,  2 Nov 2024 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="mpYFZX3E"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9404380;
	Sat,  2 Nov 2024 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730530133; cv=none; b=XMR3rfbgdsSPIpdWVLedHF/Av8FkDsWDggT0S8NxQ1sH1qw4sQS2tZeIrM/E1ETHo7jnZCfn4Po2tu3PLvGG8YLKfwM7ZuiTWagEs1gnBmfmD4hTcLNfdpAh0qvw5i8emZzXf+5MlBephGqCT62crfUvU+dZvc9uv0BS6SAHXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730530133; c=relaxed/simple;
	bh=n6Ym9nl5ofu4kHAJL5/w2BJ6rjntnfm7Mkviq67cZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh6HSTUs4kBQjBb+DBJooDA8k7oYQLbFjC4PoWklwLth46IjP2hy7BbkMdh5/kVuk9+srQKx4zc+VOz2q7TbZio8db7/UrItK+RfnKHdHFa/d/sNH0Afs+eA0sYi/zYdcv5BD3dQWR4a9Oi5/Cia2oQJZpDpIW69jQuUH0j8yIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=mpYFZX3E; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0VIcPO/qvZo2Yecv6kglkByNG81C4qnffnZZIqE0ty4=;
	b=mpYFZX3EkeqHbGE6w69j1mVPnOKV0cTtvf2l9CHxyPE3mRWdV/8O9bRu92EIht
	LUN9HixVth3IQ8gnMwACWp/HRoHaGyRwg89YKnHiXtKrflsE64Vk3n99ZAZoIgHr
	5WlnD49YjNwJi0BGftdbXhLbV0kYqCix/9D9u8OcUlMU4=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBHi8gnyyVnUm9+AQ--.14872S3;
	Sat, 02 Nov 2024 14:48:09 +0800 (CST)
Date: Sat, 2 Nov 2024 14:48:07 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: imx8qxp-mek: replace hardcode 0 with
 IMX_LPCG_CLK_0
Message-ID: <ZyXLJ0RbHqCIym3R@dragon>
References: <20241025220810.1833819-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025220810.1833819-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgBHi8gnyyVnUm9+AQ--.14872S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBOLZWclrIE-mQAAsw

On Fri, Oct 25, 2024 at 06:08:08PM -0400, Frank Li wrote:
> Update clock settings to use the macro IMX_LPCG_CLK_0 instead of the
> hardcoded value 0. The first argument of lpcg is indices, not index.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


