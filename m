Return-Path: <linux-kernel+bounces-208969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854BB902B17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966C81C2195F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833E14D719;
	Mon, 10 Jun 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF/qV0tg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64185558A5;
	Mon, 10 Jun 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056739; cv=none; b=ehrws0CovnecZDIgV4TDuN3uVzno2HpJ2+WYKre0wUVKaWs1UtZfgBzdCCYMHlEU87q+3HU7fFGz/NydlnfQF40BleBFTXtfdEEaMBR+QV6xuXnrubds4EUuvdQ2GutCNJdiIb4UdQO9PAMEa41hO0uzL+VdN7mSGv29CXhHEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056739; c=relaxed/simple;
	bh=3+G51pF9+5TTxrYCW+LOYlmhyGNeooEaJCa+EPjFDwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1iKhBbdk40MvLK7TY2VidhZtH8gGA8FhlwmJcc4vdtSM+OTlbqB1nnPvYNscDcdRyzGlwzdM0MvlZCICdu8h6ShOqdArPAkohBxWzjzwRX3cSG4j/ITcR+BuhLRY6DMowDLcW4J/U+01BSuvbRtKFYusvifCkV3zJvlPpr7K0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF/qV0tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECEDC2BBFC;
	Mon, 10 Jun 2024 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056738;
	bh=3+G51pF9+5TTxrYCW+LOYlmhyGNeooEaJCa+EPjFDwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lF/qV0tg9QnCE5AFbg5IKgjBp4KPr+9Jg4wZHRRzb7/c9uiIECEpNNcnvFAh597Jn
	 dZNo/NdYPFm+1F6FmUqfUb3facW9x8fwkt+fMV10i7tj4zyBpyBF7PUNA+yxp7g48y
	 pvw5aVY1MmQU4NMgTf/ztN3Ue0iVMlyarM6Wa+bHgA6ttraJByB3kKb5L/kDc51dnr
	 qdOcBNPQXhMEDX18e6+wBk9OSTBL3Tb2bxedWfK/wQBbluYnX7wCusr2eHoo0qCTE2
	 M2LHNGXG6wJFwEfRQ/V7TOWrRGpdLa+qK8xawDaj3ZfvjlZ+911arOMjlxNYwoa7Nj
	 djIm7Pwz2IwFA==
Date: Mon, 10 Jun 2024 15:58:57 -0600
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: linux,spdif: Convert
 spdif-reciever.txt to dtschema
Message-ID: <20240610215857.GA3135318-robh@kernel.org>
References: <20240606041212.78428-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606041212.78428-1-animeshagarwal28@gmail.com>

On Thu, Jun 06, 2024 at 09:42:00AM +0530, Animesh Agarwal wrote:
> Convert the dummy SPDIF receiver bindings to DT schema.

Really the subject should be something like "Merge linux,spdif-dir into 
linux,spdif-dit". Then the commit message should say why (they are the 
same other than compatible. "sound-name-prefix" wasn't documented for 
linux,spdif-dir, but is in use already.)

> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> 
> ---
> Changes	in v2:
> - Add linux,spdif-dir compatible in existing linux,spdif-dit.yaml
> instead of creating new yaml file specifically for dummy SPDIF receiver.
> - Change file name to support both transmitter and receiver bindings.
> ---
>  .../sound/{linux,spdif-dit.yaml => linux,spdif.yaml}   |  8 +++++---
>  .../devicetree/bindings/sound/spdif-receiver.txt       | 10 ----------
>  2 files changed, 5 insertions(+), 13 deletions(-)
>  rename Documentation/devicetree/bindings/sound/{linux,spdif-dit.yaml => linux,spdif.yaml} (75%)
>  delete mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

