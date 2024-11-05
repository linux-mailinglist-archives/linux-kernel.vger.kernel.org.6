Return-Path: <linux-kernel+bounces-396597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506419BCF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814301C22DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B41D9588;
	Tue,  5 Nov 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogheu//N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D51D8E05;
	Tue,  5 Nov 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816831; cv=none; b=XF/1GgDkyDLImBtXEb4EhWozbl/i8NzTlW13HbcDVkR79v3dCCpEkOfLt1Eh9nNW4mwjb9MJuaGYh+YCFTAZG2VPADgVBfOsw/JYvijqtSwC86nQ0qKIAgY8J9RV2luVWJg8LJLqF7zmGnl9C3QKLKVzvb+WKrARPx0FABkoHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816831; c=relaxed/simple;
	bh=H9lnLtemQ/eUrm6ZowUvs0U4ycXB0QN6ws8h/hIo9/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKh88bdAqH9HFY3w/SaMgo0k6Du9vqGxyXkm4BuqzWzRK94O9d4TDqJ+vbmb1JXxG1Rk5xbI5JGV+H0DUO935KOSDhOLYJbxMitGZGIG5zkDX1ESBJASsKOECBXsmV64eBXyEilthHdvw8Sg3Di/9a6gNmYxp9ymCeHtyZVOXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogheu//N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D3CC4CED0;
	Tue,  5 Nov 2024 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816831;
	bh=H9lnLtemQ/eUrm6ZowUvs0U4ycXB0QN6ws8h/hIo9/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ogheu//NIDOF8rIG04kMJnc8LFupeuSjfNXm5VShLhda4WRd4NVbJXKt4bczFS3mj
	 FupDNUsOy7m41/xyyPuPM+vkL6JTwzVUmImMQWikHeQZaB0KRKZfEYuBJ4XicDAwAX
	 AsMigEk1+Q728CPS52aYB6Oc3b10XMSFg57tWEYwbpKq1PA1K5xdveK45YZ9C9O6FW
	 2owv2l+weBf2rBtzNawO1P737eFBC7v250BWjA1jaqbVThDaGiLsgGcT9FTNK6HMQp
	 TmyBka1xWcHVWrC72ot5uxqJYbB2xB+Y6GOiohoj5aM7IWH4/RHENfyLQ0/hcuU4AW
	 NAzSFvX/q1pvQ==
Date: Tue, 5 Nov 2024 08:27:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: mediatek: dp: Reference common
 DAI properties
Message-ID: <173081682847.3210195.439507232582613661.robh@kernel.org>
References: <20241105090207.3892242-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105090207.3892242-1-fshao@chromium.org>


On Tue, 05 Nov 2024 17:00:28 +0800, Fei Shao wrote:
> The MediaTek DP hardware supports audio and exposes a DAI, so the
> '#sound-dai-cells' property is needed for describing the DAI links.
> 
> Reference the dai-common.yaml schema to allow '#sound-dai-cells' to be
> used, and filter out non-DP compatibles as MediaTek eDP in the same
> binding doesn't support audio.
> 
> This fixes dtbs_check error:
>   '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
> Changes in v2:
> - reference to dai-common.yaml since the hardware exposes DAI
>   and update to `unevaluatedProperties: false`
> - update commit message
> 
>  .../display/mediatek/mediatek,dp.yaml         | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


