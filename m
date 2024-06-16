Return-Path: <linux-kernel+bounces-216143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58C909BE4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A49283346
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9EA16D30F;
	Sun, 16 Jun 2024 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="k9iEiJnw"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C3A48
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518985; cv=none; b=N8/7+u83nCHkPYswt00TfroThFkamt9n0aokAoYE/L5PYeGTDsTJ84d6Q5x2y/QuoYAlgFNl7YcTIr24noycSm/XLkYklJEavO8AdjDycOk/CbFabMelSxGPC+GNlVea7SFhr3blYV7EcgnnGgeIa5/skr8QfhdRIpM3YkSzfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518985; c=relaxed/simple;
	bh=Mknlk//x2xNtEoqP8k9y55wgH6UtIrOZ6sg4zR/FQyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpEAETAFhevAqA8Sud/oC8fuNJOi6ukX1uVldZEfEr1eQ9iCuZQBNsN5+69lLB8XdEl1+LfgSb5IdklApC7d8RFjlZmNKYKgfk6vMNUI5uWA1dEbkoCpWnMUhGzf/00NzMjFqF+1chvVEOvv7tqXJZCRWufbvMyzUF9FrKH7AuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=k9iEiJnw; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=a31zCvY9cwbcKQGBKnLRpRlPlfGDPY5SQt+DrzR2m0Q=;
	b=k9iEiJnwKtM6yYKFZ/qYzFsDLAa/wc2/c94N4cJ+/sPJTPxsUAPxuebmrc38xf
	KULhF4qmeuXMV4M9pC7lchA3mN3354SVCMfA2oM9VoNb7QztOy9NYF1Ycg2bkzBA
	xR8OycM5dYvYhArGGknjOEsSwYZdyTCl3KFlH6hw9gqqQ=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrADnL2mghG5mpb_ACA--.10294S3;
	Sun, 16 Jun 2024 14:22:26 +0800 (CST)
Date: Sun, 16 Jun 2024 14:22:24 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: imx_v6_v7_defconfig: Enable drivers for
 TQMa7x/MBa7x
Message-ID: <Zm6EoB/v4eSTknVU@dragon>
References: <20240530143722.834264-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530143722.834264-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:C1UQrADnL2mghG5mpb_ACA--.10294S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxhihUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGAIAZV6Nn4x5FwAAsR

On Thu, May 30, 2024 at 04:37:22PM +0200, Alexander Stein wrote:
> Enable drivers for devices/features used on MBa7x.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


