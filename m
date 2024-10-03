Return-Path: <linux-kernel+bounces-349251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFD98F32A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D31F23087
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553E1A3A95;
	Thu,  3 Oct 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIRxvv89"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755A519F42F;
	Thu,  3 Oct 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970547; cv=none; b=GPKLtY/JMTR0OgQ2Pm/p8XAh5M9AMUPYQj186lxXDbnawGGMcTxII1JcMbQOJF9S+G7QLksgboizGplPKx0AT9f/yZCKN7r4hq14P75V4RsFwzwG0nD9L2J6/8tbTaMRYlZCRBnoRFlKEcqesh/chXWKkAHq6zMCK0Sc+3Gnrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970547; c=relaxed/simple;
	bh=KpbNkjpvejKKJcVq1QmIf7uP4nL6twJU3R7Siw5zTTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJkFxF+znvnSrfSaCwdeginc7GxgpIySSfJ2fFqLW3pjFtD+bHxcp2xFVd5HRw1UrOpmc159PwiSJVs2L2J7vo+EwVbtHJfSRroRuflDpIbWE+pdsOddaZxFAipLqs4X9i0/76f3DSJbop/PrvGpLAfL+s/62qFM63HM/PDcMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIRxvv89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7EEC4CEC5;
	Thu,  3 Oct 2024 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727970547;
	bh=KpbNkjpvejKKJcVq1QmIf7uP4nL6twJU3R7Siw5zTTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIRxvv89KC17m7lf7092R8WSIaQ3IIIu6RXFhdEXnxXPoWGmUHW/ODdJwAast3GLM
	 ntNVHL3hfRBvwgTTBe0nUUPn11RB2dmYirpBeDFjOnCf3KaDlE5VQ45nZneOKlqMsO
	 qqCUeq6H2TmGTz7MwByn8iaoo8EswERVrv7a+bpYfODoVB5pQCzWOb1e/Yc7eVbKYk
	 sEae6eU8nPN12N9BEDvhRliluBr0gwnS5ZMrxqPE1XHD4EuAO7EmLWdDOrtbotdYnW
	 jjCsAMrIhBAFmnAOSsg4XBeVn5NDAIsIEGtuasdXWNKfdQeY6Enb3EMBol6iycPZQH
	 1XlwnAQpPFSYg==
Date: Thu, 3 Oct 2024 10:49:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	Martin Botka <martin.botka@somainline.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: mfd: x-powers,axp152: Document AXP323
Message-ID: <172797054379.1660109.7296466787725944140.robh@kernel.org>
References: <20241003111444.543964-1-andre.przywara@arm.com>
 <20241003111444.543964-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003111444.543964-2-andre.przywara@arm.com>


On Thu, 03 Oct 2024 12:14:40 +0100, Andre Przywara wrote:
> The X-Powers AXP323 is a PMIC used on some newer Allwinner devices.
> It is almost the same as the AXP313, but supports dual-phasing the first
> two DC/DC converters. A pure AXP313 driver wouldn't know about this, and
> might turn the linked DCDC2 regulator off, as it does not seem to be
> used. This makes the AXP323 incompatible to the AXP313a.
> 
> Add the new compatible string, and treat it like the AXP313a.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


