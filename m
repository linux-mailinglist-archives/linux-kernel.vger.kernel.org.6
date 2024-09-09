Return-Path: <linux-kernel+bounces-321747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB68971EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EB11C229D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054413A3E8;
	Mon,  9 Sep 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6eckzBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5DC1BC44;
	Mon,  9 Sep 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898385; cv=none; b=l9WWhZJ8kVYn4t3GwL9dBym9NcKBIYpc3kI6gEGWZYaZUrncJ77q8keBi1ffMugVz22SpJLD547AetRVPosNyKZk3WEYwkaCQeeiwfui3e7vh1IHpY0E6MkZ67v5+O5nYDcN0zlaKU5GhpXMCreAEFGF+nBCSWvofXYGgAlfY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898385; c=relaxed/simple;
	bh=CuPqv1XEUhjryvlD5DFL0yvyN8vD15Z5qVwFtffbYFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgSI/+HjWXiprWVYaFNxme8aIl/9syOlpNxWXmG8jzAUwnROoSDGnkc+eG50BiMHhBu3+asn/071toTDsK3mFvIpv2/2IyVNu8mAgJqrjMGwmjs4CKK5kAllDpYhsPUxdskrWH+Wx24aqYh2z/vbHm9gpEv0Mk7kDJCl+Og3+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6eckzBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C64C4CEC7;
	Mon,  9 Sep 2024 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898385;
	bh=CuPqv1XEUhjryvlD5DFL0yvyN8vD15Z5qVwFtffbYFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6eckzBV0VzGP6AGdvzfU2yA/ueT9Ys5uRMS3aUrhI0ZMZJ/qzpRVxEOLUqga+ZEv
	 CoJ/mfkd2O7K42XlmPMafpEXQuCNp51j+6/kuvKgSsoEPl4HhzoapdPjLBdEiZ6Yr+
	 4AMbxfYkq2HNhBqjH7ZUa9g7o2fNEZWBQf+K0UVbZyuVV0hYRientqjlCx8607gVHV
	 LOs2dEn/0KKakPnBksbDH7eWotc2HBsE4ERksdmYTm1OQvQ/drTkc8Hxq0F4OHFlOc
	 nGbPyjYt99p1Utl5eqBNo2AEyUsulLNTNySsPlTTunbxW8UwO9vYEez+mOxOCxCHxJ
	 Vdpf8zKEkszCA==
Date: Mon, 9 Sep 2024 11:13:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 10/13] dt-bindings: spmi: spmi-mtk-pmif: Add compatible
 for MT8188
Message-ID: <172589838295.312976.17005993093788269336.robh@kernel.org>
References: <20240909111535.528624-1-fshao@chromium.org>
 <20240909111535.528624-11-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909111535.528624-11-fshao@chromium.org>


On Mon, 09 Sep 2024 19:14:23 +0800, Fei Shao wrote:
> Add compatible string for the SPMI block on MT8188 SoC, which is
> compatible with the one used on MT8195.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


