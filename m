Return-Path: <linux-kernel+bounces-273906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024D946F70
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6071F215FA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B215FBBA;
	Sun,  4 Aug 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="SXne06Xh"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A3A934;
	Sun,  4 Aug 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783473; cv=none; b=q2vxgQN0XEy0GQhIEsEnS/4kgEMd6aO+qg995RrEAJbfGQlQfUS2eexnmODZYiK8l7mLImOSkjWsoSQTdG0TYF6GKpNBJ+pEFoF0knXJUitKfRaPHxE8nEfY9Ai3fjN/4VHK7mme+vFL/jkDuibzccpNYtqLDUPDV6Wvj8kjSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783473; c=relaxed/simple;
	bh=M8y+LdVMnpc5ht81uEK6XB80b5nISCXQTzcloRYe3KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLy2tkMleAAwsTGNePXX+25rUicc5KjZ5Jgymcu7E+yKJ1LkjiXGSmdqQ++MAcAEG5p10nktRpE0Qk5NrBnJYNfl6Tfn2SavJvs40xl7t7yOiHgEFWdpFm2Z1XFtHAQImt44UfesqV6UeA27HYsiWHn5f/aswYV+DCokuICnfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=SXne06Xh; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8TuAd/3CLxKF95hF35sdD2H6VbiQxElPgKmbxCAbFxg=;
	b=SXne06XhEapJ3xDBSHD91xFHGeQUD4c1LfjCT+jZNJsfWCg3+ZRCBTrSACjN2v
	FHwgF79EYX+34twApVNSr5vMUOa1NMnOakCHLaoiqPkWm7v/HZ0THRlD4nBIJUWH
	FNcj6fA4J+RtaCVAEqiUcceg8I+uyzYXyi2xVx4eyg8Kc=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDHL+3Klq9mMP2DAQ--.18575S3;
	Sun, 04 Aug 2024 22:57:16 +0800 (CST)
Date: Sun, 4 Aug 2024 22:57:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] arm64: dts: imx93: drop duplicated properties
Message-ID: <Zq+WymbduhMlsPbC@dragon>
References: <20240628020953.1108967-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628020953.1108967-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:M88vCgDHL+3Klq9mMP2DAQ--.18575S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBB8xZWavYGtqTQAAsq

On Fri, Jun 28, 2024 at 10:09:53AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> '#address-cells' and '#size-cells' are already included in soc device tree,
> no need add them in board device tree.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


