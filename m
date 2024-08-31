Return-Path: <linux-kernel+bounces-309920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD49671DF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1BCB221ED
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559412E78;
	Sat, 31 Aug 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="oqAx2HDj"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B1320F;
	Sat, 31 Aug 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725111405; cv=none; b=eN/r6kJ/xfPNKj3Z8ORIRcz/uIX6UvezooNLz4L6C1dRwJorCYRwz6sH7UdNwvSfgO2ZrqEulJ6iAxXtTmZiddpdhcfKIAhNW9tyv86EaWxKJB0wJUWIVC/q9exXjHqMGlVjgAN7sdAfj6b0lPqa/Dzbx3zupRMZKoezM8yzsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725111405; c=relaxed/simple;
	bh=n5AUtF3wVZ4zwqbNzHcgWSVLZJ+mR04ru7iPNodVzCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSxwvsjFrAnRTMIC886LpmVUtMMTQFjaffJsW/OYseqxRt/xHrNCGqh9a8IxIzSJ9lzhbnHoAsVqL2mizf0AYYLnPBqjmC3LOE+QWW44JRUOhEOZ/yhNaf+ySJcqE3C3SaLjvTAi2NbLvILofVls7BkGzPCtC3NmawcHNGpfErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=oqAx2HDj; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=qsT7zp/cpYrrsz94pmaUvV+m7ImMKNji+k7TcHWFw64=;
	b=oqAx2HDjYnj+FPZRec5gYVQ6LV9Cm+CQNdJ9zhWTawSy9qeGFpWVpL/F7FdYq1
	OdvzNOWvPt3pHMxBFFLjz5waGCWEnVkAOp9NwAGd/J7DOPfByaXxbiNto+CBxQnx
	SZ6ssvOOY63NDmKaDu5tbSVFIJXHKR/TtVvj3nB1ISz0M=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3Fz9QHNNmI9M7AA--.11226S3;
	Sat, 31 Aug 2024 21:36:18 +0800 (CST)
Date: Sat, 31 Aug 2024 21:36:16 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm: Update Data Modul i.MX8M Mini eDM
 SBC DT to rev.A01
Message-ID: <ZtMcUDxUm4ZoMZbV@dragon>
References: <20240818203029.96035-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818203029.96035-1-marex@denx.de>
X-CM-TRANSID:Ms8vCgD3Fz9QHNNmI9M7AA--.11226S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIksgUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQtMZWbS-GE9EQABs3

On Sun, Aug 18, 2024 at 10:29:52PM +0200, Marek Vasut wrote:
> Update the DT to match newest Data Modul i.MX8M Mini eDM SBC rev.A01
> board which implements PHY changes. Keep some of the rev.900 PHY node
> in the DT so that a DTO can be used to support rev.900 boards easily.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks!


