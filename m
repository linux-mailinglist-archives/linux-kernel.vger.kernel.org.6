Return-Path: <linux-kernel+bounces-573454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D92A6D782
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1003A7620
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226DB25D915;
	Mon, 24 Mar 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA98kcj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614210F9;
	Mon, 24 Mar 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808846; cv=none; b=gdMc2hbOompzJMl+mEMopwY8frlC6u6I9yJ5vagkPyTe+fEVBDZqWPUA+DgNVDCEaUHXW5GRDPc/CaeUU6nrKJdlofvG+8GNLGKZLIM94me8FyyPWVCBEpdbNs6gcXmoUH7fbnaGsOvbjkI8DgPvtuE+luSdYfn5p6ymzd2a9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808846; c=relaxed/simple;
	bh=FvQn3givm85EANWlfsUtGcpdsUFHMIzmUrIJkbrLKlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePNNX6T5kNeCJw4MSZZ+N36Qa5YFTfJdZIUqZKidUmYsH63ursTbBUl3foCmyw8H5LMv0TPc6MEaNE25i3YAAhCCM1oHwsCgQ/Lt+7kByptcU07LbaE0B3qhSym1Drh5/NL3492ZtTj0ifkPXFJlULKb1vrbq9pDTFlcm4tYJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA98kcj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF6CC4CEDD;
	Mon, 24 Mar 2025 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742808846;
	bh=FvQn3givm85EANWlfsUtGcpdsUFHMIzmUrIJkbrLKlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HA98kcj3d+kiZI2Lofc3n1TBAGS7wYTceRz1BVXH62/B4d5TNdiIjqZNskJcWKKtz
	 Vpjj0auztCgtdivyZ/WHR5b0zJT8QvR6jSYk4wTuy+2oYygLaULIWN+HSsUQ7Uo3/P
	 1BZnR8plpgEWS3OmPmzjY6W/VBMYs6kI2b9dOLVchttfqBHLuv12TdXHDscJIA0lyz
	 SoJ7xwUJoBzbbUejhLYLX84VY5pUXIVbxht9NSjtO5+M0J+BrMPKVlEzZ2FVCgKbmu
	 wUoN4brf8KOLM6bRVYbq25XEeBlzOUX52q99zgulHr/en2hem1Hd0sToceVrHw0ALw
	 gQx/wmwyQHGrg==
Date: Mon, 24 Mar 2025 10:34:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "paul-pl.chen" <paul-pl.chen@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chunkuang.hu@kernel.org, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	p.zabel@pengutronix.de, jason-jh.lin@mediatek.com, nancy.lin@mediatek.com, 
	singo.chang@mediatek.com, xiandong.wang@mediatek.com, sirius.wang@mediatek.com, 
	sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 02/15] dt-bindings: soc: mediatek: add mutex yaml for
 MT8196
Message-ID: <20250324-amusing-pearl-yak-9d925a@krzk-bin>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
 <20250321093435.94835-3-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321093435.94835-3-paul-pl.chen@mediatek.com>

On Fri, Mar 21, 2025 at 05:33:31PM +0800, paul-pl.chen wrote:
> From: Paul-pl Chen <paul-pl.chen@mediatek.com>
> 
> Add compatible string to support mutex for MT8196.
> 
> Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml        | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


