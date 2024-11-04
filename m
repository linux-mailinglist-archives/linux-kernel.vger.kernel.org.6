Return-Path: <linux-kernel+bounces-394302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436009BAD16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77864B21346
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD4192595;
	Mon,  4 Nov 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="QyaHgJGp"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA123AB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705257; cv=none; b=tXovfXGR5g9YMzFFSp9RfHidFCKULmHxp7UOhGgaqODaZkM4pf+KQX7gHeUh301MqwXbSRp7bJQm+TrI9bdrVovNdkCVs61QlvPdwba317zKkGxwD4elpWVRSLwEpymDKxZJjOdLUpPhKeHUvUKx03/Uz/HSG93svHjT4ryXTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705257; c=relaxed/simple;
	bh=GiRQ44XoYqE07fZW19TbFukpCo1Y0A4Rlx7CJg8YJac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiH8z/dYOp9KYWVmhaEyfULKuMR0dpPj2kjIutcQX7MusPmcWZjT5rnSlmB0y4OExxpS8HAidpz/YtqBXPPp54Su2eMbjKnPbP3rSWsmeGIGIquY25hDW2YlxHzsqZh5UvsCRFdbZ6nK07U4LNxrThnMCECtFuL5dJiO9gMUnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=QyaHgJGp; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=eCrYpQmHtF7S8qAhF1e10rg05ea10pvsNpYjs321mqo=;
	b=QyaHgJGpPpHLQyiIiQjRLzM7UFFWU8yPtjZfta4ZdxbGxCWvmeWHKpcNWlPew1
	aGD2uMgD6tl4nzxOS5oUqioXtN3cbDBC0ufkeyAvwkEMkckqTzXwikf2Dcxya5qQ
	XXqBtbr/31ojJj2vqgxM9bwvHcbHbE97/s6xAVPBJ4xlI=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBX3tQqdyhnhWKmAQ--.16318S3;
	Mon, 04 Nov 2024 15:26:36 +0800 (CST)
Date: Mon, 4 Nov 2024 15:26:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: alice.guo@oss.nxp.com
Cc: alexander.stein@ew.tq-group.com, wahrenst@gmx.net, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
Subject: Re: [PATCH v4] soc: imx: Add SoC device register for i.MX9
Message-ID: <Zyh3KkEQ7ZFY9870@dragon>
References: <20241031065438.3912960-1-alice.guo@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031065438.3912960-1-alice.guo@oss.nxp.com>
X-CM-TRANSID:Mc8vCgBX3tQqdyhnhWKmAQ--.16318S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUciL0UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhqNZWcoMhXQgwAAsb

On Thu, Oct 31, 2024 at 02:54:38PM +0800, alice.guo@oss.nxp.com wrote:
> From: "alice.guo" <alice.guo@nxp.com>
> 
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
> 
> Signed-off-by: alice.guo <alice.guo@nxp.com>

A side note: could you git configure your user.name properly to make
the author/SoB appear like:

  Alice Guo <alice.guo@nxp.com>

Thanks,
Shawn


