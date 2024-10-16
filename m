Return-Path: <linux-kernel+bounces-367214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD199FFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFFF1C2455A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0816F8F5;
	Wed, 16 Oct 2024 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="GxGuLaez"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A38290F;
	Wed, 16 Oct 2024 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051266; cv=none; b=p/33VluBQbzuoP/zlDyIvRsrghGn3fo0J/n5AebAqthf7Ixjiw/BwFEKinYgV6gHLmcZNiJhDo5clPKuAMWUwLUhz64IGnGaBhAtiBqma8qftbD3PvLj0N0tdfMpS8oZZhKGW8TwXaIIvN/FwWTkrM31PscSoQo8/BzLkBqfjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051266; c=relaxed/simple;
	bh=omqPBGfL8vY9QxcUXb4IxqKQrV+7pN418hzMeS5LWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQy1ewmqnwnmCSgQsiVFGqwwv7KCkYpU2YRMIUVXcMbRxDbYy7gDYQzEvwW8XYcNn7Vp/bmaysoaLCYfZeUUUvj1DH/mTZDs8/vtonZHEK8qh/XdOF1n2haEvACp0VVOLI88lGET/VCqbPhZTpr6UyAN2OhOWQStpWJSVdb7LPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=GxGuLaez; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=vPZCVFvAXxX1o1BhtfXHyQ4idi+RTaxyCNJJM4SgxMU=;
	b=GxGuLaezYXAzAIcfSWa1mg2l7EgwfX32PDzftal5vs9HxR40m6+5GtW7+EIqAU
	TMHlSACRjCioCvGDMn7FVqOUQDgb+EIS/+Gbu2caKN1CyqbjABJ+gEmNSCMTb5hN
	ljZ/mSmZhdE5Vb8Z0MhOe5TiWFe0jl0Ce3Wdh4sM4lm9w=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgA3Pw9fOg9n2rYVAA--.293S3;
	Wed, 16 Oct 2024 12:00:33 +0800 (CST)
Date: Wed, 16 Oct 2024 12:00:31 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shijie Qin <shijie.qin@nxp.com>,
	Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
Message-ID: <Zw86X0V4qBJdcP+a@dragon>
References: <20240904114104.1841269-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904114104.1841269-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgA3Pw9fOg9n2rYVAA--.293S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7g18DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhV6ZWcPEZ+TTgAAsj

On Wed, Sep 04, 2024 at 01:41:03PM +0200, Alexander Stein wrote:
> imx8-ss-vpu only contained imx8qxp IRQ numbers, only mu2_m0 uses the
> correct imx8qm IRQ number, as imx8qxp lacks this MU.
> Fix this by providing imx8qm IRQ numbers in the main imx8-ss-vpu.dtsi
> and override the IRQ numbers in SoC-specific imx8qxp-ss-vpu.dtsi, similar
> to reg property for VPU core devices.
> 
> Fixes: 0d9968d98467d ("arm64: dts: freescale: imx8q: add imx vpu codec entries")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


