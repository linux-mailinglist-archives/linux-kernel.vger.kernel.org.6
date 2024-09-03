Return-Path: <linux-kernel+bounces-312256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE854969417
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA8C284985
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE41D61A2;
	Tue,  3 Sep 2024 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="izGazYsV"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8491D61A1;
	Tue,  3 Sep 2024 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346070; cv=none; b=dhuROJp6mvffLBDVmk/NKR+Tl/QH4qFNCRw4ljSAgspp2I9erQf8Jf7yH512H4gPRox2TUARSr4eWmtVpa8NDWru94smh3KD+JWfZFcQEQ9Ch0cy7shB6gKwL7Yhxd6uI8eBJk5oV4x7dQpewm67/+zlL4K8q+fMmLwHlHflNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346070; c=relaxed/simple;
	bh=MNpxCUNof5M5OF+r/1sAHGfjON6O/npSbVwGOoIMr/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo1kXeGcX/MeRyZIhJtOM7P1pnBCiyv1VZ+xpdxis+SpaJ2An21nfbDamldL3ykDob3C/isHkRbBmzZmdJ4GkM/a37xqkVPmpRhXNyvRqicpv6YSAkpZs7BOrW2jgce72EpMh7HzrzSaAOIWBmrTT3WFHDmIJhYB290q45x9XUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=izGazYsV; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fid2FlpZKhUlL5gBAJoutriQF8ObGTeMG+l1QLgPOnM=;
	b=izGazYsV236soT6tSbCC12ScfhAbGaxIbhthJ76jVdOPkw2WMZAmi1cMO+8tqx
	Ru55Z0kWkGnP0Ra1XKc0bqM8RZ8KP3Qon4Z6mUc6adCOOGHY9SOGniwLdMHbW3WE
	pQrD2OoWknL+s4/a1Phv+fPpYenvg4/Zf6P7wBxYK3qUY=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnTzzfsNZm+0pcAA--.50682S3;
	Tue, 03 Sep 2024 14:46:57 +0800 (CST)
Date: Tue, 3 Sep 2024 14:46:55 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: shawnguo@kernel.org, krzk+dt@kernel.org, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Message-ID: <Ztaw3xDa6yY1tWu1@dragon>
References: <20240902054456.5828-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902054456.5828-1-tarang.raval@siliconsignals.io>
X-CM-TRANSID:Ms8vCgDnTzzfsNZm+0pcAA--.50682S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIxpnUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERBPZWbWfDOlLwAAse

On Mon, Sep 02, 2024 at 11:14:55AM +0530, Tarang Raval wrote:
> Add following peripherals support for the Emtop i.MX8M Mini Baseboard
> 
>         * Wi-Fi
>         * Audio
>         * SD card
>         * RTC
>         * CAN bus
>         * USB OTG
> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>

I'm getting this:

  arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts:111.20-120.11: ERROR (phandle_references): /soc@0/bus@30800000/spba-bus@30800000/spi@30830000/can@0: Reference to non-existent node or label "pinctrl_canbus"

Shawn


