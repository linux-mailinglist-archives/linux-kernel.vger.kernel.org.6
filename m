Return-Path: <linux-kernel+bounces-283017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7A94EC08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D681F2261A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD2D176FAB;
	Mon, 12 Aug 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="QLC1x0dn"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D91547EA;
	Mon, 12 Aug 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463141; cv=none; b=Z5AWjEPlpNtnN/+5DWSczpMzUuaPilq5gxyBc8Ccci2G9kzFTugEux3b0jCV+GhkmJBZrVb/f4jl6Lzgo51kEuhTwCST4yijPFbFHZs8HXugMAnxAJEzAuzZfS1a2YEHbeRQzxeo2LGW10/SZtwHy8VrIh9U8y48zvpicfpLGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463141; c=relaxed/simple;
	bh=RQzIP98eTU09Qu10gILWyWOC5UI6sWVuzdcLl7xrMCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef6YmjzEsfJCYu8QDXG0VT1s4XuJTRSXxRrLsiLtABkKLkfhXIMJFKYgQ8V0yL7U99A9RjvcA+GkkMSydQGdy54gl8eBmiyxX9DJYDKbFSW8R75tZVwN4snjDT6T2l8zq5Ab8v6C5G/WEtJeNpu5o6qYURvJ1BM4Mv38IH8rsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=QLC1x0dn; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=aorH0qG+kJbHSBn1vZn5uJ/vcbDeUNHXpZL0nUzb42Q=;
	b=QLC1x0dncSAh6SzFT1xX6OeXAgRUJCflkbo5+usXM5Lmu+6G5F2rZe0IMrWmkF
	ifzuLwj2oEzb6vuHG7HCoh9t3FflhwnbT7u23rp8V0+VxhPS2+IskkmSNN4pYioo
	aw5fiQ9kKP/ezGBaKM6sPuWA+0y52+wp/qDubSFWJ5D3w=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnLy3A9blmjN1KAg--.44347S3;
	Mon, 12 Aug 2024 19:45:06 +0800 (CST)
Date: Mon, 12 Aug 2024 19:45:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mm-tqma8mqml-mba8mx: Increase
 frequency for i2c busses
Message-ID: <Zrn1wA6pJXXa7Nec@dragon>
References: <20240723110146.3133155-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723110146.3133155-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgDnLy3A9blmjN1KAg--.44347S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUa0eHDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAc5ZWa57GwZnwAAsG

On Tue, Jul 23, 2024 at 01:01:46PM +0200, Alexander Stein wrote:
> 100kHz is only needed for the USB Hub TUSB8041. But as this device is not
> connected by default, the speed can be increased.
> The other busses don't have any 100kHz only devices attached.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


