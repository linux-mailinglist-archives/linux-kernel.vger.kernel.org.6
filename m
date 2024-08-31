Return-Path: <linux-kernel+bounces-309931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E858967208
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83971C21449
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B01BDDB;
	Sat, 31 Aug 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="h/JZnhP5"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B3A932;
	Sat, 31 Aug 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725112851; cv=none; b=UfadMQMeOG7ONT4PWdA3yIv3KGkEehYfFLoUF0qyJzlDSXIkWyMfFVtrz6kyBL0WyCcQFcwN+4i+Vb21nLO3xPiyegVp5mzG7zJCu57uIdl6a/SehpPChEdbo9kYT/FshMS9DYrA7UTXcieI51pdd6gIasmeaaNPtIevUFMvrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725112851; c=relaxed/simple;
	bh=y4Qdhjn0FN8uf9zeE27PFL4cEPKOHqWUGu3Z9m6rDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+6VOgakQPIgBRuTa1BlPwY9kWyfpGUULO6yCQJxMv3saJD/7pQ4JnXbBZu34fueXGowqAYer6YsvIJYs97D1mBxIiBTtrw2yhaoTxoPkOTQyrEBRZP5+03KS5F81FQeSoPbOqCtebqEKGQssKBK73vZxOfHuJKnETgDzhFbanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=h/JZnhP5; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZHMlLxBV6WiIADgN4jDjxhO6TGFE1s5YKCIdS8a3q+A=;
	b=h/JZnhP5twlgQ7wbNgfW7av4FiiGw5reDcjYIywCCqLHLTy69k1WVGSFcAB61j
	yT5HFdYy4p/CgcDxueLOP6m8HSbm5EzuZQKw1ro6uI0n1tKR0eNOAbB1XDhrVPDF
	b6llauRWk0rQETPITjzD14QnmahhYodc5gM5m1CZBuBK8=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCXh9XoIdNmkpo6AA--.14294S3;
	Sat, 31 Aug 2024 22:00:10 +0800 (CST)
Date: Sat, 31 Aug 2024 22:00:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mp-beacon: Enable DW HDMI Bridge
Message-ID: <ZtMh6J9pUUTPdWo9@dragon>
References: <20240819231814.120053-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819231814.120053-1-aford173@gmail.com>
X-CM-TRANSID:M88vCgCXh9XoIdNmkpo6AA--.14294S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIksgUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgNMZWbS-GZHsAAAsh

On Mon, Aug 19, 2024 at 06:18:14PM -0500, Adam Ford wrote:
> There is a second HDMI connector on the baseboard which is routed
> to the DW HDMI bridge through the PVI to the LCDIF3 and requires the
> HDMI PHY to be enabled too.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!


