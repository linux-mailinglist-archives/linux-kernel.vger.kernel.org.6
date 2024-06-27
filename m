Return-Path: <linux-kernel+bounces-231917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3717691A053
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C853CB2137E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E54D8BD;
	Thu, 27 Jun 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="V0p8vKz8"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DA1BF3A;
	Thu, 27 Jun 2024 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472927; cv=none; b=Ni3J399rv3/hSGxGk75sSfuBymQ7njWZmC6uo7LavcosDmWmdZQd83Fc8si/zv1Ex0NLcDfrlrZvJnwnTNqWGU9MQ1SgomO+RtlxptBkQDehlVdJK3j7niYFSlxRJTsDazBm2xtlxNecJy9ULstXRhuZCnCbEXaAJcBusS4lXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472927; c=relaxed/simple;
	bh=3+W6nRSgBu1lbDQxXQIfTzbqZ2v1KH75GsdTVrBjpe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juTtMLZE6mDFjs8WGl+Oafm+vUjVT6TfqBlD7+DB8L6AZUHGq6uX2T7ab5sboNyVPv2CMEAi5RPSUMZcPC6mlo5Js10H1e1Lkukkk6mTRXFfRbvCRMsS6gqsPL6D+D8wdVrBsVuPOb1qrpkwvvCWdCZQ5QkT38vX4JwoZzQPp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=V0p8vKz8; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=pPy7XUr2n5B4S8tcqEZP00MH9QygojlnIRV1D1K/quw=;
	b=V0p8vKz8CrFjh/wfLwEawAmyyc9eilmdTunOkzc6oUPs/01lxCYme3tHIX1rv6
	dlKwoNDR82zl6r60QU9X3IFn6KfhEIzCR620Rd1Q6d48Rx+wGGRl7/zr1Nb4D9Xj
	8sc0oK4tD4UqNfxIHIMTq808BClZTLQbtt6uWVj7iiW70=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp3 (Coremail) with SMTP id M88vCgC3P_HpEn1mq48ZAA--.26206S3;
	Thu, 27 Jun 2024 15:21:15 +0800 (CST)
Date: Thu, 27 Jun 2024 15:21:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: add MBa8MP-RAS314 SBC
Message-ID: <Zn0S6fOv01wNBqy7@dragon>
References: <20240617081229.195638-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617081229.195638-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgC3P_HpEn1mq48ZAA--.26206S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2HGQDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgsLZWZv-cy54QAAsH

On Mon, Jun 17, 2024 at 10:12:28AM +0200, Alexander Stein wrote:
> MBa8MP-RAS314 is an SBC based on the embedded module TQMa8MPxL.
> All relevant interfaces integrated in the CPU have been implemented on
> the MBa8MP-RAS314 for (an) industrial usage. Due to the numerous interfaces
> and the small size of this SBC the use in different applications
> is possible without the need of a [special,custom] design.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied both, thanks!


