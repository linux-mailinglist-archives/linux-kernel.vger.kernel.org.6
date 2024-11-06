Return-Path: <linux-kernel+bounces-398349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABB9BEFEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4036D280DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD2520127C;
	Wed,  6 Nov 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM8W86LH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E720103F;
	Wed,  6 Nov 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902548; cv=none; b=KNLo7KfxQcclERQsH4Mi/gNQQIDCUkM4G64CUrncOPvEZ2H6mQzXfHKc2qJba3C+8XBADITjzemmJxA3f8N8uapVj8vOzc6HDJoMr2tL2pF0ELXd8EILbN8PmTIW7TKSOUhfhJ9cQz/1JLnoF36MBSXfjjdIELuJidZo0V798o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902548; c=relaxed/simple;
	bh=rvtXa1qticpSmbEDRHbH8267gmgHdH+nJ0hGrl0Dk8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMu9/s1icTG/ykMPPv6qpyWRxyWhprH25Pr6mf8R/H/HLSABHsPyG6EOD98RdNrcdhM8yOLrpOkE6zrtvcS3961eRNVpLDF8LjFWDpwoLy9WGu48cbrwYG7kbtCGrTOeLVadAhG36Te2hcmVDmSEJZbMF1etQSyCmys0hFeMzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM8W86LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2901C4CECC;
	Wed,  6 Nov 2024 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730902547;
	bh=rvtXa1qticpSmbEDRHbH8267gmgHdH+nJ0hGrl0Dk8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM8W86LHGmNofgdvSO9BnNWCw3Y5vHrZ+t6QwSoU/bWAhbf3ENoa+sMb4J9bVuUzG
	 u1GnNSYRYMR8GtHqUkLLpbmv/P2RL4VTNJzTsy+dcThk+wItkvYhxBsngqObnDNvAa
	 8BwrFX/gVrrss4Vs3itsstmOsbWSMNSl9TfjViUisO9e9bszsMIAKg4HJIzloHoe+q
	 9oAwmf0F+AqnyqEaJ2d1PTaEkx1pc8UKbS47B/NhppFfbcmGZ3n+zSj+15fMeyt8u1
	 QZ94Qt9fVe5PHF21TC9Ma+gHJzZ53NxHATwyR+pBZVUR2oOTvP88d/cLK07MTh1Igd
	 TangD9bKzWgPA==
Date: Wed, 6 Nov 2024 15:15:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: maxim,max98390: Reference common
 DAI properties
Message-ID: <quhbsusfb6ccpwl7zmoqk6ep4c5bmrjipkgofvmwsn4rda4z37@xa57whqhpird>
References: <20241105091513.3963102-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105091513.3963102-1-fshao@chromium.org>

On Tue, Nov 05, 2024 at 05:14:31PM +0800, Fei Shao wrote:
> MAX98390 is a smart amplifier and exposes one DAI, so '#sound-dai-cells'
> property is needed for describing the DAI links.
> 
> Reference the dai-common.yaml schema to allow '#sound-dai-cells' to be
> used.
> 
> This fixes dtbs_check error:
>   '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


