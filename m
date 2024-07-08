Return-Path: <linux-kernel+bounces-244847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C3E92AA46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B05282BF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6E22EE5;
	Mon,  8 Jul 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3PWHRlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D11CF9B;
	Mon,  8 Jul 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469073; cv=none; b=BjLBvdf4jChZZu8GNiXhYHyzi5obeOIjOc+/TIZDo2+av5fZ5JvE2dZir19W2clRlzUNUlKLKP9EM2dnNiTwUlSH/k7ZEiN20MyViaj1vAtFP1MHBtCe1uW7GHv0xMraMNguuW6qigMiPSZ5sSTfVIRdeEyb99iv5gbKBzldtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469073; c=relaxed/simple;
	bh=+LGYnoamoS4zfZqMrzKzYDviwFlUv6xLADZa36LTO0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRo8aLl/EqUroEqU1UpvD+g2r2HCVaWVuTli6CgoP6t+P3aYiNMgFPjQ1nanws+i4J0OAqHi9C8HLv7eOrEBpuVBRXGtqqVnk4jZwSCqIKG/O8doqeuT2Uw/OQFAVuxif4YN2YJzv4oHrLsI7V7nwgvQEMzs4V54DQiCZaX6/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3PWHRlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74967C116B1;
	Mon,  8 Jul 2024 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720469072;
	bh=+LGYnoamoS4zfZqMrzKzYDviwFlUv6xLADZa36LTO0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3PWHRlJ0VCjKO1lj50fEwf/58isiHjCmzm7NgA9+k3pMwfnIopSOatyfxItxA4st
	 Rnft84KW6cOJ3zTX2writ+/UVW1fs/hqOqmNiCrIpTIGQA0Lr9EnJVk7dhEHKVU/aY
	 LGvP6aGWDFLnFyX9uqpf6hPRdx7IAAhydYmOF7CXvA7DP5Z1rJHFVD8lrkTp+i0t7o
	 ZOoa75Ju8biYaHc2XvmaoeQoR3pzMTzomvqGPSII2E+bcdc2FwvhixjGxcUvu/BuV8
	 v2bVClheX+wE9OOOn55kW2Wq8PdUvmc6TJSDDvYQiVbEGpcwZaWivSw5SmL27cGG1x
	 1wnkCCu8XVFGg==
Date: Mon, 8 Jul 2024 14:04:31 -0600
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, tglx@linutronix.de
Subject: Re: [PATCH 01/10] dt-bindings: display: imx: Add some i.MX8qxp
 Display Controller processing units
Message-ID: <20240708200431.GA3492466-robh@kernel.org>
References: <20240705090932.1880496-1-victor.liu@nxp.com>
 <20240705090932.1880496-2-victor.liu@nxp.com>
 <eec3d2a7-0197-4196-bf6f-71d0e29777de@kernel.org>
 <9a911f88-7fbf-4484-997c-98b6c3ec045b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a911f88-7fbf-4484-997c-98b6c3ec045b@nxp.com>

On Mon, Jul 08, 2024 at 02:30:37PM +0800, Liu Ying wrote:
> On 07/07/2024, Krzysztof Kozlowski wrote:
> > On 05/07/2024 11:09, Liu Ying wrote:
> >> Freescale i.MX8qxp Display Controller is implemented as construction set of
> >> building blocks with unified concept and standardized interfaces.
> >>
> >> Document some processing units to support two display outputs.
> > 
> > 
> >> +maintainers:
> >> +  - Liu Ying <victor.liu@nxp.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: fsl,imx8qxp-dc-tcon
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  fsl,dc-tc-id:
> >> +    description: Timing Controller unit instance number
> > 
> > No instance numbering. This applies to your entire patchset.
> 
> Then, I'll call of_alias_get_id() from the drivers to get
> instance number instead.

Ideally, no.

> As i.MX8qm SoC embeds two Display Controllers, the alias
> stem would contain the Display Controller instance
> number, like "dc0-tcon" and "dc1-tcon".  Is this ok?

The format of aliases is fooN, so no. Aliases should also be generic 
rather than vendor specific.

If you need to describe the connection of components in the display 
pipeline, then use the graph binding.

Rob

