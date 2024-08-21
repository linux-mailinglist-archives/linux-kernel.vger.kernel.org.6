Return-Path: <linux-kernel+bounces-295741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C2495A101
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E17A281E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236414D422;
	Wed, 21 Aug 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxmj7O3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370D433B5;
	Wed, 21 Aug 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252925; cv=none; b=mUuiPLTOijzSVrkjkMxvkrgsyVNeWLzaJh4Wv6szwxULObcryW9acgTne2uh/QQZKDjcsSYHZiDvj5ureziVVxzUx97fOxl93WZvF6D82Dr9Ki7cXllzg7uHbXElUqwBlPBsxuSVMqryhFdKmKZYnLYDIa9L2WNbiVz0u5pz1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252925; c=relaxed/simple;
	bh=gFGxUuMrLBFfVewbTA/3YPSYUrfiqegiKsyAf+HrzOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iysetJPRgZPyurNKEwFUIwFxIGGGw42fy9BYvJi2VxRfb1QB3Ip2uTOtHOv2vjIssiEPXmsCmhV5Jwk4reiHN1m+ZpI407fMNPMuEzFLBa00TkFs+VYsfz/DXpLLFnelZsf0WObxT3DV0w9WyjxUQHVEMEO1JFxAD3r4PnZYtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxmj7O3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5CFC32781;
	Wed, 21 Aug 2024 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252924;
	bh=gFGxUuMrLBFfVewbTA/3YPSYUrfiqegiKsyAf+HrzOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxmj7O3yhKRu1tVbHQoOtdmwMbU2WeIC1lqLK9sYNOspkPiZKL5smmPU0h25fHHaN
	 GZOoY6vecAVMpZWcXKHVz1AcBoYNbuQ05ZnO9DeRvvRV3+/ykrZTogLCY5N6ae3Cu7
	 KEHt7Rggvx31/ALPClzMyVM8NGBba0rcblq9ulMh/0hLYeAQ0GC9F+qUMdUdCJBjVo
	 LUPbInzjlQEvPhceG5HaS2yt2lcrNOU1mbDgHnQb3OyyhjnUM21frPEztaRor1jd7u
	 WE/lMwlhncePP6pmv9QfhP4YAJuuNM06n3GSY37hkbdId+eVypjsVzmcbzZ5wtEC1Q
	 4O6TgaHEJbmUQ==
Date: Wed, 21 Aug 2024 16:08:39 +0100
From: Lee Jones <lee@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>,
	"open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: leds: convert leds-lm3692x to yaml
 format
Message-ID: <20240821150839.GB6858@google.com>
References: <20240820183544.496419-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820183544.496419-1-Frank.Li@nxp.com>

On Tue, 20 Aug 2024, Frank Li wrote:

> Convert binding doc leds-lm3592x to yaml format.
> Additional change
> - Add ref to common.yaml for child node
> - Add i2c node at example
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: /soc@0/bus@30800000/i2c@30a40000/backlight@36:
> 	failed to match any schema with compatible: ['ti,lm36922']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - fix dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/leds/ti.lm36922.example.dtb: /example-0/i2c/led-controller@36: failed to match any schema with compatible: ['ti,lm3692x']
> ---
>  .../devicetree/bindings/leds/leds-lm3692x.txt |  65 ------------
>  .../devicetree/bindings/leds/ti.lm36922.yaml  | 100 ++++++++++++++++++

Full-stop should be a comma.

>  2 files changed, 100 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-lm3692x.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/ti.lm36922.yaml

-- 
Lee Jones [李琼斯]

