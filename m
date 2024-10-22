Return-Path: <linux-kernel+bounces-375747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AB9A9A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F5F1F22766
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42498146A9F;
	Tue, 22 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IYmD2TNR"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA6770E4;
	Tue, 22 Oct 2024 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580112; cv=none; b=X/++wdILwJ8tUwWte03p2L8yR7ZQuViXw6pHOdhpeQPw3gRXUa5qV2mPlBsxY7VzPvhJ9ZEOwxtcszGfCPoVcHtMdYceQ1QmVakubXjTUYhvAzowIdkcn4vqAec1XJ6lHq6J8qNexqZahLO97B1eNZGYCy0CoI4fEViKvoLUKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580112; c=relaxed/simple;
	bh=ZjJ0Wt+Xa8mdkho0L0ET8P20sj6XnC50OAY4+l6RbdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn8vVcQ9BAbPKoPt8tYlMLusOcR62El5YOAZbrgF+aO5K+K3xy+iKH3aq5f/HdXCexRVSA1nZ6RJ3Hqm5t4dTZC6VDRKCgUwGONy9yuRFFclGATYM9Hmws4uscjqvOKQiqbTOLxFDHiwDcwFY5CQJB6XVJw77u+8Fw17DjuUY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IYmD2TNR; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/vhDuQYV5YlG5L+yjAZnN1ic7CiXa7VdGmu2Q0f6FIw=;
	b=IYmD2TNR1wsqfGawVh70PfnIw+hNoJoHeYNvmz9yWqu5fFv5LmT2IpLLFz4ZP/
	GQjy8n3MgJJpKMe8EVeGahTH0FhMEwTP1aRi3fp6Rt3Rg/hJhyPj95sC7mVdnm7g
	XmVCCn/cMx+6VVR84Nst+UeQFAa4d77qKCM5OgSuUKhfo=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAnpczwSxdnar+XAA--.5492S3;
	Tue, 22 Oct 2024 14:53:38 +0800 (CST)
Date: Tue, 22 Oct 2024 14:53:36 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: imx8m*-venice-gw75xx: add Accelerometer
 device
Message-ID: <ZxdL8PxrmT3X+aTV@dragon>
References: <20241018173608.810073-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018173608.810073-1-tharvey@gateworks.com>
X-CM-TRANSID:Mc8vCgAnpczwSxdnar+XAA--.5492S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsPfHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQqAZWcXFF+d1QABsU

On Fri, Oct 18, 2024 at 10:36:08AM -0700, Tim Harvey wrote:
> The GW75xx has a LIS2DE12TR 3-axis accelerometer on the I2C bus with an
> interrupt pin. Add it to the device-tree.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!


