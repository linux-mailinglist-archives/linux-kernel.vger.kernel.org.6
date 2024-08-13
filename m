Return-Path: <linux-kernel+bounces-285216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C28950AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F72813E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88F1A254F;
	Tue, 13 Aug 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaRCMPrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7621CA9F;
	Tue, 13 Aug 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567682; cv=none; b=H4IvBKXGHsCQs0xfIagWpv/VkntwvSqcPEAqG5iawjFXotudF5HwW4IxblYRDdjHej93t7Sny7qcplim5/Ai5iAibvhBNNx5SmEmbCrLiQ/wUEsNfl3/2TDn+PpwV8SrJUoGP25QpKsKNDv0mgS393gZPhvxeF/YcVLcOwHvg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567682; c=relaxed/simple;
	bh=4M4/2ndZD8ihgIUkgGf5dGl54Oh/MaPdrS3ud8ewJE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKQWF76rRT4xli7pDWXBctKo0mC5nKke6lNDtwKrvPD3EP5HhqQJBNHP5rlOErljs7c80sKuwqGX1LLDR1o6m1jXqEjlntAdPTFdi7RuefFqhQmjgaVooyYXO56SCHx5HafYXtJ4sj4vckXjjLVDR7tRe6tSk9afUdKrD5/PXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaRCMPrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02034C4AF09;
	Tue, 13 Aug 2024 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723567681;
	bh=4M4/2ndZD8ihgIUkgGf5dGl54Oh/MaPdrS3ud8ewJE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaRCMPrbX/PHYwENhUmLW7RZUUtO0z4X7FhEwfURlgtGh1sP/8MUpWlBwjbPGDzza
	 j13ST+5A6u9LGkLS5YJmqKQTv54Xy5fOXYt+YdbtncoGIXw9+rbN9brFo5rMtQam1T
	 cufyWIEzqD9i1+EqaeLixhvmpVIeGumUw0Oxju7exUQS3WNUX0pfSkbpL1lYMlHrmw
	 PS4TMpJwNGipMRNrpsl1xtPtTVTHgWBFY/CJumsBzOfwVmkV0Wc8eVwH0y/HntxrrS
	 Djf0Af78G+z7j+x+oBRop6zge+Yl/OTizCBoa8foIuZPkc/s9+xZ12guxzgJUdF4lF
	 mlca0GAV2pwnw==
Date: Tue, 13 Aug 2024 10:47:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 1/2] of: property: add of_property_for_each_u64
Message-ID: <172356767808.1192975.11867376910372288467.robh@kernel.org>
References: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
 <20240804-clk-u64-v4-1-8e55569f39a4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804-clk-u64-v4-1-8e55569f39a4@nxp.com>


On Sun, 04 Aug 2024 20:32:55 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Preparing for assigned-clock-rates-u64 support, add function
> of_property_for_each_u64 to iterate each u64 value
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/of/property.c | 23 +++++++++++++++++++++++
>  include/linux/of.h    | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


