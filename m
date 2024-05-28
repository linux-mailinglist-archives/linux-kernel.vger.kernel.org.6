Return-Path: <linux-kernel+bounces-193073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B148D2687
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBF51F21FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357DE13C83E;
	Tue, 28 May 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1QMPQjc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C6DDA9;
	Tue, 28 May 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929500; cv=none; b=FNyxB4da1je5osDgrOpVHgJC7GseQWpfpb6o6b+N2puJ8MxqWLFitPmqBMNH97CPd01HI2c9nefzR2zNknC7z6tk3jQ5YNIg7vsWxYod9cpZPCP8pnjX0eZxU8psYaWrY4AzD+jGEOr4Mlsfs0Z7Mc2I7URSFjB1nsDl8NjHh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929500; c=relaxed/simple;
	bh=KZGpRLvaGzf5eRf8gE84byFFzEexl2hoAhLMuVopf/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bznbr81qh+xTsoCmbUCZXzGcT3tUM+R0TxcL9+iX7PdoW7nDp95hSlTUqerbunxFjNs0Kc9JuKdMXwwNMx0pxovtXCFMF0qrMO0Xq3+RFfh6zVw4whdMWJG+bMMQQzA/6qAiQc6BNAiG2i3Q9zQCinA3wtS60cpogBc91Nu8ld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1QMPQjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F89C3277B;
	Tue, 28 May 2024 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716929500;
	bh=KZGpRLvaGzf5eRf8gE84byFFzEexl2hoAhLMuVopf/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1QMPQjcETWRPrTbsNK9M1kGgrJWF5yoAOtFYkq8d0Kz6qzlSszf5ANtnbA0e0Wb4
	 BUnP/7ns7f9lUu+3MJNpc0RkqfFS3mzfsbvDyzZG5unXDIzx7odlqK/vqrIocX845X
	 yhSNfEF4u6Dcwep1Q9yKEFqmf0pbjQbFFLIrkBShF/rP/Iy3fM14PqlPER5XMIY3Uc
	 NrDHhTUrAJ0lsRNWvDvLz6RZTZfzOHvvy4w3i0/SgMe8UJUlFnW+EeDCq0Ppo3jDiv
	 /6uMYFLzqhr5i55BN44xu41syeiY55QjfH+PsZRWVOoo6vMraL+dFiOEAfsE2iKP/w
	 gaiARhU5SPtIQ==
Date: Tue, 28 May 2024 15:51:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabien Dessenne <fabien.dessenne@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH] dt-bindings: arm: stm32: st,mlahb: Drop spurious "reg"
 property from example
Message-ID: <171692949668.1975521.10425255267930932407.robh@kernel.org>
References: <20240523154208.2457864-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523154208.2457864-1-robh@kernel.org>


On Thu, 23 May 2024 10:42:07 -0500, Rob Herring (Arm) wrote:
> "reg" is not documented nor used for st,mlahb, so drop it from the
> example to fix the warning:
> 
> Documentation/devicetree/bindings/arm/stm32/st,mlahb.example.dtb: ahb@38000000: Unevaluated properties are not allowed ('reg' was unexpected)
>         from schema $id: http://devicetree.org/schemas/arm/stm32/st,mlahb.yaml#
> 
> Since "reg" is dropped, the unit-address must be as well.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!


