Return-Path: <linux-kernel+bounces-215765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF0A9096CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05FC1C21EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00013199C2;
	Sat, 15 Jun 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="OpSQ8LKR"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2731863C;
	Sat, 15 Jun 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439121; cv=none; b=bWoNaWdIOJEwZlKYtpkkDs9TzmT5hRTAnxeNojHRYQqyn+5rQcLLixJEjGzKjgSdf1QlRU7L0Ua1ViwMG7XO41FS61PeEoObdMki6Np+mZudhfojp/6MYNT3ohi9KIVR22k+5gxdvku9i2QWl+W0XvL84/8+8FxkIutJ99+0+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439121; c=relaxed/simple;
	bh=z7xzY9BANm/spwJcIm0bUUa2s9EHOEM//nitveJyGBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXRi5CQqETLwg1/4CkxAx+4E5eU+wUO/fiQ6oeCVdcaxpH9NxOeG+DTOk+AJV2bheZAI0KUdGpdMUj6TNn0opaK+gPNyGD0sUYrqwXP0olKy5iXn3kTi33cfxxIGV/ZHyTJcV8yzoulV+yNrmKVeylhUa/GMLs77/onSiiZekHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=OpSQ8LKR; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Kv/0OpESA8neJmt74/g+kzxdmLs4coxB4dCFElKdJ0Q=;
	b=OpSQ8LKR6hiRNjfYsm1gXnFrH5OoTjOiXY8F1oGlqabtQjJzOT+tjV9ymn5Rix
	HZF1MVMY365nZ+DHomw/86CaDsXsXqXa+ICvsqNS9ukWiYJu1GQ7DFUR8LU+KRSb
	BjHwKA7nfjsgmuHM078Wl6p1gbIs/Awj4aaHLrlY4ptuc=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAD3_0O0TG1msRfyBw--.30197S3;
	Sat, 15 Jun 2024 16:11:34 +0800 (CST)
Date: Sat, 15 Jun 2024 16:11:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp-tqma8mpql-mba8mpxl: Remove unused
 ocram node
Message-ID: <Zm1MtOgPe5bumchX@dragon>
References: <20240516112344.200166-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516112344.200166-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:ClUQrAD3_0O0TG1msRfyBw--.30197S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUswZ2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRb+ZV6NnPtUjwAAs3

On Thu, May 16, 2024 at 01:23:43PM +0200, Alexander Stein wrote:
> This node is unused and origins from downstream kernel where it is
> used for the DSP.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


