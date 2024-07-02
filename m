Return-Path: <linux-kernel+bounces-237866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5F6923F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A049B29A11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFCA1BA096;
	Tue,  2 Jul 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMYRdYCZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956821BA08A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927363; cv=none; b=Xh2edKZq4KTHLx85x6lznvZ6oUxswuG7X6M3sNtK2u3vhc7bw4/Sa0HFoGCcL874VdEYV6B0/Z3w88Xu496tvxnwij7jB3txg+TpHj9/bFtA96ls6A/ke0VWJtQBK3A6OFRdY5yfbuQzvgLXd7YmAGufmZ4oyT0tiPcli02JDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927363; c=relaxed/simple;
	bh=CRPpCcg8sabBXb3tgEQPqA139aSG+VS5DqRUi3V5DPQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=apbKDtHUkD3EWhVnz/iCezDh8vv+CRukhfx/PLaEZdrC61nOJPGCAdC1IYiUYtlB/B0oXQtKMYop4sRJ5SMMw1oHMt30n/s3e1KXRiSv2EUrrR8FtPg6igVgb6IzTtz6aEBurZ+S39ytgiFx8J9uywq9gN25BGiJXyrAzs7sCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMYRdYCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A07C4AF0F;
	Tue,  2 Jul 2024 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927363;
	bh=CRPpCcg8sabBXb3tgEQPqA139aSG+VS5DqRUi3V5DPQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=gMYRdYCZHMs0Q3tYzuIrXQz8myt3+q2EM1gqhA7UeUPLYmKzVIhBkoJMG2vf9ELqG
	 xUN1mhlMeRNd65l37JLUXhfacMxi1dVfWWJgJwf1grwX/HFSZ9sUVXVnb7dL9omFeQ
	 w5Luf1CLgkJ2ax9FOTk4Ni9Kcsm8drdWgoEMCvicrvQCwftrcctv6HV4Ta1O8in/Ki
	 1D3kcJnEQOp+yB5ALo2WjxFo8GJs0YpC/yueCb9BTvKLIBnR2ETA8pknQznpd3NqNp
	 0c4uDMZplwWD5axXlE6B77D50dxhIQdVBlSZG79Z6sa26kffuBqdHidOwCOeHeSDbg
	 o5fSiSQh8HUhA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20240626080911.203630-1-linmq006@gmail.com>
References: <20240626080911.203630-1-linmq006@gmail.com>
Subject: Re: [PATCH] phy: core: Fix documentation of of_phy_get
Message-Id: <171992736176.699169.3316181143323311956.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:06:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 26 Jun 2024 12:09:10 +0400, Miaoqian Lin wrote:
> of_phy_put is used for of_phy_get to release the reference count.
> 
> 

Applied, thanks!

[1/1] phy: core: Fix documentation of of_phy_get
      commit: 4c75fe2a5ec409b773ed5edb0e83e2f0a88d1138

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


