Return-Path: <linux-kernel+bounces-196911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676738D637A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983FC1C227FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B046215AAD6;
	Fri, 31 May 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2xOYgYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9861586C8;
	Fri, 31 May 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163423; cv=none; b=Ipt+vcpfjEf7MSLZTDfUnN0K4uuiba6UK/VbrBy2CeTrUSJ6A8x1op5dZRcPJrgcuUaIkxZbM5CF1acsFKsCyDXxwldBAc3ooQVZ/sYoWJEN7rjVHsFRtSsXMWncIL6D8ncnmY+wm0olXTOGLRLonL4UEBNTly2/SEA+BDLU2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163423; c=relaxed/simple;
	bh=U72Hnfwv+pkza1MDuPQna617EZqo/kS0L8j4Zh+baKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syAVlK5jKhQIpX/y58yCKW0Ia7H4MkKeDxlvjGCvzb/qEBfch/Xbw7EQA0Ob8JOD2WbVeD6m7PzLs+areOBpExxz7RO9oF56a6vf+cBv69mithoyfQouwO7gIJ0eIq2fXvZkmsWt4ZyVcCN2vH4YIYaNXLL69vMwMCbc8WMlJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2xOYgYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A950C116B1;
	Fri, 31 May 2024 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717163422;
	bh=U72Hnfwv+pkza1MDuPQna617EZqo/kS0L8j4Zh+baKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2xOYgYIKaq/lv6mByWSAcQ2qMB1EXPK3S+LOLoTx/og2lPbieb9jXRYv/BsE7YU7
	 l7/rsarSSHN5yVl7M/UlnuUV1rt7IlWEdFmk1cNTQfjvFpE1ZzXKwrjEY9GwihS0Wy
	 spRIM5mLXxnWmnb+eDQvWBnEqzETROIfKWC31nkH9PE7ihKiGCOCS6Nr4YNEUj2zhV
	 5fFZu/+kZOHBKM0OeOaTSkJZ2QqC0NVwkgHIznz1HxoBdA16+c0XsiKu/cTuICf3dw
	 bmoLrS+jWRYKW73UOrYSFN5LFlP6LE6YNALxRG0zdingT7ZPkRrPyq6Hdw7XqxxfdM
	 CFcdj8OMmV/Fg==
Date: Fri, 31 May 2024 14:50:17 +0100
From: Lee Jones <lee@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: ti: Move
 ti,j721e-system-controller.yaml to soc/ti
Message-ID: <20240531135017.GL1005600@google.com>
References: <20240520-for-v6-11-j721e-syscon-v1-1-f57a93e12cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520-for-v6-11-j721e-syscon-v1-1-f57a93e12cad@kernel.org>

On Mon, 20 May 2024, Roger Quadros wrote:

> soc/ti is the more appropriate location for the system controller
> device tree binding documentation so move there.
> 
> Update Kishon's email address to a working one.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../bindings/{mfd => soc/ti}/ti,j721e-system-controller.yaml          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

