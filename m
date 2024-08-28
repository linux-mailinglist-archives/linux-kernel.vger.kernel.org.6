Return-Path: <linux-kernel+bounces-304268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CFB961CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBD283A26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C444713D508;
	Wed, 28 Aug 2024 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="liaabm9H"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151764A;
	Wed, 28 Aug 2024 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815396; cv=none; b=VZsBMdqsUlX5E9hkTbKoLECOxaBiRIQpAShHUU2qOLAr6DRDBypbQOEWycPoxU29X6ugANuAkXY2BSOCaCjW7DNvtuX/VvPjJoUlixCwVTYjKaOiwQYfVolfu6k8Zmm5odXZnsHZVrSbE+SKXAID/QUx2OD864iLNOrNT5w36u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815396; c=relaxed/simple;
	bh=E4uKhK+2Lcgv3JN8clb0pCYAPDKpfulBSPc8gSTpFvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5zVYrk9S9iIzhSWE97WebgMZ078t0LmdVCQWiZE1mTLPuNviYXGCeHWk761sgCMub7c2vvPSefeRLNGuG/w1WhoIT3yuAYhdygylSSaCnCa2BUL0UJn1HVzcyMpm1Y9zoWzcCqbT0cnQZAN5+KXSk9YANoTjDH2R7+Vy5BLbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=liaabm9H; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fk2Ed9YUNzBupdCygQKQYo3+Scmip90B6F4c/27J8ZQ=;
	b=liaabm9HWPs10HrlWJcwnrXk+kVgf8yzpFZjhBja4Tdu6tWiNiFtQUHCCcIxZp
	uMRt/VWkzY6LVZVwSlFaVU7z8w1SMFtSS6jFYF2BMnIeBdd7NF91wjkWMfbFgdSV
	IyvG5Qu6B3Pyr6dsWgtG8s7Z50dK5d2MokXa2ioTWxj3U=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCHd9X5l85mHWUOAA--.18601S3;
	Wed, 28 Aug 2024 11:22:34 +0800 (CST)
Date: Wed, 28 Aug 2024 11:22:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH 0/2] TQMa7x / MBa7x DT improvements
Message-ID: <Zs6X+IcoGDCwuVDw@dragon>
References: <20240812141414.96334-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812141414.96334-1-Markus.Niebel@ew.tq-group.com>
X-CM-TRANSID:M88vCgCHd9X5l85mHWUOAA--.18601S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIco7DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgRJZWbOiGVFWQAAsz

On Mon, Aug 12, 2024 at 04:14:12PM +0200, Markus Niebel wrote:
> This series brings two improvements: supporting the i.MX7 ADC paired
> with HWMON support and using a more specific compatible for the
> mainboard temperature sensor.
> 
> Markus Niebel (2):
>   arm: dts: imx7-mba7: add iio-hwmon support
>   arm: dts: imx7-mba7: improve compatible for LM75 temp sensor

We use prefix "ARM: dts: ..." for i.MX arm DTS changes.  Fix it up and
applied both, thanks!

Shawn


