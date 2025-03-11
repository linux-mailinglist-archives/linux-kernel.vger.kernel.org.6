Return-Path: <linux-kernel+bounces-555357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D6A5B654
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB107A7730
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C861E32A3;
	Tue, 11 Mar 2025 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bb/WEbWa"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8B1DF98B;
	Tue, 11 Mar 2025 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741657974; cv=none; b=ocYTyBd+oF1fUSgAtFr1z6EkAxhKWbG8UnDC7DpywDcMjdy2yM9qlaU+JVRR6jtTPyx2C+b5mN7Kk0x4beFwRjPNgp7A4X/IRgdSXFy62mArMFBPufHnYdM/CkVhcQZqMpKN2/5ibZlswsrKPSKwqkV6+QqJaSx7J4QdJmq2cFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741657974; c=relaxed/simple;
	bh=BePCeOBZ4CRUJOn6ITYHMdMXC7Jdn4+7xT6rUAg2NZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnyDQJgUGYpM8OEc8i5ptDJbPjHYUlfM8AtbjXXdzwsm7auymVqghfFivDFOHUO/YyER0kkzeIhA6FmdFzuO2qLQsv7NXld2bAes1TgHIaTdtEig4IrMy0OOo1WBKQxJSeh7jM4CM/iX9Ubwwa5inIpb4+mNyZKUyCfCaxydySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bb/WEbWa; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Y2j5IpfsHdKFIq/wwefRt4BQxdOS5Lzz8+3jguMQeEI=;
	b=bb/WEbWaAcQBK5+/SWIhhJjQGY7QSw5WAcBBHbKVmjct4jdi2d60S4OI1j8Neg
	i4e7C7VVShbb16g7RpTN8y86Mfc5t0NkrYHEYeh/47CUvXLQgkax895lamkfoh7h
	kNQ7Ab3+rLlUtu3JY+H6kxNnS0Rnu5rdchdZBJPlZ6IO4=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAnJdRFl89nbBawAA--.715S3;
	Tue, 11 Mar 2025 09:52:07 +0800 (CST)
Date: Tue, 11 Mar 2025 09:52:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] ARM: dts: TQMa6/6UL/7: DT cleanup
Message-ID: <Z8+XRalDiwot8Xsl@dragon>
References: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgAnJdRFl89nbBawAA--.715S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcb18DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERsNZWfPU+q+ZQAAso

On Wed, Feb 19, 2025 at 09:17:35AM +0100, Alexander Stein wrote:
> Alexander Stein (4):
>   ARM: dts: imx6qdl-tqma6: Order DT properties
>   ARM: dts: imx6ul-tqma6ul: Order DT properties
>   ARM: dts: imx6ul-tqma6ul: Add vcc-supply for spi-nor
>   ARM: dts: imx7-tqma7: Add vcc-supply for spi-nor
> 
> Markus Niebel (5):
>   ARM: dts: imx6qdl-tqma6: limit PMIC SW4 to 3.3V
>   ARM: dts: imx6qdl-tqma6: use sw4_reg as 3.3V supply
>   ARM: dts: imx6qdl-tqma6: Add partitions subnode to spi-nor
>   ARM: dts: tqma6ul: Add partitions subnode to spi-nor
>   ARM: dts: tqma7: Add partitions subnode to spi-nor

Applied all, thanks!


