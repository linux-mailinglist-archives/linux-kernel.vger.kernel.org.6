Return-Path: <linux-kernel+bounces-231955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A865191A0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35910B212DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95406E61B;
	Thu, 27 Jun 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AyhiXQnE"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC44D599;
	Thu, 27 Jun 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474630; cv=none; b=n0S7tnQpynzn2OMH2IiekZHcw5glLMWcJ+96FqN/jg/5At72IfZzN4IhZ5twLVB7kq1n9Jymmwf625c0ncXOyylhNdoau5OI1nSdPkvpbcDXoJP8V3fJUoY8NXCjvEj+wdvWdUcC9l0R2XqF0p3W9/4Blvj4IIA3pjPAjwXYAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474630; c=relaxed/simple;
	bh=A4DFNsk/8Evh+atHfIaiD0BiPEy11TZQ1hjUsej3uRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLM+66AI1xQxba8dh0i/uM171OaNmmGzmVkj9Mv1F53S5oScCy7dAzk/JJOfsq5JejHjvgXL8KKUHxAXTQwSNAKs3LklBEYUCTmU5YMJiddY08JTrqgNC0CufOItcPsBkM0Bc7K/CddCIxfu58kMrM70ys3PWI6JhTgtvTdGqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AyhiXQnE; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=mYGJ7SK1xTJp98WxWi32bZY4FNhdtb0AUofhUK5utco=;
	b=AyhiXQnE9ElhSddRXolIkjwtRxMoMreq9R205MguMSidwEbsJtsh1zd1teL7Li
	Xz03tt9ebqmyGxH1DQ7xdKL1cbDocHW6CesitYvszAhBk3xMcjys20AD0hbqMndF
	dZXVSDCX2A2imLrv6vDloXZ9+3h/9nnLeh1haB92tJwDw=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3X445GX1m3dkZAA--.52692S3;
	Thu, 27 Jun 2024 15:48:11 +0800 (CST)
Date: Thu, 27 Jun 2024 15:48:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: imx8m*-venice-*: fix gw,gsc
 dt-schema warnings
Message-ID: <Zn0ZObkf7W21thGk@dragon>
References: <20240618172150.1693704-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618172150.1693704-1-tharvey@gateworks.com>
X-CM-TRANSID:Mc8vCgD3X445GX1m3dkZAA--.52692S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIqXdUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERsLZWZv-cxUVwAAsf

On Tue, Jun 18, 2024 at 10:21:51AM -0700, Tim Harvey wrote:
> Fix the dt-schema warnings due to #address-cells/#size-cells being
> unnecessary when there are no children with reg cells.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!


