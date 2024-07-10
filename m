Return-Path: <linux-kernel+bounces-248089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A992D845
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CBC281C21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D7195FE8;
	Wed, 10 Jul 2024 18:28:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E781957E4;
	Wed, 10 Jul 2024 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636134; cv=none; b=WlR0TLzSkys/VqgFkBs5Y+3JjfcvVoIrSBGkzKgCEfQt7YKPiPfTm8sl63dYRcYdQwYmJLJRmkOwwIWSNbf/dDOVpEgeim0J1iR2JcGqo1SGUXJBHibvbyehYi7YF4+/IjUXhwWZ2bFMbauV5+YN0l/c75O/Mr+GuqLMa8Ywevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636134; c=relaxed/simple;
	bh=CsZl17CvIZim11520SPBgizecFAjkNgrT5QMMTqHJ/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FG4IiadFbRc/hLRiR+xt9rldqBDLmfrnguNJVvaDvDxGcWEGn9S4O8CWIGSaUG9qBU2c23cjZrxKH/gJtsafFpwSOgz1aP/HpwUJ5FItWrVtxRgEAwMuR8Jy0rVdMqlpM/k4R0ce03+I66iIs12f+YxKzRg6zLUWz6xw1SJeLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F267C32786;
	Wed, 10 Jul 2024 18:28:54 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 172965F7C0;
	Thu, 11 Jul 2024 02:28:52 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240705-sunxi-rsb-bus-const-regmap_bus-v1-1-129094960ce9@gmail.com>
References: <20240705-sunxi-rsb-bus-const-regmap_bus-v1-1-129094960ce9@gmail.com>
Subject: Re: [PATCH] bus: sunxi-rsb: Constify struct regmap_bus
Message-Id: <172063613207.1338781.10321511793614801122.b4-ty@csie.org>
Date: Thu, 11 Jul 2024 02:28:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 05 Jul 2024 08:05:18 +0200, Javier Carrasco wrote:
> `regmap_sunxi_rsb` is not modified and can be declared as const to
> move its data to a read-only section.
> 
> 

Applied to sunxi/drivers-for-6.11 in sunxi/linux.git, thanks!

[1/1] bus: sunxi-rsb: Constify struct regmap_bus
      https://git.kernel.org/sunxi/linux/c/e4b5a39c2fca

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


