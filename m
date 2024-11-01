Return-Path: <linux-kernel+bounces-391886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628769B8CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AD6B21F30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60107156661;
	Fri,  1 Nov 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="F3kdZrwR"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D082D15B0EC;
	Fri,  1 Nov 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449111; cv=none; b=eGzNocGXKahSlL6jBBj/6NTN1iW3AHm+eWyW0Tw0Que/8P0e9td7K08N7ey5eA1lOIBPOQoD5LB72mujZvVPWrFpPwheTI2IRvn74imrE4x/gfNqSdMvNp29shGCuaXFURj555EMFNtiS8y9Hzakoz40z07OHXmeu1ZJCeB+M5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449111; c=relaxed/simple;
	bh=5RcrjjO7qeoHBIrv/8qBQTZB/q9clujvw1CFFoAQEC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b30tOSXN+BhS1ItqzZXeDNBMJTV7r3fWk33Jc5iqsjtC15wiedVQ+Hm8HdvwV+tSSE9kkyv4oqj9YTTuA9QURA+0PLtAPT0xzcoER/hsl0y7x8KXX2TFt6b8pGKikUkG8ZnpwUukKKI/VulvEZZuXfB2FwfkfhZNvnEPMQKe0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=F3kdZrwR; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=W//kf/xYk90pfIs56Ch6ErGwbP2X2r0D6G2dOa75D2A=;
	b=F3kdZrwRbH5+cXqtnibhtwd//eQBKihnrDo6se+FoTwKJNQIs0t3AynIjszhNQ
	Fa3oqazt6r2iuWNm+p9U63uTu80vSchr/rK9arzpD6anjLD4xARQRwU/njzpjl0G
	GDJgQ3JRC0rvJ2GJym6Xc9U9LR3F04sldt9lxRRdE+UKs=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBXXhO2jiRnB35nAQ--.13924S3;
	Fri, 01 Nov 2024 16:17:59 +0800 (CST)
Date: Fri, 1 Nov 2024 16:17:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mm-venice-gw73xx: remove compatible
 in overlay file
Message-ID: <ZySOtUd9jExZdFt6@dragon>
References: <20241018182824.740133-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018182824.740133-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgBXXhO2jiRnB35nAQ--.13924S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIXTmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxyKZWckPo77kgAAsi

On Fri, Oct 18, 2024 at 02:28:23PM -0400, Frank Li wrote:
> Remove compatible string in overlay file to fix below warning:
> 'gw,imx8mm-gw73xx-0x' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


