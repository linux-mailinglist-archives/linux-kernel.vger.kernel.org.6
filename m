Return-Path: <linux-kernel+bounces-375528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F09A970A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A3C1C23C27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506A441760;
	Tue, 22 Oct 2024 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CkdjjShL"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7A136E01;
	Tue, 22 Oct 2024 03:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567657; cv=none; b=VVxHuKZDErqs6Kaz+ANFEEGVix5Md22wDFJn6XPwu0mbDXi6nBpehh3Bwyh3rVcPl/5tDMqsej0hTmKDx1MOizEXvl/iwWtt0HpByDHUdP1E+gURVJTVRjxJJfjrrS2XJP4csnrdq/z8xMVX2thOCBxOerzG27a2mKeUpDthQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567657; c=relaxed/simple;
	bh=5E/MUIWR/Iyu+JIdQ/r/WMUE9ombsVBOFdb/G/DxTYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXhUMSsJf1oU01zc+FwoS/UrxeJQaoJgXOTl+g54FQw0xbnGr2eae1/jNJGesIe+ONv2P+Nl3I5fLOhEToxhW1yY4c/uGoYhIyfmGReroyvH/ivRBWvPxPyrAmRBR+tU6OGwEy0jDma0+e0Iwyd+31HFbMgpfG5Z49i7x4DUhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CkdjjShL; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=dkDU2h6uW+xJKLl9ZR9Wm9eDWO5GXIm5Do45ucbhOLg=;
	b=CkdjjShLW0crzKcz4i7Pe3NeRQcu5dh7LAZ9xHowsCuZYpCp8SSBNHr+1VTRV1
	+WR5INlGK3Y0M56zBpb6q0xlSbKBDNLKhp2s3MqVXzPKLcO72J45FpqxPP6ozMk4
	vf+I0wzHe3eLEqPNa7NVAnNTJZtq8pR0Mts/VPcA+Rnls=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnrfWCGxdnpbOUAA--.5406S3;
	Tue, 22 Oct 2024 11:27:00 +0800 (CST)
Date: Tue, 22 Oct 2024 11:26:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: WangYuli <wangyuli@uniontech.com>
Cc: robh@kernel.org, saravanak@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, horms@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	philippe.schenker@toradex.com
Subject: Re: [PATCH] arm64: dts: colibri-imx8x: Fix typo "rewritting"
Message-ID: <ZxcbggAgGx67+xsX@dragon>
References: <45F06B5D4CA9F444+20241018023340.47617-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45F06B5D4CA9F444+20241018023340.47617-1-wangyuli@uniontech.com>
X-CM-TRANSID:Mc8vCgDnrfWCGxdnpbOUAA--.5406S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVco2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxCAZWcXFXIWFAAAsr

On Fri, Oct 18, 2024 at 10:33:40AM +0800, WangYuli wrote:
> There is a spelling mistake of 'rewritting' in comments which
> should be 'rewriting'.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Applied, thanks!


