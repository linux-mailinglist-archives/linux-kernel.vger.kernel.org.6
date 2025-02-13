Return-Path: <linux-kernel+bounces-513682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD1A34D63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F673ABCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FC245B0B;
	Thu, 13 Feb 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNm6iLA/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B6245AFB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470630; cv=none; b=HQBD4oetqt3aZb5MFWSQv5h/7cGnjUsNSl4YFKhnqKvjCVnjOg4Bx4RpKmE5CFCeFtNKOtJce0xK7dk3bWD1RiHwATFiopfJRyJcazoY1N0tAHR5LdTf4nrBYecTD2Ap1RIHUQBcabmReYC3I3ueYaIUsIh01V+H5Xhb/y2+7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470630; c=relaxed/simple;
	bh=jqUXucE5Y4nnB+VCTZkmpXrxMC8l+mi2tGy84H4NNcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lV291eGc7ppHzOAckaYh5LmhIDsFAgFdd5ZEp44FPGK4AUeSIw0Gtz0L4vf64nDnr5cdjL3fbNOQZNsQkHYOlHl3Tr1pXkMe6pbaj52L5W+GQnnQqRUGsGlYLc1b6jd1KkyaLCziSDIMKgcW4XUkReN2ZGxmv28qmvwJxXSJ94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNm6iLA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C31C4CEE4;
	Thu, 13 Feb 2025 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470630;
	bh=jqUXucE5Y4nnB+VCTZkmpXrxMC8l+mi2tGy84H4NNcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NNm6iLA/2zFOZ5gGKKqqyEklXzhKkN6DF7zk9/SE0CPtzhKVxtg7H6b5iDX1uul80
	 +fjTtwk3SAHwZf6kXRtTo0+46PRebIOlPubE681TCKxKWypKRoN4H0G/s3mW2EQm8N
	 UaAPnKrsP9F+4gUQ3t+AqeNKzVpmTjOKVr4h/+oqwKeeF9bLKF/5m0eXMBXf586emD
	 AbjNWbxyRcUkSASnjgSMe/FY1sLGdb//Pt44OoS3oTZHFn/Va5+zCSVWeZkJA5teaS
	 wkdGyLyosLv2TOMSN1hViIeZyGI2Z9ZidAuk1LJWhbl0R1z5zNU5hXZQwbvgs3iji6
	 3PiAIHk+cSvKg==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, heiko@sntech.de, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: dmitry.baryshkov@linaro.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250205105157.580060-1-damon.ding@rock-chips.com>
References: <20250205105157.580060-1-damon.ding@rock-chips.com>
Subject: Re: [PATCH v7 0/4] Add eDP mode support for Rockchip Samsung HDPTX
 PHY
Message-Id: <173947062734.294083.3270476483137876424.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 23:47:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Feb 2025 18:51:53 +0800, Damon Ding wrote:
> Picked from:
> https://patchwork.kernel.org/project/linux-rockchip/list/?series=927102
> 
> Damon Ding (4):
>   phy: phy-rockchip-samsung-hdptx: Swap the definitions of LCPLL_REF and
>     ROPLL_REF
>   phy: phy-rockchip-samsung-hdptx: Supplement some register names with
>     their full version
>   phy: phy-rockchip-samsung-hdptx: Add the '_MASK' suffix to all
>     registers
>   phy: phy-rockchip-samsung-hdptx: Add eDP mode support for RK3588
> 
> [...]

Applied, thanks!

[1/4] phy: phy-rockchip-samsung-hdptx: Swap the definitions of LCPLL_REF and ROPLL_REF
      commit: 2947c8065e9efdd3b6434d2817dc8896234a3fc0
[2/4] phy: phy-rockchip-samsung-hdptx: Supplement some register names with their full version
      commit: f706024107204cb0b640bac35ea47e7b91b8c71f
[3/4] phy: phy-rockchip-samsung-hdptx: Add the '_MASK' suffix to all registers
      commit: 2dc8224e3758c5d6387786ea1d74d2d510149b1a
[4/4] phy: phy-rockchip-samsung-hdptx: Add eDP mode support for RK3588
      commit: 8f831f272b4c89aa13b45bd010c2c18ad97a3f1b

Best regards,
-- 
~Vinod



