Return-Path: <linux-kernel+bounces-267911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E717941B05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC99281F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8781898F7;
	Tue, 30 Jul 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko3XZPEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30A155CB3;
	Tue, 30 Jul 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358204; cv=none; b=jsEUrfzLKpU7oOckTFlOKbQRZD5J/RqIQ4qR0ewrvP4uiAwOHxXoUwsMcjrMY4t5NQb3TxC8XjcdgVWrbJU+7eM8wliF8ZDevtKBkFiOvUbRVYAXEabO4c2LYxJ1j6ZDq7I3opweJxXQivEy/b2gwk7iHKUBQPPia4deA+1yA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358204; c=relaxed/simple;
	bh=r3X8C/3sWlCsyEECb963nRYST3e36OQCZGpGejhXErU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV6AVJIAEo58YMNPNTM+HES3reTvBMa1McS+MTbO6C7RWkQ3Rmhr9RghGJcW0kz717ZJda5N/ZbXCaHupV0yiA/3OOW/LX0d/63Pe8vzps4a7t8cB0rQAJYDZNi641A46Ah+aMfUbXSVj5scfdFDiBHcTexD8HdFEk9mpdmHGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko3XZPEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6B2C4AF0F;
	Tue, 30 Jul 2024 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722358204;
	bh=r3X8C/3sWlCsyEECb963nRYST3e36OQCZGpGejhXErU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ko3XZPEdtdl2sPr6s46xPFbd66QXg+miej6Cbb1GsG7uIIPEsup07vHsotmwHVoOB
	 essYkhUabKD4F8O7z3jtNn/S0QHbBE4PPv5/AzRZjgjJC5O1U3Ppa56X4N+Butlnkt
	 0K1Zws/MmxgMirLHC6tUgdXbniQGKXvNGZcZ7dcBsBBJ1RD/0aaE8VdfgjkMaGqNAL
	 DQMtIXgDQZk+uc2klppC42Uup+oafEGnEfIK0UyATrQVagWUjbMn7BV1HjBwj8Zh3y
	 SBTAHM7c74Cij2tOr/CemKxTtcm9dy274vhurvWGkgVqy7J9z/0ievfXL3qZ4JqTNn
	 RGx1+0o3z71vA==
Date: Tue, 30 Jul 2024 10:50:02 -0600
From: Rob Herring <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	ychuang3@nuvoton.com, schung@nuvoton.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 02/27] dt-bindings: mfd: syscon: add microchip's
 sam9x7 sfr
Message-ID: <20240730165002.GA1508552-robh@kernel.org>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070603.1990265-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729070603.1990265-1-varshini.rajendran@microchip.com>

On Mon, Jul 29, 2024 at 12:36:03PM +0530, Varshini Rajendran wrote:
> Add compatible for sam9x7 SoC's SFR.

That's (kind of) obvious from the diff. How is the block on the new SoC 
the same or different from the prior chip? It's kind of strange that one 
of these blocks which tend to be register bit soup of left over controls 
would be the same or a superset of another SoC.

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v6:
> 
>  - New patch in v6 as the syscon devices are moved to a new file
>    upstream.
> ---
>  .../devicetree/bindings/mfd/syscon.yaml       | 188 +++++++++---------
>  1 file changed, 97 insertions(+), 91 deletions(-)

Put this in your own schema file. I don't think we want get into more 
complicated cases here.

Rob

