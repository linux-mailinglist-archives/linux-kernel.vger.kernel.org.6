Return-Path: <linux-kernel+bounces-429918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD49E2A28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF4B29D30
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4121FA166;
	Tue,  3 Dec 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anz86Efd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE518BC1D;
	Tue,  3 Dec 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246064; cv=none; b=T6DcHtluYMTI+Y2lOTlSgFikOfeKLEBCLeZ2y5woLDEZiHAvHI6gArvDaRxPIKwnKkqekTqEs4/lH/X1NRFhXSjj0z1Z5y7EMKTvhTKqk+Q/BElHoudzhP9n+MnOm9gZ1bFOZe0ZpPeCy7nNyitmRNNypCy5FcMhff1k346H7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246064; c=relaxed/simple;
	bh=X54gmApuOV9z0KSTh0iuDvmqMg+NUxdjzp9aJq8n3Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzsMxo6kMoH3uxNJi6cWOHuAZeTcH5ADK5EKPz7/rXgG9iT+OSatVMqeUU5MqdeBDmmNR/e8j9KzUCsAV579koluc7tW8r6jbtEwlnCm1z1OmYZvFZFZjRSa0EHlacQN/vB54jwZeDbSaExiIAkwYgXDhlSW86ukPXO2Yy1/3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anz86Efd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A95C4CECF;
	Tue,  3 Dec 2024 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733246063;
	bh=X54gmApuOV9z0KSTh0iuDvmqMg+NUxdjzp9aJq8n3Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Anz86Efdp1IdwoVfnZUmqU6tLuIveq13pYFx+gRkVpxGkcZyyBw7LYzHq23uQ9Z7+
	 VessNp0ggXiyPwcknvWYy3BXbkf6gXEZxXI0n0P9Wy3K1dupw5Qk94qU2KaOktLALE
	 tINYb/0lEME2FiKeaw3asJXO0r6dG/UEIDPJz8zPCpaRbtEnFRh96jjb3uQSUP6mTj
	 Ho8h8IR3hyUUwPFtwzF/To5wrz+Z3jEdpF9shBwUXM1JOqaqw4a7/J2xrODd+JJ7fg
	 E1nJFKu5T7GURcYUTLCSETGRUsoNFYiM6bRbENRsz4I0U6wFWv0ZMHlkdZN5QUYfnm
	 y5+/cVZe4wmEw==
Date: Tue, 3 Dec 2024 11:14:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] dt-bindings: mtd: fixed-partitions: Fix "compression"
 typo
Message-ID: <173324605959.1986625.7343237766910696825.robh@kernel.org>
References: <20241113225632.1783241-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113225632.1783241-1-robh@kernel.org>


On Wed, 13 Nov 2024 16:56:31 -0600, Rob Herring (Arm) wrote:
> The example erroneously has "compress" property rather than the
> documented "compression" property.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


