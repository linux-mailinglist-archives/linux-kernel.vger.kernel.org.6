Return-Path: <linux-kernel+bounces-212029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17460905A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12511F22C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA51836C5;
	Wed, 12 Jun 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glHI03xz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D31183099
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214720; cv=none; b=LOpSm53lOjQoUtUZcyVZqpcTp0GupfxxT64qtj4g8l+B0C61Ty9nGO+mLV38GKnyHY6Mow88qADcNpHA0FBOk8O9WYuzp29vRHRmlyPmG8/5G1ecgRIyeQRQ+coY7KD+WLJJfnoimd3vw41WN9TBXrkCXeAlwrlBuZGDv0yrpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214720; c=relaxed/simple;
	bh=UknXbz5pReCHncA13mSEjNiNpJM/nxq0DuJtMoOa5Yc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XsDS915lkrAkF7d4Hj6OtKe5uMCEWMtZOCgbwA/ruWPGnQIqLqRs9cqRLuVU/1VNXoU/GD+x1wOxBuyvr+O/J41TK74TmOCZ5Bs4rFyZj/49AuCe3s5ZdCSBRx7DgbXBD07GbJ14oq6VgMEabzsl0lR7YTKja7UXThfUQi5OSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glHI03xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FCEC4AF1C;
	Wed, 12 Jun 2024 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214719;
	bh=UknXbz5pReCHncA13mSEjNiNpJM/nxq0DuJtMoOa5Yc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=glHI03xzOFwP9V+gJYyhvizsbivcbb6US3suqe2BlD0R895PQGW/vUFy4Fngr3DFy
	 1nV+n96QfuVg71IT4xrcsrR1XCwcoxjBOVrt7ifqzAa18Wn+EtnOBgwo0sqx+gyBv8
	 AFavM61VZqI6/atCAx0NlRewiU8QgnYXIQDjNniemvnQSA9mJgYQNUfmG+iqDODiHY
	 5VZVTBRgVcNurTIvcmvK/yDHDBMaWg1fiSBijtrI5IjogO3vSlOPyK8L0xXTSd3tRi
	 iEg5PTHYOOWJcvG37A6fDa1Fcs5uF6YVHmKK3EiCaW7stbmNxIGPxmWT1j7TCDV3XA
	 zdyh3fbHyVt/A==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Sekhar Nori <nsekhar@ti.com>
In-Reply-To: <60089a71-dad2-4a87-a304-a738e3334d4a@siemens.com>
References: <60089a71-dad2-4a87-a304-a738e3334d4a@siemens.com>
Subject: Re: [PATCH] phy: ti: am654-serdes: Remove duplicate define
Message-Id: <171821471768.586907.8828903354154456302.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 23:21:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 07 Jun 2024 21:33:00 +0200, Jan Kiszka wrote:
> 


Applied, thanks!

[1/1] phy: ti: am654-serdes: Remove duplicate define
      commit: bbc63e701c73bfab9f437f9661f0cbc3860097d5

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


