Return-Path: <linux-kernel+bounces-231964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F591A0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25583282E70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0577102;
	Thu, 27 Jun 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="SmeuuByr"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478C7BB14;
	Thu, 27 Jun 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474776; cv=none; b=FZS3YVaDsbfP6WRkqmJOKZvLXkXp0EzxoZVhKqiPn9c/D6oFKcfwesF6ZPL54xlrbnfZ73mkybHPnvlqnIFmF4RMzM3IMwUh6bs4z+AkLzFw1ls0YfdUvzCIPu8tBUYZ28ycxGSAxvSC90FP2GnU8WWwz02j/vU0IjKJhpal7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474776; c=relaxed/simple;
	bh=GYU8HzIdO9hP2JGYf0FV96iOrnHzrbnLscaU/Hs1bXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw6AgCr3ME9btnj0n5Qq/zS/1Xdot8rR4IfEBmEmisIuTrvcYXUY/P7K4uQwj/MUPEfYlCBbdKYO9KtZK2iSdSED8oUr/DGTFZ1fWtauZTr0YQDPJViQB9eX6HHbDnE5y3jaPLxUmOhRQi5HJn4ekM3wgbSKlqEbv8Nj/vByLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=SmeuuByr; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=QXWOD1o91C9uwUf55ogz7RKsgNBQyzukXCYzNlkSrzY=;
	b=SmeuuByrA3RzzJp+BSKvb71mCndt/XQo1w/fuzaVqXpXv1Rft3U1xsVsswJ4cw
	njUHA39THvCIDQLa5znKVjmYjJ+7EOLWDyStZFgJS/ZVDx7Kd0pf+BnFSYKznvJK
	54xEalcn0jl7PJ79ZMXqU7eJ8DB8wBnlKHEOemYi/PojE=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3H44vGn1m8t4ZAA--.53094S3;
	Thu, 27 Jun 2024 15:52:17 +0800 (CST)
Date: Thu, 27 Jun 2024 15:52:15 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix pgc vpu locations
Message-ID: <Zn0aL5jz8162ImRr@dragon>
References: <20240619101045.6317-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619101045.6317-1-aford173@gmail.com>
X-CM-TRANSID:Mc8vCgD3H44vGn1m8t4ZAA--.53094S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-o7KDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhELZWZv-cxPuAAAsi

On Wed, Jun 19, 2024 at 05:10:44AM -0500, Adam Ford wrote:
> The various pgv_vpu nodes have a mismatch between the value after
> the @ symbol and what is referenced by 'reg' so reorder the nodes
> to align.
> 
> Fixes: df680992dd62 ("arm64: dts: imx8mp: add vpu pgc nodes")
> Suggested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!


