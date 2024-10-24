Return-Path: <linux-kernel+bounces-380147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D429AE97E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9418AB23F87
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260D1E631A;
	Thu, 24 Oct 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBQelTu7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33D1171C;
	Thu, 24 Oct 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781974; cv=none; b=g9lnrU88YlHjqvCEVcEvie2i1WlCgr2Vsbb2RkOAvddQF7YAt4+KFg0uNmyxa8VOU7KXxIGj9MtSt73BlVcQGXx8+VQBU9kISFmU4bRLiH2qraccV2gRZ1l93oqAD2ZlCkRsKZ8vVHxrlI0uTemjRBwd9lnLLqJMrD+bYLRarIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781974; c=relaxed/simple;
	bh=bFUPoVTwR+LD2fnyv1D32C7lR3TZAYehUcOgaQ/4Z7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKjk5RN8YUltR/D3nwANi33V9eCeWFIFNM1oomwL7rvIMxd8VQ4CAU5UaqkBsoGlWAO4P3xiwYbEMBN+kzuAS4g99qlXHFYy5T1JqSjiyWDUlKQxfiPCwWnI9YKYy41FvH3koSPZo7fjENElJCohfzet5s/Sn0UjLVX5qfA01XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBQelTu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEF7C4CEE3;
	Thu, 24 Oct 2024 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729781973;
	bh=bFUPoVTwR+LD2fnyv1D32C7lR3TZAYehUcOgaQ/4Z7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBQelTu7RsacYF7ntupGp5OmBIuDZp8G/oBlyKiJ1Zhy7rT3gVuEkHLpu1jJHr+JX
	 V2c2+DVmBFnrjZ7CStpsBed+a8x76OExN38GQAWff2Z0MHoBCLH5xy6UIoJ+siu5cN
	 ERMFEs5jnOowX0A/UBS5Ih4VQF9EEyD5BRfdwNi3mceGm3H2B5xpTmlBfcgqBRwCrn
	 W7l34iZQy/z2PvE8x6pbWd06KFsQR6IjjV7ObkfafhXL95aNIKh64H1m5c5ZQNdRBY
	 Sz5ABXsOs5KQtjhZXg89nrmn50ci5aF/wTXF2fMzk9mbhf9bUlXJas+KxvevJUMs77
	 eMm2PWXRCn3zg==
Date: Thu, 24 Oct 2024 09:59:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Conor Dooley <conor+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com,
	Hector Martin <marcan@marcan.st>, Neal Gompa <neal@gompa.dev>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: Add CS42L84 codec
Message-ID: <172978197165.427885.15072999949261436967.robh@kernel.org>
References: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
 <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>


On Sun, 20 Oct 2024 00:47:31 +1000, James Calligeros wrote:
> From: Martin Povišer <povik+lin@cutebit.org>
> 
> CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
> computer models starting with 2021 Macbook Pros. It is not a publicly
> documented part. To a degree the part is similar to the public CS42L42.
> (The L84 superseded L83 seen in earlier Apple models, and the L83 was
> pretty much the same as L42.)
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> ---
>  .../bindings/sound/cirrus,cs42l84.yaml   | 56 +++++++++++++++++++++++++
>  MAINTAINERS                              |  1 +
>  2 files changed, 57 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


