Return-Path: <linux-kernel+bounces-198548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C418D7A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027562810F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D786FC3;
	Mon,  3 Jun 2024 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YkomyI/n"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809D82566;
	Mon,  3 Jun 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382463; cv=none; b=N459ErR6ETYeNDp7JJSHsZTVkQmBDWeLSw7Erf+F706qakcyE0bU13oWmoR2gvHQCffwIT0AwiH31XKsEa/M40973PHnFfCZaBeUUUGraeTQ26CIR0CjatZMZCwr4RtV8+cTj7O7OTQvcsIKRj1G6Mem7ztyfCBEtCVdi/41b/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382463; c=relaxed/simple;
	bh=f/LNo8wZ1TxjZ6NHh1Ki8vmUnMpxjFitkOVr7lruCUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTdBQ+i6W0NC/KSsyZE0J3z118zWI8a/6yXcmTkQuOiSMP+ba+MgOtNDqsTMRmN4atDQfsJ4UjZThnl+uNAB9o3NyUYCAeUxWH5R9S+CjX/Ef7ONr+8MStYD6nudls/Bs0sHaGCwaVYPI9JNjPIH1J9tfwSDQxQi4aIWfMHKuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YkomyI/n; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=HQ5RWTQSwYYSKe8sFZkPkiko6uKlUYaB9AsbqDpjXYM=;
	b=YkomyI/nMAH6avSV5SU/KY8r3qJ2N0C1lM8TcoQGfdwQcOo8sB+Qvq2EoU8/I2
	A/KYvItF6btX84Wd7j5e2gHu0jzi8a+oVhk2SYSLPyZIcC6Uva7mySFRbPP19Pfs
	1l8pC0r/vDNv/feIOWip2DfqIQJQWcRHXBC2cMSLUvGfs=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrACH7xgULV1mDyXtBw--.58598S3;
	Mon, 03 Jun 2024 10:40:22 +0800 (CST)
Date: Mon, 3 Jun 2024 10:40:20 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Christian Gmeiner <cgmeiner@igalia.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8qm: Add GPU nodes
Message-ID: <Zl0tFA0vUoDBxLbN@dragon>
References: <20240503212249.3102288-1-christian.gmeiner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503212249.3102288-1-christian.gmeiner@gmail.com>
X-CM-TRANSID:C1UQrACH7xgULV1mDyXtBw--.58598S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3oGQUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDRbyZVszXjZcnQAAsN

On Fri, May 03, 2024 at 11:22:48PM +0200, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Add the DT node for the GPU core found on the i.MX8QM.
> 
> etnaviv-gpu 53100000.gpu: model: GC7000, revision: 6009
> [drm] Initialized etnaviv 1.4.0 20151214 for etnaviv on minor 0
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Applied, thanks!


