Return-Path: <linux-kernel+bounces-254127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4750932F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BD281CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6F19FA9E;
	Tue, 16 Jul 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="frWSgU0Q"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99EB67F;
	Tue, 16 Jul 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151959; cv=none; b=IMPEYb3shxtzKjSsWBsBZjKUOUwDCV/w6tZjo+ILLgUX+D58PFkhqvQwpL2AYCJ3Qush3OPXuyavc3PHCpAgWc2I3t4Z37xjWHVH0WuBYmkuMpiovQXA3rDjW5ybSqL1odw9ljoMgozLzfsQ6aimicYw/ZT0zq+zbBzvzoQS6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151959; c=relaxed/simple;
	bh=YuRAgq7T7DYZ+9bOH4Kh/59c9vBYqNhQMDcTMTwSy7I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Y+xlvhS+uR7mtLuo+xKpDQuir938ysfxuH8Rcbv1GbXlYyJtlIgS8ks2dWgSOAQ1mJETWP/nF8M68uT98lnmKAXT4TBXeOSplFftrl+g74aIreiRPPnlo275MyaoSHLdE0ZawvlanP0MnfM6mBYhZKVn4OXSlARAdGfE6JPVkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=frWSgU0Q; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721151947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhR8ShgNZ4zr20pJvrZSBhHiN5aG2Rwxocrt8rVDf8Q=;
	b=frWSgU0Qd95vdp7IVtKo2hahyPh0ax6zmYOnpAABSPSToBxVZlIm22kufuYPn4pI4U4Ax5
	7AAvkancGLjf1Fg3LyYZdGPzrqX9rVBBnOxY5CqVStIarucIfekCUob5l1VKSfm9dQveDC
	l0kIVoXz9nRWl0YK76gRFVBBfp/uZKgb3hNbihuotaxjgb9jTaQCR5/5XN7CMQc5mxYiVE
	b6uMTC5SYczHW3K5Tuzq9o/lh7gqgGVl0KPgkvMmjybI5uE0Yqki888sEMEkPdnxLNQ6v2
	IFdZ1h75d1k3KRMNjn4DnT9ABU3LCgS6qI7IH5+/7YGtBuTS1NzHLthqErY+gg==
Date: Tue, 16 Jul 2024 19:45:44 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>
Subject: Re: [PATCH 0/2] Add support for Firefly CORE PX30 JD4
In-Reply-To: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
References: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
Message-ID: <81015d015aae01f2d5fa70262304837e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christopher,

On 2024-07-16 17:51, Christopher Obbard wrote:
> The Firefly CORE PX30 JD4 board is a SOM and motherboard bundle from
> Firefly containing the Rockchip PX30 SOC. This series adds support for 
> it.
> 
> ---
> Christopher Obbard (2):
>       dt-bindings: arm: rockchip: add Firefly CORE PX30 JD4
>       arm64: dts: rockchip: add Firefly CORE PX30 JD4
> 
>  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  .../dts/rockchip/px30-firefly-core-px30-jd4.dts    | 562 
> +++++++++++++++++++++
>  3 files changed, 568 insertions(+)

It would be better to split this into two separate files: a dtsi
for the SoM, and a dts for the carrier board (which would include
the new dtsi).  That would reflect the actual hardware better.

> ---
> base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
> change-id: 20240716-rockchip-px30-firefly-59efc93d6784
> 
> Best regards,

