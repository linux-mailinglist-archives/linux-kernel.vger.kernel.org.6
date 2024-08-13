Return-Path: <linux-kernel+bounces-283975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91494FB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53049B20F71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E368BF3;
	Tue, 13 Aug 2024 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="kK0XCXep"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446471804F;
	Tue, 13 Aug 2024 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513607; cv=none; b=ZwHwkyhqnBD4o2v0TvV94xXMfjuWymIaXpLTEBwMWej9C/V2a3CugBkZfMR4QpNVV8wXVk3u3PZ5mXMmI6msPmEAnC0L2TaUEgrFYakbklwFsQRcN3W+gLY11CzWqJPVBbHGZp8GO2yJOuz1BC360wr3XAB0CfavPKhZy9aKbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513607; c=relaxed/simple;
	bh=3ghMVHHy8SiX0w5LJOiikjGvC26Y2DBCfESc++S90EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqBITbYmyZj03omFPPzndfisZpoeb9mJOo2eO4fLl4y0hLQVkfzgn/C0c0BTiJyXJ4oSNbdXskL5NbwutdEBOTFOVR7r075nNiDAZhzHaXOqg8KTyyvLDdMF4juyQGp3G0XkYyT4sRwHZlxi3Aj+Bctx5x5w1wrKYVI6uHKOSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=kK0XCXep; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=39oKZo1tR8lcqsDZPVTXhqeGc16qjfsZRRH1tPjo9ew=;
	b=kK0XCXepoWVU2RJyCir8xKw+oPcELlYpoRUlGbMAeaGDPI2nQWd+xnLrkwL3Up
	YB1Gp5kttel9w4UhXx3TVJliKnX6I6q4YPua6DNWBT5+W+d1NYX8k4yR6mvSnk0J
	xIlpOSDH0idhQpTEQogfNfN4bQPBKUYCf2PKT2+ihrkfw=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAn75DNurpmUUReAg--.38403S3;
	Tue, 13 Aug 2024 09:45:51 +0800 (CST)
Date: Tue, 13 Aug 2024 09:45:49 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] arm64: dts: freescale: imx93-tqma9352: fix CMA
 alloc-ranges
Message-ID: <Zrq6zXTowvXIUk1r@dragon>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724125901.1391698-2-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgAn75DNurpmUUReAg--.38403S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwk6ZWa6Xp3TZQAAs0

On Wed, Jul 24, 2024 at 02:58:48PM +0200, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> DRAM starts at 0x80000000.
> 
> Fixes: c982ecfa7992 ("arm64: dts: freescale: add initial device tree for MBa93xxLA SBC board")
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


