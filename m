Return-Path: <linux-kernel+bounces-415783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A730E9D3C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0D9B2616C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88991AE006;
	Wed, 20 Nov 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXEFli8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA41AAE3A;
	Wed, 20 Nov 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107950; cv=none; b=cWUabTCFSm5OBgGyxr0X+W1JiPhJC9PBDtExKWZ4voEwju2NWhLSMQqR7mEZj7fnnEzOAK8o4Dg4ECZIGN39Qgm9CL+KshKqfOVn2ZG4L87PUmiTmCEHOco3WtJANoxmCjIwb6+J5AJuIWkCh5gQGysX2hjp5xu67EMzW4TU9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107950; c=relaxed/simple;
	bh=OrZhBNtRFLPlaGhj+G686tbV9mW4nzFS5Z4fiD5DDbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oldr6ZN5KRuC07IW5WWV/tG2EaIVdd+rBr5EnNG21nmu0jg4M0jbW5Vsy1oIDuBR73f8fvn4xx/tpeAccECtS5gA1a6iRd8juVU3PJ/1H357e6OYFztEGamc9mnD0XTAavxegU6E+rYxXOsJr2TtMWRHvpSP4r9pI0ymIRsN7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXEFli8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E783DC4CECD;
	Wed, 20 Nov 2024 13:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732107950;
	bh=OrZhBNtRFLPlaGhj+G686tbV9mW4nzFS5Z4fiD5DDbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXEFli8S0S0RY0bHvO/X0Uk41xKM3YJEZz7yiloTnieO0v59BEHVon1+EJJjI1Tj2
	 dJh00zqR2gqq83o+wTVOPExHEh03ImPVTF+Tk0/pnDcXkbhHOqYI+9yrtrR15LeEOg
	 D36Dn95UmDcZeEw+sKdusdaNDWz0gOlWHssg7/cqK1MaggCFYsyd0nBcr8NrzVU8jt
	 8JmJwuVTKvVE7Flk6Z/wl8JI3nueLeDwfjizU5Fv77KTX52/Nef4KB4j6k7eKrlDpi
	 SH1A8KlHYZ+WqCS1w4WIfpgeoM14ELE16LJ80HRm3b68rGHP6z9BTBv3QzRs9oB2aX
	 l6gKhI8yGj+Jw==
Date: Wed, 20 Nov 2024 07:05:48 -0600
From: Rob Herring <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] arm64: dts: sprd: sp9860g-1h10: fix
 constant-charge-voltage-max-microvolt property
Message-ID: <20241120130548.GA399236-robh@kernel.org>
References: <cover.1730918663.git.stano.jakubek@gmail.com>
 <aa557091d9494fdaa3eda75803f9ea97014c8832.1730918663.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa557091d9494fdaa3eda75803f9ea97014c8832.1730918663.git.stano.jakubek@gmail.com>

On Wed, Nov 06, 2024 at 08:05:29PM +0100, Stanislav Jakubek wrote:
> This property has hyphens/dashes, not underscores.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V2:
> - collect Baolin's R-b
> 
>  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

