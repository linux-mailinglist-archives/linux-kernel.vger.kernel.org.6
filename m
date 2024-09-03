Return-Path: <linux-kernel+bounces-312291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707CD969492
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3A02836D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920041D6196;
	Tue,  3 Sep 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZEfVjjOR"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7D1CE6EA;
	Tue,  3 Sep 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347081; cv=none; b=flR1W9wZsq7BguxDvg28AGaTuJItGgHyR6hkFAufDgWiECbNgA43pmB3GzUUXi9BBrdR4fDkj4Xq7F1UhMzm2m7IzDjzzxx1DNgzAjRqSDfZkselZIEaxxc0CwtlyAItqzlS2FAMm4UtDh+A3ZybEmw7PArTwHxVT8I7NS2qjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347081; c=relaxed/simple;
	bh=54woJQz+5ijdRGgHZexgNM1OLDQAS3przto38Kwiygw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uer4W5s7GO3VAnQ4pd18TbTnlK7Q/rdH6oPzwmnjAIb9l8AUPjxYovU+0a5EBK50yuKDZr0YaMb0JJ9fuqQWAvcGawE13uO1XKn1aEZwXwm8YzNeKRUlCAwkhPQe+SRQ88EbA2Qc7ep/aR04CA1PTlXM5JR4UtEqBKgVu7SFwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZEfVjjOR; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=760U01fPK5vwIsNnOzgMhiCsuAQbyv3hm5HmSlaeDdQ=;
	b=ZEfVjjORGGSryolJTU8/5ucSfYQys3mY88ATn9qGC9JLAD4/eBP97zphSlF9qU
	1I4qmktm7I1S+6R9k6dwrl6qImGQHJvPpSJl7qXZANHDZjfhLLcP7Dsbkv2o4Xf8
	B4zr5CtNfwRBvk+LClFprRNhRzWxxCyolxAwtt/YAT89M=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3v0nbtNZmi3ZcAA--.51275S3;
	Tue, 03 Sep 2024 15:03:57 +0800 (CST)
Date: Tue, 3 Sep 2024 15:03:55 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: imx28-lwe: Fix partitions definitions
Message-ID: <Zta029K48fGUwV4g@dragon>
References: <20240902114652.893272-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902114652.893272-1-lukma@denx.de>
X-CM-TRANSID:Ms8vCgD3v0nbtNZmi3ZcAA--.51275S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIWE_DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQNPZWbWfDOzYwAAsX

On Mon, Sep 02, 2024 at 01:46:50PM +0200, Lukasz Majewski wrote:
> The SPI-NOR memory layout has evolved during time lifetime of the
> device - for example special partitions to keep track of booted devices
> for A/B booting scheme were added.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied all, thanks!


