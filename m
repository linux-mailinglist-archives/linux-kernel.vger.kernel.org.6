Return-Path: <linux-kernel+bounces-369527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044F9A1E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040F528616C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1D1D9320;
	Thu, 17 Oct 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bYhcebF9"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84AC1D8A0B;
	Thu, 17 Oct 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157435; cv=none; b=lP0rhnme0CLED6HVjNwPFB1JFP2OrpMQDZi7fRz6+ePp7U1STrh3I6Iwvihsg1/bGHRloQQWm1HT4XEq2SFOj3nfq1ZHExEUU0LWD3z8J2zwJgujhWCw4rC3qen4fRD716oU5ry4BMOmA/p5UxkAgbJ7FsI6pgJrqBVnuEdudRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157435; c=relaxed/simple;
	bh=tpjG1VzlcbKlqImlMTci/wT9sMew797mn03v3At5H4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLWRDpetLz2KAcqu1eHrmT/JDWUui+fa96wg51HGXy9AkHEaN5Y5omrdQu7wCZcMcY4dm07hKH3elXerSJZPMhbi9bj8n2nsnopS7Xq7Izp60ukr2yp9yPm9yZmc/nO3bY3k+/12ZpoRxQ6z7KLQ2i0bs3OCjjwDUOfCdo7N7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bYhcebF9; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5RNGgtfTwAvQY9/y046REOp1czW+WTASXN0YNwPj/G8=;
	b=bYhcebF9oG89CR6a3vDpBFiUROxHgE6xJfKDyEniiSIwKTsuhEvXIwLWUt7uu3
	qGQBEhYO3+2KvXfOdLu/TFNtp0JbcF2Ag0zkbXdnEYxGF++j1Vm1gExV6qAbFQA8
	ULjA3Hu84i8L9o1YvIAjfyo1zHxzUeoXt96JNEbSRAc4w=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXW7D92BBndAAxAA--.1315S3;
	Thu, 17 Oct 2024 17:29:35 +0800 (CST)
Date: Thu, 17 Oct 2024 17:29:33 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/3] arm64: dts: freescale: imx8mp-verdin: Add Ivy
 carrier
Message-ID: <ZxDY/SiDSaz0HcsJ@dragon>
References: <20240924114053.127737-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924114053.127737-1-francesco@dolcini.it>
X-CM-TRANSID:Ms8vCgDXW7D92BBndAAxAA--.1315S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWftFykCr4DKw4ktFW5Jrb_yoW3ArgE9F
	WFgr10gr4DKrnxtws8KF47Xw1vkw4Fyr10q3sFgr1fXF97Za98Ja9rKryrXFnIgan8tF93
	J3WSgrZ3trWYkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0t8nUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQl7ZWcQs3R00QAAsT

On Tue, Sep 24, 2024 at 01:40:50PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add support for the Toradex Verdin iMX8MP Ivy carrier board. Ivy is a carrier
> board designed for industrial environments, supporting industrial
> I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
> inputs, relays, PCIe and more. The board also includes a TPM for security
> applications.
> 
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
> 
> João Paulo Gonçalves (3):
>   dt-bindings: arm: freescale: Add verdin imx8mp ivy board
>   arm64: dts: freescale: imx8mp-verdin: add labels to som nodes
>   arm64: dts: freescale: imx8mp-verdin: Add Ivy carrier board

Applied all, thanks!


