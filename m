Return-Path: <linux-kernel+bounces-393754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A559BA4B3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1F7281FAF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434911632FA;
	Sun,  3 Nov 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Xd3pJv91"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A354430;
	Sun,  3 Nov 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730624230; cv=none; b=eLNs1fsKD6v3s9KNJEcjq4DQ06mJifvaaxU2wHHRaBhPjLe76FdjMKRoHYybzlqV00eMiC8FlIdXjDzdTOmFCcNwlK/sGW4Gj/nsfrXok5IDS+oRo0Nnu5rTVSZExFGWV/4w1tY6VugypLDayXGPV//CIROqQRIp1j1EK06TU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730624230; c=relaxed/simple;
	bh=kf2YSqFIkSaE2uUJ+UB5rQmrH03K2t4Fm2WbuEiZ+gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6GaV8FIA6yZVIvoEnyF7EI1JBzPeaSYViJPZIrGRaEREXQuAYfWbAf870w/um88W7QFFNlMHYp9ujh+Y8cSkrkkYmqfZip6ubi9/Lwd9yVfDYbKMSf9MJeKOy9rg+W0wQfKqr6nAGOpqaLvnWqh45cSXjnn3XB/V4tORsnSVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Xd3pJv91; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8JTO3pXa6iKx5Hb/VSB98fJK/UCMUDuzcS6whwJ9WpM=;
	b=Xd3pJv91sb3iFpnuMZ4Z6yxTWRvSdC9/iFW/Rcrd8JrLd+4lqUsG5Qv+CX/4DY
	2TF1HEuRrc+ezfjKgo7E6ci2apbiIuhkM3ygZ5ig4RWiToeo7WvxvJevHcNYWsyF
	BoBy+GYRJdFNhKiau1xMYZKXGBzbCF/Tsux2HGxJKhQiQ=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBHo5K4Oidn1XaRAQ--.16068S3;
	Sun, 03 Nov 2024 16:56:26 +0800 (CST)
Date: Sun, 3 Nov 2024 16:56:24 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] arm64: dts: imx8mm/imx8mp-verdin: add
 single-master property to all i2c nodes
Message-ID: <Zyc6uEcPys1On65L@dragon>
References: <20241025095915.22313-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025095915.22313-1-eichest@gmail.com>
X-CM-TRANSID:Mc8vCgBHo5K4Oidn1XaRAQ--.16068S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1UJr4kXFW7tr45Jry8uFg_yoWxuFXEk3
	ZrKF1Ik3yYgFWrKw4Ut3ZrZr909rW8Wwnag342qFWSvr93Aan3CF9Yqryfu3WxXa1xJFsF
	kryxZ34SyFWUCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn6nmtUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERiMZWcm9u9uJQAAsz

On Fri, Oct 25, 2024 at 11:58:01AM +0200, Stefan Eichenberger wrote:
> Add the single-master property to all i2c nodes on the iMX8MM and iMX8MP
> Verdin modules. This will allow us to use some single-master
> optimisations on the i2c driver. Together with the following series, now
> in the i2c-host branch of Andis tree, we get rid of a timeout problem on
> the i2c bus with a SMBus ADC:
> https://lore.kernel.org/all/7ts577rxed4mmfkfin7kfdjfjkb6iak2y4vtgtz6merwxkzz6w@h5aefbvyx44u/
> 
> Stefan Eichenberger (2):
>   arm64: dts: imx8mm-verdin: add single-master property to all i2c nodes
>   arm64: dts: imx8mp-verdin: add single-master property to all i2c nodes

Applied both, thanks!


