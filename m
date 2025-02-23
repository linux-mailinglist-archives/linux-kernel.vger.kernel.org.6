Return-Path: <linux-kernel+bounces-527621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D664A40D5E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FD03BE0F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87D1FCCE0;
	Sun, 23 Feb 2025 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jnFE7BXY"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45011C84C2;
	Sun, 23 Feb 2025 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298681; cv=none; b=OUqZDe7VnF2h2v+4Y4t/nh2w0yKYxnPT6uYPmPyhbrIX7ZFU17jE5BxYQgnUywtAspsoNwYk6CaK61d4vsyxA0LNalHycAZW0+mjnqOTaLMYEwIWO7Wk7ADG/ZRhMjnPRKl27bJ8VtoucDjp8UX05IhQ1ZFkv4PTQbhv3HHeHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298681; c=relaxed/simple;
	bh=JnJaxXszhEapJdtvEBPiLgNWovhW80GOTeW5EX3OIu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l382nN9uH8/tl3kx+wgLSZy3ucuMswGDNlghRwfcC3tNwalvvtufiK6M6NNutrB/Fzhqd+7AVMr6U8XqNc8fgvEOFvuzsmnX3HdVaGNGLxGKfGWm4XJzNC7ERQD/3cQN8ZdTSsLO2PoVGUf6jczlFPfrrI6pbEjb6QRr8OzyVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jnFE7BXY; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=CAIATOjAFIlfdECkmuMV7fShBSNKlp8OzqEdVUlOvEk=;
	b=jnFE7BXYztlYs6iPiIaO4A08FKdJVr3Ra2nY7ZcQtPdFJ9u+1YhyPNmMPf8t+W
	xmM/xFOKCsPRnu7viACG8RlzaPfov26+LXlTnt3gwP2iODm1C2vwsZqHNB7ojkEI
	PXAclUfi3w0dKoM2T7DwxDtOJhREunkvZnpJHKtzoyP6E=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAnso2N2bpnXhGMCQ--.21668S3;
	Sun, 23 Feb 2025 16:17:19 +0800 (CST)
Date: Sun, 23 Feb 2025 16:17:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andrej Picej <andrej.picej@norik.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3 00/15] Update PHYTEC's i.MX8MM DTSs
Message-ID: <Z7rZjdXwN2W+Y2Bd@dragon>
References: <20250218074156.807214-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218074156.807214-1-andrej.picej@norik.com>
X-CM-TRANSID:M88vCgAnso2N2bpnXhGMCQ--.21668S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrZrWUuF1xGF18ur15KFWrAFb_yoW8Jr1DpF
	W7X347KrWDtr48uF1DXanrtay5G34UGF13uFy5ArWvv34qyFy3AF45Kry5Wr4UGr129FZY
	yF47GFyDCa4rXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzc_fUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERX8ZWe6kszsgQAAsz

On Tue, Feb 18, 2025 at 08:41:41AM +0100, Andrej Picej wrote:
> Andrej Picej (3):
>   arm64: dts: imx8mm-phycore-som: Fix bluetooth wakeup source
>   arm64: dts: imx8mm-phyboard-polis: Set RTC as wakeup-source
>   arm64: dts: imx8mm-phygate-tauri-l: Set RTC as wakeup-source
> 
> Dominik Haller (1):
>   arm64: dts: imx8mm-phycore-som: Add overlay for rproc
> 
> Janine Hagemann (1):
>   arm64: dts: imx8mm-phyboard-polis: Add overlay for PEB-EVAL-01
> 
> Teresa Remmet (5):
>   arm64: dts: imx8mm-phycore-som: Keep LDO3 on in suspend
>   arm64: dts: imx8mm-phycore-som: Remove magic-packet property
>   arm64: dts: imx8mm-phyboard-polis: Add support for PEB-AV-10
>   arm64: dts: imx8mm-phycore-som: Add no-eth phy overlay
>   arm64: dts: imx8mm-phycore-som: Add overlay to disable SPI NOR flash
> 
> Yannic Moog (3):
>   arm64: dts: imx8mm-phycore-som: add descriptions to nodes
>   arm64: dts: imx8mm-phyboard-polis: add RTC description
>   arm64: dts: imx8mm: move bulk of rtc properties to carrierboards
> 
> Yashwanth Varakala (2):
>   arm64: dts: imx8mm-phycore-som: Assign regulator for dsi to lvds
>     bridge
>   arm64: dts: imx8mm-phyboard-polis: Assign missing regulator for
>     bluetooth

Applied all, thanks!


