Return-Path: <linux-kernel+bounces-215788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1219096FB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3F5B21B56
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A3F1B95B;
	Sat, 15 Jun 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="i5fhW8sg"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC82179AA;
	Sat, 15 Jun 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718440187; cv=none; b=On5R6w2h+98/KndR4JK55d8ImycvVeaR1XxBjpFWvegL1hzvXbgxXGcd+yz0RoC8NC8eI7aicoocAMLNjmGsXPz4hZ+XuwZIxwvXB/P3NiEEfOtV2kpz64Ufy4I8dtmKj9aEXPfIYgf5mRkiDpRkFHGQuL6k2TFzGAz4yzCsyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718440187; c=relaxed/simple;
	bh=eXs2N11tk4EVTAbK5payTC/c0HV7DTP/P6F2Yhv4530=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN2iRMVAKuH6+roSBzzZmCqVhmeq1otup5ZvZC9H3YMYMzFWgyfQrq8G36NAHbqbUWnWObRk4MhD5z1WRqs87IdYiUIoHzPGPK9UZqGTCs4TknJQVlghZZlsvUYD0SRvF95JytnuwsSij/CHEi28Q6bhVfoZIFyoKuzOen9XW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=i5fhW8sg; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xVsezcPEPkow2kGQ3cKnVTNXwOF0FhPQ2nKAKebMvLI=;
	b=i5fhW8sgo80AxUoU+fVWoNDgX+tvBH0v7kn5vlEKVpc2U8OgYAzWR/M7LBizeg
	phJkjHzzpkoPU2DS31b3eCf4s9nR76xwUxYGbV05EN6PL63RBxhCYBdvrefRp4lx
	mvKp7WvH5IR8SIKvOqmc2rQrkHGzvWVYQldh2xUU+DiLo=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrAD3_1DSUG1mgBm1CA--.23524S3;
	Sat, 15 Jun 2024 16:29:07 +0800 (CST)
Date: Sat, 15 Jun 2024 16:29:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
	kernel@puri.sm, Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH] dts: imx8mq-librem5: Don't wake up on volume key press
Message-ID: <Zm1Q0UIzRErYH16u@dragon>
References: <fa416916049e85ca159805e8602fa8361d5e6d83.1716202515.git.agx@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa416916049e85ca159805e8602fa8361d5e6d83.1716202515.git.agx@sigxcpu.org>
X-CM-TRANSID:C1UQrAD3_1DSUG1mgBm1CA--.23524S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-v38UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDxP+ZVnxc0hF6QAAs4

On Mon, May 20, 2024 at 12:57:05PM +0200, Guido Günther wrote:
> The only key that should wake up the phone is power button press. This
> prevents accidental wakeup due to e.g. pressing the buttons in the
> pocket or backpack and is in line what userspace uses to unblank the
> device.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

'arm64: dts: ...' for subject prefix.

Fixed it up and applied, thanks!

Shawn


