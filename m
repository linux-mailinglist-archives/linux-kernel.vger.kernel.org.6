Return-Path: <linux-kernel+bounces-436973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823809E8D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEE01884DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45492156E1;
	Mon,  9 Dec 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AYBY+R2Y"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCE374EA;
	Mon,  9 Dec 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732879; cv=none; b=BUOMyFZD+xKJ/NwB74nVFPRTHcJm63GN+GdA2gvsQecOF4zf/9XO6dMFLNPGHycdiY4WswOfchh/39oY6lxY3Z/zgWG/MNCsKGQMfK5ew4vd49U0e49IOU8n1AZ8PNJgdfoJrBvPoNR1YQu0m1jp5Q3Af4o1wGeJ1Fy7tHsjzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732879; c=relaxed/simple;
	bh=i6UXFMAMIY3QiR0e6G2t/WA9FEry4P3PLtzEmgPIU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQMLuceDHxH7spq9f+loyRILyEqnLCYv1Y2F9wWx0xU+saZc91BazpWbtOJkczg03jX+66EWvEmt0sPcYG7j4l+/sc1CUmZDA0J78CaGii2s5FZcRlr1TVbl7Ip6hWXN9It+Fn/wfdDVYQrKmixtHx+MpnuKFclsCJjTJAaA6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AYBY+R2Y; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Uck9vxqkblasHvKIYn8GVu5axHgPGfdiHnrPp5elho4=;
	b=AYBY+R2Y5CebWsEEabugNRT1aE9+ieboWGLmtFlDxH5T+brP7bxBHxhheEhVCx
	ciqsJR9CwFRGe4bnLHy4dYj9OOfMK9HHlfx7WJS+6U12tWiYGPT7rgRwDteZxTw7
	XneVSL7O8SZgwuTWrUfsPGaAEUMqvUZ8h0G5iBi/mUwlA=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCnDkXlqVZn58h6BA--.46377S3;
	Mon, 09 Dec 2024 16:27:18 +0800 (CST)
Date: Mon, 9 Dec 2024 16:27:16 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95: correct the address length of
 netcmix_blk_ctrl
Message-ID: <Z1ap5M0KGCcz5rfl@dragon>
References: <20241105054603.1470260-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105054603.1470260-1-wei.fang@nxp.com>
X-CM-TRANSID:Mc8vCgCnDkXlqVZn58h6BA--.46377S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-PfHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgqwZWdWlR9k4QAAsj

On Tue, Nov 05, 2024 at 01:46:02PM +0800, Wei Fang wrote:
> The netc_blk_ctrl is controlled by the imx95-blk-ctl clock driver and
> provides relevant clock configurations for NETC, SAI and MQS. Its address
> length should be 8 bytes instead of 0x1000.
> 
> Fixes: 7764fef26ea9 ("arm64: dts: imx95: Add NETCMIX block control support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Applied, thanks!


