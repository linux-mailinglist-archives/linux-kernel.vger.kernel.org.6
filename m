Return-Path: <linux-kernel+bounces-529992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B4A42D66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04103ACD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53BE221F13;
	Mon, 24 Feb 2025 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9WqobFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C34200138;
	Mon, 24 Feb 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427785; cv=none; b=H3G0t4ScSLJrmVjfjPA+lqkwl6+Sl7Rbxhx53PEoF5rzZVAMrVomW0TT6VCkxjtJson5al6TuYw3KA+6MIYOCpYrunelzDuCfrOy80yxPPhwyCC5Hyma+BW/3GmAYDhWcC2sxRQiiyvW+yVOVfqIZD2S49ZPTMVqZcxJb6DMhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427785; c=relaxed/simple;
	bh=YWblvzyL6cWwWDLx/Cb21hLUSZ83nNZh13vfA6xbIdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J06Vt9cH0wKzxcbfOpWOCOMgEy2ESC9YNY0pwbV/wWoFADZ8Zq/0oW69/Z+Z1FokngNQOAndyVsVWq6vjup38r/Zd8aU3VrbwWExSk2LjkpEonwqt8AN7WsyNDz7zyep7n7tjEDbbfDI4HpmxwAskFYjAGGbmARDmgX4DfNsK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9WqobFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFD3C4CED6;
	Mon, 24 Feb 2025 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427784;
	bh=YWblvzyL6cWwWDLx/Cb21hLUSZ83nNZh13vfA6xbIdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9WqobFEmTEBiK03iSDs7rBWeNj2Enp3iOKbXMubwdCVqTH3nR7Z6Orq2THBIQCa6
	 zIsqI2hSJvv8RohqUfpxeUDzAdGknsZ/+3W/kxe409xhPovrxLr7xHdy0waAMMWXju
	 RfsTSuvr0gFY68ScJwgAX+qMUX14rPFUEJgRO9s1FhJAWAEq4w10TvVOObvqldia9d
	 pb0Bqp/f8NaTDha2k/C71GuXPDL8M9JzTRflwH18Eh/RfsSLKyyKQS1hKwlFyF5VgM
	 ak7+42bDdgp2CrkD7ZDEXBu/Gce+GuYtHiXIeEvjqdECRCr66UOZOV5wi6ezFKRVtv
	 hzjlS8AA6+Tug==
Date: Mon, 24 Feb 2025 14:09:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andy.yan@rock-chips.com, boris.brezillon@collabora.com,
	cristian.ciocaltea@collabora.com, devicetree@vger.kernel.org,
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org,
	andrzej.hajda@intel.com, conor+dt@kernel.org, hjc@rock-chips.com,
	linux-kernel@vger.kernel.org, heiko@sntech.de,
	linux-rockchip@lists.infradead.org, jonas@kwiboo.se,
	sebastian.reichel@collabora.com, Laurent.pinchart@ideasonboard.com,
	jernej.skrabec@gmail.com, linux-arm-kernel@lists.infradead.org,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	rfoss@kernel.org, krzk+dt@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v7 11/15] dt-bindings: display: rockchip: analogix-dp:
 Add support for RK3588
Message-ID: <174042778228.4021934.12821302542409218645.robh@kernel.org>
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
 <20250224081325.96724-12-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224081325.96724-12-damon.ding@rock-chips.com>


On Mon, 24 Feb 2025 16:13:21 +0800, Damon Ding wrote:
> Compared with RK3288/RK3399, the HBR2 link rate support is the main
> improvement of RK3588 eDP TX controller, and there are also two
> independent eDP display interfaces on RK3588 Soc.
> 
> The newly added 'apb' reset is to ensure the APB bus of eDP controller
> works well on the RK3588 SoC.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - Add the main defferences of the RK3588 eDP and the previous versions
>   in commit message
> 
> Changes in v3:
> - Expand the property clock-names, resets and reset-names
> 
> Changes in v4:
> - Remove 'spdif' clock which added in v3
> - Add the comment of newly added 'apb' reset in commit message
> 
> Changes in v5:
> - Put the differences between RK3288/RK3399 and RK3588 into 'allOf'
> 
> Changes in v6:
> - Keep the widest constraints and add only RK3588 related constraints
>   into 'allOf'
> 
> Changes in v7:
> - Fix the errors related to 'reset-names'
> - Remove unnecessary 'maxItems' under 'reset-names'
> ---
>  .../rockchip/rockchip,analogix-dp.yaml        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


