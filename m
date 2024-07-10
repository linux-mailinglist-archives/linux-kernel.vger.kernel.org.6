Return-Path: <linux-kernel+bounces-248073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B473A92D81A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5CF281404
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7DB195FD1;
	Wed, 10 Jul 2024 18:13:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154B1B809;
	Wed, 10 Jul 2024 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635208; cv=none; b=sycdgxm+x7sgAnUl/Qtr9XfTE6Z8GlLQo0i0y5A3Ydbvz92HGo7NmvHySz6h3lZl66sKoxxYD/8DmfcOmh1vRgiX3bEcyIoBF7D6389Iw7O0t40k+nyi+5cgbJ+vLHHpaYPydEnY0+EK5ntPKvk1eUcOa79w3j/4RlOryq9hy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635208; c=relaxed/simple;
	bh=r8MZ2mO5ZhB1xcOAOyl/cyqu2EEiFm1ftLjX5VNomVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XV2fIPPd/xvaAuUsgRxZY2EM/5gx6uojiRaZrsbooghOd0+LLVIPEfxfp7lcfLnJ2Bb2HmO0al4nHBuuDi/9BMvNsZzgJBSZXcn+34YxdrGZ7ZtBlLz6NroinkzZURddH4zj8LZgRbAnb5Q1jKtiYMOJfohULH2SKXIzmw3lLU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2EBC32781;
	Wed, 10 Jul 2024 18:13:28 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 7C2F05F7C0;
	Thu, 11 Jul 2024 02:13:25 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240705-sunxi-sram-const-regmap_config-v1-1-1b997cd65d0f@gmail.com>
References: <20240705-sunxi-sram-const-regmap_config-v1-1-1b997cd65d0f@gmail.com>
Subject: Re: [PATCH] soc: sunxi: sram: Constify struct regmap_config
Message-Id: <172063520550.1318605.17511364428184350182.b4-ty@csie.org>
Date: Thu, 11 Jul 2024 02:13:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 05 Jul 2024 12:52:27 +0200, Javier Carrasco wrote:
> `sunxi_sram_regmap_config` is not modified and can be declared as const
> to move its data to a read-only section.
> 
> 

Applied to sunxi/drivers-for-6.11 in sunxi/linux.git, thanks!

[1/1] soc: sunxi: sram: Constify struct regmap_config
      https://git.kernel.org/sunxi/linux/c/9bc1e34a7b0c

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


