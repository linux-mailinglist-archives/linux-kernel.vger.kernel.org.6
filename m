Return-Path: <linux-kernel+bounces-310167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C959675C3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8AE28239A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3814A636;
	Sun,  1 Sep 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="clSpKI0k"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF811E895;
	Sun,  1 Sep 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725183020; cv=none; b=SDhgpCyEdhtVnixao/rsVMQgZ2W6WAQhGQHm2I1idoe88t0966ykbBezJn/GryoLp+tfweeFQSJPIE4B5mrqAftjOz45bPODPbleB9lyAaI6H8VRNWRF+UhbF5yvufG2Igg0voxc+bXljShg169zXaPLOqwtnK9bhlphLM6jsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725183020; c=relaxed/simple;
	bh=W6VQ7T3yMdL9F61C4C8tbpZRVPBJ5ooOtnNRTH4ds1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSDFLvbEjGEmtxEgPl0VVj8LcWar7KZ6fZOnmPw1GUrWU9TJOW6xh5zjtHh3gQt8NkbuBk12Du4tghOd9iiOHzfLNarG/zDxxbBQX7rSOkl4BGpHFMBts3n4Esxu2iA5BfuLOKu4XN3Kmo/B5B7CHjYMhTqNAN63+OgMe+FXOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=clSpKI0k; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=pOyL+MZI8eix4bUM1DUjnC6FHJaWbquQqRYATDoE3To=;
	b=clSpKI0k3/TlpM36NH0b4Izns2Yk5fHRWL3OpalagWgVNzOc1Mg3qev+potxRP
	oQpbqvq89E3YZqlYwSQX/+LpXFeEkH1QjRCyWOdOJUOSIaJVpYHX+VqU/FHGrLIw
	037LEfnbJVxQwMusqftfe9uEDpzeaux6KSFvpmULWDg7Q=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAn99H+M9RmwIlDAA--.7991S3;
	Sun, 01 Sep 2024 17:29:36 +0800 (CST)
Date: Sun, 1 Sep 2024 17:29:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dts: nxp: mxs: Fix partitions definitions and remove
 saif (imx28-lwe.dtsi)
Message-ID: <ZtQz/tKY3Mj2BDdu@dragon>
References: <20240827151042.2254651-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827151042.2254651-1-lukma@denx.de>
X-CM-TRANSID:M88vCgAn99H+M9RmwIlDAA--.7991S3
X-Coremail-Antispam: 1Uf129KBjvdXoW5Kr4fKr4UCr1UWFWxWFy5CFg_yoWxGrX_u3
	yvgrs7Cws0grn7ta9IqFZag393Cw1DGFsxWr95Jas7trsxX39I9Fs3ur13Kr1UAFWayFsF
	kFnIqa9Fyw1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0HEEUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERZNZWbUDlVTJwAAsy

On Tue, Aug 27, 2024 at 05:10:42PM +0200, Lukasz Majewski wrote:
> The SPI-NOR memory layout has evolved during time lifetime of the
> device - for example special partitions to keep track of booted devices
> for A/B booting scheme were added.
> 
> Additionally the saifX nodes are specific to other group of the imx287
> based devices, so needs to be moved to different devices description.

It seems the patch should be split into two.

> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

We idiomatically use subject prefix "ARM: dts: " for IMX/MXS DTS
changes, so I would suggest "ARM: dts: imx28-lwe: ..." here.

Shawn


