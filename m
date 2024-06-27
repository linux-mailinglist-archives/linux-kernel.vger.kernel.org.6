Return-Path: <linux-kernel+bounces-232104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06691A362
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B2A1F226B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C513C667;
	Thu, 27 Jun 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="LYzeAr9y"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9DF4D8C3;
	Thu, 27 Jun 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482599; cv=none; b=lPVKU8+G1yXSMI9Xz0SgzdVzcG7YSas8510U9ymJuvz2budBlbpWHlYP4jabA61VqMNHe0Zy7dOJjgVDR99ZdGYW5kdnUhtE6dfMCHmGf9erYevCk0iQT/tOJwj3PPTAinBloCu3JNDw74h7tOCOq83GQzFKzIWnpiXNyKSvuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482599; c=relaxed/simple;
	bh=sd/Bmg+cTQfe4mxJdiKI08z/ZTvjG8ksqd41kgQzsqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP4z7h+ah9493YkQIjzRqWyk4ftEly8Kshta9RCW+Jw67/q+0krlR9Z+b+hQEzt95+2vhbOITU6cWNwkHN+A5azTJE7aV65xzDzbWCWtexRrSrf7b+Z2cu8qeISYUPVxA3kM1GEgJI1tFw+8P+0beCGYy01W57YpHIK0ZHeSh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=LYzeAr9y; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=hhsRFv2EXZuOOhQ6fkf9E6H06LwU61sWInvDM5ISGq4=;
	b=LYzeAr9yuaR75d71phnr/Hd8NxQSJXVokySJobyKIyykoyN5ZO0EqJ1NIb9q3b
	S9A+FnEP9FgDxUAIy8jlJgzn0DpvyMz9/a3kmwVUKKuzUOFu4lp0Qh0WstMrIyg9
	CCiWKRJGyGSh4ONv+MFw9J6uhECAD3gcVijVnUQZPKB5g=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDXX_GwOH1mCz4aAA--.26752S3;
	Thu, 27 Jun 2024 18:02:26 +0800 (CST)
Date: Thu, 27 Jun 2024 18:02:24 +0800
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
Subject: Re: [PATCH v2 1/4] arm64: dts: imx95: add '#address-cells' and
 '#size-cells' for all i2c
Message-ID: <Zn04sE+HzkmSJr2C@dragon>
References: <20240620161622.3986692-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620161622.3986692-1-Frank.Li@nxp.com>
X-CM-TRANSID:M88vCgDXX_GwOH1mCz4aAA--.26752S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUV8u4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhILZWZv-c1HrgAAsu

On Thu, Jun 20, 2024 at 12:16:19PM -0400, Frank Li wrote:
> Add '#address-cells' and '#size-cells' for all I2C to avoid duplicate these
> at every board files.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


