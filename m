Return-Path: <linux-kernel+bounces-416703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D09D48FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969631F22F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A5F13BC3F;
	Thu, 21 Nov 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKsvwfjA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3115ADB4;
	Thu, 21 Nov 2024 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178373; cv=none; b=bDuiMzPviXOsY7IxFSau6X1SY63zeH7/z6+ERM8Ir95tn4/FHJcYf49a/z3C5rcQfCM7INWtvkId+uULfllJFbLiP6+ONye46sH9N3r01nKVT3o+LwJ/muFV134lOc9NZZ9hIEsdVohUd3O4vAffJWij6uhxp8ns2h6lCUuKbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178373; c=relaxed/simple;
	bh=SUvWzbHGe7kApkeBmO6P2id2KlN/J7nuQhPn4eL2GIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+3gNhmUrybZvgebaTJcSGOfhGiyvWkjQKr9an2i2HuctfFFLvBXi8zrI4iQhcrGGtyKvpCQOHNYP4p8ch6N1YqURuA99e3edhUCLBwpdblk31/rVc9SBNYA0sv6SAY4txIsq0OMkdtQP731gHMM4pAjsOzEJpPF0sasSzON52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKsvwfjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E740C4CECC;
	Thu, 21 Nov 2024 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732178373;
	bh=SUvWzbHGe7kApkeBmO6P2id2KlN/J7nuQhPn4eL2GIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKsvwfjAZ6SGQoFQEVeGNmAIkbQkY477sov7z1nGhsTVAXulxrk7umXUn1ZbJDzha
	 e5YoQG1nbBXnmLiBCX6ASPmve/V5n3WjfecR2IO8hDKD9M0l4zmVk+iE1DOVaANvUr
	 A2pHOMwTsvZRVr+/A/LK1XVstnPv+1cm06LIaGicbSL2uVIItj3HaVGtwVdpQT2DlT
	 JtaizkXMAwgtphjzkdHVqijdl/q08BiE6MO4TfPraoP/zBgYWICw+bVE9iFumkAN+k
	 2ZFsN93OCPMBkuJgnLxmpvxgVCd3z4l0b5/i4yToeGONZoLtxKTO2IiqCv7iFArc2l
	 1Oog9ipylULig==
Date: Thu, 21 Nov 2024 09:39:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/6] dt-bindings: display: mediatek: dpi: Add MT8195
 and MT8188 compat
Message-ID: <tutddhqzp37frzi7fkvljrjemfwfmcfgv44eetaalodc5pmauc@h4hklzisfyfk>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
 <20241120124420.133914-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120124420.133914-2-angelogioacchino.delregno@collabora.com>

On Wed, Nov 20, 2024 at 01:44:15PM +0100, AngeloGioacchino Del Regno wrote:
> Add compatibles for the Digital Parallel Interface (DPI) block
> found in the MT8195 and MT8188 SoCs: inside of the chip, this one
> is directly connected to the HDMI block.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


