Return-Path: <linux-kernel+bounces-192508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C78D1E48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88CA7B21823
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C5A16F829;
	Tue, 28 May 2024 14:15:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBF1DFDE;
	Tue, 28 May 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905759; cv=none; b=B54nVOuaogkdj5cwxlv7Lha6uIe/0pxHmTSlqgbmgh5SgyMtwCOEs76WfWEBDLB75A5MZAih8Yb8waec24W2HBhx5JXOuO+0Qk9S8M+NvuaHwcClZYiOUB4lBu4CylQTPc6W6m52cn+y27NdT/1cjFgdtaqXLWMR4OBO/c7mKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905759; c=relaxed/simple;
	bh=P5yaoAfhAk5156sygC60MevnZaLe4ZhsL2vVAQ+dubE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fjWxDTZ55VabkLULCnS9sFD3fGRLJVh7OJMPF7/j3/SYh0Bq/iFWCGo1Pp6nJ/6GRGEV0UnYD4ShtjfwzbJVItQ95IjbmApEcIRA0URdunqv4oEtJsRiZ4/H9lyp/OiRo1p9/5hlYp0tR4Vb+XtrW36OpwSXI378X4fzqfU5O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B518C3277B;
	Tue, 28 May 2024 14:15:58 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id F2B735FA42;
	Tue, 28 May 2024 22:15:55 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: jernej.skrabec@gmail.com, samuel@sholland.org, linux@treblig.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240504204401.198913-1-linux@treblig.org>
References: <20240504204401.198913-1-linux@treblig.org>
Subject: Re: [PATCH] soc: sunxi: sram: Remove unused list 'claimed_sram'
Message-Id: <171690575596.639729.8852630034460661485.b4-ty@csie.org>
Date: Tue, 28 May 2024 22:15:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 04 May 2024 21:44:01 +0100, linux@treblig.org wrote:
> The list 'claimed_sram' seems unused, as far as I can tell it always
> has been.
> I think the 'list' member of sunxi_sram_data was intended to be
> used when it was on that list.
> Remove them.
> 
> Build tested only.
> 
> [...]

Applied to sunxi/drivers-for-6.11 in sunxi/linux.git, thanks!

[1/1] soc: sunxi: sram: Remove unused list 'claimed_sram'
      https://git.kernel.org/sunxi/linux/c/a40cf069ac61

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


