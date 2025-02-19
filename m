Return-Path: <linux-kernel+bounces-521270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C758FA3BAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2376162E11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59C1C68A6;
	Wed, 19 Feb 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CCsAnE4o"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B781C8617
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958404; cv=none; b=Av2yqcaVXzW5YAKlhH0x3V8zG3kJ61/Ea+OQl662sIPp4l4fQN7HmJlF5ZKTpTkiDrktc0ti/Ipa9t5yReLpu2c7g5nOwWuN7RxHqyzstBrtysaDnR9b6X/eMeb8Ew8y8m3nJMRkZQZyrx8tQKyIOV/YTPweMDeNnn9CYHUC2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958404; c=relaxed/simple;
	bh=nqcf569tnHBYYnblboGbp3DFWVxOzvikyDaKLTRVL84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYgp3HvExQ4GNY8+g9MceDudEDNjZh13NEcV0t+QYfHQG80zctAJ0PYMUrJxTSQwBwD6wyiUrC65RenywaZ+T3iK/yak/cmatSUiX+V5sqFJGLCvZOSiZMCJFFlIwrvgAG0L9O9RG4ruj2qm5L2DrmMdq725ob9cSTWX7n5Mr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CCsAnE4o; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JTw76i4BbtQyQih5Zo0i9+iSWSO7S3QZcD6OOv8jjac=;
	b=CCsAnE4oKb7Sp6POYvhvLDSp2ItTrN1MPTzYHaSuV4u89vhRSxu/w1L3VmrzYK
	NAIQbSFZ0fGBL+Gv+A6Og301Ph35ZVPKfbggrbhn/E/t1keW1Lg90qTkqNgKPz3D
	O6DCodh+JvbscRvJJoN+yEQTSEGjSXoTYLDqxKzyowD2s=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgA3e85RqLVnYuNOCQ--.19638S3;
	Wed, 19 Feb 2025 17:45:55 +0800 (CST)
Date: Wed, 19 Feb 2025 17:45:53 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: match mxc in file names by IMX / MXC entry
Message-ID: <Z7WoUSBvNZLAEm0K@dragon>
References: <20250113-b4-mxc-imx-maintainers-v1-1-7605d3d8e35f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-b4-mxc-imx-maintainers-v1-1-7605d3d8e35f@pengutronix.de>
X-CM-TRANSID:Mc8vCgA3e85RqLVnYuNOCQ--.19638S3
X-Coremail-Antispam: 1Uf129KBjvdXoW5tw43WryfKrWDZryDZryrWFg_yoWxWrc_uF
	Wqq3s3GrZrK3W7JFs3tr1jvryaka1UArn2qryYgwsIgayfZrZYyFyv9r1DJa40grnI939r
	uFZ0qwn3try7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUppB3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCR-4ZWe1nVcu1AAAsp

On Mon, Jan 13, 2025 at 11:13:01PM +0100, Ahmad Fatoum wrote:
> There is a number of i.MX-related drivers that have mxc in their name,
> but are not matched by the i.MX MAINTAINERS entry, most notably the GPIO
> driver, which is still being used on current SoCs.
> 
> Looking at current files containing mxc in their name, all of them are
> related to i.MX, except for:
> 
>   drivers/iio/accel/mxc4005.c
>   drivers/iio/accel/mxc6255.c
>   tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
> 
> Therefore adapt the regex to match all mxc files, except those above.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Applied, thanks!


