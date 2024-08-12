Return-Path: <linux-kernel+bounces-282891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9094EA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7B728175F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845A16DEC3;
	Mon, 12 Aug 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AcWQh47x"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910D716A948;
	Mon, 12 Aug 2024 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455879; cv=none; b=iwpZf2IH/m39FT1prinExOPQ8LdLvVVnxccE69WXml2/UQ9sU7B1TxEk/jaqw8Yf6JCqk0YnEQ+eohHQeqvYc1inqEhXSn1LeQ4Qx/wCj4WUKA1ghGX3xkMZs8BCMg+qI32UdPN8GDrN2AiHPo0VW0+M8Zi7vglF6sOED+cbL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455879; c=relaxed/simple;
	bh=P8t2qzTDKtuBQhzPXUYxfC3tFEHNAV85Pec+kdaY5zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnKJhPpNa7wRqruLVa6QUnZD1zo94u7U5s8FC3uuFN93b7RdekP+rknYLCz7gaq/DDdbgJveZim1TWZieXbwmouc32ooOpON3fuwhudbu/yQup7/E130AjMEpmIujyWux7Qz/0o+a1s13pZG4BVsNpwvFmYMrTqpZQyg4t7emcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AcWQh47x; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8OQDzwap6QK8JuO7jTB4iPv7Bd6WkmI/d68Ki8Wr0Ik=;
	b=AcWQh47x9pr/Dfjbz1ISPz0mIIAnCslrTImIcAZBaRUfWxpBXF8lKZSN2SPFhK
	lF5bgxux15pii+5/yBfzpFsNKMM5GWD2N4/YPatm7gTq4KzHA6E3C/Q0Oevs/vAY
	ESM/PzTsuS6AJ4mdooVhuVErXywKoEq2ry+h7gWpMzcKc=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3f8JH2blmcEBWAg--.28001S3;
	Mon, 12 Aug 2024 17:43:37 +0800 (CST)
Date: Mon, 12 Aug 2024 17:43:35 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, imx@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v1 1/4] arm64: dts: imx8: remove non-existent DACs
Message-ID: <ZrnZRz4U7D8oqOMK@dragon>
References: <20240717-anvil-ashy-544e80a1317c@spud>
 <20240717-alkalize-bouncy-83e748284bc7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-alkalize-bouncy-83e748284bc7@spud>
X-CM-TRANSID:Ms8vCgD3f8JH2blmcEBWAg--.28001S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI_OzUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgc5ZWa5z7Yh8gAAss

On Wed, Jul 17, 2024 at 10:37:53AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Neither the imx8dxl-evk or imx8qm-mek have a Rohm DAC on them as far as
> I can tell from online documentation, and they certainly do not have a
> dh2228fv, as this device does not actually exist! Remove the DAC nodes
> from the devicetrees as it is not acceptable to pretend to have a device
> on a board in order to bind the spidev driver in Linux.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied, thanks!


