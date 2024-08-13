Return-Path: <linux-kernel+bounces-284020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB394FC00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1809A1F222CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AA18AEA;
	Tue, 13 Aug 2024 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="QCx29F0s"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE73714A96;
	Tue, 13 Aug 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517617; cv=none; b=TG+4R+G1nNtSYmEO82HlHXemGHPxpwglzJhCffrGeTds5xbd5xW2/mX9GFIndsLPgDPwhqohXx1Y8MXePQjTt3DQ5gpv+j93fyWZKjSc25hGYlerjfhq1zrr6HCGjgeRRWlDvRJcpmxedBu0//wA1AuslLSowtUDUrShlwbf6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517617; c=relaxed/simple;
	bh=zpkHEFl4nm22LoiuuejnIWLVPftUOUGgk7YSO/YixTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfaXb+5KbXQwCSHswF1OS4+eTcpARxyH+P0sK50g1y1PdvnYRddSvMo45ZipWAef+jqWsvFZeKXsK39D6+Cc0rva8qkp0rJjGg7AxlNzL5ijbhNwXBbSXpkcmHetKZ9Qs2jYsbjBw8gGua1p5PWWZE00PP4ghMKMWJJULcTRDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=QCx29F0s; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=c1gYxZpW54fh+G7bon+YmrbzMVsseD0KKts9l3Dg63Q=;
	b=QCx29F0sHHo7LCGKn6Ye0N3F2CwmpN5p3GQ+djlDzTjCAwYUD4r6CLR98F02Le
	xnrgksktLUpSA2m2HHZVpS6mQBObEysamDN21Ix7Dz0zjPmAh24L6hBXvR46Z/fK
	X67CeTIRfSYodyD1AW+5F786dWw/euyLoSe6LwMFl5SJ0=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBnjyePyrpme1FSAg--.41505S3;
	Tue, 13 Aug 2024 10:53:05 +0800 (CST)
Date: Tue, 13 Aug 2024 10:53:03 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx95: correct a55 power-domains
Message-ID: <ZrrKj5pjypWHN29f@dragon>
References: <20240729064111.2060746-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729064111.2060746-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:Mc8vCgBnjyePyrpme1FSAg--.41505S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI038UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxY6ZWa6xN8YQwAAse

On Mon, Jul 29, 2024 at 02:41:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The A55 power domains is for SCMI performance usage, so for device power
> on/off. Correct the power-domains entry to use scmi_perf not scmi_devpd.
> 
> Fixes: 5e3cbb8e4256 ("arm64: dts: freescale: add i.MX95 basic dtsi")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


