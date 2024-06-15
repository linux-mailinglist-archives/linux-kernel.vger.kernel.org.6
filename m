Return-Path: <linux-kernel+bounces-215747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5BE909696
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4C8B20D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E017BCA;
	Sat, 15 Jun 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZqosBIKI"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA509460;
	Sat, 15 Jun 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718437130; cv=none; b=K2RbMNZRbd/XhHGM5cQwbPyeltH3ul/WC47ttxCizCDowKX9+IM8T3iNoQuUJnRndtyhbJxCzhAx9MzJ+es9kKhhlFKU4OXABp94Hs+B2jRJ2m2ILdubLpzZ1a2Mn17GpS0OdiGoLoaybh7KhRrYqejL1HBpK5zHjYAIZe3R3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718437130; c=relaxed/simple;
	bh=VtscccgBqPZ9Al4kyY/5E64fLc7TJp+Nx04NWxp9nTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdVcFKrDL8uReUPmymCpPPlkBXHDAlsvQ2WOdoFlbvC8Kuiv7gHcXMYNywk1KWgFDU0OOSvYdwWwbamgn/N1Ontoft3JgiX/HoxmRTv7SQjhSOx8mgZqxff5bk6hHwSlDxM3QBBuDHxM7e/otueV8kO3JpC3wAcEkRS9iXsGUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZqosBIKI; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OXJBh4XRa9tXn6n19F9dZpPyn9bj5wawMCr1I33Nqxo=;
	b=ZqosBIKIsIUFOigT6BUEVs0LUvTK09H/2l3gc3hV3rN1ttp6ovncDA9CMhXCjA
	Y+wyBKdTcxXlWtsBkqkVR9svH10ZxihRDmxXOofAcZOWY7j2qLN4N1AHu0ff574A
	rYOOoD76a4Y4RjT7DkQfjWrnEfOF9O/WZxHEgPK/AVXLg=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrACHbfbvRG1m3q7xBw--.33414S3;
	Sat, 15 Jun 2024 15:38:25 +0800 (CST)
Date: Sat, 15 Jun 2024 15:38:23 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH 0/2] arm64: dts: imx8mp-evk: support bt-sco sound card
Message-ID: <Zm1E74loyi3a4CPA@dragon>
References: <1715231698-451-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715231698-451-1-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:ClUQrACHbfbvRG1m3q7xBw--.33414S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI2Q6DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRH+ZVsVCphLrwAAs3

On Thu, May 09, 2024 at 01:14:56PM +0800, Shengjiu Wang wrote:
> support bt-sco sound card
> 
> Shengjiu Wang (2):
>   arm64: dts: imx8mp: Initialize audio PLLs from audiomix subsystem
>   arm64: dts: imx8mp-evk: add bt-sco sound card support

Applied both, thanks!


