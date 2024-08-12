Return-Path: <linux-kernel+bounces-282861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F377F94E995
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7043AB222E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BDF16C695;
	Mon, 12 Aug 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lvhF6B/N"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70B14D712;
	Mon, 12 Aug 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454535; cv=none; b=WkTzfoTDuKul8NU/m0ecOQ1CG6BvpDKdu1qU5bQtPedJxoqHS6J+XPORPFulz4OAacSfS+7y+c4U3Ae9QqFoWNZ+1/IyRSXv42dtTs9u4yuLDgdaUiPCva7l+bY9DEycVD5fwYRkc+Sob8I9L8SbGQvl3Ow4A3A3MS57xPuaCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454535; c=relaxed/simple;
	bh=zMSKNSWh/knSs3qDexWL28UU9jSfVIYFcb2OsSO9oaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUHw853dF1TeQhGDae2tpVV/j3a0H3YBUOPGJ4xfsvuokgemdxqIndax4HcGhgxn8VGQa1+FNy4J3zARIomkEe6x1czEEK1WVG0bP9/IuVYJw++T/YYZ8WbiKtPmgoh1Sf+StrLdzRfZuvLacmPw1CFq8omvD2ygMZqkYXjqmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lvhF6B/N; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5zDuPwXK1w846oyge0RbaA657hY2Vn9PqOwRQHHanCA=;
	b=lvhF6B/NzC4ryFgNgaJjTxIwFR80TCrR5jU+E9x01pWVGMzzLn9P/c5EHz0A8n
	F4mrPwrWjP/LociJVpTaQWvEQmAlc44OVUZuWlfpwl7Jq1QkIl/b6MikC2883qgO
	hHPTAqwamfKGhDS0TICB3KPgKcu3H9uzsy0W4Vj/ReA6E=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHzyAB1Llmo45JAg--.40046S3;
	Mon, 12 Aug 2024 17:21:07 +0800 (CST)
Date: Mon, 12 Aug 2024 17:21:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andrej Picej <andrej.picej@norik.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH] arm64: dts: imx8mp-phyboard-pollux: Disable
 write-protect on SD card
Message-ID: <ZrnUAb1EKZHleb3M@dragon>
References: <20240716085114.3205582-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716085114.3205582-1-andrej.picej@norik.com>
X-CM-TRANSID:Mc8vCgDHzyAB1Llmo45JAg--.40046S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQY5ZWa5zUwYPQAAso

On Tue, Jul 16, 2024 at 10:51:14AM +0200, Andrej Picej wrote:
> Micro SD cards can't be physically write-protected like full-sized
> cards. Disable this feature in device-tree to get rid of the kernel
> warning:
> 
> "host does not support reading read-only switch, assuming write-enable"
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Applied, thanks!


