Return-Path: <linux-kernel+bounces-394319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A162F9BAD57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7BB1F21149
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F5199956;
	Mon,  4 Nov 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gvGGCXOi"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CC18B491
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706031; cv=none; b=Ay7pE4cIIJ0c6g1znYf6JDC82dkfHpaerUxSZuN9XduKxvWw8uTdPHggRiLWCIHlPwKGr05qZLs6L+CH8NVhUXQX+V7zrFx4XiV4Wn6pbupgfgOr6Z1kSvKN31E9DjIo/U/LGMgGt1ynMp0XZBHzkQMBjLVTmupvp5NFTpulnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706031; c=relaxed/simple;
	bh=Ntkiw9l8fdEswuek+7PtdJmfxjlvNWhTJmMdu+rLc4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3ODmxI5ajE1E4EoCqEu5deCG5YGGVLI9Fnwsb6Zhi+xWPa4myXtwQ39DoGwl9V3gvDT3e19Tt+zI9s5pnukXJC+NA6JrfWl/1mczogDHCW5AoKwLw3trjm+Syb7lvn4iNpz+B3isUqkmSp6oj4uQrHydAuZyRdwweFG3D18khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gvGGCXOi; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=IZRpCxs1ZQTmZewSRGTv8tKfeNyI4SPc6Zju2MFK6Jg=;
	b=gvGGCXOiiOnY2rDmLIb1mGs6sM8ngd9H+Ubx8cwyBOCLGJZw7qlZOcuunFvutj
	4sonau3Vgnse4MItd3uIgjEAiNbE5MF82l2WMU4mLBUjPU5CRVmainI+IQUwOmIj
	NT8+pqAbZunxJG2GNOoxnRt0pe7iaKxfOz6SzpeSAUuRo=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCnT+o6eihndZamAQ--.16521S3;
	Mon, 04 Nov 2024 15:39:40 +0800 (CST)
Date: Mon, 4 Nov 2024 15:39:38 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: alice.guo@oss.nxp.com
Cc: alexander.stein@ew.tq-group.com, wahrenst@gmx.net, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
Subject: Re: [PATCH v4] soc: imx: Add SoC device register for i.MX9
Message-ID: <Zyh6Oi+3cPXmMjz6@dragon>
References: <20241031065438.3912960-1-alice.guo@oss.nxp.com>
 <ZydAVhFvHWCk6oNH@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZydAVhFvHWCk6oNH@dragon>
X-CM-TRANSID:Mc8vCgCnT+o6eihndZamAQ--.16521S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyrArW3tw1UGryrAryftFb_yoWfAFX_uF
	1DC34UWr1vgF4xuwn5Crn3ZFyftw1UXF98JrnFkFWfWry5Crn8JFs7X34fta1xW397tFy7
	CF1Sqr4FvwnxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn6wZ7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRCNZWcoYCtN+gABsD

On Sun, Nov 03, 2024 at 05:20:22PM +0800, Shawn Guo wrote:
> On Thu, Oct 31, 2024 at 02:54:38PM +0800, alice.guo@oss.nxp.com wrote:
> > From: "alice.guo" <alice.guo@nxp.com>
> > 
> > i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> > which are provided by the corresponding ARM trusted firmware API. This
> > patch intends to use SMC call to obtain these information and then
> > register i.MX9 SoC as a device.
> > 
> > Signed-off-by: alice.guo <alice.guo@nxp.com>
> > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> 
> Applied, thanks!

I have to drop it for now, as I just recall that we should probe SoC
driver as platform driver.  Could you rework it a bit like what Marek
has done for soc-imx8m driver?

https://patchwork.kernel.org/project/imx/patch/20240929184930.73049-1-marex@denx.de/

Shawn


