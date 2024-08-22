Return-Path: <linux-kernel+bounces-296859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E695AFE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E691C22CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3016EB56;
	Thu, 22 Aug 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS+9ZdGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3A16A955;
	Thu, 22 Aug 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313918; cv=none; b=ijWQm7keqqyGCjWPuD+XyH/TfFnBBVCWc7GPXzjBC/fWHq3EGSXQUDUBXZws5m/IgXkmYFFUMVHfpq478PqVTOvr7sXNHfrsw0iB19y40CJmJk2K+ABMUqlslz9dy24rNie/Xv6K9DcQ09O2Z38GKrZmlVcf9Qk/pOmi1ZOFL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313918; c=relaxed/simple;
	bh=wzcR7Mwh1azPYWH7HlhLg0p7e/OQR5Zp88DKFu/CYRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENLduPXyigf9IS0ivqdcexrNw2MalNvG9fHDHRbhMc9cyr6I0BsJi9d/zDeHvkbspCL1c4Q2GE8JalmgOgwcHZ42VLm5V/ycwnwnClYqBW6yVVOLB5vbZ41eJbHbNGw6TuN6yilaoaV0JyycL2aJ9UdzjcNCLPRTk5HKRb6bhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS+9ZdGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76EFC4AF0B;
	Thu, 22 Aug 2024 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724313918;
	bh=wzcR7Mwh1azPYWH7HlhLg0p7e/OQR5Zp88DKFu/CYRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AS+9ZdGu6JUQClGjWqbtpra4pNvHKg1LIAudkqiZZsaJMYpeJTIdEF6dR0pgoWuqi
	 aB4jC76ktQJp1pRl0fvX7TkkzHgXgGzVmzpzoGPaahLWN/au2K/PQMDYdOaILAP0mK
	 MUfV7+l1kEvJYurK4ZMaxSfMIcXJMbFjmHQSD1LP+hspUIlAg5TMBv9ZtoWUIuUEfP
	 uM1EB8egTIbPSHvseKlqrhOs8dD87piVvrGlGkUJIkdD5Vw4bTyhrX50PeZ98Pm8yo
	 hs1M9QKykij2HoBz0yYc5PnYUtcEpy4JTggss+Vb8PfHLzmPLIxZ4ynwQSJkm+C7PD
	 hq28yAwqV8AIA==
Date: Thu, 22 Aug 2024 10:05:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "friday.yang" <friday.yang@mediatek.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/4] dt-bindings: memory: mediatek: Add mt8188 SMI reset
 control binding
Message-ID: <2iqqjryrwimu4hi3sgdmujc6g3qxehruxxs32k33nmgle3wl67@bcz4ahhqt724>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
 <20240821082845.11792-2-friday.yang@mediatek.com>
 <1160a651-b758-4aa2-ab13-599df8518914@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1160a651-b758-4aa2-ab13-599df8518914@kernel.org>

On Wed, Aug 21, 2024 at 11:28:17AM +0200, Krzysztof Kozlowski wrote:
> On 21/08/2024 10:26, friday.yang wrote:
> > To support SMI clamp and reset operation in genpd callback, add
> > SMI LARB reset register offset and mask related information in
> > the bindings. Add index in mt8188-resets.h to query the register
> > offset and mask in the SMI reset control driver.
> > 
> > Signed-off-by: friday.yang <friday.yang@mediatek.com>
> > ---
> >  .../bindings/reset/mediatek,smi-reset.yaml    | 46 +++++++++++++++++++
> >  include/dt-bindings/reset/mt8188-resets.h     | 11 +++++
> 
> Also, your patches did not reach DT patchwork, so something is odd.
> Maybe they got flagged as spam? Please investigate with your IT
> department. In case it keeps missing patchwork, they won't be tested by
> automation and I will generally ignore them (not apply). :(

Update: they reached now, so maybe this was some Patchwork issue. You
still can double check that you send patches correctly.

Best regards,
Krzysztof


