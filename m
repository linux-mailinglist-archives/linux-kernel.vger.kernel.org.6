Return-Path: <linux-kernel+bounces-208986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECEF902B76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AA1C21F53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C6150994;
	Mon, 10 Jun 2024 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5yElWPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66518E2A;
	Mon, 10 Jun 2024 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057723; cv=none; b=sg60GXHziT4K5vaNL5AV7e1TQ+fUimnZbxz5Dm6N/ylGR2Wdl4SoqNuUs6xAgoYazfOaIhrAysdMWngW4DgSdqiwQylP6FKRc/tENywsyR1vWWFOQlUxjP1tfNkcaZnUQLZfzAZD437VDWEBFuOvyVuCT42nrSN8NyLFcceeJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057723; c=relaxed/simple;
	bh=8pWFJ1XXqjBBweFhx8IgPjOy/UDLsQFFjf6y2OVepw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc1OihXxfl4r+uSBV0QLCfBiTu1SYyZyHk0WIf1cnOqR/H0xkQMLhg6DOGjKNZXzMeIbOgyYH4w87UFwdjNffPM26l2vIxi00kyU8LkBBvaVYqJEGVGdtdYov0hDtN4OnIXbE+sibhAPKSTc5W0MGox84H0auZjBiDLNGHBsLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5yElWPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3613C2BBFC;
	Mon, 10 Jun 2024 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718057723;
	bh=8pWFJ1XXqjBBweFhx8IgPjOy/UDLsQFFjf6y2OVepw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5yElWPM5rO+4ghfrGxP2H0Ts5zftzPGyyZT5wzv/mJ+bSwvCmMdJqxNrcazYizDK
	 Tjd0Cn+9sUt/+9i7wEAgFe31/2JlAOfmMP2J9+ZZ9FZuVWVesSf1cj724WhjL9ZdvY
	 mrLqrM9Jir8lcrtFi6ztZI4wr79RnQFCrELcd3fXO7hDcQ6lzudOdNG7fbaR/IlzOs
	 g8prP43QIqfnJZuCRoG3MZ2u/sYK6JZpjClmvA7JTv6Q4ztuuVOYf6Y/p1dacPTQh5
	 MTdbwUWZVldv58JJcb2Z47CphqlyT8EOvmmAObl2pnGLM0xSU821zfxO67Hxb1qk3W
	 Xt4tu//EFfT1Q==
Date: Mon, 10 Jun 2024 16:15:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: ak4554: Convert to dtschema
Message-ID: <171805771994.3160188.15298302457025194803.robh@kernel.org>
References: <20240607055725.38057-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607055725.38057-1-animeshagarwal28@gmail.com>


On Fri, 07 Jun 2024 11:27:20 +0530, Animesh Agarwal wrote:
> Convert the AK4554 sound codec bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/sound/ak4554.txt      | 11 --------
>  .../bindings/sound/asahi-kasei,ak4554.yaml    | 27 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 11 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4554.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4554.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


