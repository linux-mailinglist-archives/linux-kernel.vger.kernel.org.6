Return-Path: <linux-kernel+bounces-370060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387979A26D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE954288571
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C933086;
	Thu, 17 Oct 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brNnxV2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C51DEFCD;
	Thu, 17 Oct 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179332; cv=none; b=DKYtMFzo0ha/TG7yrrmjEluZewyhVDXpt561wqRlsOb3D48uD6M5CiREqLuHcqmA/b3cnsNKoN4EX66N79tkBBIUzaTNK1BM1XWAoYCP1/lYvPOI+dsqSX0Ra7/gTVJ6l6YHfKKFpwGwFBr4/T8A6mcn3swu7aqYtruXLHaZ/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179332; c=relaxed/simple;
	bh=poBaeIXGhWrOXxHqNDXA9/SiaWES5p961HT2/STyJzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NPvNaog4xl2PqQw0qoOmyBKnV1z6upNDzEIR9E4lwoGFTa1CUDLscGO5Cx9zbOwgL5bASE+IcA8Cvxs4LJEAhh5BQ+I2Ut3wb1ONtEJd5fhzoww7ghKPVX4ThgSvd2M4P728rJHVU8auVNmkXZDEbGC10nv/L9YrV5xU53CA0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brNnxV2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9C3C4CEC3;
	Thu, 17 Oct 2024 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179332;
	bh=poBaeIXGhWrOXxHqNDXA9/SiaWES5p961HT2/STyJzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=brNnxV2APJL6CDVOruAOYWetiD0wY1K6o7Im04dQsDiBlwDAzik83b0miXsZ1sYKY
	 tppdn3RcGe28cwVl4GbYpWHuFyqZ15U0wYLSCz/D3npInK4hsuuU+vNj/PlaZMYgeC
	 6relWYfvShMr/MdoOM+AvUNtzoXrE3IC3GrcYgVqISUMd7Au7PbbYdww+/Uig2K76S
	 xNPM99SjWsSlAs5Vsk8vKwL/wo3iBesF1KaAAGrVc1pjyz0fymaxnGw6Xd+8/FLT13
	 g0w0kcpL59Q9z1CA6jyIWKZ0o6xn83ZwcHyQzEfkfrFPfoyZuTRWmbgrnR58c2Wpi6
	 ZfwQoNJsfcr1g==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, heiko@sntech.de, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com, 
 Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <20241017025230.28752-1-frawang.cn@gmail.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: soc: rockchip: add rk3576
 vo1-grf syscon
Message-Id: <172917932783.288841.4239096557035814697.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 21:05:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 17 Oct 2024 10:52:28 +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
> configured in usbdp phy driver.
> 
> 

Applied, thanks!

[2/3] dt-bindings: phy: rockchip-usbdp: add rk3576
      commit: b3e804ab9aad465ba7285aa5daf83656d5efc59f
[3/3] phy: rockchip: usbdp: add rk3576 device match data
      commit: a76de028c619dd18f89786805bcc7bb4d379ea9f

Best regards,
-- 
~Vinod



