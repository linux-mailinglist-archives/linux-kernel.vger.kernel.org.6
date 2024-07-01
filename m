Return-Path: <linux-kernel+bounces-236375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B091E14A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4CB1C22D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB515EFD7;
	Mon,  1 Jul 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="f4nBRQoa"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C5A15B542;
	Mon,  1 Jul 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841969; cv=none; b=bNE11BS0o/8fq5BOA+rXOFUmUdY3xD8obVMl4mXc75/IqrQBV53JhLQBsNu7TM73GHWVJy/Pwh/9NXh1ahimWCBwsmdn9/sei0VDdKtfs72n7bNTldkgWhY2LhptV5M+Shp79pVPWbiBcj+pG1pOINX5lG1cJ3TgpRorJBzSsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841969; c=relaxed/simple;
	bh=1VxrunHFnePekVsAFdYOTKByhl7MciIsr2MDBNNJ4mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzVYKS0FIAYVhqk+o258JzcK5ZP5ZQOKuG8ZK0tX2ORsqNJEiDL4zGf7RL1OJG+5+r/oiQVCQGmwVClJVXDrz5BPOZgOFBmaO3PXi5wlvZQuj2OOG2K3hyxsXRyCJaDr+6iBWWWW+5A2BwfiiyOv63vkY9ZVOLtTLtpFdu5M/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=f4nBRQoa; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=x5c6nQHpbtpUoQ1m3fxRmlqTaW9KXF9YbGJxyq9YH0w=;
	b=f4nBRQoa318CsJCjMRqGR6B9EZm/9BfMbX+wGg5M61QTspWGwiqDoVdD63RnAT
	MRQr6PdIzOBU5jEp2t81r/yrYLNsuSEIRtCPCT1mcwjLijFjhyJtMw8ovH/v5f8y
	tchiWZ0KG9fU0JwzBUXn81dd7U6xQUkdDxN5Jh+VSyNgQ=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXD8qNtIJmxWQ6AA--.345S3;
	Mon, 01 Jul 2024 21:52:15 +0800 (CST)
Date: Mon, 1 Jul 2024 21:52:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Vitor Soares <ivitro@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mm-verdin: add TPM device
Message-ID: <ZoK0jX27DHCHawWv@dragon>
References: <20240628090751.797818-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628090751.797818-1-ivitro@gmail.com>
X-CM-TRANSID:Ms8vCgDXD8qNtIJmxWQ6AA--.345S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4GQ6DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAg8PZWZv-duX5gAAs5

On Fri, Jun 28, 2024 at 10:07:51AM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add TPM device found on Verdin iMX8M Mini PID4 0090 variant.
> 
> While adding the node, rename `pinctrl_pmic_tpm_ena` to
> `pinctrl_tpm_spi_cs`.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Applied, thanks!


