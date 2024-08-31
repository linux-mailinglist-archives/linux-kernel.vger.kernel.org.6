Return-Path: <linux-kernel+bounces-309910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1869671C2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B742283B69
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0A010A1C;
	Sat, 31 Aug 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gqXEIUUR"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1228CDDBB;
	Sat, 31 Aug 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725110478; cv=none; b=SDHM1thuKX8PuezhIYg2V/QRzj3j9frSBQ4IgW7y2rt6psSMxnTSn+ey+koo6sawJxQ2Zg0JaQZeLTHPhcrNVA8yqjnmolzPCLH/trx2bJPZw/R9TYmBkuMhko3zd9LCg8TvYwd4Dv7bxesdb68lE/4VcurrnPF46YOuSZ3vHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725110478; c=relaxed/simple;
	bh=6gerh+4m9TOL8QpS7wObCi456AtJ1It5igqGsVG1oEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewmJE7UeinmtzNsAiyrfAVyHeYqoplSRIU3XGeJ/5cHjj3jW7b0ejTOpN3MACyT2Sey2oue1LJGHCh/kLmiaghp3F+ywFtfebsxrtFj2lf4ILDHL2A7XlxR03I69w8ujhFa91PfcuIde20QEEGLny0EQbbA2cR/m6O5OG5OImGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gqXEIUUR; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SCKj5wvSROJE1QpWcm2KpBEU5Y+Y3j7do70UkU92Mm4=;
	b=gqXEIUUR/7uJsS7k5q/g7o5tDGivRgqJlmWmb7T70o/Mj//aOnDCRw0Rpr5qzL
	o3ue2kbra4OW9sH7b7g8Io14D5Ca9OIjqSJRwyd5QdNgkMr9IWIsqCK7WXy1jond
	jkvq2IfW3/x7Sjw68rULQREVkaoQjCYDhqZkTjSFQYJ18=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDXfjqoGNNmjqc6AA--.19497S3;
	Sat, 31 Aug 2024 21:20:42 +0800 (CST)
Date: Sat, 31 Aug 2024 21:20:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yannic Moog <y.moog@phytec.de>,
	Benjamin Hahn <b.hahn@phytec.de>,
	Yashwanth Varakala <y.varakala@phytec.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH 0/6] arm64: dts phyBOARD-Pollux: Update regulator nodes
Message-ID: <ZtMYqOB5fjO6LKQz@dragon>
References: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
X-CM-TRANSID:Mc8vCgDXfjqoGNNmjqc6AA--.19497S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4DGFWxXFW8Zr4DCrWkCrg_yoWxuwbE9r
	1rXFn29w45ArZ7G345G3ZIvr9Iqw1jya4fZry3Wws5tw17ZF1DC34S9r95ZrW8AanxAr4D
	CF1xZay0qry5ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8_nY7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgVMZWbS-GY3CgAAst

On Wed, Aug 14, 2024 at 11:26:07AM +0200, Teresa Remmet wrote:
> Add some fixed regulators based on the phyCORE-i.MX8MP and
> phyBOARD-Pollux-i.MX8MP schematics. Reference existing or new ones
> to the correct nodes.
> 
> ---
> Teresa Remmet (1):
>       arm64: dts: imx8mp-phyboard-pollux: Add SD-Card vqmmc supply
> 
> Yashwanth Varakala (5):
>       arm64: dts: imx8mp-phycore: Add VDD_IO regulator
>       arm64: dts: imx8mp-phycore: Assign regulator to EEPROM node
>       arm64: dts: imx8mp-phyboard-pollux: Assign regulator to EEPROM node
>       arm64: dts: imx8mp-phyboard-pollux: Add VCC_5V_SW regulator
>       arm64: dts: imx8mp-phyboard-pollux: Add usb3_phy1 regulator reference

Applied all, thanks!


