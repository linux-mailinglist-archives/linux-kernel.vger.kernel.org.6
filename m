Return-Path: <linux-kernel+bounces-522643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E971CA3CCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21747173695
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673225C6E1;
	Wed, 19 Feb 2025 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5yHDyHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2D25B68C;
	Wed, 19 Feb 2025 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005726; cv=none; b=nufi9WC+0bldB4yzwetixIHFWo+A9D1EDjYDJP3zT9uwZFB+jlAEz/yAU43kRiUL/JrC9S5DONDkraPlhSWVgZoxFidtzDqbNhIPj94ysJNAykY7jicZDSXEQUSHD5KsjWX7b83n3xzHTXWRbNamMECNP2AWl69MleAzBOJaxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005726; c=relaxed/simple;
	bh=yPOGyniujTU3i3EYp1mV5Ro0Ed1aoGTxmIBahrWVhCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2nWL/mAC5giwIsSkNfHAtBRK4RrtxL+Tp/nSOBFPBDSkWPAyRraM3ZLoJrPxJHgsj1qg7sDsdaPBq7WERn0Gji8sWXOfmfKTxCaSHmXK73LuLaA/TwqjmFk+NZwDo9A+2OlpOuGwFLpnX/yKymGnhWqMsPNFAP+4814i0aGQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5yHDyHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05BBC4CED1;
	Wed, 19 Feb 2025 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005726;
	bh=yPOGyniujTU3i3EYp1mV5Ro0Ed1aoGTxmIBahrWVhCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5yHDyHfKflXsCv0KJrRUoPY2Qu7zHAmEi0xb0kyFMVA9rHPPQa0uOJZlUm/NNe8p
	 zRYzB71H5qGooCPgnngDsHEdJJZJ08HdEbTdlohCXYoMpsaHkAsULAmUgUD2Py71S8
	 zTvERcwWEZfBX6ZqHuXel7JF65LjKx5Yxqhsbg1rwffkiZCtLakUnKz7zyG2yMcwrT
	 nJ+aMWJbM65I+tUPhpoWEvHpLz4kfqySFJU0/mp1adrKUHXyG+MffU641dvoM98Flr
	 1ncI1iDXIB9qTXFZMmCfBbwDQgs3nz3SxQKJUMWtnI/C1T6AJY4vuk4e/fQzlSmK+2
	 wCRkYSqliAxYw==
Date: Wed, 19 Feb 2025 16:55:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Trevor Wu <trevor.wu@mediatek.com>, Takashi Iwai <tiwai@suse.com>,
	kernel@collabora.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 mediatek,accdet
Message-ID: <174000572376.3122081.10881553608590420273.robh@kernel.org>
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
 <20250214-mt8188-accdet-v1-1-6bbd5483855b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214-mt8188-accdet-v1-1-6bbd5483855b@collabora.com>


On Fri, 14 Feb 2025 12:14:29 -0300, Nícolas F. R. A. Prado wrote:
> Add a mediatek,accdet phandle property to allow getting a reference to
> the MT6359 ACCDET block, which is responsible for detecting jack
> insertion/removal.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


