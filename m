Return-Path: <linux-kernel+bounces-366602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D099F7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D11C22535
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF881F584F;
	Tue, 15 Oct 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSAEZSU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968E1F80AC;
	Tue, 15 Oct 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022422; cv=none; b=H28oJ7Q5aAad/s75JNo9ycDUlhtGqlmNsYf0n7kvRXnahLdeNckV3C8+H3eri8BnXMRpi7KdwF+2RoDJP3r/99txfKldbywwJvFIJBH+xUA6BRRJvEGBhf9PVx7xxhA0s+oYBHgeAjiheIkdEZB8e2MDaJ9iWYMaaBYvyN0Nt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022422; c=relaxed/simple;
	bh=H43Rm70PtO4uEyIEBYzv7WvwKVBQ1nWE3T4ED/q/rA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTuni7pz+u3bSZVfu5jfSF0WisP1g6NI1bd27mTwOhFkvFI8fmai3jwJU97l9a65LBKIqmRHTs+TnVGnqwb82VVqh/MsbAjSKk9YHQGCGYln92HkWEUiwH4D1EfDQ6KDpY8KyjH4iBdlGEwQ1uu7aIwlxAgLx7BPAW+uRRV6ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSAEZSU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85297C4CEC6;
	Tue, 15 Oct 2024 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729022421;
	bh=H43Rm70PtO4uEyIEBYzv7WvwKVBQ1nWE3T4ED/q/rA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSAEZSU07/j6rXtmzBlUT/cc5/vUNoDIg7kmzVuBdNBU2UzUJ4ZmEl9BW1JUPPLkQ
	 KTOWMEocP7e4ZFfzIScIC0EoLdqOwyxirsAAhCtbvS5RXG6awM51MlfDM2qkyo1zm4
	 DDBgRboB+tY+ShyNsbxFeUWiJqhVBBvEFMRcgIYpellFv3i7W61s/JhdQ4aUmBKXut
	 DTEmu6wSTUUCnfpzSzcxDEzk9EXCJt8PBm1dorOpJnTvbSHHImyxkHywQtqOSb3l9y
	 cggAUGMnWDC3CpUgge0JG495lukdK3tKwPxGLtc7jfdug4oBrhKHRV6bBKqJEKsZH6
	 8JIK3YzQbWddg==
Date: Tue, 15 Oct 2024 15:00:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: kishon@kernel.org, vkoul@kernel.org, heiko@sntech.de,
	yubing.zhang@rock-chips.com, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Frank Wang <frank.wang@rock-chips.com>, devicetree@vger.kernel.org,
	conor+dt@kernel.org, tim.chen@rock-chips.com,
	william.wu@rock-chips.com, linux-phy@lists.infradead.org,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip-usbdp: add rk3576
Message-ID: <172902241945.1703112.6047940247854753283.robh@kernel.org>
References: <20241014020342.15974-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014020342.15974-1-frawang.cn@gmail.com>


On Mon, 14 Oct 2024 10:03:41 +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add compatible for the USBDP phy in the Rockchip RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


