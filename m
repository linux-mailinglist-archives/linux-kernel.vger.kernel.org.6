Return-Path: <linux-kernel+bounces-354117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038379937FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B4E1C21C7C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B21DE885;
	Mon,  7 Oct 2024 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCa+E6pI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF811865FC;
	Mon,  7 Oct 2024 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331879; cv=none; b=uy3tuSymReoQh4X7EC/rR2D/DUp4Dls5I7jUGv1HbC+F5JD7J35OZ2qPLxe1xxLmSTpc2mknUAJcDggqxwxo8u4h9Y92oIZ2iX/Kqe0L7i/lyF1mNK0Zw8ZpvMZQ5g12NgjPv5U0tXWE8NMpVI/5Y7VuC2E15Aod64c4hUF+J6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331879; c=relaxed/simple;
	bh=SYtr/4gcSfXcVr29qn4rBMAGsvYyAgt2rpNPLMtwFiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0fqzdzYF6Crg2xTItGdGd7q4pfnBH93DOFpi9VoQJ1g0IBrW59QHFKqF8u4Rr4hSW4qFWdgbu7UuK315J7OoinQ6VoY6atfcd+2hql+AR1SmTv8WxUvFT0nn+GCSfIDF6Mmsuca3ZZdfuyeJjrovBS/ApZ2BSU86NL4R6t+fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCa+E6pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B03C4CEC6;
	Mon,  7 Oct 2024 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331879;
	bh=SYtr/4gcSfXcVr29qn4rBMAGsvYyAgt2rpNPLMtwFiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCa+E6pIleCBfL6XsVkaU1LPzTBKDAQf7WxSkh2HJJSD3JvSGpKsMLuge3IddJaJf
	 iRtF4nBquybECuafmB8UnSogqKd9tS5KkV0Mw2E+UhumYUkqvWXkP80EOUfPuFEMzf
	 tiV94HGrZhJU0FFyZEH44HNGWq7P9Ez/jKzsaAbM4XbdopiM9u58lQNA0er3YZyPmW
	 /6pDQpBzOurYqzhv8NskDGhboqjXyJxKPmiV3kjhg/oLt6q6fBZtf7GYxAryQd0hHg
	 4ZkJk1Wnk4LVnmUhrhgnNoSsuTozeO7zwy+DU2CGQ5Ci7a7/ssQ3xOVT65TQToUfmu
	 FL9rHmodNmpRg==
Date: Mon, 7 Oct 2024 15:11:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: kishon@kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: phy: rk3228-hdmi-phy: convert to yaml
Message-ID: <172833187233.2320517.14578580436121276126.robh@kernel.org>
References: <20241007162732.2450168-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007162732.2450168-1-heiko@sntech.de>


On Mon, 07 Oct 2024 18:27:32 +0200, Heiko Stuebner wrote:
> Convert the binding to yaml and rename it according to its first
> compatible instead of the unspecific rockchip-inno-hdmi naming.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/phy/phy-rockchip-inno-hdmi.txt   | 43 --------
>  .../phy/rockchip,rk3228-hdmi-phy.yaml         | 97 +++++++++++++++++++
>  2 files changed, 97 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3228-hdmi-phy.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


