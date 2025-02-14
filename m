Return-Path: <linux-kernel+bounces-514597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91741A35912
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5968F167079
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39F6227B8C;
	Fri, 14 Feb 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxINyX1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20F1F8908;
	Fri, 14 Feb 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522421; cv=none; b=t2miGPj75YYxfODN2XKkR3WfDRoFIlqNOYE5SxSSY37qxT8oG3chfhb26RgQCj+pt1gqHgSdV+T5H/6anf8Wf1P4bSR5wxSO4gs1iI9YnNj8PBEnGnnQb8Qi/2wOwiJNgsHmeoHOGMikhUR7YEwpYpO+pSZqcqOpSwriGGjd+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522421; c=relaxed/simple;
	bh=YE4l8V3UVTEVbSPXutJ4j6Y6NMn523OYmOJG5yYkcjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRzqTg1SRKymRXw+/QtzzpibCpi2DG3pFeh0Fesv6KDIDdyALYrMAIBWHTntPKLmfvdoddLb2xtvBylx77O9LR4sR+7C0KTqTMQV8YY0jYkqMfcE//QYkDvprO6iCIxvUa2uMOigtjPOwOChsqGNKb+HtNL77297wrV3d5ijWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxINyX1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6005C4CED1;
	Fri, 14 Feb 2025 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739522420;
	bh=YE4l8V3UVTEVbSPXutJ4j6Y6NMn523OYmOJG5yYkcjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxINyX1nsva9oK8xaDH5WHmRvU01UOW+REYlhjfVDrEpNU6+U56EAL9RwOXo95DNB
	 7XBTBPaSi0G7m/Xs0liBIg4I+e06vkyyR2ealXUjZkTkwLZWYOF318xBUOJyytKNdF
	 cjNehgtBM61B9JadQkJiimYpwpzWNke42cqAUXi+aM8ZVfBH7lS7n6MyywYjwwZX2D
	 75LlyJhFchFWEMQH9boTW6UAptsFmDLqaudauFkPFIZiq1X+ADDIwL+c07xDoq0IH2
	 SGHv/PJHYTS8VqT3p3NNcHrpIqheXwleoSgmispXJxDb32yPv7KY/7ih+J3QkYiCjQ
	 tKz++T9bnGklw==
Date: Fri, 14 Feb 2025 09:40:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: imx-card: Add playback-only
 and capture-only property
Message-ID: <20250214-honest-puzzling-bear-b8060d@krzk-bin>
References: <20250214070533.2808496-1-shengjiu.wang@nxp.com>
 <20250214070533.2808496-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214070533.2808496-2-shengjiu.wang@nxp.com>

On Fri, Feb 14, 2025 at 03:05:32PM +0800, Shengjiu Wang wrote:
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-card.yaml b/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
> index f7ad5ea2491e..86571fa930f6 100644
> --- a/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
> @@ -46,6 +46,14 @@ patternProperties:
>          description: see tdm-slot.txt.
>          $ref: /schemas/types.yaml#/definitions/uint32
>  
> +      playback-only:
> +        description: link is used only for playback
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      capture-only:

Aren't these mutually exclusive? If so, you need proper schema for this.

https://lore.kernel.org/all/20230118163208.GA117919-robh@kernel.org/

Best regards,
Krzysztof


