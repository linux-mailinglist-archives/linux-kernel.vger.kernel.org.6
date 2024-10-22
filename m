Return-Path: <linux-kernel+bounces-375391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF59A9562
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D14C1C23032
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24784D0D;
	Tue, 22 Oct 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="E/g9X6wz"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E4A927;
	Tue, 22 Oct 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560013; cv=none; b=ataPGadlLOm+JnxRvKxo2hTGXo7ggMWffCAqGF/SurRqQXWP8PKUMwQnGQ00Ms5apUDrqsIwLGFRgCEjRchfq3O+DDP7svmQVOhl7a+u6VsNukMD1sj7NRN7XH/QyWloYCJ60rSENuQVtaN4xG7MAK0RONg92ywgSGHecWSMT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560013; c=relaxed/simple;
	bh=5baJspTJ0J5mx7/6wivbGp1IqsNi/PO6dUDpAATa/xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5dUf509tm2HxyW6BaxqOeVsmPlx4ZBEnxYw6bYm7hL+M33h24lgXAp+nxKR2OkCDs93iu6WOlI2i4mgdv+EOpww0hCHJLv2Ts5nLXQdQh98c3xIr78DRYuKgdZ3CGKXa/e1iZ8+Dqc3XfWKs5RCcOF1vH9j2QkfjeXQsy7Wrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=E/g9X6wz; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=bOjL/jQ40KAe5D/J0GrcWh3Utm+eplr07wGvM4WXZD0=;
	b=E/g9X6wzZuOWtCp6wpKcHREPql2/hX9i9msqUG8sDQ1eboqbxh0RXJPq9tWRM5
	l/7YZIHlc8eLy9igDv8eIA1X9xUdwiXdtm56Le+lqavaovPDTQWN3X1myl1hsbUw
	0dt1gpdjjSHLxW0ZRESWwyQJXml0rQtVGFA28hf6rFVdY=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCH9fys_RZnBviUAA--.5363S3;
	Tue, 22 Oct 2024 09:19:42 +0800 (CST)
Date: Tue, 22 Oct 2024 09:19:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: imx[6qdl|7]-[apalis|colibri]: Update
 audio card names
Message-ID: <Zxb9rOJuRBZR1LTf@dragon>
References: <20241010171128.107819-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010171128.107819-1-hiagofranco@gmail.com>
X-CM-TRANSID:Ms8vCgCH9fys_RZnBviUAA--.5363S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVcTmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxWAZWcWn4mgTQABsw

On Thu, Oct 10, 2024 at 02:11:25PM -0300, Hiago De Franco wrote:
> Hiago De Franco (3):
>   ARM: dts: imx6qdl-apalis: Update audio card name
>   ARM: dts: imx6qdl-colibri: Update audio card name
>   ARM: dts: imx7-colibri: Update audio card name

Applied all, thanks!


