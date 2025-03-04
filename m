Return-Path: <linux-kernel+bounces-544374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AAFA4E084
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F117A440
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657D205AC0;
	Tue,  4 Mar 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYy5Z2oE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895EF204F91;
	Tue,  4 Mar 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097779; cv=none; b=XKJnDv4zRUs9dvjvNfFC//9dktDfL/eDpcm2kY0zzCWKaR3BuJHgY1BubauOiV07WmDkJuSn1WsBCehT+kB6B9cG9OWdArO9iH7QObBBBpVl/4JxPbb0zP3dO7QoYMt28gKn6QvU/AJtBrZPvmlJ9OJbm2R+wRWrJZCNg1bll38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097779; c=relaxed/simple;
	bh=/fDJuygvLATY6Q6bpD5+xIF7qDmEEvXLXiE7U6NBHak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsAsrYf77svd0IqIhnyvdpkSLJ2Url/uR55cOHb81wT1myLyjT21WxURez8j4BVrOclJ6LgZlNkrIiNZJodVkVM6rcGt9T++jJ/2w5MXNrWcN0LwHG3u0vE/Ank534dflzdrFG0SlQuWajhHwNxsJvWJT0g56gkRRzBC/MAHQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYy5Z2oE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BA2C4CEE5;
	Tue,  4 Mar 2025 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097779;
	bh=/fDJuygvLATY6Q6bpD5+xIF7qDmEEvXLXiE7U6NBHak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYy5Z2oEn64OFFVGg6DPbiDhNaP5JXXumw6wRUHkY43uZtj0GplsUuMS5d+bi4FYA
	 7smYu26Yea56FnqLZMzFDNzP4pw1XBAf5jkCbpNeMunjQ/0CCAfbQx4zh6wO8ATreF
	 EKHXDAqdZ0bXXLW/ojVqmaL0ZDBoHncFnufIWjSlUCOer8z6H0x4l0/7j32Go5zXtR
	 BIlr5SJ2nRa6/zvwtwgZjtlOEmKHXxz25cM6gnVWkrB4Ym3aNQkLUjnEhOOUOt4vKO
	 OTWL4zswmmToRF4xhR1C9ugxvdcN9S+9T8FO7wCEW1YZkiREkeevcdmTOyefguAunD
	 oXp4/+IxBdFvA==
Date: Tue, 4 Mar 2025 08:16:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v6 01/10] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
Message-ID: <174109777678.2543384.14004490230937287192.robh@kernel.org>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-1-ae8302358443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-bcm59054-v6-1-ae8302358443@gmail.com>


On Tue, 04 Mar 2025 07:20:32 +0100, Artur Weber wrote:
> Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
> TXT to YAML format. This patch does not change any functionality;
> the bindings remain the same.
> 
> The bindings have been split into two parts: the MFD binding and
> a separate binding for the regulator node, to simplify the addition
> of other models later (which have different regulators).
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v6:
> - Replace mfd/brcm,bcm590xx.yaml with mfd/brcm,bcm59056.yaml
> 
> Changes in v5:
> - Replace mfd/brcm,bcm59056.yaml with mfd/brcm,bcm590xx.yaml in
>   regulator binding description
> 
> Changes in v4:
> - Made $ref use full schema path
> - Cleaned up example
> - Dropped regulator name list comment
> - Changed description of regulator binding to mention BCM59056
>   explicitly
> - Changed "Power Management IC" to "Power Management Unit" to match
>   official Broadcom naming
> - Renamed mfd/brcm,bcm59056.yaml to mfd/brcm,bcm590xx.yaml
> 
> Changes in v3:
> - Moved regulator node to separate binding
> - Removed quotes around compatibles/vbus property
> - Style fixes for example
> ---
>  .../devicetree/bindings/mfd/brcm,bcm59056.txt      | 39 ----------------
>  .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 54 ++++++++++++++++++++++
>  .../bindings/regulator/brcm,bcm59056.yaml          | 51 ++++++++++++++++++++
>  3 files changed, 105 insertions(+), 39 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


