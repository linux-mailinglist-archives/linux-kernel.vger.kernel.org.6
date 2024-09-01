Return-Path: <linux-kernel+bounces-310159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7609675A8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2997A1F21923
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F981419A9;
	Sun,  1 Sep 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Dauo9VVB"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1361386C0
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725181665; cv=none; b=HXVnSlDX6wl9c1WG+/DHX0/7ZjSzKzk3U00ZEZhRtSwikdcgqlwMsEurPOnR+3CEeMnUKxx//0YrZAv1vvWT7/lai4oQ9kxS4p5sZma9g+aOhlU6ke46dyvJbdzVOaCPYhcdIHLoTaziTTEssUF6iVBR/QdEVV8SzeXBj8phgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725181665; c=relaxed/simple;
	bh=nZ9R9DPZ6MyAX/fu92JQAlf3F9AiHQg+OWwabV3td94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEjRO8IOtvevTLB9Pv9ioLnqZZ+sMxHtP92j+EXBuT3pv8vJpGlavap9xk0rHMatHbtQ72CFmyTi41ayX3DxoQhJcVq32SlsfxWTdgg2JXuaU/zFboQtcHhIY7Sr5QkUUSvS/kbnA+cNjwN5Ea+bERxUbZRDw+VYpy4wTsznkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Dauo9VVB; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5FhioCpypEaW6U0xjwuXsrDTI/jrqUyx2EFccUyrmbU=;
	b=Dauo9VVBQ+FA6W3c/n230sw3LwSHLParJAG++ydM1FCc6EFnwL2mDmJvFnT4Ap
	a2tdW1s36zW1VAAYzgCjgq3wj2vXPSM33PhC1JEC8f7B9a+D/zXas1SBWx/8fWIq
	IzITZ0C8fjmQ9/3vTkun9sGv210hubgia8a3xeN3jUdXs=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnN1vGLtRmtstDAA--.32211S3;
	Sun, 01 Sep 2024 17:07:20 +0800 (CST)
Date: Sun, 1 Sep 2024 17:07:18 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] bus: imx-weim: support compile test
Message-ID: <ZtQuxseGzLDqZIqm@dragon>
References: <d0d3877a33db855e232ec4c6911a6937402d501a.1724728767.git.bo.wu@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d3877a33db855e232ec4c6911a6937402d501a.1724728767.git.bo.wu@vivo.com>
X-CM-TRANSID:Mc8vCgDnN1vGLtRmtstDAA--.32211S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVj2MUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRNNZWbUDFlF4AABsx

On Mon, Aug 26, 2024 at 09:23:47PM -0600, Wu Bo wrote:
> Add COMPILE_TEST to support code compile test
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Applied both, thanks!


