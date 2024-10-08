Return-Path: <linux-kernel+bounces-354829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED0994317
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0AF1F294CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691431DCB09;
	Tue,  8 Oct 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="OpwYvbnr"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06C19340A;
	Tue,  8 Oct 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377474; cv=none; b=aOqD3GACPSJjFvBh3PaUvp1zilK0nCVqDLppUABw1lKnmuuN/NVeh9jvrhrlhfXdQPmrTVQW7xA991ulY7a+lLDaplcp1cc/PY610iyArDI5086foRkYMAHsJO9kZHfMGvGDfw7cmXMiJoPhSxpAG36fx2AAVoj3rW7ffXip7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377474; c=relaxed/simple;
	bh=5EYqTaH65chTt/LnuwJZgF8ia3vSrrdnjA7snFEHGqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duAWVfjJkDRXABRup8g+bhsDBtzlllHJM64cszRqXjWB3Ncz+WXdvQUrijFTyA9jTkLyRVrMluPFeqRtHpbkbdOcgno1jFE21VkBIpodfZHqtXMxoSNHk1XRCNkMIEAVe+LAuumvk2HswhgY8ge3L7SUsTajF5W7XH2xn0HyoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=OpwYvbnr; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=PJZdc22OCR844nkMs2ao6cs66z7059vtXIHCyFffkPk=;
	b=OpwYvbnrgpjlqKX5BnUpeI3nMk3cUj6Xfs7mEVUIQD6IwhgjOfyo1ayZvAC1mh
	MAonW5dn/A+cQLzU8rFn+BI2rb3ZVaIRJrjZl4rMBf0H/cpGV44/etOSUx8Nh2Y9
	12DsQZH3pn0fOKo+RTLQRsin7/LPVpK7xWFqMsYHGbdZo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnlx5O8gRnBRXTAQ--.54852S3;
	Tue, 08 Oct 2024 16:50:23 +0800 (CST)
Date: Tue, 8 Oct 2024 16:50:21 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: imx6qdl: Add reserved memory area for CMA
 memory
Message-ID: <ZwTyTZH4+CS8lm0Q@dragon>
References: <20240827142458.265558-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827142458.265558-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgDnlx5O8gRnBRXTAQ--.54852S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVxR6UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCR9yZWcEqhjkVQAAsh

On Tue, Aug 27, 2024 at 04:24:58PM +0200, Alexander Stein wrote:
> Default CMA size is too small for HDMI output and VPU usage. Increase the
> default size by providing a CMA memory area.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Changed subject prefix to "ARM: dts: imx6qdl-mba6: "

Applied, thanks!


