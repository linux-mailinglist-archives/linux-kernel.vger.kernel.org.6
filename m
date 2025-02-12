Return-Path: <linux-kernel+bounces-511667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE237A32E08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCCF3A77EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6E25D537;
	Wed, 12 Feb 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTVTLPqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4125C6F0;
	Wed, 12 Feb 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383151; cv=none; b=TD0QzFhHUFzXT7WICwAPieHfRGMugdHwl20yGAWF8O3DL5DE4xMf3f+o9bOpYzHbFXK8EIJVX9Q4ceu/EdV2q/jD4+oVuvyNH768n37iwX12SMio1yk/nMpFzmrylBF9lrUnnMydD8S/sgn2ZTWhuiEnHz4NEql+tkuT0QhW4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383151; c=relaxed/simple;
	bh=7FZmUFVS3klnUPuYRwtsVfz8zmBeu3PQo5Tp5OmlS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZDrFPcYPh1dc2uGZurRZfj6x3Q4/dnW0GV4iXpFTyf1c0IIC1/pCENC6QQnjCmJlIw2to9vzsKC4uiP6Fq10ApqzmIY/VJyr5hmAoAIPmlAu8wsEhSuBXh1c7H+7rGHLXtp9NMwFYAUQVNmXWazCE2AbW3H7SfVFSqGGH2A6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTVTLPqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57641C4CEDF;
	Wed, 12 Feb 2025 17:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739383149;
	bh=7FZmUFVS3klnUPuYRwtsVfz8zmBeu3PQo5Tp5OmlS9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTVTLPqTYziWyX/EsodjbJdGRAgyBsZ1FgcjgHib9ngGWVSjwN8UFoebeQghdGS9X
	 wXWDcM5VUkoH7ub0H64Js/cnV0lxBMAylKdMsyKjFGMBzlpzw0oL95ll4GRpoapVWm
	 pOyJlNgMhy/beoZzfOSDN+guO+jTh0JAIu2S/AwKsYMBDU0yRSd/yy8FMzxGAFe4pV
	 xso8XUhe6UMLkaajM7UCpdkHcPK7bC7K1Tg8b+o108voA3f6suAV0i7uNuOFdzz2sP
	 5VSC2TMfWImWvxPqmk4mtMDkRrxrZTlfc+mNjXFpyaXYBfLg8zmhB7NGk3lfrr+r8p
	 26HYvh1LtuJzA==
Date: Wed, 12 Feb 2025 11:59:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8960: add 'port' property
Message-ID: <173938314806.4055277.15033019734121376770.robh@kernel.org>
References: <20250207163029.3365-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207163029.3365-1-laurentiumihalcea111@gmail.com>


On Fri, 07 Feb 2025 11:30:29 -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> The wm8960 codec may be used with audio graph card and thus may require an
> additional property: 'port'. Add it.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/wlf,wm8960.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


