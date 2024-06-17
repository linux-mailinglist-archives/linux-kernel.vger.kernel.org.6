Return-Path: <linux-kernel+bounces-216576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA690A1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325011C20D66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4230679F3;
	Mon, 17 Jun 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Kz6p00gP"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDAEC2;
	Mon, 17 Jun 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587232; cv=none; b=a3OGqj7oPaz3M0be9UiwyQ83UB2JIMIDUrRqwtdTZQ55zt+pEnBgL0kGls7uD7fmJEp0R/cthT00AhK8FDxpfVzz0D567mCeuRm5jybx0FNsYcRnH8GKXK1SPzYcdGO7ViAW2NTXonnPNgrBybBYbOzGQ/+HjHrG2sm9tJU0DZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587232; c=relaxed/simple;
	bh=IWhyn77NhL9p2n0L7x6uS8RyPsjaZElXzod/unlkziI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaJ8kUGoi3URFFLa9Jul5yRjnpolLTYh4b2dutTNMvrIf1F2A8qzqI0Pk/IqaNZxJIzN+kY7XJJtYkb9k9RD10W3m19+7tl2PVMrZUxTDIM5CqGp2QokB+tuwzDSb66ca90yxob4h3XsRDK8Yi1jfXTYpQpDG6si9YH8NXzAVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Kz6p00gP; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=LyRaKTwcSbpX4+h/vcbOMfO4SU63utEUz5JhEM/Q7Y4=;
	b=Kz6p00gPY1egIvYjGxUe5KXOuKrCwUPq4WyFIFx5B0Ak4qYw5Ts05Ez8JLh2v2
	ed67yq+2H7j5h+yEv8or12NWKyulaet1VWyi6cfZ35981G26Tthcqnac6cxmFhaI
	z5L72QaoNlOUg+3hD5XwgFnvcEXdzpFGhvPfzc7a1TkPc=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrAD3XxlIj29mFzjNCA--.4024S3;
	Mon, 17 Jun 2024 09:20:10 +0800 (CST)
Date: Mon, 17 Jun 2024 09:20:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/3] arm64: dts: freescale: use defines for interrupts
Message-ID: <Zm+PSA8Rpo+fbbEC@dragon>
References: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:C1UQrAD3XxlIj29mFzjNCA--.4024S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUswZ2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDw0BZVnxc0xPZwABsY

On Wed, Jun 05, 2024 at 05:30:18PM +0200, Krzysztof Kozlowski wrote:
> Replace hard-coded interrupt parts (GIC, flags) with standard defines
> for readability.  No changes in resulting DTBs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied all, thanks!


