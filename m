Return-Path: <linux-kernel+bounces-373973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED29A600B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3568D1F2330A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9241E32C6;
	Mon, 21 Oct 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pRYAp1aB"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F54C8EB;
	Mon, 21 Oct 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503040; cv=none; b=W/29U1IsaGx2MlEQjhkhg/5P8ipk5LAGetDBa588f+Beu2Rew0Cr658kfsEdkHe0XipPHjykjfi9LiA/QrvmMoGmE8ZpiK/aYQ9QjuVr3HcsW7UPhzkdxfhsByC4zVONHzmsTZAoELIRLh8XIJjjDrkXNEpfti60vCYIIjKNCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503040; c=relaxed/simple;
	bh=XNMRCMkK6PDEJ8+GAYVR/SX2ZAGnKDe+KC2cYYCVSAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTtyUTCUS0xvotmuxOUKIP5gE18eZjJTqTedzQrxgmnR/ZzD4MMJxu2LYxoVKLX8Ofc2jmjrOcP3IK8et8DTB3oMcH0xVVI97K3oIg4G4BMfdse+LED2RPTWi4cGQPq2SuaOtgfLG02hlBtMr7ILMbt+/3IkR64FXxp9RpGnLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pRYAp1aB; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=oPeQwjN5+Aqq+N6ZgX8E0B65rXeXBqrPsgK5gCG/RgQ=;
	b=pRYAp1aB+13bgEr/Hfoomff0biQmXjPhLbmJ6ax0d7TeH3gnpgBPeqXtZBFYwR
	XKePqdJlcE5Y0g5G0hfbRjdthjOyqSUVFl7bLq63Y0xLVRN8tS0IYvE4+uy+lmSK
	4Wt6E2CbFsZbzM+jTD+cByeWeZx0KTQT/XspaUdFE65mI=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgC3e9AcHxZnHv6EAA--.4810S3;
	Mon, 21 Oct 2024 17:30:06 +0800 (CST)
Date: Mon, 21 Oct 2024 17:30:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Conor Dooley <conor@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: drop usage of Toradex SOMs
 compatible alone
Message-ID: <ZxYfHMViwfCQEdNY@dragon>
References: <20241004160842.110079-1-francesco@dolcini.it>
 <20241004-enforcer-absently-e3a056284991@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-enforcer-absently-e3a056284991@spud>
X-CM-TRANSID:Mc8vCgC3e9AcHxZnHv6EAA--.4810S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF15Cw1Utw1rJw4UtFW7twb_yoWxZFb_uF
	ZIgryxJrZ5CF4UXa9I9rn0qr9rK3WSvr15tay3Gw1fAas5ZrW8G34kJr97Z34xGa12krsx
	AanI9r1fu343ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1uHq7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgd-ZWcWDekz3wAAs2

On Fri, Oct 04, 2024 at 05:24:11PM +0100, Conor Dooley wrote:
> On Fri, Oct 04, 2024 at 06:08:42PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > The Toradex SOMs cannot be used alone without a carrier board, so drop
> > the usage of its compatible alone.
> 
> FYI, alot of what you're removing here appears in the $som.dtsi files.
> I don't think that matters at all, since the dtsi files need to be
> included somewhere - but figured I'd point it out in case the platform
> maintainer for fsl cares.

Thanks for pointing it out, Conor!

I would say we should remove the compatible from dtsi files before
dropping it from bindings.

Shawn


