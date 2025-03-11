Return-Path: <linux-kernel+bounces-555435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E4A5B748
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD75B1892906
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07B1EB1B9;
	Tue, 11 Mar 2025 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="FipnhvAy"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968861E0B9C;
	Tue, 11 Mar 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664218; cv=none; b=aZNoBpPrk8h0ugMblN3kwIFHDpDig7X9RUNR6o6C99rIHTYcxZC9UqLwdFkCzvVXa/qpIZJq0JkBtwLh3TV7TkIHDYFwNx40F+E4OZvHgIT5b/PFz1FUSxswVGFe5upQUfW38R+232lCqPwvPNbI7nE3MrKAvwGiriyqUE/kRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664218; c=relaxed/simple;
	bh=s4H+Y9we62fXCCnHrxBU9pSXlTEJIEszZhIBpsmMnU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbqXpGz4s/RAcKCQMQVC/lhNFRWlpE352HPA1AVaDEXsyLWbg5BGGBm1ii+y/HIukVxtiXsPxtzruOXFWvST+KWSB5IbIypp+egTfD2pzciZ+hsaTO3nRBi6tOca0f7g8lXtI1BuFb8uJwLVeNLUVymhZrbYo2SFO1rnc1MO0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=FipnhvAy; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=IOD/8eH6MReKw3gPdZRtk1Rage4HyTQ3t3nqYrwuxj4=;
	b=FipnhvAyKOlglU6eH1sX5EopfIT2wQOpNzsc5WZ/Daaq6TRRIKLz4NgrU0Zm1u
	ePyg6ojedl9PaG7h0gPt1e/qc/C6KLMfce7dtkbrmz435V/FIFwP039HJyQ+j5Qp
	n4Sa4k4rbZwW5qA6mF1OwkBmjq6CZdW3G3IfpfRpdlYZU=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnUiKzr89nKi21AA--.48775S3;
	Tue, 11 Mar 2025 11:36:21 +0800 (CST)
Date: Tue, 11 Mar 2025 11:36:19 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/3] Add Variscite i.MX6UL SoM and Concerto board
 support
Message-ID: <Z8+vs+0dKyBDMU5b@dragon>
References: <20250310-varsom6ul-concerto-dts-v4-0-6034fda6ec64@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-varsom6ul-concerto-dts-v4-0-6034fda6ec64@bootlin.com>
X-CM-TRANSID:Ms8vCgDnUiKzr89nKi21AA--.48775S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsHUqUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhANZWfPpLE8DAAAsn

On Mon, Mar 10, 2025 at 05:39:47PM +0100, Antonin Godard wrote:
> Antonin Godard (3):
>       dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and Concerto board
>       ARM: dts: imx6ul: Add Variscite VAR-SOM-MX6UL SoM support
>       ARM: dts: imx6ul: Add Variscite Concerto board support

Applied all, thanks!


