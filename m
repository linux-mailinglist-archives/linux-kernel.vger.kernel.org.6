Return-Path: <linux-kernel+bounces-171820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518C8BE91C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9890B1F210E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABD16D4D1;
	Tue,  7 May 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijxKTfvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E816C680;
	Tue,  7 May 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099348; cv=none; b=pH5Fq6uXFWjJOw+rO24i8QgRQZKXoI9UKVUEN0TzXH6K1LC73azwxVXs44TiKSsPyQt34ktDkNSJ6NTsRi/BYNIFAb4L5s0CEqVqJ8IcRpOj3ySW8U2oqFC/TcaR+nZgeH5kSDvaO2GDHkq90D1e/lJ3vmpC0FLLTFvrSggu6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099348; c=relaxed/simple;
	bh=dPChBTgN3pNTkEs39qbzPGhdirgHNSrhYcFvG2Sfkig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcMvRvYRxA/VA35bley+FDE5NnwwT5o4x3M3PWyUKz41OFeXqnr7Vfm5YuH8/0dkxdQzjPKuedBKgP+hOstNfFNz7QG/Oa3PSDpCVbPBTo7tGJsEDoFHZBWs7s16lSMrN8oxbleXtsqE8DMG2bKt/EFKGVG652dFokXj7TE0kkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijxKTfvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46773C2BBFC;
	Tue,  7 May 2024 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715099347;
	bh=dPChBTgN3pNTkEs39qbzPGhdirgHNSrhYcFvG2Sfkig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijxKTfvRkApxZcFjD7YQUsrymcqd0uU5wkvTKh8iVf+V2joVZVCh4S0KkksoFOgQ/
	 PdCi8mwlCTk3PVsr/DzOtfJ1w30aDzpnprrCH5qzuWkQZ92+ME4Was184IcA45XsRd
	 IfcxdKKZ33G//bqXMIYFDZ2wkuK2DS6vIxqY5wpCFElnwl22ivwCVZTyZ476JvXm4J
	 f21KYREQSE7s+GKnfG9ft5ENAQ7EVSW5hv4pNRzZEV/PeM9j5gxpXHeFsiutys4k31
	 9i49qlIxn60d/Zg9Iw2rGgxEJpklq0KxaYUtsPUb6jUQztNFfp/lKTN0+axcqipD6w
	 MhljztaFM37WA==
Date: Tue, 7 May 2024 11:29:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	devicetree@vger.kernel.org, matthias.bgg@gmail.com,
	wenst@chromium.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, conor+dt@kernel.org, p.zabel@pengutronix.de,
	jitao.shi@mediatek.com, ck.hu@mediatek.com, mripard@kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	shawn.sung@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
	dri-devel@lists.freedesktop.org, chunkuang.hu@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, yu-chang.lee@mediatek.com
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Message-ID: <171509934047.820109.12693254267558250910.robh@kernel.org>
References: <20240502115622.248456-1-angelogioacchino.delregno@collabora.com>
 <20240502115622.248456-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502115622.248456-3-angelogioacchino.delregno@collabora.com>


On Thu, 02 May 2024 13:56:21 +0200, AngeloGioacchino Del Regno wrote:
> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
> per HW instance (so potentially up to six displays for multi-vdo SoCs).
> 
> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
> so it only supports an output port with multiple endpoints - where each
> endpoint defines the starting point for one of the (currently three)
> possible hardware paths.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


