Return-Path: <linux-kernel+bounces-527042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B21A406B4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B72F7AEA16
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4702066FF;
	Sat, 22 Feb 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pG73TqlZ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55592AF04;
	Sat, 22 Feb 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740215427; cv=none; b=kpnPgm5Vmf8VUg2pXxyYTiFMBVMBZ6kbm7Lk5bpe7wVyV1nljaiymTZoSuHL5u0DBy/qu5o/pHeFSJ5o/Yxat/JqshTy0sqDNQZmN6HyCLoF2nLVqgUZSbrj8PxO1L+AIBB1rP/1hVQO9u7TAeGRawYi2X80yyD62YBDPcHQg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740215427; c=relaxed/simple;
	bh=IOzuINMkP8/jYoWkvyZGSyLnrz2QRHSYnZDmR7OufNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwOU12IUsj2VPpXIk8p8BfFtob4tVWm/bNrx7oZLIwc07R9ANBTH7IrDeqMA5GPd/HoW4JZsNbDJY2969ZzHfQ1x3YIe8hNkiwAmVdA+olV32/QxSKczoniV6o/DywWtPxWb+yL998OWb1BMvePxufMxGzttNj//UFqCKkSOa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pG73TqlZ; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=HNf3ovGngIu+2imVC6jh5NhzQqrcYgc31OJf+dXqycE=;
	b=pG73TqlZWjD/lpev2f0r2Oon0FE7bKhizo3EOL4E8vmZbeMhTHho9HhElLiGHz
	TLN93grFoPq2ishUfDPsJbanYld6c4rXGeuDbAvBg+CUIoOlYjd+6Va+djVNVZv7
	I1GzMFnot5SUWcTCEyD2MDbYhmWfhVxYSniRNJzOZcTbo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAXoo1TlLlnd1N6CQ--.21701S3;
	Sat, 22 Feb 2025 17:09:41 +0800 (CST)
Date: Sat, 22 Feb 2025 17:09:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: mba8mx: change sound card model name
Message-ID: <Z7mUU/Rgj3Gx7g9E@dragon>
References: <20250120132503.556547-1-alexander.stein@ew.tq-group.com>
 <20250120132503.556547-5-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120132503.556547-5-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgAXoo1TlLlnd1N6CQ--.21701S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWxGF13uFW8Ar1UJFW7XFb_yoW3Xrg_AF
	Wftw1DJa1DZF4fur1Fkr4agrZa9ws7WF1DGr13Ww13X3WrKa1kGF4qq342yw1j9a4jg345
	Crn3t3yq93yjkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8pHq7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRf7ZWe5dcBuMAAAs1

On Mon, Jan 20, 2025 at 02:25:02PM +0100, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> The card name for ALSA is generated from the model name string and
> is limited to 16 characters. Use a shorter name to prevent cutting the
> name.
> 
> Since nearly all starter kit mainboards for i.MX based SoM by TQ-Systems
> use the same codec with the same routing on board it is a good idea to
> use the same mode name for the sound card. This allows sharing a default
> asound.conf in BSP over all the kits.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

I may have missed some prerequisite ones, but #4 and #5 do not apply for
me.

Shawn 


