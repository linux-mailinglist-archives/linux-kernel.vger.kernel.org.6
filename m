Return-Path: <linux-kernel+bounces-284029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8494FC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FCA2833D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6191B970;
	Tue, 13 Aug 2024 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="k4zN7Lto"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A41BC39;
	Tue, 13 Aug 2024 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519453; cv=none; b=ue5+kN+XIK8/fyJzpYd5JwwfX8nr91vDWgIzHHgOseQX5lvIj4zWSQdW+81gmPxFTsouwpmUDpSm4rGcBDR3x1Hnar6VF4LxqINRy5h5HN2Ubxaagz2idVuOKcJoGG10TOGm0nuf768rtUgYKBp03SpzyaHdrWYeSbL7dW8tc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519453; c=relaxed/simple;
	bh=7lFWEAvnvATGYUjYbE+UQZZ8avjVPPXPwLKehfmOkIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHtNjP146qpvddwhu2+Y2n48lvoHyUxjUUP7CjEx2Qgry53mOeIc2nKZjBtrd5dgtWgWVyGuCvlteXPW8lwpfKhdg+CnfsN0o7f3LzpSTt1iqvpgzxP8iB2XY1zoNLBeHRuwKvYMCGOfwg6ZXsnMnicT4j+IREEMns6ZKR9/OTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=k4zN7Lto; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=49hsTj1rKElOl0QAjIJapCTHihP1lMG/WubSN1o3tAg=;
	b=k4zN7LtosjlwGnW8fGuf+qdhJEoVEqZXPSwPJ8L/nf361HUBSLZ9w5I0X2Xz29
	D7TF0uJk/6Mwf7balQAFdBbkrWQCI+9vsCyx7O4d2sIXnk0fRfh5a1/B4ZPjPx0a
	Bb3zZGYn+CNDCqNLzx5j2WpqP/Va/mZvhKR04cIPgfYXw=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAnTye00bpmE6FSAg--.42079S3;
	Tue, 13 Aug 2024 11:23:33 +0800 (CST)
Date: Tue, 13 Aug 2024 11:23:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx95: correct L3Cache cache-sets
Message-ID: <ZrrRtKBYybQKyxk/@dragon>
References: <20240805030535.3027963-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805030535.3027963-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:Mc8vCgAnTye00bpmE6FSAg--.42079S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI5fHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEg46ZWa6xHU46AAAs+

On Mon, Aug 05, 2024 at 11:05:35AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The L3Cache size is 512KB.
> Size = Cache Line Size(64) * num sets(512) * Assoc(0x10).
> 
> Correct the number of Cache sets.
> 
> Fixes: 5e3cbb8e4256 ("arm64: dts: freescale: add i.MX95 basic dtsi")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


