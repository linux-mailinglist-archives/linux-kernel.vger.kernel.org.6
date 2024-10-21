Return-Path: <linux-kernel+bounces-373998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439549A606C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723221C21806
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC6D1E32D4;
	Mon, 21 Oct 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZWAykMsO"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886F946C;
	Mon, 21 Oct 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503794; cv=none; b=G59br9PpmMUy5c0z0k84as5+gFizdXuAYInpH7Cn8L+uUnU/mtPeRoXq7cEkq/GeUHtkg4owUkG/VSoYrKntR76iPDuqDDf3KGpTPPFEq1Obxn8vGysgiQQ5BbrtZXehytnbYgHF8mbxtfSBfedcOibjkxzp8i1cB0NPiyXjL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503794; c=relaxed/simple;
	bh=OL44tXeoxalIZKSmbvd+NvtT+kQ8M6pJ8t8GR13R0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRhQIdGFITiieKeEQEYD76vdXhjshhj4h5+oN108poiFJ1CX94XbcO5KCIcC1ht0GUf2ljMsumTI+4SbDyq138mKjqJmdnFBP2h0DEtv2UmMMF4J/ehY/6QRyeTbx8Rvjl7wG67lAy+5qBO1tk7v1YP87n5zIFsxAGH63HBUx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZWAykMsO; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=YkZ4qiiMuubjDD/b8aOn38w6UrzOXZrqBqxzSQrF+Dk=;
	b=ZWAykMsOQ1ljAeLPFa6AMNUqHm4addGoow458FJRQAMYUV87+3GQ39jxuXDiTa
	zd0LsHDf1UZAQfL85pxNKZVBZvFXA50uDqm7s9emYptozxJ7hfWBcFLiTjMHqas0
	14wKJokvmomA5efRh37o+L+kFWolzEU+do7lqxgcJQjeA=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBHr9ULIhZnXh+EAA--.4753S3;
	Mon, 21 Oct 2024 17:42:36 +0800 (CST)
Date: Mon, 21 Oct 2024 17:42:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH] arm64: dts: imx8mp: add cpuidle state "cpu-pd-wait"
Message-ID: <ZxYiCv6SpLq9uh08@dragon>
References: <20241007134424.859467-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007134424.859467-1-catalin.popescu@leica-geosystems.com>
X-CM-TRANSID:M88vCgBHr9ULIhZnXh+EAA--.4753S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4IJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAl-ZWcV6t2pkwAAso

On Mon, Oct 07, 2024 at 03:44:24PM +0200, Catalin Popescu wrote:
> So far, only WFI is supported on i.MX8mp platform. Add support for
> deeper cpuidle state "cpu-pd-wait" that would allow for better power
> usage during runtime. This is a port from NXP downstream kernel.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Applied, thanks!


