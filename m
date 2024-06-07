Return-Path: <linux-kernel+bounces-206305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B51900799
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2422029126C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3D19B58F;
	Fri,  7 Jun 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="EVyk/tlt"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A713F42E;
	Fri,  7 Jun 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771547; cv=none; b=h84qou6TDzZg877QMAw9Rpxqo1VqIwlIDoj/x3H0tsy+qrNFK+PJjmIMUwejnkFKblPlPasTjZa7ivX9TwQx7mkHFd9X4MSwfAif8OMpvBghvLR6kt+mvYXqbXRP9feSIYZBBUePZNpjgRcfJGFlaHgwQOlFpBP/EHeBZ6hvzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771547; c=relaxed/simple;
	bh=+26zE7pepphgrDVsnqvGEVAq//JALxnWLBjwBy3WjA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeYcH3w03SGdSTT7RZUckqCSnqf/79dIwly3YJnNmxaKNrlAw6S8iUVKzfDjrkfLqmOCLGcSDyPc89xDxv/F5ELceEFsW5M5wSXqKnui+sS8WtqZFB1dt7blT5yfnNy2Jn1m+8LZUCyHb8os93HyjcaLZY3ZvCHG4yhBcgfVhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org; spf=pass smtp.mailfrom=tronnes.org; dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b=EVyk/tlt; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tronnes.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=0pBBebWaKItSZZvGMg+oo04bl3J9t4F+/w8mYuUg+g8=; b=E
	Vyk/tlt0i/iV9mQcEq11i6SevJJysuk7swmpFjcu8RhPQkRNmczBLfrk8FrjPzuQUzM0dFIphbid4
	HTUyIn0ivC+RYyvkR/DUMzLyYE8tJATa2TN2YPPrzHYPji3zO33H3YMBVE6wboJh3RF310ZpKZf3b
	ZQy2iPGBVe8fwhT5BninUVixCYGJxU9WkxdVsAZDiC+vPkoSvfCH265bKar765G63F0sYSGfXWWHj
	MOg7AR010IIYjXIZNikYdjpko6auijngGej5WjtJ51qttMsYCMCRjuxnLcMs7Pfj8AvCWMkoU1dVY
	oCl7gR84/C0WZWvIvhW+/lQVKGBgpSoHw==;
Received: from [2a01:799:962:4900:815f:3dd0:60d8:6458] (port=56414)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <noralf@tronnes.org>)
	id 1sFaqc-009Va2-0S;
	Fri, 07 Jun 2024 16:45:42 +0200
Message-ID: <6537508e-8a67-42d0-911a-45e14852f818@tronnes.org>
Date: Fri, 7 Jun 2024 16:45:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] drm/tiny: panel-mipi-dbi: Support 18 bits per
 color RGB666
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
References: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
Content-Language: en-US
From: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
In-Reply-To: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 15:20, Noralf Trønnes via B4 Relay wrote:
> Hi,
> 
> In this version I've fixed up a commit message that I had forgotten to 
> write before sending and improved a struct member name.
> 
> See version 1 of the patchset for the full cover letter.
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---

Thanks a lot for reviewing the patches, applied to drm-misc-next.

Noralf.

> Changes in v4:
> - Expand the commit message (Dmitry)
> - s/emulation_format/pixel_format/ (Dmitry)
> - Link to v3: https://lore.kernel.org/r/20240603-panel-mipi-dbi-rgb666-v3-0-59ed53ca73da@tronnes.org
> 
> Changes in v3:
> - Added r-b's to patch 1 and 5
> - Link to v2: https://lore.kernel.org/r/20240512-panel-mipi-dbi-rgb666-v2-0-49dd266328a0@tronnes.org
> 
> Changes in v2:
> - binding: Use 'default: r5g6b5' (Rob)
> - Link to v1: https://lore.kernel.org/r/20240507-panel-mipi-dbi-rgb666-v1-0-6799234afa3e@tronnes.org
> 
> ---
> Noralf Trønnes (5):
>       dt-bindings: display: panel: mipi-dbi-spi: Add a pixel format property
>       drm/mipi-dbi: Remove mipi_dbi_machine_little_endian()
>       drm/mipi-dbi: Make bits per word configurable for pixel transfers
>       drm/mipi-dbi: Add support for DRM_FORMAT_RGB888
>       drm/tiny: panel-mipi-dbi: Support the pixel format property
> 
>  .../bindings/display/panel/panel-mipi-dbi-spi.yaml | 30 +++++++++
>  drivers/gpu/drm/drm_mipi_dbi.c                     | 76 +++++++++++++++-------
>  drivers/gpu/drm/tiny/panel-mipi-dbi.c              | 55 +++++++++++++++-
>  include/drm/drm_mipi_dbi.h                         | 10 +++
>  4 files changed, 147 insertions(+), 24 deletions(-)
> ---
> base-commit: 0209df3b4731516fe77638bfc52ba2e9629c67cd
> change-id: 20240405-panel-mipi-dbi-rgb666-4e033787d6c9
> 
> Best regards,

