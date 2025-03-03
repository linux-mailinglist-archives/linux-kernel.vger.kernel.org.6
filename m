Return-Path: <linux-kernel+bounces-541754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7AA4C12F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E36D168137
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42770210F59;
	Mon,  3 Mar 2025 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z12p8awD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653213FEE;
	Mon,  3 Mar 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007047; cv=none; b=Fl1GJyO+UDx93l6UVIhuGYn0pZQUXKOY2D1Sop/UAFXyXbQg1M1jB+trmRcCZcWkxSApkljGjgCQEqhmg3wYqn4jCWEzWKCn6yLOxxT6Ne+9bdBBV87XS5DI0+lHqaBQ6VXzmrqmamSZ5MvQnlXBXA4Roi8U6Gl2oUyLtD6wu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007047; c=relaxed/simple;
	bh=iyUoLSPXMiRrDuj1QjSG3Se/xMam/JZHpS5wjuiJGpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnbY1yDDbi7TgiXg8Y1CWfqNcJNSq/PI9Kgyd23qiu6zfevTR76m0k4fmxY2sU3lBhSGLD5ksSIs4UnuyQ7QYX8eJHiwXQGbjXrYPdId1Jkl+PBFEBizsGVwpEW7BAn94P+Yt6H3pTBg1i6ei7XxRdITViJ4/k3SQuTI/NNarrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z12p8awD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C800CC4CED6;
	Mon,  3 Mar 2025 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007047;
	bh=iyUoLSPXMiRrDuj1QjSG3Se/xMam/JZHpS5wjuiJGpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z12p8awDHjQe/xOPfCA3gI1tAXP8mLksekgMbbmPdzcdtitUwiV7Yyq2jcz4gS2V+
	 4BvijIr4YBpjkW6eWZIkZDi/d3r2DGNMfKyB953LdUDfV9qnjhoOeNMsTiEpIv83rX
	 XPeVzEL+WOCUtd1k6U4+U7Gm3bBr4KeEEcm90UZHK+WaKtxI7rG99ASlrWEUkI9gmE
	 CLEC/Jl8RBr6uMIwCmYGPk/MGoUcHP3Sh21gIlMXISziRl1H3xZtxvRmZokhKJwaqv
	 nZeGLy69SDMhNPdTjws2M6WROHYK4VCLfaEMmlw86KA7AJ7nR2/CSMOQLWIzSP0WkF
	 1a+l8nvRzV+Qg==
Date: Mon, 3 Mar 2025 07:04:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, broonie@kernel.org,
	nicoleotsuka@gmail.com, tiwai@suse.com, linux-sound@vger.kernel.org,
	krzk+dt@kernel.org, linuxppc-dev@lists.ozlabs.org,
	shengjiu.wang@gmail.com, festevam@gmail.com, perex@perex.cz,
	devicetree@vger.kernel.org, Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: fsl,audmix: Document audio graph
 port
Message-ID: <174100704415.1424041.5644377914048631835.robh@kernel.org>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
 <20250226100508.2352568-3-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226100508.2352568-3-shengjiu.wang@nxp.com>


On Wed, 26 Feb 2025 18:05:06 +0800, Shengjiu Wang wrote:
> This device can be used in conjunction with audio-graph-card to provide
> an endpoint for binding with the other side of the audio link.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,audmix.yaml | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


