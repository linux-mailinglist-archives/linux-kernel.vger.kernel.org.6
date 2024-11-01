Return-Path: <linux-kernel+bounces-391969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4926D9B8E04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4FAB21BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1728B158DC8;
	Fri,  1 Nov 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="GBkr7Vc4"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01C1B95B;
	Fri,  1 Nov 2024 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454000; cv=none; b=ArZ5t4hgTGpUsnS+pTZsV5n8oYG6Dw0x/DxRqqmVLJt/N6ce+8qW8aqAayHneF7WvoHxcqZzrTjnwfA3EPMEShezZYRo0e9+2CpKecC6wyJA2Ss6bJbr2WclJ4GzvigpaLv5zXilUijq71v3PyZj7w5oumdGW03+DWozYvxKirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454000; c=relaxed/simple;
	bh=f6BIz+ojUJWTypTM8zGtuhsZ1lVFeNYt74FygA8sQ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5Hp2tUPRs4zPg+L9f1kgJUzfjFkRwfEkJxqChYs/8C4XdjTfRDyPFGSotVqy8ncr+oP/PaIEqXecgEmdRxEIsddKMVrE50t0fbQRmReyV801C7bboZe+aX9qG62jiG+mfD99dqyEbGcTaKkNZTlXTU3g9Pqm0/LwXnocZXlsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=GBkr7Vc4; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Z2TwBYfpElSm/MhOCL9/cehfvLVKgyMFtIi/m3/gOgU=;
	b=GBkr7Vc41c4uZsN7uGdzBSK5PTxR8rNYIUVi48x0UG1KRLZiRwH8X1LX9LrnKR
	XlGZgzpCuj12tyOrfEy45sgOK9k3ma+KzQLqkCbJwBGR0JdFqwjAk4JW+QEUvf9Q
	H8jucQXf5cBqf3stjvlMAP0xS+YLBN6K5zHFhP/XnRi/Q=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgB3lMpFnyRndp5jAQ--.13947S3;
	Fri, 01 Nov 2024 17:28:38 +0800 (CST)
Date: Fri, 1 Nov 2024 17:28:36 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 0/3] arm64: dts: imx8ulp-evk: add sound card support
Message-ID: <ZySfRAjsPSsgbhk0@dragon>
References: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
X-CM-TRANSID:Mc8vCgB3lMpFnyRndp5jAQ--.13947S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVcTmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCR6KZWckjmUy0gAAsw

On Tue, Oct 22, 2024 at 01:29:16PM +0800, Shengjiu Wang wrote:
> add bt-sco and spdif sound card support.
> 
> changes in v2:
> - remove 'status' in edma nodes
> 
> Shengjiu Wang (3):
>   arm64: dts: imx8ulp: Add audio device nodes
>   arm64: dts: imx8ulp-evk: Add bt-sco sound card support
>   arm64: dts: imx8ulp-evk: Add spdif sound card support

Applied all, thanks!


