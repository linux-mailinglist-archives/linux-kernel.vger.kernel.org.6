Return-Path: <linux-kernel+bounces-437050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473609E8E76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08408281BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA9F18872D;
	Mon,  9 Dec 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="MZ8/j1oE"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3A21481E;
	Mon,  9 Dec 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735533; cv=none; b=nSKVrgpvKy9rE58W7E0g2sXy41iFjW4qKbVkmeT6DWo7RpEb7jPynVCPtosq3QBGOJhAeYh7EMsq8p8r4msVig28GYr1s/uhlBLU+QeOVABZxWOMedJ6cY5JB1oarpJk9lg1H5aY5cpCqAAzYLJMfGvWIHhlEqgdKSLa2CmiSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735533; c=relaxed/simple;
	bh=THySfj94iqMosY1olRs08xVkuR/A+URSyqRNUOJ998Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3aHp1MlPNgaWhw48smfS10m4Y5zEICWIzhwY17UbtGwZqgBGHu9JETWxy6HUAMXl4nxdJYn7xdlpRTuzc3ThuFzyZlVbo17FBB87KfNVdBexcT3+pP6VdKVO1YGshjYA6E3kWXadkE0lMF7xC3ennSpAG39m+ktHPIzV7iw2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=MZ8/j1oE; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=67tvmmn9OuQWrMC+HWaoLNhCgYmT8MPFGmX2K5RtNBA=;
	b=MZ8/j1oE5cQRVGjm7bWOLx/KOgKTwAVpmJtNPLX8wxeoe/pbrNLSgSvhgSDtKb
	p4u1fvTJfUV4n3sxw8STx6Chu4oCFQ0XoZrpF8lfCesg2UpEWWQxXNwVjTvAOMo4
	Kkc/O2zZDuTGikxmI7/Syu0mSaJGR0tyFxvIQqyj9n/p4=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAHjwUttFZnkWp7BA--.46698S3;
	Mon, 09 Dec 2024 17:11:11 +0800 (CST)
Date: Mon, 9 Dec 2024 17:11:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?iso-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] TQMa7x DT cleanup
Message-ID: <Z1a0Lc+N+J3PGnH7@dragon>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgAHjwUttFZnkWp7BA--.46698S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruryxXr43WryfKFyfXr43ZFb_yoW3uFb_uw
	15Wa1DZ347Xr4fCw10gwnI9rZ5Ary5Xw4DKFy5Wa9xWr1a9F13GFyfJ34a9FyxXasIgw1D
	Jr1DZ3W7ZF9FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0xu4UUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhOwZWdWoWNcVAAAsv

On Fri, Nov 08, 2024 at 02:49:18PM +0100, Alexander Stein wrote:
> Hi all,
> 
> this series fixes some DT binding check warnings as well as removing
> duplicated nodes. Eventually IRQ support for thernet PHYs was added.
> Additionally add CONFIG_JC42 to imx_v6_v7_defconfig.
> 
> Best regards,
> Alexander
> 
> Alexander Stein (8):
>   ARM: dts: imx7-mba7: remove LVDS transmitter regulator
>   ARM: dts: imx7-tqma7: Remove superfluous status="okay" property
>   ARM: dts: imx7-tqma7: add missing vs-supply for LM75A (rev. 01xxx)
>   ARM: dts: imx7-mba7: Add 3.3V and 5.0V regulators
>   ARM: dts: imx7-mba7: Fix SD card vmmc-supply
>   ARM: dts: imx7-mba7: Remove duplicated power supply
>   ARM: dts: imx7[d]-mba7: add Ethernet PHY IRQ support
>   ARM: imx_v6_v7_defconfig: enable JC42 for TQMa7x

Applied all, thanks!


