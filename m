Return-Path: <linux-kernel+bounces-370062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A779A26E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3644228814B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFD1DF252;
	Thu, 17 Oct 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOHvnN9g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050EE1D47AC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179342; cv=none; b=R4PX9mP1gpGyzqN32PKLKx7uNqHpW4TxbeuqaC+lS5qodyead3Z3oloG/TCtJXdopD2QEVN6tciFtLFDU8ndFPSvx7S1jIB3CnINsuidYJdYxjzzzGtQxLttH8OgWSZNXgw/jkSTIB/HkTLzWNkejFaf2TTwsGh8PPAtJRpqn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179342; c=relaxed/simple;
	bh=P1lQx9wD81DvlOvlceUyKmrKzmEfjIo6JQtVyhf4K9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mBmZrRURSD9TNp7YwFGrMmbop9ZsGiZaVWsk/eUWjug6hAZq4tzWX1GF7RciH5ccT9eGx5mCswpj32dA/fbQToK99K2yky53hMRfvIW+de/XHokYtICLk9av95eCewwNd2TbRSjb+3Lq4EBDgbFheXlyfmHhuPWkWGuljoCHx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOHvnN9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C6CC4CED6;
	Thu, 17 Oct 2024 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179341;
	bh=P1lQx9wD81DvlOvlceUyKmrKzmEfjIo6JQtVyhf4K9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bOHvnN9g8fljhOdINWlyNyGP4IZRmhKnmafva44/BXp+zznL1xVmMDoCfLADuqVil
	 YL0HYtlcgrWHTaizPUmV0Qc6BZfxj3lmBuGJa9PBpDzktUV3f3OGqAN5JTC5qKSlEs
	 OncktYtJPj3VHz4jriSezjena8f5qx51B+j+3NTKZDicX684p16QO4rVlou96solup
	 69Jeueio4FIaqLkye6lqUbr8s87WewcDfJ8fdGPU/Sjzj8TYU9xHETZxjXGM3FH8p2
	 IhnUrycAoWYIqzj+zdJW6hBhFGIC7s4Um68/J6VaE9ZM23LNDpK1wPtgSYrVy9ptLq
	 uB/JVZcCPs3Pw==
From: Vinod Koul <vkoul@kernel.org>
To: christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20241017040657.33992-1-yang.lee@linux.alibaba.com>
References: <20241017040657.33992-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] phy: stm32: Remove unneeded semicolon
Message-Id: <172917933891.288841.1409635021239519028.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:05:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 17 Oct 2024 12:06:57 +0800, Yang Li wrote:
> This patch removes an unneeded semicolon after a switch statement.
> 
> ./drivers/phy/st/phy-stm32-combophy.c:226:2-3: Unneeded semicolon
> 
> 

Applied, thanks!

[1/1] phy: stm32: Remove unneeded semicolon
      commit: e592a65584fce0852825156086cfa1d5ef4dc2b0

Best regards,
-- 
~Vinod



