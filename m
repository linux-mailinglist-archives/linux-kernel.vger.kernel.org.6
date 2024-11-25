Return-Path: <linux-kernel+bounces-421194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0349D88B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E4AB3F136
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0D1B2184;
	Mon, 25 Nov 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXonjeSb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F5184520;
	Mon, 25 Nov 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544460; cv=none; b=dPt5Ou0w6U1Cwul3nklo1KIJ1SCskg9miDbjNboNg+L0dNWUnY0UL5oNL/eP+p85fuR9kZZwLYztX6SCBGj18MLhKViLKL5AU8Kn8JQAS4pg3mziAUtkIo2blfskH9G08zLU9jUob0+Nh5/S27n+5MztNQZAG0pxrRyd8ebkVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544460; c=relaxed/simple;
	bh=BJFiZKZUiXJdE7BCJYHoYsMcMtEgwgFeoIpU0YaHwZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVPwWIg3i01bZWSzLcJoj3CAWcg1wi8hFKYNNvtIMk5DsWeV5jg5RSBefHv17JLVuPeouFF+9pj7mFS9fhwHZ0Q529h+0oElnaurRDRMajqa70gTgYl/osv1lGRDNf86Le9n4fqIl/tnSj3IigoEKtk4zv3K+SfEAe/qnXOu3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXonjeSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81285C4CECE;
	Mon, 25 Nov 2024 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544459;
	bh=BJFiZKZUiXJdE7BCJYHoYsMcMtEgwgFeoIpU0YaHwZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXonjeSbIogq7Uq/RghIOWPdWN8cjsFRN2ihUVNV8/bk/P143kThC1A9GVr6KeWcf
	 KqZChTETZ1o0zy6DffOnTQPmN7qtnfOeeOgwghrp83BgP8XUYAgkyo1sf7CyISsMVm
	 zito8LvVZfMXFPol4R6tqGwviWexBKIdmzShqSKTCexDZGP0944/MdvJ7BUbsxlsq0
	 EtufmCYr5lgilXi3ITkGqHiYz7oleh70Y2+woevEEP+wogwSNgbZfFE7h7HFtmLBu1
	 k00RiqAphCsVBBJ2jsZ/R1c4w7vPLZLsWOwqf0YIY5BCqJPsoWjJ+6k/z6ttt04JSr
	 tH6a6lJZH5wfg==
Date: Mon, 25 Nov 2024 08:20:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <mripard@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v6 2/5] dt-bindings: sound: Add Allwinner suniv F1C100s
 Audio Codec
Message-ID: <173254426800.1714666.14026732187475007449.robh@kernel.org>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
 <20241123123900.2656837-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241123123900.2656837-3-csokas.bence@prolan.hu>


On Sat, 23 Nov 2024 13:39:00 +0100, Csókás, Bence wrote:
> Add compatible string for Allwinner suniv F1C100s audio codec.
> 
> [ csokas.bence: Reimplement Mesih Kilinc's binding in YAML ]
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>  .../sound/allwinner,sun4i-a10-codec.yaml      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




