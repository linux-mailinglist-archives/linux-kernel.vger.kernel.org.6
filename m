Return-Path: <linux-kernel+bounces-168632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E9B8BBB0C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0E7282A88
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1586D20DC4;
	Sat,  4 May 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0+jhOA9f"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1E1CA92;
	Sat,  4 May 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824529; cv=none; b=JeX4f8P/k44Yqtby/U4ueZ9bWiex6DLPOqA/mk/PfDMwf7Mmk3eaUVa6/0zRo82J6YzGQiEKlgcqJgSk9bKU7yYINNNxD16+Tydd+SoRfqvdOjyD6Z6IRUmmWEl9WLE6wOgAZSUPGN7irErr9996Z1WWxQahJd8pyJqB7Sk7Shs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824529; c=relaxed/simple;
	bh=0fbCjFhfYivYU11Wu3h38hXHo8+BtXT5qZrpETfvx4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp4+LZqk8aUpHlhO7ksUpvIXmsmBcy7QyN1BS7Ni1WTvHnELoyNP2VaFaNH9OOeFZ62Jsn1tN4lsM4sdM0hGFiIAFCfzo+qbW97xMD1BmJzAyDnQt3bueoOrPYJAEwnaXu/SYRm070vBgbazlrc3Hph0VXA88De+RAT9uSTQtUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0+jhOA9f; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 358DF1FC05;
	Sat,  4 May 2024 13:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1714823914;
	bh=Cxi2xIblwS9mptHHfMVehasWNU2Xj3zceCDJW5esh28=; h=From:To:Subject;
	b=0+jhOA9f8ALr+I2+CVVeXivn1jsPLgkjgQzNMkSP67tVBmbNWhaEDK7XMui370Tav
	 QJH/Gbab/x1vGoOa6aULtSDxQbjUoeGtjaqbmdm+r4lg4/V/83uMNNWwLQOPN97Kuo
	 FhxeB9Jg7DOA9q14ZAT9tt357TJKap9imbN/ctgawj91nGOOz3YOZXC9Ldwe54elGO
	 YZ/hkc814KoX8VFz/XcOe8a34vlfzgkXcEZ3VMuq+0Qdlmy9zhxU3bD9Lb16jq2j3m
	 7rabgG7d42kr0USzKSaw7Mg1yUe6aVLpZVACwe13D9KDW/cJR6d1W7jk5Zjze9N/1C
	 ZbVpGVPTNkkyQ==
Date: Sat, 4 May 2024 13:58:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>,
	Florin Pavelescu <florin.pavelescu@nxp.com>,
	Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH 07/18] clk: imx: pll14xx: potential integer overflow
 eliminated by casting to u64
Message-ID: <20240504115828.GA3666@francesco-nb>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
 <20240504-imx-clk-v1-7-f7915489d58d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504-imx-clk-v1-7-f7915489d58d@nxp.com>

Hello Peng,

On Sat, May 04, 2024 at 08:49:00AM +0800, Peng Fan (OSS) wrote:
> From: Florin Pavelescu <florin.pavelescu@nxp.com>
> 
> Cast to u64, so that multiplications and additions will be done
> in 64-bit arithmetic (and the results will also be 64-bit)
> and the possibility of integer overflow is eliminated.
> 
> Fix Unintentional integer overflow reported by Coverity

Fixes tag if this is a fix?

It would be interesting in general if this can be trigger in real life
and with which side effects or if we are just silencing the tool


