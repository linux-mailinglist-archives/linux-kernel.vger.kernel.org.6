Return-Path: <linux-kernel+bounces-518661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98727A392BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC8C168303
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A71B0F09;
	Tue, 18 Feb 2025 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Vpvn7bDV"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58410E5;
	Tue, 18 Feb 2025 05:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856934; cv=none; b=mAwPT/NFseeeuaXzOKf7nWnkOgnH9S2NZ4UkbtcPOOhILqjfCJ4JZV3UwrQ5hUegPiv6wS0ufVrGu85uKDB2wvwkqS6VAoyQ0HTp+Fnr/bzegX4jZ9eecpJvqVLhNkf/SPZZVUN5z9kBgJuCOZdcfxKx+4odcApve9dnlLuaogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856934; c=relaxed/simple;
	bh=GXux+2bNHW/ofqMkyaA5cdZj5doOFYWe+KH/9bczihk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9T1ZR1aUqNrN4ipzEKZMz/gAVhPQ7J8906ZN5muJ17Z2ZrXjJKGqvdWbAMpYi8EEbQQIhxP8Ekgw3y5AfA9sr4BJIopctQbevQQjrxbts4t2FEdoC0lLXKMupie56cqzaQBesS4ttpozT7tHMAESER5lWtscwo3KGPJZKQuG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Vpvn7bDV; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=bhwcdtlEhV2tm8XYwIBp93zYZFnlA/GalM7yZ7Dl6nU=;
	b=Vpvn7bDVzGJEPcjeB2eOS2HvMEpvkz0Ni43KP6fFREs7anhS8dJHZ51zfsHNEI
	P+n1IaqylkvNly76632VKXldXSNVf0vzVSxmnAm1XHHXjXAp/MpgAoVN0pYPBTXN
	VQ/Irmbz7GNgWrubDB/PGATW+OI8xpl1c5oK6GkkxWJtQ=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCn8YsGHLRnKZ4jCQ--.17131S3;
	Tue, 18 Feb 2025 13:35:03 +0800 (CST)
Date: Tue, 18 Feb 2025 13:35:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] TQMa93xx fixes
Message-ID: <Z7QcBZSU28w3tC8f@dragon>
References: <20250107141117.984652-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141117.984652-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgCn8YsGHLRnKZ4jCQ--.17131S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsmFCUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhj3ZWe0E1YVmgACsD

On Tue, Jan 07, 2025 at 03:11:14PM +0100, Alexander Stein wrote:
> Alexander Stein (3):
>   arm64: dts: freescale: imx93-tqma9352-mba93xxca: sort pinctrl nodes
>   arm64: dts: mba93xxca: Do not assert power-down pins
>   arm64: dts: tqma9352-mba93xx[cl]a: swap ethernet aliases

Applied all, thanks!


