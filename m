Return-Path: <linux-kernel+bounces-304250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FF961CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AAA1C22BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2E13D537;
	Wed, 28 Aug 2024 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nV1sagbt"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A0125BA;
	Wed, 28 Aug 2024 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814883; cv=none; b=k3zN7Ii14gfEEz2yYc2Ol466JzIW7rB5ZqRR8XmMLYzmIaZlSwHa2bfRVXVb1wiQioeIbYeWBn+j/dd1Ms91b4yGxNnyn4o61fDjfZmGfl8EQ+hRRyTWB3P43oTELyqy9LmX83UooXDsMwlCbYjV6rPwhnI3tm9BwjCENU8/oVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814883; c=relaxed/simple;
	bh=CSU9auxuLhf6sFomUIH5ASPqNAgWKlIDFlEAOr2nIYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srQIvllKtd0jF+NECxwOtBuPxGzLvfUwSySrLj7v5Tfz8wHnvQErBWSmAUPsZ/+voAA7hLkkJ8t6jT9r1mIKszKVEXKxrc7evfODceOkq8aHzZcDrlwFu7zSzn64o/I99diuy3BpLuKKiWelHWGDDmXgmTfjLxVcVL99KOfJB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nV1sagbt; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=DWhb0jkM2zlEwmTC/i7OXXZ3X6PAwFSXHLBj8sVkZRo=;
	b=nV1sagbttxgblcchakJnGQEo6ygbWaLQrPT5waylAoxxJQ7exLRH9J/5rEfWeG
	lbImF5Iq+WO3RHnVk7vAdULN8Luv4YDpzN650Z0Mjk89ciWP+8xwnbUsfGI8lRsS
	4AfFmkZmjK8WBgzgJk25CQjVXBgQEudc0gpjVlwTlYYAk=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCHbjP3lc5mJG0OAA--.21770S3;
	Wed, 28 Aug 2024 11:14:01 +0800 (CST)
Date: Wed, 28 Aug 2024 11:13:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux@ew.tq-group.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: mba8mx: Add Ethernet PHY IRQ support
Message-ID: <Zs6V9+hKTgb3eqbb@dragon>
References: <20240812130636.180483-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812130636.180483-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgCHbjP3lc5mJG0OAA--.21770S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIco7DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxRJZWbOh4I-ZwAAsG

On Mon, Aug 12, 2024 at 03:06:36PM +0200, Alexander Stein wrote:
> The interrupt pin of the PHY is connected to the GPIO expander, configure
> it accordingly.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


