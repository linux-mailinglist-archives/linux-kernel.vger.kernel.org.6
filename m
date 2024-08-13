Return-Path: <linux-kernel+bounces-284028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06494FC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC5E283362
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D21BC39;
	Tue, 13 Aug 2024 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="I6xgm9zi"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA1E1CA89;
	Tue, 13 Aug 2024 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519319; cv=none; b=isqjb6myb/6V/neVi/G1PO4qDFG/unhgS5wWpGEcf/3EBmpA9739laoe1aqRM2joAI4/dN5ukpPITUDS6xCHQtf99Aa/V/3vq0OSKfHc8rLGdGUnAF0rvAwlM98ruYRj49FXMFnFxyE0sVwQMninKSL6JiUBybIVepFG9eDVcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519319; c=relaxed/simple;
	bh=qa8hrCIuw/DZvzNGXRkoic1AaKOPbfAItMwf5cEK41w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m49OLGODgVl8P4wwRKFU9D9ZhJ9JehzxxxTqdU0W5TE7rVzjwkrYN1y0Xhtdi5q/h861GgbuBICwRI4wXA5QEdOvOuM8nJ9R4yvfzOcOnihEhyknqkmBmy9AzcfACmhaIWRUjXyI9G7RU/qUdGmAVHUim77gxgQpSCJLqtc5uM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=I6xgm9zi; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=VaTN/iONQn/aQCaJ3eYqrbMR3KgB3UWpWae6aU/82zc=;
	b=I6xgm9zi5IvbrWPQPSBTqd4MtKQoB417slFQ8vBF7OJpbh05yynFkUVts87S7b
	3RrXum5xqZuDgA6Jck80HCN6wEuqFgXbAeiXviS78AvVi3Th+S7b84McmQVolUTY
	r4JEazZSno+8L4hQ1fS27uMIjYvrNYo3VGidxiIuy5Dhw=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCHjyAu0bpm3JtSAg--.42013S3;
	Tue, 13 Aug 2024 11:21:20 +0800 (CST)
Date: Tue, 13 Aug 2024 11:21:18 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx93: add cache info
Message-ID: <ZrrRLoffDDsrP2Kw@dragon>
References: <20240801081111.1492688-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801081111.1492688-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:Mc8vCgCHjyAu0bpm3JtSAg--.42013S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsPfHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgo6ZWa6xHErEgABsG

On Thu, Aug 01, 2024 at 04:11:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX93 features two Cortex-A55 cores with per core L1 Instruction
> cache size 32KB, L1 data cache size 32KB, per core L2 cache 64KB, and
> unified 256KB L3 cache.
> 
> Add the cache info to remove cacheinfo warnings at boot:
> "cacheinfo: Unable to detect cache hierarchy for CPU 0"
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


