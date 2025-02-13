Return-Path: <linux-kernel+bounces-513450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02869A34AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4237A3BCF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080C20550F;
	Thu, 13 Feb 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx8ZFKG3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EC26FA52;
	Thu, 13 Feb 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464210; cv=none; b=QxosQR0dQf6xFr+7T0quuFdKkqK63fRLANqzjIjBcdFuOa2zOVUqNlrHShVL7ik2TSOJZetJIN3WHUO4fqzJsjkPwusd4E35RTX+uDdyAxLnIUoS1FKSbnh3Om6KXgznuNjwdOcKWdF7lsBGx5VqboXgrVeXcwjtuXQ0VN+39Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464210; c=relaxed/simple;
	bh=Xo8DjJ7dkF4QvlEqmx7HWu1SRPK2cOD4V3F5nnSorQM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mWV6nqtyUSo2CvN+1c2qkDBS4jKOME89BbweKIPyO9PtLyCw7/O1qFwNJE7FP7rTT35buyxl82X72UZXSBZrfBhneXFsUyO7pAvnkRKswvnAAdsfszwkebdJkH35pc9YUhcKt7Vc4BUDgM+fTxIuls0xEDWTYWG3JgbOe/TzIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx8ZFKG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C05C4CEE4;
	Thu, 13 Feb 2025 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464209;
	bh=Xo8DjJ7dkF4QvlEqmx7HWu1SRPK2cOD4V3F5nnSorQM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kx8ZFKG3JO12fpbDgEZcg4pZJwugnoUKQqXHoLGZa2g5vpq8aJpBrno8DtPHD5k0D
	 BfqwW+w/St5IYOCzcSgJWyxzkIipI+U1HMs0GKmqqet2rGbns6edELrlrNeCI5b5bB
	 qIUx9X516wEWmDvBPzTcnzU3bLJAIA3C+jOsIaB3k3nEb0RWxGYIAMiWqDMu0e4mnm
	 4NI1KPcJVf9GMWjANHJJeBgWZvJFcTCNg4kj5WpT1m96RgUc4uhwmoNOCBTrVlK3UK
	 NGdlQdfoNtjWq1lijyRoecj0ni3TwWZ/wQFHeJ/VPG/sK/zX9R8YYcrhlA0nUUpSCu
	 7PWg0JwScNbMw==
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com, 
 pierre-louis.bossart@linux.dev, sanyog.r.kale@intel.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, Mario.Limonciello@amd.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250207065841.4718-1-Vijendar.Mukunda@amd.com>
References: <20250207065841.4718-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V4 0/6] soundwire: amd: code improvements and new
 platform support
Message-Id: <173946420611.270661.6294707599627839150.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 22:00:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 07 Feb 2025 12:28:35 +0530, Vijendar Mukunda wrote:
> This patch series consists of code improvements and new platform support
> for ACP7.0 & ACP7.1 platforms.
> 
> Changes since v3:
> - Remove extra white line in amd_sdw_manager_start() function.
> 
> Changes since v2:
> - Rebase the patch series after dropping the patch which adds conditional
>   check for SoundWire manager device resume when wake event is asserted.
> 
> [...]

Applied, thanks!

[1/6] soundwire: amd: change the soundwire wake enable/disable sequence
      commit: dcc48a73eae7f791b1a6856ea1bcc4079282c88d
[2/6] soundwire: amd: add debug log for soundwire wake event
      commit: 19427c08b818c65f579cbfc78062e1ff4c37c768
[3/6] soundwire: amd: add support for ACP7.0 & ACP7.1 platforms
      commit: 2c0ae8ef1e5edfd0e42727fba4617694f3aac2eb
[4/6] soundwire: amd: set device power state during suspend/resume sequence
      commit: 829c3e1cb4a3f60c5cef11963052009ea50d2941
[5/6] soundwire: amd: set ACP_PME_EN during runtime suspend sequence
      commit: 5818ed3636b3c63eddef299223c7369de86eefee
[6/6] soundwire: amd: add soundwire host wake interrupt enable/disable sequence
      commit: 3df75289ddc28b46121d51d2812943b78676497b

Best regards,
-- 
~Vinod



