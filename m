Return-Path: <linux-kernel+bounces-522674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E8A3CD24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95D51895C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5703525C710;
	Wed, 19 Feb 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzKjMpVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED81B2193;
	Wed, 19 Feb 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006809; cv=none; b=O7AFlkDn5YQPzwUQrkANzg0YU8v6c67AyG2nsWiW4xx4lkApd/EjTCQ7l6rPzzr0ACcBOC+4c2o3/2FG2olA+JW2utcibu+1GVZFG+KngeacqRbN2HM5dxXyEyhYN1wNttWqpMUnxMiO7F+b3uRLeEXUeFNP0vxRr0QjqQd/DTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006809; c=relaxed/simple;
	bh=1hogxnuECIzSV/Tm1A6DPdaKyUbceozlacoXk8KBzwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA4z8H/c5C/tPxpuVeZtWmwczWdBV2PMvshutya96Vjf3Krz7snDqM9du0BKKdXyfdPk9XlDK3QiTLDo6zWDmsd+clCJzmqCqj0RgTOu62SSIdqd/ftOOwrcbZi7ddd1KWdqx3vkgk/gcg5eZXUD4bBiGGAejuaAHqQH88ct2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzKjMpVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDA2C4CED1;
	Wed, 19 Feb 2025 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006809;
	bh=1hogxnuECIzSV/Tm1A6DPdaKyUbceozlacoXk8KBzwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzKjMpVZTHiOg2EJoOlVL4olptH5P+B4qffLfXz7wGY66guDlrYX+4e5KUQkW9sKY
	 6R2AFlEJugpdEnFSQ/H2mlGKdXx+tdG3k60h6YqhneYWj1cIjubwOvc8uf0lWHFl24
	 GgA+JrgVRpMpG56fLXy48jK7Wbe8yPsBC/s9M8RoqDFRCgNcV26n7c4r9PLszkqtr3
	 F58GOyDBrW/fBfUUInEQz3HpjhKovHygjHOpeEinKTG+VCqsXO3B0oT61JLltE1rMQ
	 BxWYAOUo22Dhf1nKmmHbXpWSW9L7WEbKobvm/IhASjJ5FS/bntuL24BQh7wgdjowg6
	 A+oCUMMd+oG3Q==
Date: Wed, 19 Feb 2025 17:13:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, festevam@gmail.com, krzk+dt@kernel.org,
	lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, shawnguo@kernel.org,
	tiwai@suse.com, nicoleotsuka@gmail.com, conor+dt@kernel.org,
	perex@perex.cz, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	broonie@kernel.org, Xiubo.Lee@gmail.com
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: imx-card: Add playback-only
 and capture-only property
Message-ID: <174000680771.3151442.2014916167117128565.robh@kernel.org>
References: <20250217021715.284951-1-shengjiu.wang@nxp.com>
 <20250217021715.284951-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217021715.284951-2-shengjiu.wang@nxp.com>


On Mon, 17 Feb 2025 10:17:14 +0800, Shengjiu Wang wrote:
> Refer to audio graph card, add playback-only and capture-only property
> for imx-audio-card.yaml for the case that only playback or capture is
> supported.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  .../devicetree/bindings/sound/imx-audio-card.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


