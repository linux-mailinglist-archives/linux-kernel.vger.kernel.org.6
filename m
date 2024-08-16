Return-Path: <linux-kernel+bounces-290371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE176955304
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F381C24274
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52837142E92;
	Fri, 16 Aug 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlgB+i/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFE13DB92;
	Fri, 16 Aug 2024 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845770; cv=none; b=GjVnwelgGvv1uxwrLOhiJ478oVe9A08RfQzYJoT+vwiLvegDfW09AjpZ7Hy/nFlq7jQrRBq0uMxhfvvADVP+7v1KxwXQOIxMUCp6XcPAaF1jLGWpkOYFGr8VieYwtKyAJyHmomiRr2FGQAoDxgXD5FTT/yq8vc1QclnzwPwKe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845770; c=relaxed/simple;
	bh=C7weTXHP5DZBvZKNrnFze/Hiwgy5qiIv6X3bg5485vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBwzwt3J3zOvlqdnk1ajbifVgnx/BvD4p1B2kPDBy29MW3sidwv5fisGHTaXU/j1dNdUhFuc4QQ5dWerqw9d/TuW7nL/qT2vQyN4CUktXMxZ9D68SFdHFANLACysuIIS6qUyAO++o2KDr206dipb2MvokQlaxLiq9gFrADrBlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlgB+i/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDECFC32782;
	Fri, 16 Aug 2024 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723845770;
	bh=C7weTXHP5DZBvZKNrnFze/Hiwgy5qiIv6X3bg5485vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlgB+i/wdBxZDnIfAhM6wRJNvY7OgDrPc38z3dxY38q1grTJ8qJ15hpB5yxwbPRu2
	 7tufqgtCoAjyOzZBJuYJCbtHykjrv4kug4OATK8qDplZ6T2xdO7JvqQ2Jb1VCtatqs
	 tHYBcGhPpj5OQVnc3jOpCcdJ4eig5tZkhTQ6AKnCpD62H23JuiIMMS63kIzHQf8uoL
	 hu8Yq7fL3cOZbmQ8yo0+1JZQZSmgnpw7hEDhyTsZ4Mddd6oW9NhGTFret8LeOU0exp
	 YV9w/R4SMA1h8xl+xavo5eDbC6QgZHi3ERfbmPpS8aRnEctqQ+RfFZkVEbwI5eX9gr
	 RHRQd+G1qCOFA==
Date: Fri, 16 Aug 2024 16:02:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Liu Ying <victor.liu@nxp.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: display:
 panel-simple-lvds-dual-ports: add panel-timing: true
Message-ID: <172384576729.2335127.2343168496385011708.robh@kernel.org>
References: <20240814191656.4035551-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814191656.4035551-1-Frank.Li@nxp.com>


On Wed, 14 Aug 2024 15:16:56 -0400, Frank Li wrote:
> Add property panel-timing: true to allow use 'panel-timing', which defined
> in panel-common.yaml.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtb: panel-lvds: 'panel-timing' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/display/panel/panel-simple-lvds-dual-ports.yaml#
> 
> Suggested-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - move it after enable-gpios: true' to sort the referenced properties
> alphabetically
> 
> Change from v1 to v2
> - add panel-timing instead of change to unevaluatedProperties
> ---
>  .../bindings/display/panel/panel-simple-lvds-dual-ports.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


