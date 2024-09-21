Return-Path: <linux-kernel+bounces-334724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C9A97DB17
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89A6B20E6C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5423C39;
	Sat, 21 Sep 2024 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm+WOWxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CB257D;
	Sat, 21 Sep 2024 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726880210; cv=none; b=XnVJqlupf2zucFFHFsZPy2lS2K0PwStfUt40SJGJPteSPV6xu9VILNyXsCXm4UkmpAOXVK+DmX5Eq9ZRqj+Cp8kKp9fyawPEyWBgdkGfEYnJx7L6iZgG2WrTYdhVgSnwwNzDAf8bU3dgmtLkWSSVTsj1BSvaltItPpfTM4HJGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726880210; c=relaxed/simple;
	bh=lDJ009p2D/pUJQr1simWECFgi0I9G+uGt/YBTgsS7uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq9pLga8YatkrvTIYAJuapNxE0h+CjLftoxL0KDfV86yzRgKdU4YNkl7yvmMej+WV9I5RVhPAtbUmnric9yqrwZrWbnqdmqXih9/IUj/v4xT6F4J08whj+ZP1kO2xf+uJ1DYHVuz2rrUIhUxRcCgfyD/p26J4GrIxEjTHfPsvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm+WOWxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A8CC4CEC3;
	Sat, 21 Sep 2024 00:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726880209;
	bh=lDJ009p2D/pUJQr1simWECFgi0I9G+uGt/YBTgsS7uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cm+WOWxGpGnZtBTiftR6hnhBsFi3I2Xb5pbMXl9fG8X2/MXb064sRRhBluWl720ep
	 vNcNn9sQQ84V7L9gXHV1bYmV6utCRgday0dRL9JWCYyvAT3TGkitYxVjRGMpinDXiW
	 CIXL0H4uCxgVzX21/OdGkFPPmBqRe01xWW0gkA6XRalEfQbDI/QsGwymX8Geyr4QIs
	 ZF0uWIzR7r3j/TfGcNke4iStZqFELe8GcgOq7zEfktxBIB+YVWxsSMlL/u86r6E0mQ
	 t7e3PFTC9Sk3MpapiGSdxT8INAjiXM3UbSl5QJ+vUrbUD2P+x80tTt7ycN4CcUlpL4
	 LY5jIwAP9OCVw==
Date: Fri, 20 Sep 2024 19:56:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: sam@ravnborg.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
	quic_jesszhan@quicinc.com, thierry.reding@gmail.com,
	airlied@gmail.com, mripard@kernel.org, conor+dt@kernel.org,
	maarten.lankhorst@linux.intel.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, neil.armstrong@linaro.org,
	simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel-simple: Document
 support for Microchip AC69T88A
Message-ID: <172688020813.189327.3194453889234095156.robh@kernel.org>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919091548.430285-1-manikandan.m@microchip.com>


On Thu, 19 Sep 2024 14:45:47 +0530, Manikandan Muralidharan wrote:
> Add Microchip AC69T88A 5" LVDS interface (800x480) TFT LCD panel
> compatible string
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
> changes in v2:
> - Replace microchip,ac69t88a-lvds-panel with
> microchip,ac69t88a
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


