Return-Path: <linux-kernel+bounces-216150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB0909BF9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A45B20C26
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C7C16EC07;
	Sun, 16 Jun 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="DT3Jk8l6"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231E1849;
	Sun, 16 Jun 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718520966; cv=none; b=KhTYB7+Dyp8rO4jyCeK6KHRfqvvykofAc8RO5xn9OALQoFF9uD4NEWv0gpFvx9Ru0NGNxhdZ7fQeFiid7wrDIRU2z0eOw8/BRVxeOgSs2pAlpOnE4OV+6QCc75M/kdjqb1tFkam/y8BIEG96FPSaKmrjJo7YwFIWl3a+Al0orb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718520966; c=relaxed/simple;
	bh=weXblZGQTXhCcgWR2tS3lV6++Dz7ruXUjcEWPz8id/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Blkvu7Qs4CFB7CVaj5lMpZ9otKS27Q0BR3nueHigfv0nNmpACkXgBUVzmdc2FQzaNdHQKPdgdT/PL+/DNKTpXPJRAk0F/F3tjQRVidNd8yywxJQz0Gyf2yiNo1faz9yjQ1xPWdg2ZRJq6HFyYheP4mA5hZiBVVmbV8OtWwGZ8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=DT3Jk8l6; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=TyImyxiwmiztTDCYgP43q/RjNR9SBQZeJHg9PIFjFpI=;
	b=DT3Jk8l6eeEGnQo8LCRh9X3zSiSOQbhsb6CK2wQ6BwWb+yfk7xwlmBpfRHPNIa
	BK0mBSN0isIcW7lEu+ClbmcIPGUZigzpH1GTN2tIhJ0+9ApIdGj5oUK34pm5PdwS
	2Ggr3ngKpVsCPOaDwyJMbEgwabCYT41BP9EgKa6KW/x8E=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrADnD1BtjG5meRfBCA--.30676S3;
	Sun, 16 Jun 2024 14:55:43 +0800 (CST)
Date: Sun, 16 Jun 2024 14:55:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: shawnguo@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: ls1012a: Reorder sai dma-names to clean
 up DTB_CHECK  warning
Message-ID: <Zm6MbW60pmIFY+rS@dragon>
References: <20240531215017.1969431-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531215017.1969431-1-Frank.Li@nxp.com>
X-CM-TRANSID:C1UQrADnD1BtjG5meRfBCA--.30676S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsiF4DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDxAAZVnxc0p68wAAsi

On Fri, May 31, 2024 at 05:50:14PM -0400, Frank Li wrote:
> Change order of sai's dma-names to clearn up below DTB_CHECK warning.
> 
>    arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: sai@2b50000: dma-names:1: 'tx' was expected
>    arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: sai@2b60000: dma-names:1: 'tx' was expected
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


