Return-Path: <linux-kernel+bounces-310262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE71967730
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068AF1C20C85
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5317F389;
	Sun,  1 Sep 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CtwVuYsR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18214B08C;
	Sun,  1 Sep 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725203904; cv=none; b=iCP9Vha82ck58P19G15vBbDwgkuzxVn2PQtkKZN+bF5Iwa163yNhHLgfHXpri5iOrsp6RoCe1vZCtmqwyJ+DhJZyYQM5XXrQV0ly6hk15iJ3fnCaNdNZ3mxKfFCGfLMDnFG884N7WFs09OZ3bJWIe+JQ0wC9FRzegT09uYOmQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725203904; c=relaxed/simple;
	bh=wwddOlMawN+jDA0/PzDOzw41cjOxFeVpe04rgDXwZHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX9ZoIMnQ+0GF0XVhSpLYYwcaflvx4gx9K91TL4+xBEpyRGGhXizkEEzBH+dwBM1u/53K9Bnedzc9hI2u5Jb/1/ykgUJd9wThAKPx8UYv/E+05vj8yJRfLYVzBAJfSpKU+748JUVGFL5LZmY4L/z66d/AKwtEsCP+57RqsLBzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CtwVuYsR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C785F51B;
	Sun,  1 Sep 2024 17:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725203826;
	bh=wwddOlMawN+jDA0/PzDOzw41cjOxFeVpe04rgDXwZHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtwVuYsR8BPW47fJK6FPqZdzCOxeaPxEBRybyBx6M0y96lqy5vx6LWGTCCOnj01vo
	 LE6rTCqqVihUnMltd9NbRRtKuEcB+qZvuCayJmB/F1RYRaGHXRLqqUjG3XjV4PyeCl
	 dILkIx0guL5MBZ6Nfhh2i39oUAzDM3nN4qrnGmGI=
Date: Sun, 1 Sep 2024 18:17:45 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: thierry.reding@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: Re: [PATCH] docs: devicetree: Fix typo in lvds.yaml
Message-ID: <20240901151745.GB6713@pendragon.ideasonboard.com>
References: <20240901133046.962263-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901133046.962263-1-eleanor15x@gmail.com>

Hi Yu-Chun,

Thank you for the patch.

On Sun, Sep 01, 2024 at 09:30:46PM +0800, Yu-Chun Lin wrote:
> Corrected the spelling in the description of LVDS Display Common
> Properties.
> 
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/display/lvds.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/lvds.yaml b/Documentation/devicetree/bindings/display/lvds.yaml
> index 224db4932011..b74efbea3be2 100644
> --- a/Documentation/devicetree/bindings/display/lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/lvds.yaml
> @@ -16,7 +16,7 @@ maintainers:
>  description:
>    This binding extends the data mapping defined in lvds-data-mapping.yaml.
>    It supports reversing the bit order on the formats defined there in order
> -  to accomodate for even more specialized data formats, since a variety of
> +  to accommodate for even more specialized data formats, since a variety of
>    data formats and layouts is used to drive LVDS displays.
>  
>  properties:

-- 
Regards,

Laurent Pinchart

