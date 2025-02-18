Return-Path: <linux-kernel+bounces-518651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D042A3929D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65FF3AF9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD07E1B0F1B;
	Tue, 18 Feb 2025 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="a7+hdU1D"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF061AF0C0;
	Tue, 18 Feb 2025 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856432; cv=none; b=hj9Z7Vo1cEChRUVeA3D4a7mcJVbbOo24C9VKg8pbZABB/P1apDwImnySL5izAUu/uY7jrh5lElSAGbhp7J4KcAi9L8Qe1zTaqDef2dlMWxzGHxsbGFWa0mY7ORVYBuTn31yrFM9r2X5HKEC3+5+aR0qabbqHOFumOO5kbwAyYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856432; c=relaxed/simple;
	bh=tZ0HpU3MZgiWbBVKSa853kjFuS+3oWsTAEhBNwlQ3YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkAxqk6Mo6GF5wFwysz3amyb/Q6Jt8HFWz4zHVpYTOmpX/hHjB0EEv3rih1wjpZ9w8hhogyduF0N9Z3yhNSv2jtsPv84QqN14+i3H/rJ81tg7K7C57NArfJfWpIVoQ6LccOYC9QphZgtPab8pm821V1vUhM+9ZvqhVwBL+RnJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=a7+hdU1D; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5Z/rv6kgbqoEOS86d4A1Y0Ox+de8Jp1ZNiq3e/n2Z+0=;
	b=a7+hdU1DqXwpOZMxiVczG6MxPp7lyP9gTrPGKiYsFe6vyVLv6puTFoIxIja/Sy
	Laq+l91Au5+e6XtMLnv8steg8BnrNC27fF9OShYZvPVakLzXCLzcyWcfpIyN+476
	VX0/hc0rO0snjY/aXe3/kOAFzD0cnMv/LWEmplhkNfWfc=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgC3WloFGrRnlE02CQ--.18058S3;
	Tue, 18 Feb 2025 13:26:31 +0800 (CST)
Date: Tue, 18 Feb 2025 13:26:29 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 0/5] TQMa8Xx update
Message-ID: <Z7QaBZ4kWTBrVOEo@dragon>
References: <20250107140110.982215-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107140110.982215-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgC3WloFGrRnlE02CQ--.18058S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsmFCUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhj3ZWe0E1YVmgABsA

On Tue, Jan 07, 2025 at 03:01:05PM +0100, Alexander Stein wrote:
> Alexander Stein (5):
>   arm64: dts: imx8-ss-hsio: Wire up DMA IRQ for PCIe
>   arm64: dts: tqma8xx: Add vcc-supply for spi-nor
>   arm64: dts: tqma8xx: enable jpeg encode and decode
>   arm64: dts: tqma8xx: Remove GPU TODO
>   arm64: dts: mba8xx: Add PCIe support

Applied all, thanks!


