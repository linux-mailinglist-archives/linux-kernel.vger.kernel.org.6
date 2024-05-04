Return-Path: <linux-kernel+bounces-168629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB4E8BBB06
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2062827D8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F7208CE;
	Sat,  4 May 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="T9n2ecnS"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B71CFAF;
	Sat,  4 May 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823997; cv=none; b=cz3v5Hrk/l/CBkhgsPi7N9cNU+58wSFcBOnfLhNlQsFcloqM/reakPpGfwZ37MGLz18PrGyQvj4J0M3hATgjdNl3y/mjxApWgYarvRGF+A9csqPSEv9rSu/DglmRG6npCOfm3Vi0RzW88JWXIfZ4Re4c25x+VjYBZRm/zzNGjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823997; c=relaxed/simple;
	bh=DG6ZzvoZqqNektgKXFqBSa5NBmz3+6SwhK7LJtxeu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnwejpS//11rGAR98ksU2hCgOb5DDsJWgKQtMn3BUsfQtMUlrXaO7WLDyLauF2AKejKcWxPzqui00sYJJHpD/ousDxySk2Kf85jpdyziCopWb7vbPZLbfyA7OT97DqjSJQlieTWVuEAV3z3nsqxjeRhZVgUSdhecBmjzC1NMVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=T9n2ecnS; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2F9E21FC17;
	Sat,  4 May 2024 13:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1714823993;
	bh=BtyuWpktl7GPWn+81xg+0EEV0yF0Qh5Wlg6f5xNjC/Y=; h=From:To:Subject;
	b=T9n2ecnS8JZrSMJDHyRkTkQKySP7F93Esv6GxbTSbhhYgFeP2qRdnvDxREhz+DBhH
	 5DEx0bgSG1RT1nLowQeWihs9uafMjescIbHcwNrSmjf0O3wM5FbpQ+K7/h35t1dW4e
	 EQi0qRKahEJpYWFFYC5EQaPJcq1CoA4ehTFWFjV2HbFU/MbPy/ziWNIu1pYFJyHPj8
	 THJ3cKJOGW5nLF8rD583/llxk1yrmEtni3B7aZcaEIlwBsN7v3mDSb+8IJ0F1RulA9
	 fkC5vDK7bB3UbOqXZzNPVnheOM0FpYjdj/pMcDbTcyg1MgAGDlAFusScicRz1Pa0vF
	 i+1+PNhJSNtGQ==
Date: Sat, 4 May 2024 13:59:51 +0200
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
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 08/18] clk: imx: imx8mp-audiomix: remove sdma root clock
Message-ID: <20240504115951.GB3666@francesco-nb>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
 <20240504-imx-clk-v1-8-f7915489d58d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504-imx-clk-v1-8-f7915489d58d@nxp.com>

Hello Peng,

On Sat, May 04, 2024 at 08:49:01AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is an issue:
> SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2] (bit-26) to 1

Fixes tag, given that this is fixing an issue?

Francesco


