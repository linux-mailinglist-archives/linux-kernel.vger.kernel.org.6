Return-Path: <linux-kernel+bounces-394298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4249BAD0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36592822BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F101192B91;
	Mon,  4 Nov 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="a6eLp7oC"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685023AB;
	Mon,  4 Nov 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730704715; cv=none; b=hzEiFq18LGwhEBSSdNQ0bvka9/umyGjJM9f2mWdK8349EqtcLYfAOt5Si6E7Q5XJNAAlY4pHWBaZH6eCF/0P7T2vX3Dvl5Wf4NPXYK9rQJyoNnn6bz2sR/bZQ1q66HmoScF7DLZWLZfxjcUMkNw7sm8y5SmiwFoWExHa57/MHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730704715; c=relaxed/simple;
	bh=frXb0Lok2+S7AxxRyLcA2tyzYP6Pe4kdGhMvdbZs68U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8nDL8jJFhNLqOtcKObbl5Vsx31FngFDdjxGmwMXKSB1jdvtKO/Q8NXQyWu8i8yFCTKhLZdwEToDcEng9IQkjhj6hSzxj/0XQfb6IaExDe/Op3OGQE+GLK+a28PEKbyFv0fYrNram+OmBA6YINGZjS5Y9febdj768/w9ep83XEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=a6eLp7oC; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=u0JY0l9KILWtgurR5lkp/s4CjaE73Dq2Pe4jWzYkjNc=;
	b=a6eLp7oCTvtMLCXR6x0IO4FMP8fHujOklnFcuT4b4ukhJp1m3fyVygHDpbPAJ1
	EcCK/gja+Y3oBj9oJcNInT08fPEvnT/h1qv2BxABaOohvsTvvgoVeRUnS1hP+k0s
	T2KDbPY78ReV5iwzgvHlHtNmEYVmKYvtQ8youZKYCaXgs=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHDu8ZdShnBECmAQ--.16720S3;
	Mon, 04 Nov 2024 15:17:46 +0800 (CST)
Date: Mon, 4 Nov 2024 15:17:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 0/3] ARM: dts: add Kobo Clara 2E
Message-ID: <Zyh1GKFk9fksLCQo@dragon>
References: <20241103135201.25615-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103135201.25615-1-andreas@kemnade.info>
X-CM-TRANSID:Mc8vCgDHDu8ZdShnBECmAQ--.16720S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry7AFy8uw1UZr43ZrWfAFb_yoWxArX_uw
	4kZ34UCa15CFs7Kwnxtr1q9r4rKr1jyrZ3ur1kKa4SyF93ZF98uFWkX34xu34UZan0qwnF
	vF17W34kC3Wa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8DDG5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgmNZWcocJkPOwAAsx

On Sun, Nov 03, 2024 at 02:51:58PM +0100, Andreas Kemnade wrote:
> Add a basic device tree for the Kobo Clara 2E Ebook reader.
> It is equipped with an i.MX6SLL SoC. EPDC PMIC drivers
> are not ready for mainline yet.
> 
> Changes in V4:
> - fix order of pinmux nodes
> - remove some blank lines
> 
> Changes in V3:
> - removed 30MegaOhm current sense resistor nonsense
> 
> Changes in V2:
> - improved commit message about devices without binding
> 
> Andreas Kemnade (3):
>   dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
>   ARM: dts: imx: Add devicetree for Kobo Clara 2E
>   ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E

Applied all, thanks!


