Return-Path: <linux-kernel+bounces-282232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469C94E121
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CEB1C20E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D2D4CDEC;
	Sun, 11 Aug 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jl6YcRt1"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26153EEBA;
	Sun, 11 Aug 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379466; cv=none; b=vDLpvK8vlUOSTi1cA3z7zScsgQVtMydQE2HdajjN/WHkR7gMLJ/87/HjmJizfy3h8BIm+Fs+ppVYametJaKFjzjDX43y0o3Uex7nJGjn+/Wtb//v3YTGT+kwF/Zu5YnNat8eGkgjsG3fO9mZMlVhdd9cuVsXIU3mdIF8Vv0bSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379466; c=relaxed/simple;
	bh=bAifYTB4RwqD8R//HvQVD9qR48TBcyRj3dq5UT6jxpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo/tb3EA7GAv1Jjq0eNvzc7JDo81OeRwl+4z4LAioodBZXTON5/U8MGgb/DUcz1ErlFpwry2M+bffSG78NVsj0Go5ZJho1uRrJgZiv9nlm7BtkUaZ91Q6lMmpXIBs5IY8PQR/bReVZGgGbNn5rSkagCww6f+S5GybxUEu0xLUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jl6YcRt1; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=BnN4wx3GxIvl/QqscWZIne594Cyo0eoq/KaOBJyLsB8=;
	b=jl6YcRt18Z2m7WfWV8RnCKuCTKQ7QubMldZRAoGXjTCLEKiVZK4OGelFHZ7qjl
	Lw0uGc6XycinDIvYXHGRREfEJvACowd8krcphpsT64p6oafaEZdZ7GMP+DjJ0ifn
	3H3nFSemxVCOgf8JZLYPnaTN86aVYn9bOhZ3BM7sKHqck=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDX35TKrrhmCYFKAg--.36296S3;
	Sun, 11 Aug 2024 20:30:03 +0800 (CST)
Date: Sun, 11 Aug 2024 20:30:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	s32@nxp.com
Subject: Re: [PATCH v2] arm64: dts: s32g: Disable usdhc write-protect
Message-ID: <ZriuyYqhOQiA0dhe@dragon>
References: <20240704135653.2969532-1-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704135653.2969532-1-ciprianmarian.costea@oss.nxp.com>
X-CM-TRANSID:Ms8vCgDX35TKrrhmCYFKAg--.36296S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxWrWDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgM4ZWa4nhcbtAAAsk

On Thu, Jul 04, 2024 at 04:56:53PM +0300, Ciprian Costea wrote:
> NXP S32G2/S32G3 SoC based platforms do not
> use a pin for SD-Card write protection used by
> the uSDHC controller.
> 
> Hence, adding 'disable-wp' usdhc device-tree property in order to fix
> observed warnings on SD boot as the following:
> "host does not support reading read-only switch, assuming write-enable"
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>

Applied, thanks!


