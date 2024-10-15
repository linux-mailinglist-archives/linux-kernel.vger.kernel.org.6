Return-Path: <linux-kernel+bounces-366631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E699F804
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B96287B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2F1F8184;
	Tue, 15 Oct 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiDmF2tu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5315699D;
	Tue, 15 Oct 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023611; cv=none; b=amAJtI8dGWWRwrALfzdBeXWbXEI4dwr54x2iFqz2S4ydrSfdPxKHUbqv0GMr00CDSy0SePmFuLuNtV/kidtyli+YWWouKt7h//Dhu541wzgpw2v5LDxwwWtkyYH/eQUDzNeya6/J7KNyDukcxes/Cx46f+bcj50qvqcaHJsnDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023611; c=relaxed/simple;
	bh=x0dv1P7HzpQz4hE653c48L2iacolgQtCuY2vADBo2ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+qoy75vOms0RgtRSzBqNN1ikHL8JebyHvwr3YUV6XZGG+Rn25R3VIW4obKZP3WEEMs4GCllGgTokHQGphCFZulljb5BgkzlbpnaUgW9mPLL8HQV/ITCJU64dRYZE6slCAp/gQlM/cKGfdu/RmVjhQcGm01hdWYr4x3YvPRXOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiDmF2tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BB5C4CEC6;
	Tue, 15 Oct 2024 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729023610;
	bh=x0dv1P7HzpQz4hE653c48L2iacolgQtCuY2vADBo2ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiDmF2tuZMfM7dxtZRtLkXRo3SXilj/RlJ8d2HDlilDGK2XJPlp2PN6VY5U3chydC
	 p26rdE6Wkj3Q+/Q69JISEV3mS2tcK8QGr7oHbB1HYjCunoqunRPdUrCxplr9AkCLnn
	 vxzcdFA9yHYJ2/LYOn2O+J3CUM1eh3jmFUR0SnGRlWyfZqKBvVs+LPtE/ffxpC9i/Z
	 NatGgpJFY2dv4ttdADq+eVAJ/gwxKQUA97bp2mWl/H4byBTtIjbd//o3hx8rupce2z
	 d0UVOqCd4CXr0SgCf6hWdjlEHoKREeTGCFiVgZq11NQmfQv/97CXPxd9vDwJuhcarL
	 o/ycSgdPH/iRA==
Date: Tue, 15 Oct 2024 15:20:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, tim.chen@rock-chips.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, krzk+dt@kernel.org,
	william.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
	kishon@kernel.org, vkoul@kernel.org, linux-kernel@vger.kernel.org,
	heiko@sntech.de, Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip: add rk3576 compatible
Message-ID: <172902360776.1846766.3809277607860876723.robh@kernel.org>
References: <20241015013351.4884-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015013351.4884-1-frawang.cn@gmail.com>


On Tue, 15 Oct 2024 09:33:50 +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Adds the compatible line to support RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


