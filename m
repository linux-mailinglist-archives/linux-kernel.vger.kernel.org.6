Return-Path: <linux-kernel+bounces-423610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAD79DAA57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135BEB22CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138751FF617;
	Wed, 27 Nov 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ept6l6sl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69F224EA;
	Wed, 27 Nov 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719934; cv=none; b=sNwbPGvFUKirfY+F2xTJxCTzpasxTOF66HDcUC9JRQ69igAjY3S3I6xKpeHX82lMoP6UTMENyUis9VMWrfszbFKNSqMaCrkElB8/MpWijRf8JGYR/PJsHoUGP5lq9mXh2oH/cdAz2oI7YtPVogyo45iL0Kr2l8UqDV+2YBH1mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719934; c=relaxed/simple;
	bh=sB5WsF2yTtwAJZFMBi4Ub30MJ2hXC4QT4NG4uzLcRRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmS+qJveD3hJPlinUiuRQE5C0cJZl1/tJdt6KpP4vaxOKQ+otKn7PapGJe/ARFZNvWBrrgdDLbIEECEIYob+A3BVDyZ5brWOoktU5j8hsBIB2tAwDwbICG1qFYFQpfSGqRvw7Hh9exRNhe7Hx6SAs9/tWlHAAfOY9P732GaAFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ept6l6sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25E8C4CED3;
	Wed, 27 Nov 2024 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732719933;
	bh=sB5WsF2yTtwAJZFMBi4Ub30MJ2hXC4QT4NG4uzLcRRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ept6l6slC82V06hpuS5FuclQ4x/1Oo7ci31otvDJKT8wxxgrFr+TrYAC6SwVz7cfw
	 BTpUnHj15/vdehiZspar722ryFF4mXbbuCt7B7iYEEG/ONglHHnya1lhfZh66c9paQ
	 d80g1Tf4C3vjhBpdlBJIgs/4/BWbZUCbJffNNwUxCIA1G2//4kcw2fJpGwFsO8I+ht
	 RLKa4KxposzT9J6o+xR6nR2RHUbjYfCairL/JawkR7ruhhycSGgfGwBRZrKSX8iRXh
	 SU3PiZat6A0VKGvQ5bjVIBLXvZGisz2uChmgk89ABMHwSY4FO2uLkSOADd1cmOjvao
	 yZdAXShismNyA==
Date: Wed, 27 Nov 2024 09:05:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: rfoss@kernel.org, neil.armstrong@linaro.org, quentin.schulz@cherry.de,
	maarten.lankhorst@linux.intel.com, krzk+dt@kernel.org,
	andy.yan@rock-chips.com, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	mripard@kernel.org, tzimmermann@suse.de,
	Laurent.pinchart@ideasonboard.com,
	linux-rockchip@lists.infradead.org, conor+dt@kernel.org,
	jernej.skrabec@gmail.com, Heiko Stuebner <heiko.stuebner@cherry.de>,
	andrzej.hajda@intel.com, jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: display: rockchip: Add schema for
 RK3588 DW DSI2 controller
Message-ID: <173271993052.3509811.7014863879823500729.robh@kernel.org>
References: <20241126201213.522753-1-heiko@sntech.de>
 <20241126201213.522753-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126201213.522753-3-heiko@sntech.de>


On Tue, 26 Nov 2024 21:12:12 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Display Serial Interface 2 (DSI-2) is part of a group of communication
> protocols defined by the MIPI Alliance. The RK3588 implements this
> specification in its two MIPI DSI-2 Host Controllers that are based on a
> new Synopsis IP.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


