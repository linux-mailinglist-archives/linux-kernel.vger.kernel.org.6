Return-Path: <linux-kernel+bounces-370072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F099A26F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C978283314
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BFF1E0085;
	Thu, 17 Oct 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEgM85/z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F01DF242;
	Thu, 17 Oct 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179372; cv=none; b=vBIiNws9pckDIpHI3N3oumSpnm+coCpul6qSApFN5NYkJeuBcTn9j0wpgvjDV1ZSm3MYUhdluKroKfzn+n2SivFvlVIYQbrOKCdPMf6oFQX+Bqe6MnOLDonKpawP/hkVk2e6EMbZJnVi9On+4hUSJQumy4LZIHO4F7gqAPgT57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179372; c=relaxed/simple;
	bh=fo+CHF9qHwWN/uBVKplYMXMd5ty02jFEE2Ox30uGgf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uF8zbMO93LRrRBe9dXD3xIeF5naMoge0iE3LpRHirc6b7V5QQIpaDNd9D4dIDPl3tUuK3k9pPizhM2AxG1rCmPiE39nlO3/41INCbu7CW4VCQQvxbo5ThQGw0GlHJ3w7PLr6EP4Pnxyc5GXf8HBCVg/KWn5OAs1FnMD9G8BZB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEgM85/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923E8C4CEC3;
	Thu, 17 Oct 2024 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179372;
	bh=fo+CHF9qHwWN/uBVKplYMXMd5ty02jFEE2Ox30uGgf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KEgM85/zWOLKZ5N/8GHERiMJ5bO4Dj3IoNVywTfnEa4ZQ3HVCduEfskJZpsUNJpzy
	 zx5dNSNwizZOtU7TNJotLf6rrjYuhftYzjySzP2oL+3RnCZvat2HtDd0zkPDn0jot4
	 I12FQT+drgIh5tD1NBpb+HEWYpXwAO4ziZRpJmJjxwBe5ngVkSHJD2HirY7nigJZ3a
	 YayW+dR1dkKY5gvw/GeAhzu8E5O0o/mD8Ra9xQsO/7J2nUfV8roariIrsgT3jJMxnS
	 i0E6BQsvoY+0JXyPIWAD+zyuqzstxhvDJ4OdCn8Zlphkx1ZPX+C0KJWyCzC2IpoJf+
	 EL9TTGdi8RsnA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007162732.2450168-1-heiko@sntech.de>
References: <20241007162732.2450168-1-heiko@sntech.de>
Subject: Re: [PATCH] dt-bindings: phy: rk3228-hdmi-phy: convert to yaml
Message-Id: <172917936923.288841.7317586355645803007.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:06:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 18:27:32 +0200, Heiko Stuebner wrote:
> Convert the binding to yaml and rename it according to its first
> compatible instead of the unspecific rockchip-inno-hdmi naming.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: rk3228-hdmi-phy: convert to yaml
      commit: de30906910f8c2a91b236ff77d7dd5edfb14bb55

Best regards,
-- 
~Vinod



