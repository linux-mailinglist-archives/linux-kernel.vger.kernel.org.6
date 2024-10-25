Return-Path: <linux-kernel+bounces-382102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90389B0962
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703671F21160
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AD184549;
	Fri, 25 Oct 2024 16:12:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592E21A4AA;
	Fri, 25 Oct 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872728; cv=none; b=to1Qxc0sHi7x85yodDi0dEudRU8fTwB4vUnOMZ88MaOTc0s1j385AOjekFRF0qGRU/d6oMKiutKSXQX5HimOMsTjRHrDIgZqd+ML3eJ48nmb09FJ6jQC8Y08BM5uzYF7e4i/3QEb6WhIOH5dBIYu4Ktske3RpsO7502tetV8TXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872728; c=relaxed/simple;
	bh=5x9aUksHXptTvLe0+WGuDdukxDof2ob3CdvqqtXeaGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hQLZOZCQ22IzYMaD0z594tD/5mmVEES8te8McvM2FetU2K3AUVSnM7fzah3Ll4GXozQsEX55NamCvEYC9YJD+kCB5Uyr0r8fFpaxMcoXbEHX1NRbZ30Z/AY2bdAvKmNaYC5zyCAAfPeRgNr0+rchCUpN/AV4qvc2v8dkiRLh34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F7FC4CEC3;
	Fri, 25 Oct 2024 16:12:08 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id C90575F870;
	Sat, 26 Oct 2024 00:12:05 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <44745f27034fa670605cd16966a39b7fe88fe5a6.1726863905.git.christophe.jaillet@wanadoo.fr>
References: <44745f27034fa670605cd16966a39b7fe88fe5a6.1726863905.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: sunxi-ng: Constify struct ccu_reset_map
Message-Id: <172987272580.802486.16073827596015670054.b4-ty@csie.org>
Date: Sat, 26 Oct 2024 00:12:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 20 Sep 2024 22:25:24 +0200, Christophe JAILLET wrote:
> 'struct ccu_reset_map' are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    1533	   2224	      0	   3757	    ead	drivers/clk/sunxi-ng/ccu-sun20i-d1-r.o
> 
> [...]

Applied to clk-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/1] clk: sunxi-ng: Constify struct ccu_reset_map
      commit: c7e09a613bbddd0eea086e475855aba3b2410148

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


