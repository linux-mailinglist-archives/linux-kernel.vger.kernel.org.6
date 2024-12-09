Return-Path: <linux-kernel+bounces-436950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8A9E8CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8BB164CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB9215170;
	Mon,  9 Dec 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jdt+PlMB"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077E481B3;
	Mon,  9 Dec 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731475; cv=none; b=LexkrUrsszp+CxQFAsc/EA+wWJbZ+9Nhyd2hWP2gOi4fiOr+dsNsmqmFkWY7n5W2wdfxfAjLzQG+DpEzconO3lJnMJTjFqq4ZrQKWeh52/m+p7nhdOipwJY8Hqg4jcShrnh8uus3NjTz6Kl0HeiHC0DR6qRG24IXFSKuvlcnBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731475; c=relaxed/simple;
	bh=IetJKfhC1Wng649lB28KvwBLb5pogvRQt/kSK5Cf0D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6MEKSh4kLvjYZD0FVRDKL0g3ZZpo0hHdAqh34Jt6Z6gcY6p52YwdTaaSgR7AK6JISRhs/YHHvMAqH3Pxyw+75u2pLFttamGWsPOHxKaQ2gyanuAMtUqT8oxQrnJLfdQMttWDbgwAYjqkrbHq5Y0LSzGKQ4UyImmpP2TALdBP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jdt+PlMB; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=wDcyAUm7weadxplw3iWC3WRLmtSv74le9OVm0hGb1gc=;
	b=jdt+PlMB9IkuE4x45jZUUVpzKIJ3Pu3iuarObGCypbL86BoY6PG7ysV7rWsNkQ
	ghvmrclznVS1oWeqINSA6aCKfaR1o5e3fFgST/KHSUgOSj4EshUORS7x5PINitX/
	qD8wqG2wNw5ipwMvq8DAlhuXoQYMesXNUAUq2u9d3uRy0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHiNsGolZnqoeMBA--.47519S3;
	Mon, 09 Dec 2024 15:53:44 +0800 (CST)
Date: Mon, 9 Dec 2024 15:53:42 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8-ss-audio: add fallback compatible
 string fsl,imx6ull-esai for esai
Message-ID: <Z1aiBrlz5qjw7LVY@dragon>
References: <20241028-esai_fix-v1-0-3c1432a5613c@nxp.com>
 <20241028-esai_fix-v1-2-3c1432a5613c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-esai_fix-v1-2-3c1432a5613c@nxp.com>
X-CM-TRANSID:Ms8vCgDHiNsGolZnqoeMBA--.47519S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVdWrDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxqwZWdWeOyxRQAAsV

On Mon, Oct 28, 2024 at 03:49:32PM -0400, Frank Li wrote:
> The ESAI of i.MX8QM is the same as i.MX6ULL. So add fsl,imx6ull-esai for
> esai.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for 6.13, thanks!


