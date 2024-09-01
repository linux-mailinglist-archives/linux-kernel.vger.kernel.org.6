Return-Path: <linux-kernel+bounces-310143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9446967578
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFBF282933
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555761448DC;
	Sun,  1 Sep 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NvXgLli6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67391442F6;
	Sun,  1 Sep 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725176376; cv=none; b=uo25hafjtS0gyR8+h702E4flWbUSdCO4OLjCJvfPLbr9b4WyLUoMn/ymrlkYhho2PoZhFrseaQOLiq4CaXGS9xg2kTCR1/vhQkm4nJSnkzWMH0ShPG8NGN9OwM9E5GFNZL17dGMJjNmf2K6YsjmFFRk1IhDWa+aSYHiwT8dxLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725176376; c=relaxed/simple;
	bh=gMVfahwDd8Bg+Um22R0oyOMnqP9JF6rpt1c3+R0yPsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8SOFbkiIx0t80uHRCrAQn48CAjsrmLkElXp8GjAw2vWGKvy8hLzwLxzbKLBQ5REUcKKOAZBwsRASgSFkr4IM+pbI+fG317SvUvO0JCyuFxX3b6sWT0lJi1AtyFGK0JYj5GRURPzOEsUL03gs2XZ0SGzjYUzed1yalDN/7yVSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NvXgLli6; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nkkAvqscjV3VwDh+ot+genWNqMJPdPuo/uhphejIV/s=;
	b=NvXgLli6WLZPoDQ0XyEKC0aYGmLi5vKPbv810e9CQOKyPf8ZsCORYmIkYEPbUY
	8N87NWGO7meYMWjaaEeHToUwgLswt5FNE6NxucUp/NJ+QYwZOggLj77PxoLGWilM
	yEzEF08+NmrlksQI1awmve6oeeBdUW8smfNt3NoeO1L9w=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDH7SYQGtRmwxNDAA--.6687S3;
	Sun, 01 Sep 2024 15:38:58 +0800 (CST)
Date: Sun, 1 Sep 2024 15:38:56 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v2] arm64: dts: imx8mp-evk: Add native HDMI output
Message-ID: <ZtQaEFhedn3X7Cpp@dragon>
References: <20240823021257.1067054-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823021257.1067054-1-victor.liu@nxp.com>
X-CM-TRANSID:Mc8vCgDH7SYQGtRmwxNDAA--.6687S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4GQ6DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBB9NZWbUC2If0QAAsm

On Fri, Aug 23, 2024 at 10:12:57AM +0800, Liu Ying wrote:
> J17 on i.MX8mp EVK base board is a HDMI type A connector.
> It connects with i.MX8mp HDMI PHY.  Add support for it.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!


