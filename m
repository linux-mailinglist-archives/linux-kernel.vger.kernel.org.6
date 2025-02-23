Return-Path: <linux-kernel+bounces-527618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B84DA40D58
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8661719E2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CAA1FCD14;
	Sun, 23 Feb 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RCtDqBhC"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C832AF0E;
	Sun, 23 Feb 2025 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298492; cv=none; b=kEoccMryL34peuY5uO8aTwsbYMRi6Qx59AM7tacBY7zEe/fPwWedFoa2R3sbp1HUtC4MGy5jiMIqB5QaCN3+LVeiJmpwzlzrpSKbTJOQ4L0BL64bhmHUGuXpFI5M0z/gnxDAbGEFBAWr4h2D+1ft9vIFTQhY8sY0II6K9PI/w+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298492; c=relaxed/simple;
	bh=EsSDH5RDWjgl+Q0mmtZhHUdhAQy1893oIm7uW2kYDbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJKPpGV+DlSL0602aGG0WIuMgUcr5cO/zgS+866TbwS9dFfBJ09No0p9V+CsivZqAl0yZrG8oVp46rjBV/CF1njvOVMLaANyOl8fMN8exVCIYBNWy0FNTb198U/yjOlTJaaOcgH14zhQ/rN6XiXFDRt6KJL1Wwlj0Ec+zLMdtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RCtDqBhC; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=n3SRU/TDBo/tfOH6JoaPn06v8I/Q1ljpHPKh21D3Jgw=;
	b=RCtDqBhCNuIrI9hy8GZFB1a0sHFGaDzajlFD8ozBMopzGI7CR/9wG3aUu/LHLd
	0ouIQ679RbCOxLaOnRVbggWzKKP6jwSmP9r6nVDCLqs2bbJEinA5pqJ356RjVYtU
	SfvLyTPKzL+nPQ6NszY8LSkEnekdnKoWPjHBUGiKxN3zo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgB339XU2Lpn4weMCQ--.22264S3;
	Sun, 23 Feb 2025 16:14:14 +0800 (CST)
Date: Sun, 23 Feb 2025 16:14:12 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale:
 imx8mm/imx8mp-verdin-dahlia: add Microphone Jack to sound card
Message-ID: <Z7rY1DCwS3RjjS9s@dragon>
References: <20250217145744.179213-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217145744.179213-1-eichest@gmail.com>
X-CM-TRANSID:M88vCgB339XU2Lpn4weMCQ--.22264S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyrKF13GFWfWw4xtFWDArb_yoWxKFb_Wa
	n7CF1kJr1ktFsrG345Gr45Ja1I9ay8AryrWryDWFZ2v348Ja4rZ3s8KFn5WF1Uta929F47
	Zw15XFsI9rWa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0kR67UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhD8ZWe6kuHc6AABsA

On Mon, Feb 17, 2025 at 03:56:39PM +0100, Stefan Eichenberger wrote:
> This patch series adds a Microphone Jack to the simple-audio-card of the
> Verdin iMX8MM and iMX8MP Dahlia carrier board device trees to separate
> the microphone and headphone functions.
> 
> This resolves the following boot-time kernel log message, which
> indicated a conflict when the microphone and headphone functions were
> not separated:
>   debugfs: File 'Headphone Jack' in directory 'dapm' already present!
> 
> Stefan Eichenberger (2):
>   arm64: dts: freescale: imx8mp-verdin-dahlia: add Microphone Jack to
>     sound card
>   arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack to
>     sound card

Applied both, thanks!


