Return-Path: <linux-kernel+bounces-312531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE439697CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D67B24D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D201AD24A;
	Tue,  3 Sep 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="eZZTYjIf"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC919F436;
	Tue,  3 Sep 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353308; cv=none; b=c1jFDYdcCxVTmqJbTHzMelEubmhvcxSTDUuru5M2fi6vXGbv8CAFkC/fbola7XkJlfr04u42kjJdUF1MnGu/nxVPbMwMAJ1FbpnaOIO/1Y7Su7CrA3kMDLTaBlQULU6d8LR85XRwNlKB6JCSyM4Y/afjKlOvegjRqSHp30CHO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353308; c=relaxed/simple;
	bh=sElBf8ySjKlJFo0FWycNZ8r+AmDIv4aPy2vC//s49nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOKq7FYbF/o9LKfEdEGFu55CJzQsfTeDdZ2MqGFx5PH9WFTuLBh2Bno9mndzJqNLiQeDyK1ksqSx19cMkCEbhHNbdLq11luZmNXYwDFXl05B7vgt6Qb29qNDc81CkfEBjdvb7s1bam9vMI3mqjN9Lq1uYyRXN+oi7inRcCflix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=eZZTYjIf; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=dmTmVn7+b+7knv63OjIIhNmzwrdlD/kG9NEDBxzlBAs=;
	b=eZZTYjIf1yiW+cQ3REaTTugu7J/ACx4aYjk9QORXmH82uTaHcGzSKpDGjhhSH3
	drcD3EelFuYcOKzd5Hj+8he8x1gIQZh1qGZh+kNZmg9D8/BJfy7ScvkAm0G2BonN
	nknaDwhJ8CTv3ssLRAihHIbnbF0A3TLLQnwyrvCrYwGnI=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3v_QtzdZmBlBbAA--.1919S3;
	Tue, 03 Sep 2024 16:47:43 +0800 (CST)
Date: Tue, 3 Sep 2024 16:47:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>
Subject: Re: [PATCH v3 1/1] arm64: dts: imx: rename gpio hog as <gpio
 name>-hog
Message-ID: <ZtbNLcP5CPRI1oTa@dragon>
References: <20240902193013.1456513-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902193013.1456513-1-Frank.Li@nxp.com>
X-CM-TRANSID:M88vCgD3v_QtzdZmBlBbAA--.1919S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr15Ww4kZFy3WFyxAw43Wrg_yoWDGrX_Aa
	s7JrnxZr4kCayIg3WSyr4rG3y0kFZ5Zw1aqrn5Xwn7Gr43XayDtF4xJFWFkw1akFZIkr98
	AryfJrsxtrWrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0_gA7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxRPZWbWykwJXgAAsU

On Mon, Sep 02, 2024 at 03:30:12PM -0400, Frank Li wrote:
> Rename admin_led_lower to admin-led-lower-hog.
> Rename gpio rs485_en as rs485-en-hog.
> Rename gpio uart4_rs485_en to uart4-rs485-en-hog.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: gpio@76:
>   'admin_led_lower' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb:
>   gpio@30230000: 'rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtb:
>   gpio@30220000: 'uart4_rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


