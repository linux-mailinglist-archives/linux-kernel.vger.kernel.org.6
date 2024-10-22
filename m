Return-Path: <linux-kernel+bounces-375822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DC9A9B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C6F1F22645
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA32153565;
	Tue, 22 Oct 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="SA3kOMqn"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67161509B4;
	Tue, 22 Oct 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582874; cv=none; b=tPhp8BSZ3mP4sxHBnT+S42YT7LO3uYjHPnyE68lEyNP00wRnFNVAXUEpSHLAS+YtWejGJMTXoOoCBAEzYaAVWwpHJzeznoOI4bjYvdXp9EwDyPWr4J6zpnRVAL9yS4dLKNULV0wNgQtZI9eBIFcYu7Tj5rjCAF7sFPp/j2OHlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582874; c=relaxed/simple;
	bh=JY1gQe2qU5WzF3U30yMucXyRWlD4ph5p3fQk0wzpWzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf0R/0i1Zptga1Q5aR/8R8AWjjltkzXCjoPfXq9sAnm4zML/66sg0HgOqdQKxAspL0e8ZeWthaz+H0fZEvPNyjqmL8vqUhoDtcZ2VxDVw7wWQq4IWumR9Kc8mYeEa34+oi5Lfwsg2xXOO66792uY8U3P597rdsZ2cNCteDCsh5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=SA3kOMqn; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ujdnPlLm1QpvvQSMXgl2euqF7OZl5+ZMrRT1eVvKES0=;
	b=SA3kOMqnA4rc3ZgL6I8o+qMYsmySax+YWJmCgf3Or32WVRQF5/bKCl/Mm8/lTU
	fNvDXIcRCK+1Nqje9HbGH2ohCkWakgIw3B/zozdtBFaTsEI46BuT8CA0qU4ymEHp
	OcATretRJm2+pSQSl+sXideGM9rOkSW7NauEcbNMUOGyM=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnvHjqVhdnKL2aAA--.5517S3;
	Tue, 22 Oct 2024 15:40:28 +0800 (CST)
Date: Tue, 22 Oct 2024 15:40:26 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v2 1/6] arm64: dts: imx8qxp-mek: add bluetooth audio codec
Message-ID: <ZxdW6stftIQd4WDP@dragon>
References: <20241021163437.1007507-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163437.1007507-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgDnvHjqVhdnKL2aAA--.5517S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaeHqUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBqAZWcXEdrRoQAAsw

On Mon, Oct 21, 2024 at 12:34:32PM -0400, Frank Li wrote:
> Add bluetooth audio codec.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


