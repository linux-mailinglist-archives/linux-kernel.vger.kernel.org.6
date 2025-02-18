Return-Path: <linux-kernel+bounces-519036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C69DA3975D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0833A66A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D99C230274;
	Tue, 18 Feb 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="BSnIe/Ug"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5A22FF40;
	Tue, 18 Feb 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871734; cv=none; b=LOZ2LcTDgTjLu39xVNBd8rNt3ZJsMW8KqeiTgvv3TZJLq4tMjIi2RDEn08ignLHL4YvMIkAG6+fAoL+AqzEs63cup+2Vv5YdyBRzE6zRpC6o7pUJbztbExGYOQSAKzNqjmnbWNbz9gTzzbjfVYp5VTu4qNUp9wxwZ+c3U5qSIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871734; c=relaxed/simple;
	bh=7lgiX0WkJ1p/qX9ivmhvKwBQNKziFEeFXGDQfXJc3x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX7MXflDRRFeM1YoqrjXe0YoggirDfusnTlIAblQauKLGKXnLKpZftZLhTDg2Fakh307DMS4IGzfTctkzl1rDFrKSC93DOhfWg1DEvusGWASRVwagGzj2TSqslU2SdTvZao43v0E9TzGYGMZDw9Xduc87VXAdYF7zBSg6JMqJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=BSnIe/Ug; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=eLj9MWLdh0oMfWDc+SInSAR4dxVskqRMPSbsgEfwJUI=;
	b=BSnIe/Ugl+bHYxYpJFgcOGidrVXpe4CZh22unGoKI2XGY7g3OqEpb8T8oVtGQg
	rTg1uNBLMPaPsqM0qNIbwBFXiH/8AVCpqwLRZquNaiFJi/Dd5rnzmU5D4G28MTaR
	dsH3yMYOACWxOylHfLWNLgHZGlz1Dt1kmFpoGhYctqGK4=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBHLe3TVbRnBRI6CQ--.18371S3;
	Tue, 18 Feb 2025 17:41:41 +0800 (CST)
Date: Tue, 18 Feb 2025 17:41:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH 0/6] Complete WM8960 power supplies for i.MX boards
Message-ID: <Z7RV0wA0WCi64pGs@dragon>
References: <20250109012718.328692-1-chancel.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109012718.328692-1-chancel.liu@nxp.com>
X-CM-TRANSID:Mc8vCgBHLe3TVbRnBRI6CQ--.18371S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaqjgUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhD3ZWe0L6um2QAAso

On Thu, Jan 09, 2025 at 10:27:12AM +0900, Chancel Liu wrote:
> Chancel Liu (6):
>   arm64: dts: imx8mp-evk: Complete WM8960 power supplies
>   arm64: dts: imx8dxl-evk: Complete WM8960 power supplies
>   arm64: dts: imx8qm-mek: Complete WM8960 power supplies
>   arm64: dts: imx8qxp-mek: Complete WM8960 power supplies
>   ARM: dts: imx6ul-14x14-evk: Complete WM8960 power supplies
>   ARM: dts: imx7d-sdb: Complete WM8960 power supplies

Applied all, thanks!


