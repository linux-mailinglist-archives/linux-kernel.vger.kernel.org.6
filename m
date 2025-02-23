Return-Path: <linux-kernel+bounces-527586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFDA40CEA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B8A3B4F58
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD481C860A;
	Sun, 23 Feb 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ivsPA/lQ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47A10A3E;
	Sun, 23 Feb 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740291098; cv=none; b=nIeR1MhAL9Yt0R+6iy3lAuAShIfo6GudCWtk2MbE8meMav/6AmH/IiL7r2tVweqqi6tQuAd8zzeLnj64R1dU44hiqCfXrZHLgtqKLhghiVB+lSR/yYgoKKm+9gCBnTmaeso3YL3pF767srl4wtS2UUNMuldhL/CMHmLi0fqPf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740291098; c=relaxed/simple;
	bh=Jn9Meso2LWjBuECA8Jb9aB5l1UPTW7cHi1W2fgrXJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/XzmDOEuDoqnqiL8fjlUr6MDnYrvAQJmyc4yBi7AbeCfiIy5Ub8edEjokf70U9Ch7vIFkNCwiqrYz2H5kxpoH/tvfQ20adp1z+YzOdx2mQim9ilP3Q/ybe2pnqaGjODTBoScq4PN7INi4CnyhcaZJw1AbTqsyLOysrymtlysuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ivsPA/lQ; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=rO+gRo73pxHWZnf3Uevq5TM1eEuO1YJeFmYf2Fpyzak=;
	b=ivsPA/lQcPO96FCaMKFp2KwNIZiIoIl5AgVI/wN/oiTkk0oAQ3etIpaRpAx34C
	O9+y0SlDo8OdYTyCll6j+EwqwbCYfDlx//oo5X+n29K25rTXf4QiED5Z4wZACnZ/
	niNLTK8PP2pykN5p1Xvj5BAR8Sjkp5h7uNN7WOnUbQoFw=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCnSlrXu7pnhEaeCQ--.22694S3;
	Sun, 23 Feb 2025 14:10:33 +0800 (CST)
Date: Sun, 23 Feb 2025 14:10:31 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	s32@nxp.com, clizzi@redhat.com, aruizrui@redhat.com,
	eballetb@redhat.com
Subject: Re: [PATCH v2 1/2] arm64: dts: s32g: add the eDMA nodes
Message-ID: <Z7q711GJZWOp0j+0@dragon>
References: <20250203080919.1814455-1-larisa.grigore@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080919.1814455-1-larisa.grigore@oss.nxp.com>
X-CM-TRANSID:Mc8vCgCnSlrXu7pnhEaeCQ--.22694S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsR6wDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERj8ZWe6ksyM4wAAs8

On Mon, Feb 03, 2025 at 10:09:19AM +0200, Larisa Grigore wrote:
> Add the two eDMA nodes in the device tree in order to enable the probing
> of the S32G2/S32G3 eDMA driver.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>

Applied, thanks!


